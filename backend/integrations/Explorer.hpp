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

#ifndef EXPLORER_HPP
#define EXPLORER_HPP

#include <QObject>
#include <QtNetwork/QHostInfo>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

class Explorer : public QObject
{
    Q_OBJECT
public:
    explicit Explorer(QObject *parent = nullptr);
    QString  getBalanceAddress(QString coin, QString address);

signals:
    void updateBalance(const QString &coin, const QString &address, const QString &balance);

public slots:
    void getBalanceEntireWallet(QString);
    void onResult(QNetworkReply *reply);

private:
    QString explorerValue;
};

#endif // EXPLORER_HPP
