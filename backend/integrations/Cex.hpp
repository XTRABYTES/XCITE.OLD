/**
 * Filename: Explorer.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef CEX_HPP
#define CEX_HPP

#include <QObject>
#include <QtNetwork/QHostInfo>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QtWidgets>
#include "../support/DownloadManager.hpp"

class Cex : public QObject
{
    Q_OBJECT
public:
    explicit Cex(QObject *parent = nullptr);
    void DownloadManagerHandler(URLObject *url);
    void createOlhcv(QString exchange, QString pair,  QString granularity);

signals:
    //
    void receivedCoinInfo(QString exchange, QString pair, QString low, QString high, QString last, QString change, QString quoteVolume, QString baseVolume, QString infoDate, QString infoTime);

public slots:
    //
    void DownloadManagerRouter(QByteArray, QMap<QString,QVariant>);
    void getCoinInfoSlot(QByteArray, QMap<QString,QVariant>);
    void getRecentTradesSlot(QByteArray, QMap<QString,QVariant>);
    void getOlhcvSlot(QByteArray, QMap<QString,QVariant>);
    void createOlhcvSlot(QByteArray, QMap<QString,QVariant>);
    void getOrderBookSlot(QByteArray, QMap<QString,QVariant>);

    void getCoinInfo(QString exchange, QString pair);
    void getRecentTrades(QString exchange, QString pair, QString limit);
    void getOlhcv(QString exchange, QString pair,  QString granularity);
    void getOrderBook(QString exchange, QString pair);
private:
    //
    bool creatingOlhcv;
    QString olhcvTime;
    qint64 interval;
    QString startTimeStr;
    QString endTimeStr;
    qint64 startTime;
    qint64 endTime;
    qint64 count;
};

#endif // CEX_HPP
