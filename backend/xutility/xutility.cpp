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
#include "../staticnet/staticnet.hpp"
#include "./crypto/ctools.h"
#include "./transaction/transaction.h"

Xutility xUtility;

Xutility::Xutility(QObject *parent) : QObject(parent) {
    this->Initialize();
}

void Xutility::Initialize() {

    if (!xutility_initialised) {
        networks.push_back("nothing");
        networks.push_back("xfuel");
        networks.push_back("xtrabytes");
        networks.push_back("testnet");
        network=networks.begin();
        xutility_initialised = true;
    }
}

unsigned char Xutility::getNetworkid(std::vector<std::string>::iterator network_iterator ) const {
    std::string selected_network = *network_iterator;
    if ( selected_network.compare("xfuel") == 0 ) return 35;
    if ( selected_network.compare("xtrabytes") == 0 ) return 25;
    if ( selected_network.compare("testnet") == 0 ) return 38;
    return 0;
}


unsigned char Xutility::getSelectedNetworkid() const {
    return getNetworkid(network);
}


std::string Xutility::getSelectedNetworkName() const {
	return *network; 
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
    } else if (command == "privkey2address") {
        privkey2address(params);
    } else {
        xchatRobot.SubmitMsg("Bad !!xutil command. Ignored.");
        xchatRobot.SubmitMsg("More informations: !!xutil help");
    }
}

void Xutility::help() {
    xchatRobot.SubmitMsg("!!xutil usage informations:");
    xchatRobot.SubmitMsg("!!xutil network [net]");
    QString help1 = "!!xutil network";
    xchatRobot.SubmitMsg("!!xutil createkeypair");
    QString help2 = "!!xutil createkeypair [xtrabytes/xfuel]";
    xchatRobot.SubmitMsg("!!xutil privkey2address [privkey]");
    QString help3 = "!!xutil privkey2address [xtrabytes/xfuel] [privkey]";
    QString help4 = "!!staticnet sendcoin [target] [amount] [privatekey]";

    emit helpReply(help1, help2, help3, help4);

}


void Xutility::privkey2address(const QJsonArray *params) {

    if (getNetworkid(network) != 0) {

        std::string secret = params->at(2).toString().toStdString();
        QString privKey = params->at(2).toString();
        CXCiteSecret xciteSecret;
        bool fGood = xciteSecret.SetString(secret,getNetworkid(network));
        if (!fGood) {
            qDebug()<< "Invalid private key";
            xchatRobot.SubmitMsg("Invalid private key");

            emit badKey();

        } else {

            CKey key = xciteSecret.GetKey();
            CPubKey xcpubkey = key.GetPubKey();
            std::string pubkeyHex = HexStr(xcpubkey.begin(), xcpubkey.end());
            std::vector<unsigned char> pubkeyBin = ParseHexcstr(pubkeyHex.c_str());
            std::string pubkeyBase58 = EncodeBase58(pubkeyBin);
            qDebug() << "Public key: "+QString::fromStdString(pubkeyBase58);
            xchatRobot.SubmitMsg("Public key: "+QString::fromStdString(pubkeyBase58));
            QString pubKey = QString::fromStdString(pubkeyBase58);

            CKeyID xciteAddresskeyID = xcpubkey.GetID();
            std::string XciteGenAddressStr = CXCiteAddress(xciteAddresskeyID,getNetworkid(network)).ToString();
            qDebug() << "Address: "+QString::fromStdString(XciteGenAddressStr);
            xchatRobot.SubmitMsg("Address: "+QString::fromStdString(XciteGenAddressStr));
            QString addressID = QString::fromStdString(XciteGenAddressStr);

            emit addressExtracted(privKey, pubKey, addressID);

        }

    } else {
        qDebug()<< "Bad or mising network ID.";
        xchatRobot.SubmitMsg("Bad or mising network ID.");
    }
}

void Xutility::createKeypairEntry(QString network) {

    QString setNetwork = "!!xutil network " + network;
    QString createKeys = "!!xutil createkeypair";
    
    this->CheckUserInputForKeyWord(setNetwork);
    this->CheckUserInputForKeyWord(createKeys);

}

void Xutility::helpEntry() {

    help();
}

void Xutility::networkEntry(QString netwrk) {

    qDebug() << "accessing xutil";
    QString setNetwork = "!!xutil network " + netwrk;
    this->CheckUserInputForKeyWord(setNetwork);
}

void Xutility::importPrivateKeyEntry(QString network, QString privKey) {

    QString setNetwork = "!!xutil network " + network;
    QString importKeys = "!!xutil privkey2address " + privKey;

    this->CheckUserInputForKeyWord(setNetwork);
    this->CheckUserInputForKeyWord(importKeys);

}

void Xutility::createkeypair(const QJsonArray *params) {

    qDebug()<< "New keypaird for ["+QString::fromStdString(*network)+"] network:";
    xchatRobot.SubmitMsg("New keypaird for ["+QString::fromStdString(*network)+"] network:");

    if (getNetworkid(network) != 0) {

        CKey key;
        CPubKey pubkey;
        key.MakeNewKey(false);
        pubkey = key.GetPubKey();
        CKeyID keyID = pubkey.GetID();

        std::string pubkeyHex = HexStr(pubkey.begin(), pubkey.end());
        std::vector<unsigned char> pubkeyBin = ParseHexcstr(pubkeyHex.c_str());
        std::string pubkeyBase58 = EncodeBase58(pubkeyBin);

        QString address = QString::fromStdString(CXCiteAddress(keyID,getNetworkid(network)).ToString());
        QString pubKey = QString::fromStdString(pubkeyBase58);
        QString privKey = QString::fromStdString(CXCiteSecret(key,getNetworkid(network)).ToString());
        qDebug()<< "Private key: "+ privKey;
        qDebug()<< "Public key: "+ pubKey;
        qDebug()<< "Address: "+ address;

        emit keyPairCreated(address, pubKey, privKey);


        xchatRobot.SubmitMsg("Private key: "+QString::fromStdString(CXCiteSecret(key,getNetworkid(network)).ToString()));
        xchatRobot.SubmitMsg("Public key: "+QString::fromStdString(pubkeyBase58));
        xchatRobot.SubmitMsg("Address: "+QString::fromStdString(CXCiteAddress(keyID,getNetworkid(network)).ToString()));
    } else {
        qDebug()<< "Bad or mising network ID.";
        xchatRobot.SubmitMsg("Bad or mising network ID.");

        emit createKeypairFailed();

    }
}

void Xutility::set_network(const QJsonArray *params) {

    if (params->at(2).toString()=="") {
        xchatRobot.SubmitMsg("Active network: "+QString::fromStdString(*network));
        QString myNetwork = ("Active network: "+QString::fromStdString(*network));
        emit networkStatus(myNetwork);


    } else {
        bool param_valid=false;
        QString networktypes;
        QString currentNetwork;
        for(std::vector<std::string>::iterator i = networks.begin(); i != networks.end(); ++i) {
            networktypes += ( (i != networks.begin()) ? ",":"" ) + QString::fromStdString(*i);
            if ( params->at(2).toString() == QString::fromStdString(*i) ) {
                param_valid=true;
                network=i;
            }
        }

        if (param_valid) {
            xchatRobot.SubmitMsg("New active network: "+QString::fromStdString(*network));
            currentNetwork = ("Current network: "+QString::fromStdString(*network));
            qDebug() << currentNetwork;
            emit newNetwork(currentNetwork);

        } else {
            xchatRobot.SubmitMsg("("+params->at(2).toString()+") is invalid network type. Existing types are:"+networktypes);
            xchatRobot.SubmitMsg("Active network: "+QString::fromStdString(*network));
            QString networkFault = ("("+params->at(2).toString()+") is invalid network type. Existing types are:"+networktypes);
            qDebug() << networkFault;
            emit badNetwork(networkFault);

        }

    }
}



