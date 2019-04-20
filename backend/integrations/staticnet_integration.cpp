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

#include "../xutility/xutility.hpp"
#include "staticnet_integration.hpp"

staticnet_integration::staticnet_integration(QObject *parent) : QObject(parent)
{
}

void staticnet_integration::sendCoinsEntry(QString msg) {

    qDebug() << "send coins requested!";

    //QString setNetwork = "!!xutil network " + network;
    QString sendCoins = "!!staticnet sendcoin " + msg;

    //xUtility.CheckUserInputForKeyWord(setNetwork);
    staticNet.CheckUserInputForKeyWord(sendCoins);

}

void staticnet_integration::onResponsefromStaticnet(QJsonArray response) {
     qDebug() << "staticnet response recevied";
}
