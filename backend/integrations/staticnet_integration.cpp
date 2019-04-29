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
#include "../staticnet/staticnet.hpp"
#include "staticnet_integration.hpp"

staticnet_integration::staticnet_integration(QObject *parent) : QObject(parent)
{
}

void staticnet_integration::sendCoinsEntry(QString msg) {

    qDebug() << "send coins requested!";
    int _traceID;
    QString sendCoins = "!!staticnet sendcoin " + msg;
    if (staticNet.CheckUserInputForKeyWord(sendCoins, &_traceID)) {
        qDebug() << "staticnet command accepted";
    } else {
        qDebug() << "staticnet command not accepted";
    }
    
}


void staticnet_integration::onResponseFromStaticnetEntry(QJsonObject response) {
    qDebug() << "staticnet response recevied:";

    QJsonDocument json_doc(response);
    QString error = response.value("error").toString();
    QString sender = response.value("sender").toString();
    QJsonValue params = response.value("params");
    QJsonObject result = json_doc.object().value("params").toObject();
    QString txid = result.value("txid").toString();
    QString traceid = response.value("traceID").toString();

    if (sender == "SendcoinWorker::txbroadcast_request") {
        if (params == true) {
            emit validParams(traceid);
            qDebug() << "Valid parameters for sendcoin, traceId: " + traceid;
        }
        else {
            emit badParams();
            qDebug() << "Invalid parameters for sendcoin";
        }
    }

    else if (sender == "SendcoinWorker::unspent_onResponse") {
        emit badRawTX(traceid);
        qDebug() << "bad raw transaction, traceid: " + traceid;
    }

    else if (sender ==  "SendcoinWorker::txbroadcast_onResponse") {
        if (txid != ""){
            emit sendCoinsSuccess(txid, traceid);
            qDebug() << "transactionId: " + txid + " traceId: " + traceid;
        }else{
            emit sendCoinsFailure(error, traceid);
            qDebug() << "ERROR: " + error + " traceId: " + traceid;

        }
    }

    QString json_string = json_doc.toJson();
    qDebug() << json_string;
}
