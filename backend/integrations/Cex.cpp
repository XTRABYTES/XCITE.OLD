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
        // time format: yyyy-MM-ddTHH%3Amm%3Ass.zzzZ
        QString tradeDate;
        QString tradeHour;
        QString tradeMin;
        QString tradeSec;
        endTime = QDateTime::currentMSecsSinceEpoch();
        QDateTime timestamp1 = QDateTime::fromMSecsSinceEpoch(endTime);
        tradeDate = timestamp1.toString("yyyy-MM-dd");
        tradeHour = timestamp1.toString("HH");
        tradeMin = timestamp1.toString("mm");
        tradeSec = timestamp1.toString("ss");
        endTimeStr = tradeDate + "T" + tradeHour + "%3A" + tradeMin + "%3A" + tradeSec + ".000Z";
        startTime = QDateTime::currentMSecsSinceEpoch() - 432000000;
        QDateTime timestamp2 = QDateTime::fromMSecsSinceEpoch(startTime);
        tradeDate = timestamp2.toString("yyyy-MM-dd");
        tradeHour = timestamp2.toString("HH");
        tradeMin = timestamp2.toString("mm");
        tradeSec = timestamp2.toString("ss");
        startTimeStr = tradeDate + "T" + tradeHour + "%3A" + tradeMin + "%3A" + tradeSec + ".000Z";

        url = "https://api.probit.com/api/exchange/v1/trade?market_id=" + pair + "&start_time=" + startTimeStr + "&end_time=" + endTimeStr + "&limit=" + limit;
    }
    else if (exchange == "crex24") {
        url = "https://api.crex24.com/v2/public/recentTrades?instrument=" + pair + "&limit=" + limit;
    }

    xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", url: " + url.toString().toLatin1());

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
    QString exchange = props.value("exchange").toString();
    QString pair = props.value("pair").toString();
    QJsonDocument jsonResponse = QJsonDocument::fromJson(response);

    QString low = "";
    QString high = "";
    QString last = "";
    QString change = "";
    QString quoteVolume = "";
    QString baseVolume ="";
    QString infoDate = "";
    QString infoTime = "";

    if (exchange == "crex24") {
        QJsonObject data = jsonResponse.object();
        if (data.contains("errorDescription")) {
            low = "n/a";
            high = "n/a";
            last = "n/a";
            change = "n/a";
            quoteVolume = "n/a";
            baseVolume = "n/a";
            infoDate = "????-??-??";
            infoTime = "??:??:??";
            xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: " + data.value("errorDescription").toString());
            emit receivedCoinInfo(exchange, pair, low, high, last, change, quoteVolume, baseVolume, infoDate, infoTime);
        }
        else {
            QString strJson(jsonResponse.toJson(QJsonDocument::Compact));
            strJson.remove(0, 1);
            strJson.chop(1);
            xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", info: " + strJson);
            QJsonDocument doc = QJsonDocument::fromJson(strJson.toUtf8());
            QJsonObject data = doc.object();
            double lowdb = 0;
            double highdb = 0;
            double lastdb = 0;
            double changedb = 0;
            double quoteVoldb = 0;
            double baseVoldb = 0;
            try {
                lowdb = data.value("low").toDouble();
                low = QString::number(lowdb, 'f', 8);
                highdb = data.value("high").toDouble();
                high = QString::number(highdb, 'f', 8);
                lastdb = data.value("last").toDouble();
                last = QString::number(lastdb, 'f', 8);
                changedb = data.value("percentChange").toDouble();
                change = QString::number(changedb, 'f', 2);
                quoteVoldb = data.value("quoteVolume").toDouble();
                quoteVolume = QString::number(quoteVoldb);
                baseVoldb = data.value("baseVolume").toDouble();
                baseVolume = QString::number(baseVoldb);
                QString dateTimeInfo = data.value("timestamp").toString();
                QDateTime date = QDateTime::fromString(dateTimeInfo,"yyyy-MM-ddThh:mm:ssZ");
                qint64 epoch = date.toMSecsSinceEpoch();
                QDateTime local = QDateTime::fromMSecsSinceEpoch(epoch, Qt::LocalTime);
                dateTimeInfo = local.toString("yyyy-MM-ddThh:mm:ss");
                QStringList dateAndTime = dateTimeInfo.split("T");
                infoDate = dateAndTime.at(0);
                infoTime = dateAndTime.at(1);
                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", low: " + low + ", high: " + high + ",last: " + last + ", change: " + change + ", quote-volume: " + quoteVolume + ", base-volume: " + baseVolume + ", date: " + infoDate + ", time: " + infoTime);
                emit receivedCoinInfo(exchange, pair, low, high, last, change, quoteVolume, baseVolume, infoDate, infoTime);
            }
            catch (...) {
                low = "n/a";
                high = "n/a";
                last = "n/a";
                change = "n/a";
                quoteVolume = "n/a";
                baseVolume = "n/a";
                infoDate = "????-??-??";
                infoTime = "??:??:??";
                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: failed to extract values" );
                emit receivedCoinInfo(exchange, pair, low, high, last, change, quoteVolume, baseVolume, infoDate, infoTime);
            }
        }
    }
    else if (exchange == "probit") {
        QJsonObject data = jsonResponse.object();
        if (data.contains("errorCode")) {
            low = "n/a";
            high = "n/a";
            last = "n/a";
            change = "n/a";
            quoteVolume = "n/a";
            baseVolume = "n/a";
            infoDate = "????-??-??";
            infoTime = "??:??:??";
            xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: " + data.value("errorCode").toString());
            emit receivedCoinInfo(exchange, pair, low, high, last, change, quoteVolume, baseVolume, infoDate, infoTime);
        }
        else {
            QString strJson(jsonResponse.toJson(QJsonDocument::Compact));
            strJson.remove(0, 9);
            strJson.chop(2);
            xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", info: " + strJson);
            QJsonDocument doc = QJsonDocument::fromJson(strJson.toUtf8());
            data = doc.object();
            try {
                low = data.value("low").toString();
                high = data.value("high").toString();
                last = data.value("last").toString();
                change = data.value("change").toString();
                double lastInt = low.toDouble();
                double changeInt = change.toDouble();
                double oldInt = lastInt - changeInt;
                double changePerc = (changeInt / oldInt) * 100;
                change = QString::number(changePerc,'f', 2);
                quoteVolume = data.value("quote_volume").toString();
                baseVolume = data.value("base_volume").toString();
                QString dateTimeInfo = data.value("time").toString();
                QDateTime date = QDateTime::fromString(dateTimeInfo,"yyyy-MM-ddThh:mm:ss.zzzZ");
                qint64 epoch = date.toMSecsSinceEpoch();
                QDateTime local = QDateTime::fromMSecsSinceEpoch(epoch, Qt::LocalTime);
                dateTimeInfo = local.toString("yyyy-MM-ddThh:mm:ss");
                QStringList dateAndTime = dateTimeInfo.split("T");
                infoDate = dateAndTime.at(0);
                infoTime = dateAndTime.at(1);
                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", low: " + low + ", high: " + high + ",last: " + last + ", change: " + change + ", quote-volume: " + quoteVolume + ", base-volume: " + baseVolume + ", date: " + infoDate + ", time: " + infoTime);
                emit receivedCoinInfo(exchange, pair, low, high, last, change, quoteVolume, baseVolume, infoDate, infoTime);
            }
            catch (...) {
                low = "n/a";
                high = "n/a";
                last = "n/a";
                change = "n/a";
                quoteVolume = "n/a";
                baseVolume = "n/a";
                infoDate = "????-??-??";
                infoTime = "??:??:??";
                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: failed to extract values" );
                emit receivedCoinInfo(exchange, pair, low, high, last, change, quoteVolume, baseVolume, infoDate, infoTime);
            }
        }
    }
}

void Cex::getRecentTradesSlot(QByteArray response, QMap<QString, QVariant> props) {
    QString exchange = props.value("exchange").toString();
    QString pair = props.value("pair").toString();
    QJsonDocument jsonResponse = QJsonDocument::fromJson(response);
    QJsonArray tradesList;
    QString side;
    QString price;
    QString quantity;
    QString timestamp;
    QString tradeDate;
    QString tradeTime;

    if (exchange == "probit") {
        QJsonObject data = jsonResponse.object();
        QString strJson(jsonResponse.toJson(QJsonDocument::Compact));
        xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", trades: " + strJson );
        if (data.contains("errorCode")) {
            xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: " + data.value("errorCode").toString());
            emit receivedRecentTrades(exchange, pair, "");
        }
        else {
            QJsonArray trades = jsonResponse.object().value("data").toArray();
            QJsonDocument doc;
            doc.setArray(trades);
            QString dataToString(doc.toJson());
            xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", trades: " + dataToString );
            try {
                int i;
                int count = trades.size();
                for (i = 0; i < count; ++i) {
                    QJsonObject obj = trades.at(i).toObject();
                    side = obj.value("side").toString();
                    price = obj.value("price").toString();
                    double pricedb = price.toDouble();
                    price = QString::number(pricedb, 'f', 8);
                    quantity = obj.value("quantity").toString();
                    double quantitydb = quantity.toDouble();
                    quantity = QString::number(quantitydb, 'f', 8);
                    timestamp = obj.value("time").toString();
                    timestamp.chop(5);
                    QStringList timeStrLst = timestamp.split("T");
                    tradeDate = timeStrLst.at(0);
                    tradeTime = timeStrLst.at(1);
                    QJsonObject arrayItem;
                    arrayItem.insert("side", side);
                    arrayItem.insert("price", price);
                    arrayItem.insert("quantity", quantity);
                    arrayItem.insert("date", tradeDate);
                    arrayItem.insert("time", tradeTime);
                    tradesList.append(arrayItem);
                }
                QJsonDocument arrayDoc;
                arrayDoc.setArray(tradesList);
                QString tradeString(arrayDoc.toJson());

                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", trades: " + tradeString );
                emit receivedRecentTrades(exchange, pair, tradeString);
            }
            catch (...) {
                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: failed to extract trades" );
                emit receivedRecentTrades(exchange, pair, "");
            }

        }
    }
    else if (exchange == "crex24") {
        QJsonObject data = jsonResponse.object();
        if (data.contains("errorDescription")) {
            xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: " + data.value("errorDescription").toString());
            emit receivedRecentTrades(exchange, pair, "");
        }
        else {
            QJsonArray trades = jsonResponse.array();
            QJsonDocument doc;
            doc.setArray(trades);
            QString dataToString(doc.toJson());
            xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", trades: " + dataToString );
            try {
                int i;
                int count = trades.size();
                for (i = 0; i < count; ++i) {
                    QJsonObject obj = trades.at(i).toObject();
                    side = obj.value("side").toString();
                    double pricedb = obj.value("price").toDouble();
                    price = QString::number(pricedb,'f', 8);
                    double quantitydb = obj.value("volume").toDouble();
                    quantity = QString::number(quantitydb, 'f', 8);
                    timestamp = obj.value("timestamp").toString();
                    timestamp.chop(1);
                    QStringList timeStrLst = timestamp.split("T");
                    tradeDate = timeStrLst.at(0);
                    tradeTime = timeStrLst.at(1);
                    QJsonObject arrayItem;
                    arrayItem.insert("side", side);
                    arrayItem.insert("price", price);
                    arrayItem.insert("quantity", quantity);
                    arrayItem.insert("date", tradeDate);
                    arrayItem.insert("time", tradeTime);
                    tradesList.append(arrayItem);
                }
                QJsonDocument arrayDoc;
                arrayDoc.setArray(tradesList);
                QString tradeString(arrayDoc.toJson());

                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", trades: " + tradeString );
                emit receivedRecentTrades(exchange, pair, tradeString);
            }
            catch (...) {
                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: failed to extract trades" );
                emit receivedRecentTrades(exchange, pair, "");
            }

        }
    }
}

void Cex::getOlhcvSlot(QByteArray response, QMap<QString, QVariant> props) {

}

void Cex::createOlhcvSlot(QByteArray response, QMap<QString, QVariant> props) {

}

void Cex::getOrderBookSlot(QByteArray responde, QMap<QString, QVariant> props) {

}
