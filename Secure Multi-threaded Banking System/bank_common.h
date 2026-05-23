#ifndef BANK_COMMON_H
#define BANK_COMMON_H

/* stuff shared between the client and server - keep them in sync */

#include <stddef.h>

/* the pipe everyone writes requests to */
#define PUBLIC_FIFO "/tmp/smbs_public_fifo"

/* max sizes for string fields - picked something reasonable */
#define MAX_USERNAME 32
#define MAX_PASSWORD 64
#define MAX_FIFO_PATH 128
#define MAX_MESSAGE 256
#define MAX_ACCOUNTS 100

/* where the server keeps its data */
#define USERS_FILE "users.auth"
#define ACCOUNTS_DIR "accounts"

/* what the client can ask the server to do */
typedef enum {
    OP_BALANCE = 1,
    OP_DEPOSIT = 2,
    OP_WITHDRAW = 3,
    OP_TRANSFER = 4,
    OP_QUIT = 5
} operation_t;

/* one request packet - client fills this and sends it to the public FIFO
   private_fifo tells the server where to send the reply back */
typedef struct {
    char username[MAX_USERNAME];
    char password[MAX_PASSWORD];
    char private_fifo[MAX_FIFO_PATH];
    int operation;
    int src_account;
    int dst_account;
    double amount;
} bank_request_t;

/* what the server sends back
   success=1 means it worked, 0 means something went wrong */
typedef struct {
    int success;
    double balance;
    char message[MAX_MESSAGE];
} bank_response_t;

#endif
