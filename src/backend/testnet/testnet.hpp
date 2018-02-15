#ifndef TESTNET_HPP
#define TESTNET_HPP

#include <QObject>
#include <QAuthenticator>
#include "qjsonrpchttpclient.h"
#include "transactionmodel.hpp"

class HttpClient : public QJsonRpcHttpClient
{
    Q_OBJECT
public:
    HttpClient(const QString &endpoint, QObject *parent = 0)
        : QJsonRpcHttpClient(endpoint, parent)
    {
        // defaults added for my local test server
        m_username = "xcite";
        m_password = "xtrabytes";
    }

     ~HttpClient() {}

    void setUsername(const QString &username) {
        m_username = username;
    }

    void setPassword(const QString &password) {
        m_password = password;
    }

private Q_SLOTS:
    virtual void handleAuthenticationRequired(QNetworkReply *reply, QAuthenticator * authenticator)
    {
        Q_UNUSED(reply)
        authenticator->setUser(m_username);
        authenticator->setPassword(m_password);
    }

private:
    QString m_username;
    QString m_password;
};

class Testnet : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qlonglong balance MEMBER m_balance NOTIFY walletChanged)
    Q_PROPERTY(qlonglong unconfirmed MEMBER m_unconfirmed NOTIFY walletChanged)
    Q_PROPERTY(TransactionModel *transactions MEMBER m_transactions NOTIFY walletChanged)

public:
    Testnet(QObject *parent = 0) : QObject(parent) {
        client = new HttpClient("http://127.0.0.1:2222");
        m_transactions = new TransactionModel;

        for (int i = 0; i < 10; i++) {
            qlonglong rnd = (qrand() % 100000) - 50000;
            m_transactions->add(rnd < 0 ? "OUT" : "IN", "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34", "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34", rnd, QDateTime::currentDateTime());
        }
    }

    ~Testnet() {}   

signals:
    void response(QVariant response);
    void walletChanged();
    void walletError(QVariant response);
    void walletSuccess(QVariant response);

public Q_SLOTS:
    void request(QString command);
    void sendFrom(QString account, QString address, qreal amount);

public:
    TransactionModel *m_transactions;

private:
    HttpClient *client;
    qlonglong m_balance = 175314;
    qlonglong m_unconfirmed = 0;
};

#endif
