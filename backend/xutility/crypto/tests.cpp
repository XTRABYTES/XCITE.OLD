/**
 * Filename: tests.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2019 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */


#include <locale.h>
#include <string>
#include <exception>
#include <iterator>
#include <iostream>
#include <vector>

#include <boost/filesystem.hpp>

#include "ctools.h"


int main(int argc, char *argv[])
{
	setlocale(LC_ALL, "");
	
	try {
      std::cout << "Tests:" << std::endl;
      
      CKey key;
      CPubKey pubkey;
      key.MakeNewKey(false);
      pubkey = key.GetPubKey();
      CKeyID keyID = pubkey.GetID();

      std::string pubkeyHex = HexStr(pubkey.begin(), pubkey.end());
      std::vector<unsigned char> pubkeyBin = ParseHexcstr(pubkeyHex.c_str());
      std::string pubkeyBase58 = EncodeBase58(pubkeyBin);
      
      std::cout << "PublicKey:" << pubkeyBase58 << std::endl; 
      std::cout << "PrivateKey:" << CXCiteSecret(key).ToString() << std::endl;
      std::cout << "Address:" << CXCiteAddress(keyID).ToString() << std::endl;
            
      CXCiteSecret xciteSecret;
      bool fGood = xciteSecret.SetString("6U5vEdVWKzYfFgTztEoW2PyqUDyTzJ8gK3RbBH8CbPpmm6dQVfH");      

      if (!fGood) assert(!"Invalid private key");

      CKey xcite_key = xciteSecret.GetKey();
      CPubKey xcite_pubkey = xcite_key.GetPubKey();
      CKeyID xciteAddresskeyID = xcite_pubkey.GetID();
      std::string XciteGenAddressStr = CXCiteAddress(xciteAddresskeyID).ToString();
      assert (XciteGenAddressStr.compare("F7zyDi5j5F6vnoigbuC8LujUqakapBREX4") == 0);            
      
	}
	catch (std::exception& e) {
		std::cerr << "exception: " << e.what() << "\n";
	}

	return 0;
}