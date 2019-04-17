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

//signals:

public slots:

    void helpEntry();
    void networkEntry(QString netwrk);
    void createKeypairEntry(QString network);
    void importPrivateKeyEntry(QString network, QString privKey);
    void sendCoinsEntry(QString network, QString msg);
};

#endif // WALLET_HPP
