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

#ifndef XUTILITY_INTEGRATION_HPP
#define XUTILITY_INTEGRATION_HPP

#include <QMainWindow>
#include <QObject>
#include <QWidget>

class xutility_integration : public QObject
{
    Q_OBJECT
public:
    explicit xutility_integration(QObject *parent = nullptr);

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
};

#endif // XUTILITY_INTEGRATION_HPP
