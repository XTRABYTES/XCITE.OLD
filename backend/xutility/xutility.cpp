/**
 * Filename: xutility.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include <iostream>
#include <QDebug>
#include "xutility.hpp"
#include "../xchat/xchat.hpp"
#include "./crypto/ctools.h"
	
Xutility xUtility;

void Xutility::Initialize() {
		
	  networks.push_back("nothing");
     networks.push_back("xfuel");
     networks.push_back("xtrabytes");
     networks.push_back("testnet");
     network=networks.begin();          

}



bool Xutility::CheckUserInputForKeyWord(const QString msg) {
	
	 QStringList args = msg.split(" ");

    QJsonArray params; 
    
    for (QStringList::const_iterator it = args.constBegin(); it != args.constEnd(); ++it) params.append(QJsonValue(*it));	 	 
	 	 
	 if (params.at(0).toString() == "!!xutil") {
	    CmdParser(&params);
	    return true;
	 }
	 	      
    return false;
}


void Xutility::CmdParser(const QJsonArray *params) {

    QString command = params->at(1).toString();

    if (command == "help") {
    	  help();                

    } else if (command == "network") {
        set_network(params); 
    } else if (command == "createkeypair") {
        createkeypair(params); 

    } else {
      xchatRobot.SubmitMsg("Bad !!xutil command. Ignored.");
      xchatRobot.SubmitMsg("More informations: !!xutil help");   
    }        
}

void Xutility::help() {
   xchatRobot.SubmitMsg("!!xutil usage informations:");
   xchatRobot.SubmitMsg("!!xutil network [net]");
   xchatRobot.SubmitMsg("!!xutil createkeypair");
}

void Xutility::createkeypair(const QJsonArray *params) {
	
     xchatRobot.SubmitMsg("New keypaird for ["+QString::fromStdString(*network)+"] network:");
     CKey key;
     CPubKey pubkey;
     key.MakeNewKey(false);
     pubkey = key.GetPubKey();
     CKeyID keyID = pubkey.GetID();

      std::string pubkeyHex = HexStr(pubkey.begin(), pubkey.end());
      std::vector<unsigned char> pubkeyBin = ParseHexcstr(pubkeyHex.c_str());
      std::string pubkeyBase58 = EncodeBase58(pubkeyBin);
      
      xchatRobot.SubmitMsg("Private key: "+QString::fromStdString(CXCiteSecret(key).ToString()));
      xchatRobot.SubmitMsg("Public key: "+QString::fromStdString(pubkeyBase58));
      xchatRobot.SubmitMsg("Address: "+QString::fromStdString(CXCiteAddress(keyID).ToString()));
     
}

void Xutility::set_network(const QJsonArray *params) {
	
	 if (params->at(2).toString()=="") {
	      xchatRobot.SubmitMsg("Acttive network:"+QString::fromStdString(*network));

	 } else { 
	    bool param_valid=false;
	    QString networktypes;
	    for(std::vector<std::string>::iterator i = networks.begin(); i != networks.end(); ++i) {
       	 networktypes += ( (i != networks.begin()) ? ",":"" ) + QString::fromStdString(*i);
       	 if ( params->at(2).toString() == QString::fromStdString(*i) ) {
       	 	param_valid=true;
       	 	network=i;
       	 }       
       }

       if (param_valid) {
          xchatRobot.SubmitMsg("New acttive network:"+QString::fromStdString(*network));

       } else {
           xchatRobot.SubmitMsg("("+params->at(2).toString()+") is invalid network type. Existing types is:"+networktypes);
           xchatRobot.SubmitMsg("Acttive network:"+QString::fromStdString(*network));                                 
       }
       
	 }    
}


