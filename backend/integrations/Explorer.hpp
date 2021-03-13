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
#include <QtWidgets>
#include "../support/DownloadManager.hpp"



class Explorer : public QObject
{
    Q_OBJECT
public:
    explicit Explorer(QObject *parent = nullptr);
    void getTransactionStatus(QString coin, QString transaction, QString address);
    void  DownloadManagerHandler(URLObject *url);

signals:
    void updateBalance(const QString &coin, const QString &address, const QString &balance);
    void updateTransactions(const QString &transactions, const QString &totalPages);
    void updateTransactionsDetails(const QString &timestamp, const QString &confirmations, const QString &balance, const QString &inputs, const QString &outputs);
    void txidConfirmed(const QString &coin, const QString &address, const QString &txid, const QString &result);
    void txidExists(const QString &coin, const QString &address, const QString &txid, const QString &result);
    void txidNotFound(const QString &coin, const QString &address, const QString &txid, const QString &result);
    void allTxChecked();
    void explorerBusy();
    void detailsCollected();
    void walletChecked();
    void noInternet();
    void internetStatusSignal(bool);
  //  void quitLoop();
    void quitLoopSignal();



public slots:
    void getBalanceEntireWallet(QString, QString);
    void getTransactionList(QString, QString, QString);
    void getTransactionDetailsSlot(QByteArray);
    void getDetailsSlot(QByteArray, QMap<QString,QVariant>);
    void getBalanceAddressXBYSlot(QByteArray, QMap<QString,QVariant>);
    void getBalanceAddressExtSlot(QByteArray, QMap<QString,QVariant>);
    void getTransactionStatusSlot(QByteArray, QMap<QString,QVariant>);

//  void internetTimeout(QMap<QString,QVariant>);
    void DownloadManagerRouter(QByteArray, QMap<QString,QVariant>);


    void getDetails(QString, QString);
    void WalletUpdate(QString coin, QString label, QString message);
    void checkTxStatus(QString);
    void checkInternetSlot(QByteArray,QMap<QString,QVariant>);
    bool checkInternet(QString url);


private:
    QString explorerValue;
};

#endif // EXPLORER_HPP
