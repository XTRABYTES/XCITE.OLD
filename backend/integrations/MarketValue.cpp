/**
 * Filename: MarketValue.cpp
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
#include <QTimer>
#include <QSettings>
#include "MarketValue.hpp"

MarketValue::MarketValue(QObject *parent) : QObject(parent)
{
}

void MarketValue::findCurrencyValue(QString currency) {
    QUrl Url;
    Url.setScheme("http");
    Url.setHost("37.59.57.212");
    Url.setPort(8080);
    Url.setPath("/v1/marketvalue/" + currency);

    QNetworkRequest request;
    request.setUrl(Url);

    QNetworkAccessManager *restclient;
    restclient = new QNetworkAccessManager(this);
    request.setRawHeader("Accept", "application/json");

    QNetworkReply *reply = restclient->get(request);
    QByteArray bytes = reply->readAll();
    QTimer getTimer; // let's use a 10 second period for timing out the GET opn


    QEventLoop loop;
    QTimer::connect(&getTimer,SIGNAL(timeout()),&loop, SLOT(quit()));
    connect(reply, SIGNAL(finished()), &loop, SLOT(quit()));
    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)), &loop, SLOT(quit()));
    QObject::connect(restclient, SIGNAL(finished(QNetworkReply*)), &loop, SLOT(quit()));

    getTimer.start(10000); // 10000 milliSeconds wait period for get() method to work properly

    loop.exec();

    QString currencyValue = QString::fromStdString(reply->readAll().toStdString());
    if (!currencyValue.isNull() && !currencyValue.isEmpty()){
        currencyValue.remove(0, 1).chop(2);
        setMarketValue(currency + ":" + currencyValue, currency, currencyValue);
        qDebug() << currency + ":" + currencyValue;
    }

    reply->close();
    delete reply;

}

void MarketValue::findAllCurrencyValues(){
    if (checkInternet()) {
        findCurrencyValue("btcusd");
        findCurrencyValue("btceur");
        findCurrencyValue("btcgbp");
        findCurrencyValue("xbybtc");
        findCurrencyValue("xbycha");
        findCurrencyValue("xflbtc");
        findCurrencyValue("xflcha");
        findCurrencyValue("btccha");
        findCurrencyValue("ethbtc");
        findCurrencyValue("ethcha");
        return;
    }else {
        return;
    }
}

void MarketValue::setMarketValue(const QString &check, const QString &currency, const QString &currencyValue) {
    if (check != m_marketValue) {
        m_marketValue = check;
        emit marketValueChanged(currency, currencyValue);
    }
}

bool MarketValue::checkInternet(){
    bool connected = false;
    QNetworkAccessManager nam;
    QNetworkRequest req(QUrl("http://www.google.com"));
    QNetworkReply* reply = nam.get(req);
    QEventLoop loop;
    QTimer getTimer;
    QTimer::connect(&getTimer,SIGNAL(timeout()),&loop, SLOT(quit()));

    connect(reply, SIGNAL(finished()), &loop, SLOT(quit()));

    getTimer.start(4000);
    loop.exec();
    if (reply->bytesAvailable()){
        connected=true;
    }else{
    }

    reply->close();
    delete reply;

    return connected;

}
