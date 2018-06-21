/**
 * Filename: key.hpp
 *
 * Key management
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XtraBYtes developers
 *
 * This file is part of xtrabytes project.
 *
 */

#ifndef KEY_HPP
#define KEY_HPP

#include <iostream>
#include <openssl/ec.h>

class key {
public:
	EC_KEY *keypair;
	EC_KEY *sessionKeypair;
	bool compressed;

	bool generate_ecdsa();
	std::string address(unsigned char version);
	std::string WIF(unsigned char wifprefix);
	bool fromWIF(char *wif);
	std::vector<unsigned char> pubkey();
	void setCompressedPubKey();

	key();
};

#endif

