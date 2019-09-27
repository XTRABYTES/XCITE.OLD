/**
 * Filename: xutility.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef XUTILTY_HPP
#define XUTILITY_HPP

#include <QObject>

#include <QJsonDocument>
#include <QSignalMapper>
#include <QJsonObject>
#include <QJsonArray>


class Xutility : public QObject {
    Q_OBJECT

public:
    explicit Xutility(QObject *parent = nullptr);

    void Initialize();
    void CmdParser(const QJsonArray *params);
    bool CheckUserInputForKeyWord(const QString msg);
    void set_network(const QJsonArray *params);
    void help();
    void createkeypair(const QJsonArray *params);
    void privkey2address(const QJsonArray *params);
signals:
    void keyPairCreated(const QString &address, const QString &pubKey, const QString &privKey);
    void addressExtracted(const QString &priv, const QString &pubKey, const QString &addressID);
    void createKeypairFailed();
    void badKey();
    void newNetwork(const QString &currentNetwork);
    void badNetwork(const QString &noNetwork);
    void networkStatus(const QString &myNetwork);
    void helpReply(const QString &help1, const QString &help2, const QString &help3, const QString &help4);

public slots:
    void createKeypairEntry(QString network);
    void importPrivateKeyEntry(QString network, QString privKey);
    void networkEntry(QString netwrk);
    void helpEntry();
    unsigned char getNetworkid(std::vector<std::string>::iterator network_iterator ) const;
    unsigned char getSelectedNetworkid() const;
    std::string getSelectedNetworkName() const;

private:
    bool xutility_initialised = false;
    std::vector<std::string> networks;
    std::vector<std::string>::iterator network;

};

extern Xutility xUtility;

#endif  // XUTILITY_HPP
