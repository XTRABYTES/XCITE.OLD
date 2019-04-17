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

void Wallet::networkEntry(QString netwrk) {

    QString setNetwork = "!!xutil network " + netwrk;
    xUtility.CheckUserInputForKeyWord(setNetwork);
}

void Wallet::createKeypairEntry(QString network) {

    qDebug() << "request to create keypair received";

    QString setNetwork = "!!xutil network " + network;
    QString createKeys = "!!xutil createkeypair";

    xUtility.CheckUserInputForKeyWord(setNetwork);
    xUtility.CheckUserInputForKeyWord(createKeys);
}

void Wallet::importPrivateKeyEntry(QString network, QString privKey) {

    QString setNetwork = "!!xutil network " + network;
    QString importKeys = "!!xutil privkey2address " + privKey;

    xUtility.CheckUserInputForKeyWord(setNetwork);
    xUtility.CheckUserInputForKeyWord(importKeys);

}


void Wallet::sendCoinsEntry(QString network, QString msg) {

    QString setNetwork = "!!xutil network " + network;
    QString sendCoins = "!!staticnet sendcoin " + msg;

    xUtility.CheckUserInputForKeyWord(setNetwork);
    staticNet.CheckUserInputForKeyWord(sendCoins);

}
