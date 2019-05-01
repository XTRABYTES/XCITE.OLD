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
#include <boost/algorithm/string.hpp>

#include "transaction.h"

int main(int argc, char *argv[])
{
	setlocale(LC_ALL, "");
	
	try {

      std::cout << "Tests #1 create signed raw xfuel transaction" << std::endl;
       
      std::vector<std::string> xf_inputs;
      xf_inputs.push_back("00f54ee63cdcfa8a3252e2cd995b960287bf38bfe2a399a9bb19544bbf2028a3,1,76a91416c9b41e22ab3436e7c2099e14196bda77d948b888ac,20"); 
      xf_inputs.push_back("02a98689c6847fcb0edc53ab330498669d687b68bd828006bed77173394f40f8,0,76a91416c9b41e22ab3436e7c2099e14196bda77d948b888ac,10");

      std::vector<std::string> xf_outputs;
      xf_outputs.push_back("FBCMNhonjRxELB2UrxNGHgAusPnNHvsMUi,18"); 
      xf_outputs.push_back("F7ubxddgvGoG7VRsAxoiTH56JaJZErNtas,11");

      std::string xf_privkey="R9fXvzTuqz9BqgyiV4tmiY2LkioUq7GxKGTcJibruKpNYitutbft";

      unsigned char xf_network_id = 35; // 35 = XFUEL network
      std::string xf_RawTransaction = CreateRawTransaction( xf_network_id, xf_inputs, xf_outputs, xf_privkey);
      
      std::cout << "Raw transaction: " << xf_RawTransaction << std::endl;

      std::cout << "Tests #2 create signed raw xfuel transaction using invalid network" << std::endl;

      unsigned char iv_network_id = 33; // Invalid network      
      std::string iv_RawTransaction = CreateRawTransaction( iv_network_id, xf_inputs, xf_outputs, xf_privkey);
      std::cout << "Invalid raw transaction: [" << iv_RawTransaction << "]" << std::endl;

      std::cout << "Tests #3 create signed raw testnet transaction" << std::endl;
       
      std::vector<std::string> tn_inputs;
      tn_inputs.push_back("1e0c16ee32cb3b3bbc13cda41f0a4981b7246fcd551f6e31e89e26698fd2587b,0,76a914b8a03f679b51c6e6a4f3d92e56c900d7918981fc88ac,221018.00000000"); 

      std::vector<std::string> tn_outputs;
      tn_outputs.push_back("GQufCtACUjYdBycKb9kaJXF8bbV9aHryJ2,9.87654321"); 
      tn_outputs.push_back("Gag8idMPazxaSatdu9LmKk8EPdbuHrnpMA,221007.12345679");

      std::string tn_privkey="RgeFarE5WTUMmuHtHfGt7B23sL7VoWGeyiGJ1Yrzrz6Jc3zMN1rU";

      unsigned char tn_network_id = 38; // 38 = TESTNET network
      std::string tn_RawTransaction = CreateRawTransaction( tn_network_id, tn_inputs, tn_outputs, tn_privkey);
      
      std::cout << "Raw transaction: " << tn_RawTransaction << std::endl;

     
	}
	catch (std::exception& e) {
		std::cerr << "exception: " << e.what() << "\n";
	}

	return 0;
}
