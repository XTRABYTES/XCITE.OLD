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

void staticnet_integration::pingRequestEntry(QString msg) {

    qDebug() << "ping requested";
    int _traceID;
    QString sendPing = "!!staticnet sping " + msg;
    if (staticNet.CheckUserInputForKeyWord(sendPing, &_traceID)) {
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

    if (sender == "SendcoinWorker::process") {
        if (error == "") {
            emit validParams(traceid);
            qDebug() << "Valid parameters for sendcoin, traceID: " + traceid;
        }
        else {
            emit sendCoinsFailure(error, traceid);
            emit badParams();
            qDebug() << "Invalid parameters for sendcoin, error: " + error + ", traceID: " + traceid;
        }
    }

    else if (sender == "SendcoinWorker::txbroadcast_request") {
        if (params == true) {
            emit validParams(traceid);
            qDebug() << "Valid parameters for sendcoin, traceID: " + traceid;
        }
        else {
            emit sendCoinsFailure(error, traceid);
            emit badParams();
            qDebug() << "Invalid parameters for sendcoin, traceID: " + traceid;
        }
    }

    else if (sender == "SendcoinWorker::unspent_onResponse") {
        if (!error.isNull()) {
            emit sendCoinsFailure(error, traceid);
            emit badRawTX(traceid);
            qDebug() << "bad raw transaction, error: " + error + ", traceID: " + traceid;
        }
        else {
            qDebug() << "Valid raw transaction, traceID: " + traceid;
        }
    }

    else if (sender ==  "SendcoinWorker::txbroadcast_onResponse") {
        if (txid == ""){
            emit sendCoinsFailure(error, traceid);
            qDebug() << "Transaction not broadcasted, traceID: " + traceid;
        }else{
            emit sendCoinsSuccess(txid, traceid);
            qDebug() << "Transaction broadcasted, transactionId: " + txid + " traceID: " + traceid;
        }
    }

    QString json_string = json_doc.toJson();
    qDebug() << json_string;
}
