
#include <vector>
#include <cstring>
#include <openssl/ecdsa.h>
#include <openssl/obj_mac.h>

#include "key.hpp"
#include "hash.hpp"
#include "base58.hpp"
#include "util.hpp"

// Testnet
// Network version: 0x4B
// WIF prefix: 0xCB

key::key() {
	keypair = NULL;

	if (!generate_ecdsa()) {
		printf("failed to generate private key\n");
	}
}

bool key::generate_ecdsa() {
	if (keypair != NULL) {
		EC_KEY_free(keypair);
	}

	keypair = EC_KEY_new_by_curve_name(NID_secp256k1);
	if (keypair == NULL) {
		printf("EC_KEY_new_by_curve_name fail");
		return false;
	}

	if (!EC_KEY_generate_key(keypair)) {
		printf("ec_key_generate_key fail");
		return false;
	}

	setCompressedPubKey();

	return true;
}

std::string key::WIF(unsigned char wifprefix) {
	BIGNUM const* prv = EC_KEY_get0_private_key(keypair);
	if(!prv)
	{
		std::cerr << "Error getting private key" << '\n';
		return "";
	}

	int priv_s = BN_num_bytes(prv);
	unsigned char *privbuf = (unsigned char*)malloc(priv_s);
	int res = BN_bn2bin(prv, privbuf);
	if (res != priv_s) {
		std::cerr << "Error getting private key bytes" << std::endl;
		return "";
	}
	int pklen = compressed ? priv_s+1 : priv_s;

	unsigned char wif[1+pklen+4];
	unsigned char sha256_1[32];
	unsigned char sha256_2[32];

	memcpy(&wif[1], privbuf, pklen);
	free(privbuf);

	wif[0] = wifprefix;

	if (compressed) {
		wif[33] = 0x01;
	}

	sha256(wif, pklen+1, sha256_1); 
	sha256(sha256_1, 32, sha256_2); 
	memcpy(&wif[pklen+1], sha256_2, 4);

	//print_hex(wif, pklen+5);

	return EncodeBase58(&wif[0], &wif[pklen+5]);
}

void key::setCompressedPubKey() {
	EC_KEY_set_conv_form(keypair, POINT_CONVERSION_COMPRESSED);
	compressed = true;
}

bool key::fromWIF(char *xbywif) {
	if (keypair != NULL) {
		compressed = false;
		EC_KEY_free(keypair);
	}

	keypair = EC_KEY_new_by_curve_name(NID_secp256k1);
	if (keypair == NULL) {
		std::cout << "failed to generate pkey" << std::endl;
		return false;
	}

	std::vector<unsigned char> xbypk(strlen(xbywif));

	std::cout << "F: " << xbywif << " " << strlen(xbywif) << std::endl;
	
	if (!DecodeBase58(xbywif, xbypk)) {
		std::cout << "couldn't decode wif" << std::endl;
		return -1;
	}

	int pklen = xbypk.size()-5;
	unsigned char yaypk[32]; 
	memcpy(yaypk, &xbypk[1], 32);

	BIGNUM *priv_key = BN_bin2bn(yaypk, 32, NULL);

	int ok = 0;
	BN_CTX *ctx = NULL;
	EC_POINT *pub_key = NULL;

	//if (!eckey) return 0;

	const EC_GROUP *group = EC_KEY_get0_group(keypair);

	if ((ctx = BN_CTX_new()) == NULL)
		goto err;

	pub_key = EC_POINT_new(group);

	if (pub_key == NULL)
		goto err;

	if (!EC_POINT_mul(group, pub_key, priv_key, NULL, NULL, ctx))
		goto err;

	EC_KEY_set_private_key(keypair,priv_key);
	EC_KEY_set_public_key(keypair,pub_key);

	if (pklen == 33 && (xbypk[pklen] == 0x01)) {
		setCompressedPubKey();
	}

	ok = 1;

err:

	if (pub_key)
		EC_POINT_free(pub_key);
	if (ctx != NULL)
		BN_CTX_free(ctx);

	return(ok);
}

std::vector <unsigned char> key::pubkey() {
	int nSize = i2o_ECPublicKey(keypair, NULL);
	if (!nSize) {
		printf("i2o_ECPublicKey fail");
		return {};
	}

	std::vector<unsigned char> vchPubKey(nSize, 0);
	unsigned char* pbegin = &vchPubKey[0];

	// Moves the pbegin pointer
	// TODO: Use EC_POINT_point2cbb instead: https://boringssl.googlesource.com/boringssl/+/HEAD/include/openssl/ec_key.h
	if (i2o_ECPublicKey(keypair, &pbegin) != nSize) {
		printf("i2o_ECPublicKey fail 2");
		return {};
	}

	return vchPubKey;
}

std::string key::address(unsigned char version) {
	std::vector<unsigned char> pub_key = pubkey();

	unsigned char sha256_1[32];
	unsigned char sha256_2[32];
	unsigned char sha256_3[32];
	unsigned char ripemd160_1[25];

	sha256(&pub_key[0], pub_key.size(), sha256_1); 
	ripemd160(sha256_1, 32, &ripemd160_1[1]); 
	ripemd160_1[0] = version; // ltc
	sha256(ripemd160_1, 21, sha256_2);
	sha256(sha256_2, 32, sha256_3);
	memcpy(&ripemd160_1[21], sha256_3, 4);

	return EncodeBase58(&ripemd160_1[0], &ripemd160_1[25]);
}
