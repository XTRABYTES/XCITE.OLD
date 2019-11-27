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

#include <QTimer>
#include <QSettings>
#include "MarketValue.hpp"

MarketValue::MarketValue(QObject *parent) : QObject(parent)
{
}

void MarketValue::DownloadManagerHandler(URLObject *url){

    DownloadManager *manager = manager->getInstance();
    url->addProperty("url",url->getUrl());
    url->addProperty("class","MarketValue");

    manager->append(url);
    connect(manager,  SIGNAL(readFinished(QByteArray,QMap<QString,QVariant>)), this,SLOT(DownloadManagerRouter(QByteArray,QMap<QString,QVariant>)),Qt::UniqueConnection);
}

void MarketValue::DownloadManagerRouter(QByteArray response, QMap<QString,QVariant> props){

    if (props.value("class").toString() == "MarketValue"){

        QString route = props.value("route").toString();
        if (route == "findCurrencyValueSlot"){
               findCurrencyValueSlot(response, props);
        }else if (route == "checkInternetSlot"){
            checkInternetSlot(response,props);
        }
    }
}

void MarketValue::findCurrencyValue(QString currency) {
    QUrl Url;
    Url.setScheme("http");
    Url.setHost("37.59.57.212");
    Url.setPort(8080);
    Url.setPath("/v1/marketvalue/" + currency);

    URLObject urlObj {Url};
    urlObj.addProperty("route","findCurrencyValueSlot");
    urlObj.addProperty("currency",currency);
    DownloadManagerHandler(&urlObj);

}

void MarketValue::findCurrencyValueSlot(QByteArray response, QMap<QString,QVariant> props){
    QString currencyValue = QString::fromStdString(response.toStdString());
    QString currency = props.value("currency").toString();
    if (!currencyValue.isNull() && !currencyValue.isEmpty()){
        currencyValue.remove(0, 1).chop(2);
       // setMarketValue(currency + ":" + currencyValue, currency, currencyValue);
        emit marketValueChanged(currency, currencyValue);
        qDebug() << currency + ":" + currencyValue;
    }
}

void MarketValue::findAllCurrencyValues(){
    if (checkInternet("http://37.59.57.212:8080")) {
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
        qDebug() << "no connection to coin info server";
        emit noInternet();
        return;
    }
}

void MarketValue::setMarketValue(const QString &check, const QString &currency, const QString &currencyValue) {
    if (check != m_marketValue) {
        m_marketValue = check;
        emit marketValueChanged(currency, currencyValue);
    }
}

bool MarketValue::checkInternet(QString url){
    bool internetStatus = false;

    QEventLoop loop;
        QTimer *timeout = new QTimer();
        timeout->setSingleShot(true);
        timeout->start(6000);
        connect(timeout, SIGNAL(timeout()), &loop, SLOT(quit()),Qt::QueuedConnection);
        auto connectionHandler = connect(this, &MarketValue::internetStatusSignal, [&internetStatus, &loop](bool checked) {
            internetStatus = checked;
            loop.quit();

        });
        URLObject urlObj {QUrl(url)};
        urlObj.addProperty("route","checkInternetSlot");
        DownloadManagerHandler(&urlObj);
    loop.exec();
    disconnect(connectionHandler);

    return internetStatus;
}

void MarketValue::checkInternetSlot(QByteArray response, QMap<QString,QVariant> props){
    if (response != ""){
       emit internetStatusSignal(true);
    }else{
        emit internetStatusSignal(false);
    }
}
