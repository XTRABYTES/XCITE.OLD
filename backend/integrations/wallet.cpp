/**
 * Filename: Wallet.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include "wallet.hpp"
#include "../xutility/xutility.hpp"
#include "../staticnet/staticnet.hpp"

Wallet::Wallet(QObject *parent) : QObject(parent)
{
}

void Wallet::helpEntry() {
     xUtility.CheckUserInputForKeyWord("!!xutil help");
}

bool Wallet::helpReply(QString help1, QString help2, QString help3, QString help4) {
    emit help(help1, help2, help3, help4);
}

void Wallet::networkEntry(QString network) {

    QString setNetwork = "!!xutil network " + network;
    xUtility.CheckUserInputForKeyWord(setNetwork);
}

bool Wallet::networkReply(QString network) {
    emit networkStatus(network);
}

void Wallet::createKeypairEntry(QString network) {

    qDebug() << "request to create keypair received";

    QString setNetwork = "!!xutil network " + network;
    QString createKeys = "!!xutil createkeypair";

    xUtility.CheckUserInputForKeyWord(setNetwork);
    xUtility.CheckUserInputForKeyWord(createKeys);
}

bool Wallet::newKeypair(QString address, QString pubKey, QString privKey) {
    emit newKeypairCreated(address, pubKey, privKey);
}

bool Wallet::keypairFailed() {
    emit newKeypairFailed();
}

void Wallet::importPrivateKeyEntry(QString network, QString privKey) {

    QString setNetwork = "!!xutil network " + network;
    QString importKeys = "!!xutil privkey2address " + privKey;

    xUtility.CheckUserInputForKeyWord(setNetwork);
    xUtility.CheckUserInputForKeyWord(importKeys);

}

bool Wallet::addressExtracted(QString privKey, QString pubKey, QString addressID) {
    emit addressExtractedSucceeded(privKey, pubKey, addressID);
}

bool Wallet::badkey() {
    emit addressExtractedFailed();
}


void Wallet::sendCoinsEntry(QString msg) {

    qDebug() << "send coins requested!";

    //QString setNetwork = "!!xutil network " + network;
    QString sendCoins = "!!staticnet sendcoin " + msg;

    //xUtility.CheckUserInputForKeyWord(setNetwork);
    // staticNet.CheckUserInputForKeyWord(sendCoins);  no direct call ! need use the integration methods

}
