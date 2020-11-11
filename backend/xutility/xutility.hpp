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

#include <amqpcpp.h>
#include "kashmir/uuid.h"
#include "kashmir/devrand.h"

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
    std::string get_uuid();
signals:
    void keyPairCreated(const QString &addr, const QString &pub, const QString &priv);
    void addressExtracted(const QString &priv, const QString &pub, const QString &addr);
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

class SimplePocoHandlerImpl;
class SimplePocoHandler: public AMQP::ConnectionHandler
{
public:

    static constexpr size_t BUFFER_SIZE = 8 * 1024 * 1024; //8Mb
    static constexpr size_t TEMP_BUFFER_SIZE = 1024 * 1024; //1Mb

    SimplePocoHandler(const std::string& host, uint16_t port);
    virtual ~SimplePocoHandler();

    void loop();
    void quit();

    bool connected() const;

private:

    SimplePocoHandler(const SimplePocoHandler&) = delete;
    SimplePocoHandler& operator=(const SimplePocoHandler&) = delete;

    void close();

    virtual void onData(
            AMQP::Connection *connection, const char *data, size_t size);

    virtual void onConnected(AMQP::Connection *connection);

    virtual void onError(AMQP::Connection *connection, const char *message);

    virtual void onClosed(AMQP::Connection *connection);

    void sendDataFromBuffer();

private:

    std::shared_ptr<SimplePocoHandlerImpl> m_impl;
};


extern Xutility xUtility;

#endif  // XUTILITY_HPP
