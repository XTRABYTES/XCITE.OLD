/**
 * Filename: hash.hpp
 *
 * Key management 
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XtraBYtes developers
 *
 * This file is part of xtrabytes project.
 *
 */

#ifndef HASH_HPP
#define HASH_HPP

void sha256(const unsigned char *s, uint8_t len, unsigned char digest[32]);
void ripemd160(const unsigned char *s, uint8_t len, unsigned char digest[20]);

#endif

