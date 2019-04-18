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
#include <QSettings>
#include "MarketValue.hpp"

MarketValue::MarketValue(QObject *parent) : QObject(parent)
{
}

void MarketValue::findCurrencyValue(QString currency)
{
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

    QEventLoop loop;
    connect(reply, SIGNAL(finished()), &loop, SLOT(quit()));
    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)), &loop, SLOT(quit()));
    loop.exec();

    QString currencyValue = QString::fromStdString(reply->readAll().toStdString());
    currencyValue.remove(0, 1).chop(2);
    setMarketValue(currency + ":" + currencyValue, currency, currencyValue);
    qDebug() << currency + ":" + currencyValue;
}

void MarketValue::findAllCurrencyValues(){
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
}

void MarketValue::setMarketValue(const QString &check, const QString &currency, const QString &currencyValue) {
    if (check != m_marketValue) {
        m_marketValue = check;
        emit marketValueChanged(currency, currencyValue);
    }
}
