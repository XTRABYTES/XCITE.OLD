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

#include <QSettings>
#include "MarketValue.hpp"

MarketValue::MarketValue(QObject *parent) : QObject(parent)
{
}

void MarketValue::findXBYValue(QString currency)
{
    QSettings appSettings;
    appSettings.setValue("defaultCurrency", currency);

    QNetworkRequest request(QUrl("https://api.coinmarketcap.com/v1/ticker/xtrabytes/?convert="+currency));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QNetworkAccessManager *restclient = new QNetworkAccessManager(this);
    connect(restclient, SIGNAL(finished(QNetworkReply*)), this, SLOT(onFinished(QNetworkReply*)));

    QNetworkReply* reply = restclient->get(request);
    reply->setProperty("selectedCurrency", currency);
}

void MarketValue::onFinished(QNetworkReply* reply)
{
    if (reply->error()) {
        qDebug() << reply->errorString();
        return;
    }

    QString selectedCurrency = reply->property("selectedCurrency").toString();

    QString marketValue = "";
    QString strReply = (QString)reply->readAll();
    QJsonDocument priceDataDoc = QJsonDocument::fromJson(strReply.toUtf8());
    QJsonArray priceDataArray = priceDataDoc.array();
    foreach (const QJsonValue &value, priceDataArray){
        QJsonObject jsonObj = value.toObject();
        marketValue = jsonObj["price_"+selectedCurrency.toLower()].toString();
    }
    setMarketValue(marketValue);
}

