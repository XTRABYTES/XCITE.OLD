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

void create_keypairs( const unsigned char AddressNetworkID ) {

      CKey key;
      CPubKey pubkey;
      key.MakeNewKey(false);
      pubkey = key.GetPubKey();
      CKeyID keyID = pubkey.GetID();

      std::string pubkeyHex = HexStr(pubkey.begin(), pubkey.end());
      std::vector<unsigned char> pubkeyBin = ParseHexcstr(pubkeyHex.c_str());
      std::string pubkeyBase58 = EncodeBase58(pubkeyBin);
      
      std::cout << "PublicKey:" << pubkeyBase58 << std::endl; 
      std::cout << "PrivateKey:" << CXCiteSecret(key,AddressNetworkID).ToString() << std::endl;
      std::cout << "Address:" << CXCiteAddress(keyID,AddressNetworkID).ToString() << std::endl << std::endl;
}

void validate_keys( std::string secret, std::string pubkey, std::string address, const unsigned char AddressNetworkID ) {
        
      CXCiteSecret xciteSecret;
      bool fGood = xciteSecret.SetString(secret,AddressNetworkID);      
      if (!fGood) assert(!"Invalid private key");
      std::cout << "Private Key(" << secret << "): OK" << std::endl;

      CKey key = xciteSecret.GetKey();
      CPubKey xcpubkey = key.GetPubKey();
      std::string pubkeyHex = HexStr(xcpubkey.begin(), xcpubkey.end());
      std::vector<unsigned char> pubkeyBin = ParseHexcstr(pubkeyHex.c_str());
      std::string pubkeyBase58 = EncodeBase58(pubkeyBin);
      assert (pubkeyBase58.compare(pubkey) == 0);            
      std::cout << "Pubkey(" << pubkey << "): OK" << std::endl;

      
      CKeyID xciteAddresskeyID = xcpubkey.GetID();
      std::string XciteGenAddressStr = CXCiteAddress(xciteAddresskeyID,AddressNetworkID).ToString();
      assert (XciteGenAddressStr.compare(address) == 0);            
      std::cout << "Address(" << address << "): OK" << std::endl;
} 

int main(int argc, char *argv[])
{
	setlocale(LC_ALL, "");
	
	try {
      std::cout << "Tests #1 (generate) XFUEL_NETWORKID = 35" << std::endl;
      create_keypairs(35);
      std::cout << "Tests #2  (generate) XTRABYTES_NETWORKID = 25" << std::endl;
      create_keypairs(25);
      std::cout << "Tests #3  (generate) TESTNET_NETWORKID = 38" << std::endl;            
      create_keypairs(38);            
            
      std::cout << "Tests #4  (validate) XFUEL_NETWORKID = 35" << std::endl;      
      validate_keys(	"6UyFeiBCrjQdguj7ju6pFCTakxpmTWVBGjB8jDRRtz412huZAbU",
      					"RoQkkWSmdTch51dKnpiSd2gJ64YfWrcRi66A2zZpryjiymfRhpbWscxbT87FWkcEeuX1VU2YoBXqBvdU3qwAgxM7",
      					"F5tZiwtJR5jaeHsDkNYEgvF3PqkEjtfWHF",35);  
      std::cout << std::endl;      					
 
      std::cout << "Tests #5  (validate) XTRABYTES_NETWORKID = 25" << std::endl;      
      validate_keys(	"68mgUTCtuEFY8XZ7VRbsppdxoYhUHLDJCNCw6McjwxNWuiFCe6H",
      					"MkrSkRcjsxTGLhv1diB7r7aazeahSYkeV78BB5TZoNz3hMZgKTqi6RWVPvckBKT5hUWngS617JgEttVbX6xVXevN",
      					"BHPNf9NTwzGYNy4Cj3n6zeupAKzrNLZWG8",25);
      std::cout << std::endl;      					  
 
      std::cout << "Tests #6  (validate) TESTNET_NETWORKID = 38" << std::endl;      
      validate_keys(	"6a2qkydNpWyvc6EBssLXfzgChE32xGYN9V8h6AxwAVdNeusLyYw",
      					"NBJsyih8ZDiA6Ho9kZjj3FM65TU1mRvo233StnPWKjYxUZCRf1uTEJMN1wrDowYm8JUAwWYragcrcCFg2DTzBqfd",
      					"GWEujWzAvGd3EbuPGPeBbomLUQNFYDSert",38);  
      std::cout << std::endl;
 
      
	}
	catch (std::exception& e) {
		std::cerr << "exception: " << e.what() << "\n";
	}

	return 0;
}