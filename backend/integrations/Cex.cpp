/**
 * Filename: Cex.cpp
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
#include "Cex.hpp"
#include "../xchat/xchat.hpp"
#include <QWindow>
#include <QDateTime>

Cex::Cex(QObject *parent) : QObject(parent)
{
}

void Cex::DownloadManagerHandler(URLObject *url){
    DownloadManager *manager = manager->getInstance();
    url->addProperty("url",url->getUrl());
    url->addProperty("class","Cex");
    manager->append(url);

    connect(manager,  SIGNAL(readFinished(QByteArray,QMap<QString,QVariant>)), this,SLOT(DownloadManagerRouter(QByteArray,QMap<QString,QVariant>)),Qt::UniqueConnection);
}

void Cex::DownloadManagerRouter(QByteArray response, QMap<QString,QVariant> props){
    if (props.value("class").toString() == "Cex"){
        QString route = props.value("route").toString();

        if (route == "getCoinInfoSlot"){
            getCoinInfoSlot(response, props);
        }else if (route == "getRecentTradesSlot"){
            getRecentTradesSlot(response,props);
        }else if (route == "getOlhcvSlot"){
            getOlhcvSlot(response,props);
        }else if (route == "createOlhcvSlot"){
            createOlhcvSlot(response,props);
        }else if (route == "getOrderBookSlot"){
            getOrderBookSlot(response,props);
        }
    }
}

void Cex::getCoinInfo(QString exchange, QString pair) {
    QUrl url;
    if (exchange == "probit") {
        url = "https://api.probit.com/api/exchange/v1/ticker?market_ids=" + pair;
    }
    else if (exchange == "crex24") {
        url = "https://api.crex24.com/v2/public/tickers?instrument=" + pair;
    }

    URLObject urlObj {QUrl(url)};
    urlObj.addProperty("route","getCoinInfoSlot");
    urlObj.addProperty("exchange",exchange);
    urlObj.addProperty("pair",pair);
    DownloadManagerHandler(&urlObj);
}

void Cex::getRecentTrades(QString exchange, QString pair, QString limit) {
    QUrl url;
    if (exchange == "probit") {
        // time format: YYYY-mm-ddThh:ii:ssZ
        startTime = QDateTime::currentMSecsSinceEpoch();
        QDateTime timestamp1 = QDateTime::fromMSecsSinceEpoch(startTime);
        startTimeStr = timestamp1.toString("YYYY-mm-ddThh:ii:ssZ");
        endTime = QDateTime::currentMSecsSinceEpoch() - 86400000;
        QDateTime timestamp2 = QDateTime::fromMSecsSinceEpoch(endTime);
        endTimeStr = timestamp2.toString("YYYY-mm-ddThh:ii:ssZ");

        url = "https://api.probit.com/api/exchange/v1/trade?market_id=" + pair + "&start_time=" + startTimeStr + "&end_time=" + endTimeStr + "&limit=" + limit;
    }
    else if (exchange == "crex24") {
        url = "https://api.crex24.com/v2/public/recentTrades?instrument=" + pair + "LTC-BTC&limit=" + limit;
    }

    URLObject urlObj {QUrl(url)};
    urlObj.addProperty("route","getRecentTradesSlot");
    urlObj.addProperty("exchange",exchange);
    urlObj.addProperty("pair",pair);
    DownloadManagerHandler(&urlObj);
}

void Cex::getOlhcv(QString exchange, QString pair, QString granularity) {
    QUrl url;
    if (exchange == "probit") {
        count = 0;
        createOlhcv(exchange, pair, granularity);
        return;
    }
    else if (exchange == "crex24") {
        url = "https://api.crex24.com/v2/public/ohlcv?instrument=" + pair + "&granularity=" + granularity;
    }

    URLObject urlObj {QUrl(url)};
    urlObj.addProperty("route","getOlhcvSlot");
    urlObj.addProperty("exchange",exchange);
    urlObj.addProperty("pair",pair);
    DownloadManagerHandler(&urlObj);
}

void Cex::createOlhcv(QString exchange, QString pair,  QString granularity) {
    creatingOlhcv = true;
    QUrl url;

    if (granularity == "5m") {
        interval = 300000;
    }
    else if (granularity == "15m") {
        interval = 900000;
    }
    else if (granularity == "30m") {
        interval = 1800000;
    }
    else if (granularity == "1h") {
        interval = 3600000;
    }
    else if (granularity == "4h") {
        interval = 14400000;
    }

    if (count == 0) {
        // time format: YYYY-mm-ddThh:ii:ssZ
        startTime = QDateTime::currentMSecsSinceEpoch();
        endTime = QDateTime::currentMSecsSinceEpoch() - interval;
    }

    QDateTime timestamp1 = QDateTime::fromMSecsSinceEpoch(startTime);
    QDateTime timestamp2 = QDateTime::fromMSecsSinceEpoch(endTime);
    startTimeStr = timestamp1.toString("YYYY-mm-ddThh:ii:ssZ");
    endTimeStr = timestamp2.toString("YYYY-mm-ddThh:ii:ssZ");

    url = "https://api.probit.com/api/exchange/v1/trade?market_id=" + pair + "&start_time=" + startTimeStr + "&end_time=" + endTimeStr + "&limit=1000";
    URLObject urlObj {QUrl(url)};
    urlObj.addProperty("route","createOlhcvSlot");
    urlObj.addProperty("exchange",exchange);
    urlObj.addProperty("pair",pair);
    DownloadManagerHandler(&urlObj);
}

void Cex::getOrderBook(QString exchange, QString pair) {
    QUrl url;
    if (exchange == "probit") {
        url = "https://api.probit.com/api/exchange/v1/order_book?market_id=" + pair;
    }
    else if (exchange == "crex24") {
        url = "https://api.crex24.com/v2/public/orderBook?instrument=" + pair;
    }

    URLObject urlObj {QUrl(url)};
    urlObj.addProperty("route","getOrderbookSlot");
    urlObj.addProperty("exchange",exchange);
    urlObj.addProperty("pair",pair);
    DownloadManagerHandler(&urlObj);
}

void Cex::getCoinInfoSlot(QByteArray response, QMap<QString, QVariant> props) {

}

void Cex::getRecentTradesSlot(QByteArray response, QMap<QString, QVariant> props) {

}

void Cex::getOlhcvSlot(QByteArray response, QMap<QString, QVariant> props) {

}

void Cex::createOlhcvSlot(QByteArray response, QMap<QString, QVariant> props) {

}

void Cex::getOrderBookSlot(QByteArray responde, QMap<QString, QVariant> props) {

}
