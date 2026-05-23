#include "bank_common.h"

/*
 * bank_server.c
 *
 * The server - handles everything sensitive:
 *   - verifying passwords against salted SHA-256 hashes
 *   - reading and writing AES-encrypted account files
 *   - locking accounts so concurrent requests don't corrupt balances
 *   - spawning one worker thread per incoming request
 */

#include <errno.h>
#include <fcntl.h>
#include <openssl/evp.h>
#include <openssl/rand.h>
#include <openssl/sha.h>
#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define SALT_BYTES 16
#define HASH_BYTES SHA256_DIGEST_LENGTH
#define AES_KEY_BYTES 32
#define AES_IV_BYTES 16
#define FILE_BUFFER 4096

/*
 * Custom reader/writer lock - built from scratch to show how it works.
 * Balance checks are readers, everything else is a writer.
 * Writers get priority so a flood of balance checks can't starve a deposit.
 */
typedef struct {
    pthread_mutex_t mutex;
    pthread_cond_t readers_ok;
    pthread_cond_t writers_ok;
    int active_readers;
    int active_writer;
    int waiting_writers;
} account_lock_t;

/* one parsed entry from users.auth - only lives in memory during auth */
typedef struct {
    char username[MAX_USERNAME];
    int account_id;
    unsigned char salt[SALT_BYTES];
    unsigned char hash[HASH_BYTES];
} user_record_t;

/* one lock slot per account ID - index 0 is just wasted, IDs start at 1 */
static account_lock_t g_account_locks[MAX_ACCOUNTS];

/* protects users.auth from being read and written at the same time */
static pthread_mutex_t g_auth_mutex = PTHREAD_MUTEX_INITIALIZER;
static int g_running = 1;

/* snprintf wrapper - just keeps the operation handlers a bit cleaner */
static void safe_message(bank_response_t *response, const char *message)
{
    snprintf(response->message, sizeof(response->message), "%s", message);
}

/* turns raw bytes into a hex string for storing in users.auth */
static void bytes_to_hex(const unsigned char *bytes, size_t len, char *hex, size_t hex_size)
{
    size_t i;

    if (hex_size < (len * 2) + 1) {
        return;
    }

    for (i = 0; i < len; i++) {
        snprintf(hex + (i * 2), 3, "%02x", bytes[i]);
    }
    hex[len * 2] = '\0';
}

/* single hex char to its numeric value - returns -1 on bad input */
static int hex_value(char c)
{
    if (c >= '0' && c <= '9') {
        return c - '0';
    }
    if (c >= 'a' && c <= 'f') {
        return c - 'a' + 10;
    }
    if (c >= 'A' && c <= 'F') {
        return c - 'A' + 10;
    }
    return -1;
}

/* opposite of bytes_to_hex - reads hex string back into binary */
static int hex_to_bytes(const char *hex, unsigned char *bytes, size_t len)
{
    size_t i;

    if (strlen(hex) != len * 2) {
        return 0;
    }

    for (i = 0; i < len; i++) {
        int high = hex_value(hex[i * 2]);
        int low = hex_value(hex[(i * 2) + 1]);

        if (high < 0 || low < 0) {
            return 0;
        }

        bytes[i] = (unsigned char)((high << 4) | low);
    }

    return 1;
}

/*
 * SHA-256(salt + password) - the salt is prepended so two users with the
 * same password don't end up with the same stored hash.
 * Using EVP instead of SHA256() directly because it works on all OpenSSL versions.
 */
static void hash_password(const unsigned char salt[SALT_BYTES],
                          const char *password,
                          unsigned char output[HASH_BYTES])
{
    EVP_MD_CTX *ctx = EVP_MD_CTX_new();
    unsigned int output_len = 0;

    if (ctx == NULL) {
        memset(output, 0, HASH_BYTES);
        return;
    }

    if (EVP_DigestInit_ex(ctx, EVP_sha256(), NULL) != 1 ||
        EVP_DigestUpdate(ctx, salt, SALT_BYTES) != 1 ||
        EVP_DigestUpdate(ctx, (const unsigned char *)password, strlen(password)) != 1 ||
        EVP_DigestFinal_ex(ctx, output, &output_len) != 1 ||
        output_len != HASH_BYTES) {
        memset(output, 0, HASH_BYTES);
    }

    EVP_MD_CTX_free(ctx);
}

/*
 * Compare two hashes without bailing early on the first difference.
 * A normal memcmp would return faster for "closer" wrong passwords,
 * leaking info through timing. This always runs all 32 iterations.
 */
static int constant_time_equal(const unsigned char *a, const unsigned char *b, size_t len)
{
    unsigned char diff = 0;
    size_t i;

    for (i = 0; i < len; i++) {
        diff |= (unsigned char)(a[i] ^ b[i]);
    }

    return diff == 0;
}

/*
 * Hash SMBS_MASTER_KEY into 32 bytes to use as the AES key.
 * The key lives only in an env variable - never in the binary or on disk.
 */
static int derive_master_key(unsigned char key[AES_KEY_BYTES])
{
    const char *secret = getenv("SMBS_MASTER_KEY");

    if (secret == NULL || secret[0] == '\0') {
        fprintf(stderr, "SMBS_MASTER_KEY is not set.\n");
        return 0;
    }

    SHA256((const unsigned char *)secret, strlen(secret), key);
    return 1;
}

/* just builds the path string for a given account file */
static void account_file_path(int account_id, char *path, size_t path_size)
{
    snprintf(path, path_size, "%s/account_%d.dat", ACCOUNTS_DIR, account_id);
}

/* create accounts/ if it's not already there */
static int ensure_accounts_dir(void)
{
    if (mkdir(ACCOUNTS_DIR, 0700) == -1 && errno != EEXIST) {
        perror("mkdir accounts");
        return 0;
    }

    return 1;
}

/*
 * Write an encrypted account file.
 * Format: [16 byte random IV][AES-256-CBC ciphertext]
 * Fresh IV every write so the file looks different even if the balance didn't change.
 */
static int encrypt_to_file(int account_id, double balance)
{
    unsigned char key[AES_KEY_BYTES];
    unsigned char iv[AES_IV_BYTES];
    unsigned char plaintext[128];
    unsigned char ciphertext[256];
    int plain_len;
    int out_len = 0;
    int final_len = 0;
    char path[128];
    FILE *file;
    EVP_CIPHER_CTX *ctx;

    if (!derive_master_key(key) || !ensure_accounts_dir()) {
        return 0;
    }

    if (RAND_bytes(iv, sizeof(iv)) != 1) {
        fprintf(stderr, "RAND_bytes failed for AES IV.\n");
        return 0;
    }

    plain_len = snprintf((char *)plaintext, sizeof(plaintext), "%.2f\n", balance);
    if (plain_len <= 0 || plain_len >= (int)sizeof(plaintext)) {
        return 0;
    }

    ctx = EVP_CIPHER_CTX_new();
    if (ctx == NULL) {
        return 0;
    }

    if (EVP_EncryptInit_ex(ctx, EVP_aes_256_cbc(), NULL, key, iv) != 1 ||
        EVP_EncryptUpdate(ctx, ciphertext, &out_len, plaintext, plain_len) != 1 ||
        EVP_EncryptFinal_ex(ctx, ciphertext + out_len, &final_len) != 1) {
        EVP_CIPHER_CTX_free(ctx);
        return 0;
    }

    EVP_CIPHER_CTX_free(ctx);
    account_file_path(account_id, path, sizeof(path));

    file = fopen(path, "wb");
    if (file == NULL) {
        perror("open encrypted account file for writing");
        return 0;
    }

    if (fwrite(iv, 1, sizeof(iv), file) != sizeof(iv) ||
        fwrite(ciphertext, 1, (size_t)(out_len + final_len), file) != (size_t)(out_len + final_len)) {
        fclose(file);
        return 0;
    }

    fclose(file);
    return 1;
}

/* read and decrypt an account file - IV is the first 16 bytes of the file */
static int decrypt_from_file(int account_id, double *balance)
{
    unsigned char key[AES_KEY_BYTES];
    unsigned char iv[AES_IV_BYTES];
    unsigned char ciphertext[FILE_BUFFER];
    unsigned char plaintext[FILE_BUFFER];
    int cipher_len;
    int out_len = 0;
    int final_len = 0;
    char path[128];
    FILE *file;
    EVP_CIPHER_CTX *ctx;

    if (!derive_master_key(key)) {
        return 0;
    }

    account_file_path(account_id, path, sizeof(path));
    file = fopen(path, "rb");
    if (file == NULL) {
        return 0;
    }

    if (fread(iv, 1, sizeof(iv), file) != sizeof(iv)) {
        fclose(file);
        return 0;
    }

    cipher_len = (int)fread(ciphertext, 1, sizeof(ciphertext), file);
    fclose(file);

    if (cipher_len <= 0 || cipher_len >= FILE_BUFFER) {
        return 0;
    }

    ctx = EVP_CIPHER_CTX_new();
    if (ctx == NULL) {
        return 0;
    }

    if (EVP_DecryptInit_ex(ctx, EVP_aes_256_cbc(), NULL, key, iv) != 1 ||
        EVP_DecryptUpdate(ctx, plaintext, &out_len, ciphertext, cipher_len) != 1 ||
        EVP_DecryptFinal_ex(ctx, plaintext + out_len, &final_len) != 1) {
        EVP_CIPHER_CTX_free(ctx);
        return 0;
    }

    EVP_CIPHER_CTX_free(ctx);
    plaintext[out_len + final_len] = '\0';
    *balance = strtod((const char *)plaintext, NULL);
    return 1;
}

static void account_lock_init(account_lock_t *lock)
{
    pthread_mutex_init(&lock->mutex, NULL);
    pthread_cond_init(&lock->readers_ok, NULL);
    pthread_cond_init(&lock->writers_ok, NULL);
    lock->active_readers = 0;
    lock->active_writer = 0;
    lock->waiting_writers = 0;
}

/*
 * Block if a writer is active OR if writers are queued.
 * The second condition is what gives writers priority over readers.
 */
static void read_lock(account_lock_t *lock)
{
    pthread_mutex_lock(&lock->mutex);
    while (lock->active_writer || lock->waiting_writers > 0) {
        pthread_cond_wait(&lock->readers_ok, &lock->mutex);
    }
    lock->active_readers++;
    pthread_mutex_unlock(&lock->mutex);
}

/* if we were the last reader, wake a waiting writer */
static void read_unlock(account_lock_t *lock)
{
    pthread_mutex_lock(&lock->mutex);
    lock->active_readers--;
    if (lock->active_readers == 0) {
        pthread_cond_signal(&lock->writers_ok);
    }
    pthread_mutex_unlock(&lock->mutex);
}

/*
 * Announce we're waiting before we actually wait - that's what tells
 * new readers to hold off and give writers a chance to get through.
 */
static void write_lock(account_lock_t *lock)
{
    pthread_mutex_lock(&lock->mutex);
    lock->waiting_writers++;
    while (lock->active_writer || lock->active_readers > 0) {
        pthread_cond_wait(&lock->writers_ok, &lock->mutex);
    }
    lock->waiting_writers--;
    lock->active_writer = 1;
    pthread_mutex_unlock(&lock->mutex);
}

/* prefer the next writer if there is one, otherwise let all readers go */
static void write_unlock(account_lock_t *lock)
{
    pthread_mutex_lock(&lock->mutex);
    lock->active_writer = 0;
    if (lock->waiting_writers > 0) {
        pthread_cond_signal(&lock->writers_ok);
    } else {
        pthread_cond_broadcast(&lock->readers_ok);
    }
    pthread_mutex_unlock(&lock->mutex);
}

/* account IDs run from 1 to MAX_ACCOUNTS-1 */
static int valid_account(int account_id)
{
    return account_id > 0 && account_id < MAX_ACCOUNTS;
}

/* parse one colon-separated line from users.auth into a user_record_t */
static int parse_user_line(const char *line, user_record_t *user)
{
    char copy[256];
    char *username;
    char *account_text;
    char *salt_hex;
    char *hash_hex;

    snprintf(copy, sizeof(copy), "%s", line);
    username = strtok(copy, ":\n");
    account_text = strtok(NULL, ":\n");
    salt_hex = strtok(NULL, ":\n");
    hash_hex = strtok(NULL, ":\n");

    if (username == NULL || account_text == NULL || salt_hex == NULL || hash_hex == NULL) {
        return 0;
    }

    snprintf(user->username, sizeof(user->username), "%s", username);
    user->account_id = atoi(account_text);

    return valid_account(user->account_id) &&
           hex_to_bytes(salt_hex, user->salt, SALT_BYTES) &&
           hex_to_bytes(hash_hex, user->hash, HASH_BYTES);
}

/*
 * Check username + password against users.auth.
 * On success, fills account_id so the worker knows which account belongs to this user.
 */
static int authenticate(const char *username, const char *password, int *account_id)
{
    FILE *file;
    char line[256];
    int authenticated = 0;

    pthread_mutex_lock(&g_auth_mutex);
    file = fopen(USERS_FILE, "r");
    if (file == NULL) {
        pthread_mutex_unlock(&g_auth_mutex);
        return 0;
    }

    while (fgets(line, sizeof(line), file) != NULL) {
        user_record_t user;
        unsigned char computed_hash[HASH_BYTES];

        if (!parse_user_line(line, &user)) {
            continue;
        }

        if (strncmp(user.username, username, MAX_USERNAME) != 0) {
            continue;
        }

        hash_password(user.salt, password, computed_hash);
        if (constant_time_equal(user.hash, computed_hash, HASH_BYTES)) {
            *account_id = user.account_id;
            authenticated = 1;
        }
        break;
    }

    fclose(file);
    pthread_mutex_unlock(&g_auth_mutex);
    return authenticated;
}

/* write the response to the client's private FIFO */
static void send_response(const char *private_fifo, const bank_response_t *response)
{
    int fd = open(private_fifo, O_WRONLY);

    if (fd == -1) {
        fprintf(stderr, "Could not open client private FIFO %s: %s\n",
                private_fifo, strerror(errno));
        return;
    }

    if (write(fd, response, sizeof(*response)) != (ssize_t)sizeof(*response)) {
        fprintf(stderr, "Could not write complete response to client FIFO.\n");
    }

    close(fd);
}

/* balance check is read-only so multiple clients can do it at the same time */
static void process_balance(const bank_request_t *request, bank_response_t *response)
{
    double balance = 0.0;

    read_lock(&g_account_locks[request->src_account]);
    if (decrypt_from_file(request->src_account, &balance)) {
        response->success = 1;
        response->balance = balance;
        safe_message(response, "Balance check successful.");
    } else {
        safe_message(response, "Could not read encrypted account file.");
    }
    read_unlock(&g_account_locks[request->src_account]);
}

/* exclusive lock for deposit - can't let anyone else touch the file mid-update */
static void process_deposit(const bank_request_t *request, bank_response_t *response)
{
    double balance = 0.0;

    if (request->amount <= 0.0) {
        safe_message(response, "Deposit amount must be positive.");
        return;
    }

    write_lock(&g_account_locks[request->src_account]);
    if (decrypt_from_file(request->src_account, &balance)) {
        balance += request->amount;
        if (encrypt_to_file(request->src_account, balance)) {
            response->success = 1;
            response->balance = balance;
            safe_message(response, "Deposit committed.");
        } else {
            safe_message(response, "Deposit failed while encrypting account file.");
        }
    } else {
        safe_message(response, "Deposit failed while decrypting account file.");
    }
    write_unlock(&g_account_locks[request->src_account]);
}

/*
 * The check and the subtract both happen inside the same write lock.
 * Without that, two concurrent withdrawals could both pass the balance check
 * and overdraft the account.
 */
static void process_withdraw(const bank_request_t *request, bank_response_t *response)
{
    double balance = 0.0;

    if (request->amount <= 0.0) {
        safe_message(response, "Withdrawal amount must be positive.");
        return;
    }

    write_lock(&g_account_locks[request->src_account]);
    if (decrypt_from_file(request->src_account, &balance)) {
        if (balance >= request->amount) {
            balance -= request->amount;
            if (encrypt_to_file(request->src_account, balance)) {
                response->success = 1;
                response->balance = balance;
                safe_message(response, "Withdrawal committed.");
            } else {
                safe_message(response, "Withdrawal failed while encrypting account file.");
            }
        } else {
            response->balance = balance;
            safe_message(response, "Withdrawal denied: insufficient funds.");
        }
    } else {
        safe_message(response, "Withdrawal failed while decrypting account file.");
    }
    write_unlock(&g_account_locks[request->src_account]);
}

/*
 * Always lock the lower account ID first, no matter which direction the
 * transfer is going. Without this ordering, two opposite transfers
 * (1->2 and 2->1) could deadlock waiting on each other.
 */
static void process_transfer(const bank_request_t *request, bank_response_t *response)
{
    int first;
    int second;
    double source_balance = 0.0;
    double destination_balance = 0.0;

    if (!valid_account(request->dst_account)) {
        safe_message(response, "Destination account does not exist.");
        return;
    }

    if (request->src_account == request->dst_account) {
        safe_message(response, "Source and destination accounts must be different.");
        return;
    }

    if (request->amount <= 0.0) {
        safe_message(response, "Transfer amount must be positive.");
        return;
    }

    first = request->src_account < request->dst_account ? request->src_account : request->dst_account;
    second = request->src_account < request->dst_account ? request->dst_account : request->src_account;

    write_lock(&g_account_locks[first]);
    write_lock(&g_account_locks[second]);

    if (!decrypt_from_file(request->src_account, &source_balance) ||
        !decrypt_from_file(request->dst_account, &destination_balance)) {
        safe_message(response, "Transfer failed while decrypting account files.");
    } else if (source_balance < request->amount) {
        response->balance = source_balance;
        safe_message(response, "Transfer denied: insufficient funds.");
    } else {
        source_balance -= request->amount;
        destination_balance += request->amount;

        if (encrypt_to_file(request->src_account, source_balance) &&
            encrypt_to_file(request->dst_account, destination_balance)) {
            response->success = 1;
            response->balance = source_balance;
            safe_message(response, "Transfer committed.");
        } else {
            safe_message(response, "Transfer failed while encrypting account files.");
        }
    }

    /* unlock in reverse order */
    write_unlock(&g_account_locks[second]);
    write_unlock(&g_account_locks[first]);
}

/*
 * Entry point for each worker thread.
 * Gets a heap-allocated request copy, handles it, sends the reply, then frees it.
 * The main loop doesn't wait for us - we're detached.
 */
static void *client_worker(void *arg)
{
    bank_request_t *request = (bank_request_t *)arg;
    bank_response_t response;
    int authenticated_account = -1;

    memset(&response, 0, sizeof(response));

    if (!authenticate(request->username, request->password, &authenticated_account)) {
        safe_message(&response, "Authentication failed.");
        send_response(request->private_fifo, &response);
        free(request);
        return NULL;
    }

    /* even after login, make sure the account in the request belongs to this user */
    if (!valid_account(request->src_account) || request->src_account != authenticated_account) {
        safe_message(&response, "Account access denied.");
        send_response(request->private_fifo, &response);
        free(request);
        return NULL;
    }

    if (request->operation == OP_BALANCE) {
        process_balance(request, &response);
    } else if (request->operation == OP_DEPOSIT) {
        process_deposit(request, &response);
    } else if (request->operation == OP_WITHDRAW) {
        process_withdraw(request, &response);
    } else if (request->operation == OP_TRANSFER) {
        process_transfer(request, &response);
    } else {
        safe_message(&response, "Unknown operation.");
    }

    send_response(request->private_fifo, &response);
    free(request);
    return NULL;
}

/*
 * Write one user line to users.auth and create the encrypted account file.
 * Shared by --init-demo and --add-user so they both produce the same format.
 */
static int write_user_record(FILE *file,
                             const char *username,
                             int account_id,
                             const char *password,
                             double initial_balance)
{
    unsigned char salt[SALT_BYTES];
    unsigned char hash[HASH_BYTES];
    char salt_hex[(SALT_BYTES * 2) + 1];
    char hash_hex[(HASH_BYTES * 2) + 1];

    if (RAND_bytes(salt, sizeof(salt)) != 1) {
        return 0;
    }

    hash_password(salt, password, hash);
    bytes_to_hex(salt, sizeof(salt), salt_hex, sizeof(salt_hex));
    bytes_to_hex(hash, sizeof(hash), hash_hex, sizeof(hash_hex));

    fprintf(file, "%s:%d:%s:%s\n", username, account_id, salt_hex, hash_hex);
    return encrypt_to_file(account_id, initial_balance);
}

/* scan users.auth to make sure neither the username nor the account ID is taken */
static int user_or_account_exists(const char *username, int account_id)
{
    FILE *file = fopen(USERS_FILE, "r");
    char line[256];

    if (file == NULL) {
        return 0;
    }

    while (fgets(line, sizeof(line), file) != NULL) {
        user_record_t user;

        if (!parse_user_line(line, &user)) {
            continue;
        }

        if (strncmp(user.username, username, MAX_USERNAME) == 0 ||
            user.account_id == account_id) {
            fclose(file);
            return 1;
        }
    }

    fclose(file);
    return 0;
}

/* ./bank_server --add-user mario 1 1500 pass123 */
static int add_user(const char *username,
                    int account_id,
                    double initial_balance,
                    const char *password)
{
    FILE *file;

    if (strlen(username) == 0 || strlen(username) >= MAX_USERNAME) {
        fprintf(stderr, "Username must be 1-%d characters.\n", MAX_USERNAME - 1);
        return 1;
    }

    if (!valid_account(account_id)) {
        fprintf(stderr, "Account ID must be between 1 and %d.\n", MAX_ACCOUNTS - 1);
        return 1;
    }

    if (initial_balance < 0.0) {
        fprintf(stderr, "Initial balance cannot be negative.\n");
        return 1;
    }

    if (!derive_master_key((unsigned char[AES_KEY_BYTES]){0}) || !ensure_accounts_dir()) {
        return 1;
    }

    if (user_or_account_exists(username, account_id)) {
        fprintf(stderr, "Username or account ID already exists.\n");
        return 1;
    }

    file = fopen(USERS_FILE, "a");
    if (file == NULL) {
        perror("users.auth");
        return 1;
    }

    if (!write_user_record(file, username, account_id, password, initial_balance)) {
        fclose(file);
        fprintf(stderr, "Could not create user/account.\n");
        return 1;
    }

    fclose(file);
    printf("Created user '%s' with account %d and encrypted balance %.2f.\n",
           username, account_id, initial_balance);
    return 0;
}

/* quick setup for demos - five users, all with pass123 and $1000 */
static int init_demo_data(void)
{
    FILE *file;

    if (!derive_master_key((unsigned char[AES_KEY_BYTES]){0}) || !ensure_accounts_dir()) {
        return 1;
    }

    file = fopen(USERS_FILE, "w");
    if (file == NULL) {
        perror("users.auth");
        return 1;
    }

    if (!write_user_record(file, "alice", 1, "pass123", 1000.00) ||
        !write_user_record(file, "bob", 2, "pass123", 1000.00) ||
        !write_user_record(file, "carol", 3, "pass123", 1000.00) ||
        !write_user_record(file, "dave", 4, "pass123", 1000.00) ||
        !write_user_record(file, "erin", 5, "pass123", 1000.00)) {
        fclose(file);
        fprintf(stderr, "Could not create all demo users/accounts.\n");
        return 1;
    }

    fclose(file);
    puts("Demo users and encrypted accounts created.");
    puts("Users: alice, bob, carol, dave, erin");
    puts("Password for all demo users: pass123");
    return 0;
}

/* Ctrl+C sets g_running=0 and removes the FIFO so the read() in the main loop wakes up */
static void handle_signal(int signum)
{
    (void)signum;
    g_running = 0;
    unlink(PUBLIC_FIFO);
}

static void init_locks(void)
{
    int i;

    for (i = 0; i < MAX_ACCOUNTS; i++) {
        account_lock_init(&g_account_locks[i]);
    }
}

/*
 * Main loop - owns the public FIFO, reads requests, and hands each one
 * to a fresh detached thread.
 */
static int start_server(void)
{
    int public_fd;
    int keepalive_fd;

    if (!derive_master_key((unsigned char[AES_KEY_BYTES]){0})) {
        return 1;
    }

    init_locks();
    signal(SIGINT, handle_signal);
    signal(SIGTERM, handle_signal);
    signal(SIGPIPE, SIG_IGN);

    unlink(PUBLIC_FIFO);
    if (mkfifo(PUBLIC_FIFO, 0666) == -1) {
        perror("mkfifo public FIFO");
        return 1;
    }

    /*
     * Open both ends with O_NONBLOCK to avoid a deadlock at startup.
     * The write-end "keepalive" stays open so read() never gets a surprise EOF
     * when the last client disconnects.
     */
    public_fd = open(PUBLIC_FIFO, O_RDONLY | O_NONBLOCK);
    if (public_fd == -1) {
        perror("open public FIFO");
        unlink(PUBLIC_FIFO);
        return 1;
    }

    keepalive_fd = open(PUBLIC_FIFO, O_WRONLY | O_NONBLOCK);
    if (keepalive_fd == -1) {
        perror("open public FIFO keepalive");
        close(public_fd);
        unlink(PUBLIC_FIFO);
        return 1;
    }

    /* switch back to blocking so we sleep between requests instead of spinning */
    if (fcntl(public_fd, F_SETFL, fcntl(public_fd, F_GETFL) & ~O_NONBLOCK) == -1) {
        perror("set public FIFO blocking mode");
        close(keepalive_fd);
        close(public_fd);
        unlink(PUBLIC_FIFO);
        return 1;
    }

    printf("SMBS server is running on %s\n", PUBLIC_FIFO);

    while (g_running) {
        bank_request_t request;
        ssize_t received = read(public_fd, &request, sizeof(request));

        if (received == 0) {
            continue;
        }

        if (received == -1) {
            if (errno == EINTR) {
                continue;  /* interrupted by signal - just loop and check g_running */
            }
            perror("read public FIFO");
            break;
        }

        if (received != (ssize_t)sizeof(request)) {
            fprintf(stderr, "Ignored incomplete request.\n");
            continue;
        }

        bank_request_t *copy = malloc(sizeof(*copy));
        pthread_t thread;

        if (copy == NULL) {
            fprintf(stderr, "Out of memory while accepting client.\n");
            continue;
        }

        *copy = request;

        /* worker owns the copy - it will free it when done */
        if (pthread_create(&thread, NULL, client_worker, copy) != 0) {
            fprintf(stderr, "pthread_create failed.\n");
            free(copy);
            continue;
        }

        pthread_detach(thread);
    }

    close(keepalive_fd);
    close(public_fd);
    unlink(PUBLIC_FIFO);
    return 0;
}

int main(int argc, char **argv)
{
    if (argc == 2 && strcmp(argv[1], "--init-demo") == 0) {
        return init_demo_data();
    }

    if (argc == 6 && strcmp(argv[1], "--add-user") == 0) {
        return add_user(argv[2], atoi(argv[3]), strtod(argv[4], NULL), argv[5]);
    }

    if (argc != 1) {
        fprintf(stderr, "Usage:\n");
        fprintf(stderr, "  %s\n", argv[0]);
        fprintf(stderr, "  %s --init-demo\n", argv[0]);
        fprintf(stderr, "  %s --add-user <username> <account_id> <initial_balance> <password>\n", argv[0]);
        return 1;
    }

    return start_server();
}
