
#include <stdio.h>

void print_hex(unsigned char *buf, unsigned int len) {
	for (unsigned int x = 0; x < len; x++) {
        fprintf(stderr, "%.2X", buf[x]);
	}

    fprintf(stderr, "\n");
}

