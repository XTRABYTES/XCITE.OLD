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
    infoPair = pair;
    infoExchange = exchange;
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
    tradePair = pair;
    tradeExchange = exchange;
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

    URLObject urlObj {QUrl(url)};
    urlObj.addProperty("route","getRecentTradesSlot");
    urlObj.addProperty("exchange",exchange);
    urlObj.addProperty("pair",pair);
    DownloadManagerHandler(&urlObj);
}

void Cex::getOlhcv(QString exchange, QString pair, QString granularity) {
    QUrl url;
    chartPair = pair;
    chartExchange = exchange;
    while (!ohlcvList.isEmpty()) {
        ohlcvList.removeLast();
    }

    if (exchange == "probit" && olhcvRunning) {
        countSlots = 0;
        trySlots = 0;
        firstReceived = false;
        endTime = QDateTime::currentMSecsSinceEpoch();
        findLastInterval(endTime, granularity);
        createOlhcv(exchange, pair, granularity);
    }
    else {
        if (exchange == "crex24" && olhcvRunning) {
            url = "https://api.crex24.com/v2/public/ohlcv?instrument=" + pair + "&granularity=" + granularity + "&limit=15";
        }

        URLObject urlObj {QUrl(url)};
        urlObj.addProperty("route","getOlhcvSlot");
        urlObj.addProperty("exchange",exchange);
        urlObj.addProperty("pair",pair);
        DownloadManagerHandler(&urlObj);
    }
}

void Cex::createOlhcv(QString exchange, QString pair,  QString granularity) {
    gran = granularity;
    QUrl url;

    if (firstReceived) {
        endTime = startTime;
        startTime = endTime - interval;
    }


    if (olhcvRunning) {
        QString tradeDate;
        QString tradeHour;
        QString tradeMin;
        QString tradeSec;
        // time format: YYYY-mm-ddThh:ii:ss.000Z
        QDateTime timestamp1 = QDateTime::fromMSecsSinceEpoch(endTime);
        tradeDate = timestamp1.toString("yyyy-MM-dd");
        tradeHour = timestamp1.toString("HH");
        tradeMin = timestamp1.toString("mm");
        tradeSec = timestamp1.toString("ss");
        endTimeStr = tradeDate + "T" + tradeHour + "%3A" + tradeMin + "%3A" + tradeSec + ".000Z";
        QDateTime timestamp2 = QDateTime::fromMSecsSinceEpoch(startTime);
        tradeDate = timestamp2.toString("yyyy-MM-dd");
        tradeHour = timestamp2.toString("HH");
        tradeMin = timestamp2.toString("mm");
        tradeSec = timestamp2.toString("ss");
        startTimeStr = tradeDate + "T" + tradeHour + "%3A" + tradeMin + "%3A" + tradeSec + ".000Z";

        url = "https://api.probit.com/api/exchange/v1/trade?market_id=" + pair + "&start_time=" + startTimeStr + "&end_time=" + endTimeStr + "&limit=10000";
        URLObject urlObj {QUrl(url)};
        urlObj.addProperty("route","createOlhcvSlot");
        urlObj.addProperty("exchange",exchange);
        urlObj.addProperty("pair",pair);
        DownloadManagerHandler(&urlObj);
    }
}

void Cex::getOrderBook(QString exchange, QString pair) {
    QUrl url;
    orderPair = pair;
    orderExchange = exchange;
    if (exchange == "probit") {
        url = "https://api.probit.com/api/exchange/v1/order_book?market_id=" + pair;
    }
    else if (exchange == "crex24") {
        url = "https://api.crex24.com/v2/public/orderBook?instrument=" + pair;
    }

    URLObject urlObj {QUrl(url)};
    urlObj.addProperty("route","getOrderBookSlot");
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
    QString dateTimeInfo = "";
    QString infoDate = "";
    QString infoTime = "";
    qint64 epoch = 0;

    if (infoPair == pair && infoExchange == exchange) {
        if (exchange == "crex24") {
            QJsonObject data = jsonResponse.object();
            if (data.contains("errorDescription")) {
                low = "n/a";
                high = "n/a";
                last = "n/a";
                change = "n/a";
                quoteVolume = "n/a";
                baseVolume = "n/a";
                epoch = QDateTime::currentMSecsSinceEpoch();
                QDateTime local = QDateTime::fromMSecsSinceEpoch(epoch, Qt::UTC);
                dateTimeInfo = local.toString("yyyy-MM-ddThh:mm:ss");
                QStringList dateAndTime = dateTimeInfo.split("T");
                infoDate = dateAndTime.at(0);
                infoTime = dateAndTime.at(1);
                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: " + data.value("errorDescription").toString());
                emit receivedCoinInfo(exchange, pair, low, high, last, change, quoteVolume, baseVolume, infoDate, infoTime);
            }
            else {
                QString strJson(jsonResponse.toJson(QJsonDocument::Compact));
                strJson.remove(0, 1);
                strJson.chop(1);
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
                    emit receivedCoinInfo(exchange, pair, low, high, last, change, quoteVolume, baseVolume, infoDate, infoTime);
                }
                catch (...) {
                    low = "n/a";
                    high = "n/a";
                    last = "n/a";
                    change = "n/a";
                    quoteVolume = "n/a";
                    baseVolume = "n/a";
                    epoch = QDateTime::currentMSecsSinceEpoch();
                    QDateTime local = QDateTime::fromMSecsSinceEpoch(epoch, Qt::UTC);
                    dateTimeInfo = local.toString("yyyy-MM-ddThh:mm:ss");
                    QStringList dateAndTime = dateTimeInfo.split("T");
                    infoDate = dateAndTime.at(0);
                    infoTime = dateAndTime.at(1);
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
                epoch = QDateTime::currentMSecsSinceEpoch();
                QDateTime local = QDateTime::fromMSecsSinceEpoch(epoch, Qt::UTC);
                dateTimeInfo = local.toString("yyyy-MM-ddThh:mm:ss");
                QStringList dateAndTime = dateTimeInfo.split("T");
                infoDate = dateAndTime.at(0);
                infoTime = dateAndTime.at(1);
                QString errorDetails = data.value("details").toString();
                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: " + data.value("errorCode").toString() + ", details: " + errorDetails);
                emit receivedCoinInfo(exchange, pair, low, high, last, change, quoteVolume, baseVolume, infoDate, infoTime);
            }
            else {
                QString strJson(jsonResponse.toJson(QJsonDocument::Compact));
                strJson.remove(0, 9);
                strJson.chop(2);
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
                    emit receivedCoinInfo(exchange, pair, low, high, last, change, quoteVolume, baseVolume, infoDate, infoTime);
                }
                catch (...) {
                    low = "n/a";
                    high = "n/a";
                    last = "n/a";
                    change = "n/a";
                    quoteVolume = "n/a";
                    baseVolume = "n/a";
                    epoch = QDateTime::currentMSecsSinceEpoch();
                    QDateTime local = QDateTime::fromMSecsSinceEpoch(epoch, Qt::UTC);
                    dateTimeInfo = local.toString("yyyy-MM-ddThh:mm:ss");
                    QStringList dateAndTime = dateTimeInfo.split("T");
                    infoDate = dateAndTime.at(0);
                    infoTime = dateAndTime.at(1);
                    xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: failed to extract values" );
                    emit receivedCoinInfo(exchange, pair, low, high, last, change, quoteVolume, baseVolume, infoDate, infoTime);
                }
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

    if (tradePair == pair && tradeExchange == exchange) {
        if (exchange == "probit") {
            QJsonObject data = jsonResponse.object();
            if (data.contains("errorCode")) {
                QString errorDetails = data.value("details").toString();
                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: no data returned");
                emit receivedRecentTrades(exchange, pair, "");
            }
            else {
                QJsonArray trades = jsonResponse.object().value("data").toArray();
                try {
                    int i;
                    int countTrades = trades.size();
                    for (i = 0; i < countTrades; ++i) {
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
                try {
                    int i;
                    int countTrades = trades.size();
                    for (i = 0; i < countTrades; ++i) {
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

                    emit receivedRecentTrades(exchange, pair, tradeString);
                }
                catch (...) {
                    xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: failed to extract trades" );
                    emit receivedRecentTrades(exchange, pair, "");
                }

            }
        }
    }
}

void Cex::getOlhcvSlot(QByteArray response, QMap<QString, QVariant> props) {
    QString exchange = props.value("exchange").toString();
    QString pair = props.value("pair").toString();
    QJsonDocument jsonResponse = QJsonDocument::fromJson(response);
    QString timestamp;
    QString open;
    QString high;
    QString low;
    QString close;

    if (chartPair == pair && chartExchange == exchange) {
        if (exchange == "crex24") {
            QJsonObject data = jsonResponse.object();
            if (data.contains("errorDescription")) {
                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: " + data.value("errorDescription").toString());
                emit receivedOlhcv(exchange, pair, "", startDate, endDate);
            }
            else {
                QJsonArray candles = jsonResponse.array();
                try {
                    int i;
                    int countCandles = candles.size();
                    for (i = 0; i < countCandles; ++i) {
                        QJsonObject obj = candles.at(i).toObject();
                        double opendb = obj.value("open").toDouble();
                        open = QString::number(opendb,'f', 8);
                        opendb = open.toDouble() * 100000000;
                        double closedb = obj.value("close").toDouble();
                        close = QString::number(closedb,'f', 8);
                        closedb = close.toDouble() * 100000000;
                        double highdb = obj.value("high").toDouble();
                        high = QString::number(highdb,'f', 8);
                        highdb = high.toDouble() * 100000000;
                        double lowdb = obj.value("low").toDouble();
                        low = QString::number(lowdb,'f', 8);
                        lowdb = low.toDouble() * 100000000;
                        timestamp = obj.value("timestamp").toString();
                        timestamp.chop(1);
                        QDateTime date = QDateTime::fromString(timestamp,"yyyy-MM-ddThh:mm:ss");
                        qint64 mSec = date.toMSecsSinceEpoch();
                        if (i == 0) {
                            startDate = date;
                            endDate = date;
                        }
                        else {
                            if (mSec < startDate.toMSecsSinceEpoch()){
                                startDate = date;
                            }
                            if (mSec > endDate.toMSecsSinceEpoch()){
                                endDate = date;
                            }
                        }
                        timestamp = QString::number(mSec);
                        //xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", timestamp: " + timestamp + ", open: " + open + ", high: " + high + ", low: " + low + ", close: " + close);
                        QJsonObject arrayItem;
                        arrayItem.insert("timestamp", mSec);
                        arrayItem.insert("open", opendb);
                        arrayItem.insert("high", highdb);
                        arrayItem.insert("low", lowdb);
                        arrayItem.insert("close", closedb);
                        ohlcvList.append(arrayItem);
                    }

                    QJsonDocument arrayDoc;
                    arrayDoc.setArray(ohlcvList);
                    QString ohlcvString(arrayDoc.toJson());
                    emit receivedOlhcv(exchange, pair, ohlcvString, startDate, endDate);
                    qDebug() << "start date: " << startDate;
                    qDebug() << "end date: " << endDate;
                    //xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", ohlcvList: " + olhcvString);
                }
                catch (...) {
                    xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: failed to extract candles" );
                    emit receivedOlhcv(exchange, pair, "", startDate, endDate);
                }

            }
        }

        else {
            xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: not available for this exchange" );
            emit receivedOlhcv(exchange, pair, "", startDate, endDate);
        }
    }
}

void Cex::createOlhcvSlot(QByteArray response, QMap<QString, QVariant> props) {
    QString exchange = props.value("exchange").toString();
    QString pair = props.value("pair").toString();
    QJsonDocument jsonResponse = QJsonDocument::fromJson(response);
    QJsonArray tradesList;
    QString price;
    QString timestamp;
    double open = 0;
    double high = 0;
    double low = 0;
    double close = 0;
    QDateTime date;
    xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", slot: " + QString::number(countSlots + 1));
    firstReceived = true;
    ++trySlots;

    if (chartPair == pair && chartExchange == exchange) {
        if (exchange == "probit") {
            QJsonObject data;
            QJsonArray trades;
            try {
                data = jsonResponse.object();
            } catch (...) {
                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: failed to extraction data" );
            }
            if (jsonResponse.object().contains("data") || !data.isEmpty()){
                trades = jsonResponse.object().value("data").toArray();
                if (!trades.isEmpty()) {
                    try {
                        int i;
                        int countTrades = trades.size();
                        for (i = 0; i < countTrades; ++i)  {
                            QJsonObject obj = trades.at(i).toObject();
                            if (obj.contains("price")){
                                price = obj.value("price").toString();
                                double pricedb = price.toDouble();
                                price = QString::number(pricedb,'f', 8);
                                pricedb = price.toDouble() * 100000000;
                                if (i == 0) {
                                    open = pricedb;
                                    close = pricedb;
                                    high = pricedb;
                                    low = pricedb;
                                }
                                else {
                                    if (i == (countTrades - 1)) {
                                        open = pricedb;
                                    }
                                    if (pricedb > high) {
                                        high = pricedb;
                                    }
                                    if (pricedb < low) {
                                        low = pricedb;
                                    }
                                }
                            }
                        }
                        if (countTrades > 0) {
                            qDebug() << "adding ohlcv item";
                            QJsonObject arrayItem;
                            arrayItem.insert("timestamp", endTime);
                            arrayItem.insert("open", open);
                            arrayItem.insert("high", high);
                            arrayItem.insert("low", low);
                            arrayItem.insert("close", close);
                            ohlcvList.append(arrayItem);
                            if (countSlots < 14) {
                                qDebug() << "increasing slot count";
                                ++countSlots;
                                emit progressOlhcv(countSlots);
                            }
                        }
                        if (countSlots < 14 && trySlots < 45) {
                            createOlhcv(exchange, pair, gran);
                        }
                        else {
                            startDate =  QDateTime::fromMSecsSinceEpoch(endTime);
                            QJsonDocument arrayDoc;
                            arrayDoc.setArray(ohlcvList);
                            QString ohlcvString(arrayDoc.toJson());
                            emit receivedOlhcv(exchange, pair, ohlcvString, startDate, endDate);
                            qDebug() << "start date: " << startDate;
                            qDebug() << "end date: " << endDate;
                        }
                    }
                    catch (...) {
                        if (countSlots < 14 && trySlots < 45) {
                            createOlhcv(exchange, pair, gran);
                        }
                        else {
                            startDate =  QDateTime::fromMSecsSinceEpoch(endTime);
                            QJsonDocument arrayDoc;
                            arrayDoc.setArray(ohlcvList);
                            QString ohlcvString(arrayDoc.toJson());
                            emit receivedOlhcv(exchange, pair, ohlcvString, startDate, endDate);
                            qDebug() << "start date: " << startDate;
                            qDebug() << "end date: " << endDate;
                        }
                        xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: failed to extract trades" );
                    }
                }
                else {
                    if (countSlots < 14 && trySlots < 45) {
                        createOlhcv(exchange, pair, gran);
                    }
                    else {
                        startDate =  QDateTime::fromMSecsSinceEpoch(endTime);
                        QJsonDocument arrayDoc;
                        arrayDoc.setArray(ohlcvList);
                        QString ohlcvString(arrayDoc.toJson());
                        emit receivedOlhcv(exchange, pair, ohlcvString, startDate, endDate);
                        qDebug() << "start date: " << startDate;
                        qDebug() << "end date: " << endDate;
                    }
                    xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", no trading data for this timeslot");
                }
            }
            else {
                if (countSlots < 14 && trySlots < 45) {
                    createOlhcv(exchange, pair, gran);
                }
                else {
                    startDate =  QDateTime::fromMSecsSinceEpoch(endTime);
                    QJsonDocument arrayDoc;
                    arrayDoc.setArray(ohlcvList);
                    QString ohlcvString(arrayDoc.toJson());
                    emit receivedOlhcv(exchange, pair, ohlcvString, startDate, endDate);
                    qDebug() << "start date: " << startDate;
                    qDebug() << "end date: " << endDate;
                }
                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error retrieving olhcv data");
            }
        }
    }
}

void Cex::getOrderBookSlot(QByteArray response, QMap<QString, QVariant> props) {
    QString exchange = props.value("exchange").toString();
    QString pair = props.value("pair").toString();
    QJsonDocument jsonResponse = QJsonDocument::fromJson(response);
    QJsonArray orderBookList;
    QString side;
    QString price;
    QString quantity;
    QString accBuyVolume;
    QString accSellVolume;
    QString buyVolume;
    QString sellVolume;
    double buyVol = 0;
    double sellVol = 0;
    int orderID = 0;

    if (orderPair == pair && orderExchange == exchange) {
        if (exchange == "probit") {
            QJsonObject data = jsonResponse.object();
            QString strJson(jsonResponse.toJson(QJsonDocument::Compact));
            if (data.contains("errorCode")) {
                QString errorDetails = data.value("details").toString();
                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: " + data.value("errorCode").toString() + ", details: " + errorDetails);
                emit receivedOrderBook(exchange, pair, "", "", "");
            }
            else {
                QJsonArray orders = jsonResponse.object().value("data").toArray();
                try {
                    int i;
                    int countOrders = orders.size();
                    for (i = 0; i < countOrders; ++i) {
                        QJsonObject obj = orders.at(i).toObject();
                        side = obj.value("side").toString();
                        price = obj.value("price").toString();
                        double pricedb = price.toDouble();
                        quantity = obj.value("quantity").toString();
                        double quantitydb = quantity.toDouble();
                        if (side == "buy") {
                            buyVol = buyVol + quantitydb;
                        }
                        else {
                            sellVol = sellVol + quantitydb;
                        }
                        QJsonObject arrayItem;
                        arrayItem.insert("orderID", orderID);
                        orderID += 1;
                        arrayItem.insert("side", side);
                        arrayItem.insert("price", pricedb);
                        arrayItem.insert("quantity", quantitydb);
                        arrayItem.insert("accVolume", 0);
                        orderBookList.append(arrayItem);
                    }

                    QJsonDocument arrayDoc;
                    arrayDoc.setArray(orderBookList);
                    QString orderBookString(arrayDoc.toJson());
                    buyVolume = QString::number(buyVol, 'f', 8);
                    sellVolume = QString::number(sellVol, 'f', 8);

                    emit receivedOrderBook(exchange, pair, orderBookString, buyVolume, sellVolume);
                }
                catch (...) {
                    xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: failed to extract orderbook" );
                    emit receivedOrderBook(exchange, pair, "", "", "");
                }
            }
        }
        else if (exchange == "crex24") {
            QJsonObject data = jsonResponse.object();
            if (data.contains("errorDescription")) {
                xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: " + data.value("errorDescription").toString());
                emit receivedOrderBook(exchange, pair, "", "", "");
            }
            else {
                QJsonArray buys = jsonResponse.object().value("buyLevels").toArray();
                QJsonArray sells = jsonResponse.object().value("sellLevels").toArray();
                try {
                    int i;
                    int countBuys = buys.size();
                    for (i = 0; i < countBuys; ++i) {
                        QJsonObject obj = buys.at(i).toObject();
                        side = "buy";
                        double pricedb = obj.value("price").toDouble();
                        double quantitydb = obj.value("volume").toDouble();
                        buyVol = buyVol + quantitydb;
                        QJsonObject arrayItem;
                        arrayItem.insert("orderID", orderID);
                        orderID += 1;
                        arrayItem.insert("side", side);
                        arrayItem.insert("price", pricedb);
                        arrayItem.insert("quantity", quantitydb);
                        arrayItem.insert("accVolume", buyVol);
                        orderBookList.append(arrayItem);
                    }
                    int e;
                    int countSells = sells.size();
                    for (e = 0; e < countSells; ++e) {
                        QJsonObject obj = sells.at(e).toObject();
                        side = "sell";
                        double pricedb = obj.value("price").toDouble();
                        double quantitydb = obj.value("volume").toDouble();
                        sellVol = sellVol + quantitydb;
                        QJsonObject arrayItem;
                        arrayItem.insert("orderID", orderID);
                        orderID += 1;
                        arrayItem.insert("side", side);
                        arrayItem.insert("price", pricedb);
                        arrayItem.insert("quantity", quantitydb);
                        arrayItem.insert("accVolume", sellVol);
                        orderBookList.append(arrayItem);
                    }
                    QJsonDocument arrayDoc;
                    arrayDoc.setArray(orderBookList);
                    QString orderBookString(arrayDoc.toJson());
                    buyVolume = QString::number(buyVol, 'f', 8);
                    sellVolume = QString::number(sellVol, 'f', 8);

                    emit receivedOrderBook(exchange, pair, orderBookString, buyVolume, sellVolume);
                }
                catch (...) {
                    xchatRobot.SubmitMsg("exchange - " + exchange + " - pair: " + pair + ", error: failed to extract orderbook" );
                    emit receivedOrderBook(exchange, pair, "", "", "");
                }
            }
        }
    }
}

void Cex::findLastInterval(qint64 time, QString granularity) {
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
    double nTimes = time/interval;
    int roundedTimes = time/interval;
    double difference = roundedTimes - nTimes;
    int n = 0;
    if (difference <= 0) {
        n = roundedTimes;
    }
    else  {
        n = roundedTimes - 1;
    }
    endTime = n*interval;
    startTime = endTime - interval;
    endDate = QDateTime::fromMSecsSinceEpoch(endTime);
}

void Cex::updateOlhcv(QString status) {
    if (status == "true") {
        olhcvRunning = true;
    }
    else {
        olhcvRunning = false;
    }
    qDebug() << olhcvRunning;
}
