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

#include <QDebug>
#include "../xutility/xutility.hpp"
#include "xutility_integration.hpp"

xutility_integration::xutility_integration(QObject *parent) : QObject(parent)
{
}

void xutility_integration::helpEntry() {
     xUtility.CheckUserInputForKeyWord("!!xutil help");
}

void xutility_integration::networkEntry(QString network) {

    QString setNetwork = "!!xutil network " + network;
    xUtility.CheckUserInputForKeyWord(setNetwork);
}

void xutility_integration::createKeypairEntry(QString network) {

    qDebug() << "request to create keypair received";

    QString setNetwork = "!!xutil network " + network;
    QString createKeys = "!!xutil createkeypair";

    xUtility.CheckUserInputForKeyWord(setNetwork);
    xUtility.CheckUserInputForKeyWord(createKeys);
}

void xutility_integration::importPrivateKeyEntry(QString network, QString privKey) {

    QString setNetwork = "!!xutil network " + network;
    QString importKeys = "!!xutil privkey2address " + privKey;

    xUtility.CheckUserInputForKeyWord(setNetwork);
    xUtility.CheckUserInputForKeyWord(importKeys);

}
