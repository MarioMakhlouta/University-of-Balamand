# Build file for the Secure Multi-threaded Banking System.
#
# The project is intended to be compiled in WSL/Linux because it uses POSIX
# FIFOs and pthreads. OpenSSL is linked only with the server because hashing
# and account-file encryption happen on the server side.

CC=gcc
CFLAGS=-Wall -Wextra -Wpedantic -std=c11 -D_POSIX_C_SOURCE=200809L -g
LDLIBS=-lssl -lcrypto -lpthread

# Default target: build both programs.
all: bank_server bank_client

# Server needs OpenSSL for SHA-256/AES and pthreads for worker threads.
bank_server: bank_server.c bank_common.h
	$(CC) $(CFLAGS) bank_server.c -o bank_server $(LDLIBS)

# Client only uses the shared packet format and POSIX FIFO calls.
bank_client: bank_client.c bank_common.h
	$(CC) $(CFLAGS) bank_client.c -o bank_client

# Remove generated binaries and temporary FIFOs left from interrupted runs.
clean:
	rm -f bank_server bank_client
	rm -f /tmp/smbs_public_fifo /tmp/smbs_client_*

.PHONY: all clean
