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

      std::cout << "Tests #1 create signed raw transaction" << std::endl;
 
      CTransaction TransactionRet;
      
      std::vector<std::string> inputs;
      inputs.push_back("00f54ee63cdcfa8a3252e2cd995b960287bf38bfe2a399a9bb19544bbf2028a3,1,76a91416c9b41e22ab3436e7c2099e14196bda77d948b888ac,20"); 
      inputs.push_back("02a98689c6847fcb0edc53ab330498669d687b68bd828006bed77173394f40f8,0,76a91416c9b41e22ab3436e7c2099e14196bda77d948b888ac,10");

      std::vector<std::string> outputs;
      outputs.push_back("FBCMNhonjRxELB2UrxNGHgAusPnNHvsMUi,18"); 
      outputs.push_back("F7ubxddgvGoG7VRsAxoiTH56JaJZErNtas,11");

      std::string privkey="R9fXvzTuqz9BqgyiV4tmiY2LkioUq7GxKGTcJibruKpNYitutbft";

      std::string RawTransaction = CreateRawTransaction( inputs, outputs, privkey);
      
      std::cout << "Raw transaction: " << RawTransaction << std::endl;
     
	}
	catch (std::exception& e) {
		std::cerr << "exception: " << e.what() << "\n";
	}

	return 0;
}