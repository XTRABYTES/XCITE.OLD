/**
 * Filename: Explorer.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include <QEventLoop>
#include <QSettings>
#include "Explorer.hpp"

Explorer::Explorer(QObject *parent) : QObject(parent)
{
}

void Explorer::getBalanceEntireWallet(QString walletList){

    QJsonArray walletArray = QJsonDocument::fromJson(walletList.toLatin1()).array();
    foreach (const QJsonValue & value, walletArray) {
        QJsonObject obj = value.toObject();
        QString coin = obj.value("name").toString().toLower();
        QString address = obj.value("address").toString();
        if (coin.length() > 0){
            if ((coin == "xby") || (coin == "xfuel")){
                QString response =  getBalanceAddress(coin,address);
                QJsonDocument jsonResponse = QJsonDocument::fromJson(response.toLatin1());
                QJsonObject result = jsonResponse.object().value("result").toObject();
                QString balance = result.value("balance_current").toString();
                balance = balance.insert(balance.length() - 8, ".");
                emit updateBalance(coin.toUpper(),address, balance);
            }
        }
    }
}

QString Explorer::getBalanceAddress(QString coin, QString address){
    QString balance = "";
    QString url = "https://xtrabytes.global/api/"+ coin + "/address/" + address;

    QUrl Url;
    Url.setPath(url);

    QEventLoop eventLoop;
    QNetworkAccessManager mgr;
    QObject::connect(&mgr, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    QJsonObject json;

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Accept", "application/json");

    QSslConfiguration conf = request.sslConfiguration();
    conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    request.setSslConfiguration(conf);

    QNetworkReply *reply = mgr.get(request);
    eventLoop.exec();

    QString strReply = (QString)reply->readAll();
    return strReply;
}

void Explorer::onResult(QNetworkReply *reply){

}
