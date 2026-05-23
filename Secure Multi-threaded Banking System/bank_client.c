#include "bank_common.h"

/*
 * bank_client.c
 *
 * The client side - just collects input, sends a request through the public
 * FIFO, and waits on the private FIFO for the server to reply.
 * All the real work (auth, encryption, locking) happens on the server.
 */

#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

/* saved globally so cleanup() can reach it without a parameter */
static char g_private_fifo[MAX_FIFO_PATH];

/* called automatically on exit to delete our private pipe */
static void cleanup(void)
{
    if (g_private_fifo[0] != '\0') {
        unlink(g_private_fifo);
    }
}

/* fgets leaves the newline in - strip it so strings compare properly */
static void trim_newline(char *text)
{
    size_t len = strlen(text);
    if (len > 0 && text[len - 1] == '\n') {
        text[len - 1] = '\0';
    }
}

/* safer than scanf - respects the buffer size */
static void read_line(const char *prompt, char *buffer, size_t size)
{
    printf("%s", prompt);
    fflush(stdout);  /* make sure the prompt shows before we block on input */

    if (fgets(buffer, (int)size, stdin) == NULL) {
        buffer[0] = '\0';
        return;
    }

    trim_newline(buffer);
}

static int read_int(const char *prompt)
{
    char line[64];
    read_line(prompt, line, sizeof(line));
    return atoi(line);
}

static double read_amount(const char *prompt)
{
    char line[64];
    read_line(prompt, line, sizeof(line));
    return strtod(line, NULL);
}

/* send one request and block until we get the response back */
static int send_request(const bank_request_t *request, bank_response_t *response)
{
    int public_fd = open(PUBLIC_FIFO, O_WRONLY);
    if (public_fd == -1) {
        perror("Could not open server public FIFO. Is ./bank_server running?");
        return 0;
    }

    ssize_t written = write(public_fd, request, sizeof(*request));
    close(public_fd);

    /* reject a partial write - server would get a garbage packet */
    if (written != (ssize_t)sizeof(*request)) {
        fprintf(stderr, "Could not send the complete request to the server.\n");
        return 0;
    }

    /* open our private pipe and wait here until the server responds */
    int private_fd = open(request->private_fifo, O_RDONLY);
    if (private_fd == -1) {
        perror("Could not open private FIFO for server response");
        return 0;
    }

    ssize_t received = read(private_fd, response, sizeof(*response));
    close(private_fd);

    if (received != (ssize_t)sizeof(*response)) {
        fprintf(stderr, "Could not read a complete response from the server.\n");
        return 0;
    }

    return 1;
}

static void print_menu(void)
{
    puts("");
    puts("Secure Multi-threaded Banking System");
    puts("1. Balance check");
    puts("2. Deposit");
    puts("3. Withdraw");
    puts("4. Transfer");
    puts("5. Quit");
}

int main(void)
{
    bank_request_t request;
    bank_response_t response;
    char username[MAX_USERNAME];
    char password[MAX_PASSWORD];

    /* PID in the name so two clients running at the same time don't clash */
    snprintf(g_private_fifo, sizeof(g_private_fifo), "/tmp/smbs_client_%ld", (long)getpid());
    unlink(g_private_fifo);  /* remove any leftover from a previous crash */

    if (mkfifo(g_private_fifo, 0600) == -1) {
        perror("mkfifo private FIFO");
        return 1;
    }

    atexit(cleanup);

    /* without this, a broken server pipe would just kill us silently */
    signal(SIGPIPE, SIG_IGN);

    read_line("Username: ", username, sizeof(username));
    read_line("Password: ", password, sizeof(password));

    while (1) {
        int choice;

        print_menu();
        choice = read_int("Choose an option: ");

        /* zero out the struct first - leftover fields from last iteration could cause issues */
        memset(&request, 0, sizeof(request));
        snprintf(request.username, sizeof(request.username), "%s", username);
        snprintf(request.password, sizeof(request.password), "%s", password);
        snprintf(request.private_fifo, sizeof(request.private_fifo), "%s", g_private_fifo);
        request.operation = choice;

        if (choice == OP_BALANCE) {
            request.src_account = read_int("Your account ID: ");
        } else if (choice == OP_DEPOSIT) {
            request.src_account = read_int("Your account ID: ");
            request.amount = read_amount("Deposit amount: ");
        } else if (choice == OP_WITHDRAW) {
            request.src_account = read_int("Your account ID: ");
            request.amount = read_amount("Withdrawal amount: ");
        } else if (choice == OP_TRANSFER) {
            request.src_account = read_int("Your account ID: ");
            request.dst_account = read_int("Destination account ID: ");
            request.amount = read_amount("Transfer amount: ");
        } else if (choice == OP_QUIT) {
            puts("Goodbye.");
            break;
        } else {
            puts("Invalid option.");
            continue;
        }

        if (!send_request(&request, &response)) {
            continue;
        }

        printf("\nServer: %s\n", response.message);
        if (response.success) {
            printf("Balance: %.2f\n", response.balance);
        }
    }

    return 0;
}
