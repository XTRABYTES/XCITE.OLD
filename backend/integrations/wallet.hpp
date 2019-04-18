/**
 * Filename: Wallet.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef WALLET_HPP
#define WALLET_HPP

#include <QMainWindow>
#include <QObject>
#include <QWidget>

class Wallet  : public QObject
{
    Q_OBJECT
public:
    explicit Wallet(QObject *parent = nullptr);
    bool helpReply(QString help1, QString help2, QString help3, QString help4);
    bool networkReply(QString network);
    bool newKeypair(QString address, QString pubKey, QString privKey);
    bool keypairFailed();
    bool addressExtracted(QString privKey, QString pubKey, QString addressID);
    bool badkey();

signals:
    void help(const QString &help1, const QString &help2, const QString &help3, const QString &help4);
    void networkStatus(const QString &network);
    void newKeypairCreated(const QString &address, const QString &pubKey, const QString &privKey);
    void newKeypairFailed();
    void addressExtractedSucceeded(const QString &privKey, const QString &pubKey, const QString &address);
    void addressExtractedFailed();

public slots:
    void helpEntry();
    void networkEntry(QString network);
    void createKeypairEntry(QString network);
    void importPrivateKeyEntry(QString network, QString privKey);
    void sendCoinsEntry(QString network, QString msg);


};


#endif // WALLET_HPP
