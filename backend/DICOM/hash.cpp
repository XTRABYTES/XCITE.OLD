
#include <openssl/sha.h>
#include <openssl/ripemd.h>
#include <stdint.h>

void sha256(const unsigned char *s, uint8_t len, unsigned char digest[32]) {
	SHA256_CTX sha256;
	SHA256_Init(&sha256);
	SHA256_Update(&sha256, s, len);
	SHA256_Final(digest, &sha256);
}

void ripemd160(const unsigned char *s, uint8_t len, unsigned char digest[20]) {
	RIPEMD160_CTX ripemd160;
	RIPEMD160_Init(&ripemd160);
	RIPEMD160_Update(&ripemd160, s, len);
	RIPEMD160_Final(digest, &ripemd160);
}

