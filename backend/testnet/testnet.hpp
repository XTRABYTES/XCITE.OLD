#ifndef TESTNET_HPP
#define TESTNET_HPP

#include <QObject>

#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QAuthenticator>
#include <QJsonDocument>
#include <QSignalMapper>
#include <QJsonObject>
#include <QJsonArray>

#include "transactionmodel.hpp"
#include "../addressbook/addressbookmodel.hpp"

class HttpClient : public QObject
{
    Q_OBJECT
public:
    HttpClient(const QString &endpoint, QObject *parent = 0)
        : QObject(parent)
    {
        // defaults added for my local test server
        m_username = "xcite";
        m_password = "xtrabytes";

        req.setUrl(QUrl(endpoint));
        req.setHeader(QNetworkRequest::ContentTypeHeader,"application/json;");
        manager = new QNetworkAccessManager (this);

        connect(manager, SIGNAL (authenticationRequired(QNetworkReply*,QAuthenticator*)),  SLOT (handleAuthenticationRequired(QNetworkReply*,QAuthenticator*)));
        connect(manager, SIGNAL (finished(QNetworkReply*)), this, SLOT (onResponse(QNetworkReply*)));
    }

     ~HttpClient() {}

    void setUsername(const QString &username) {
        m_username = username;
    }

    void setPassword(const QString &password) {
        m_password = password;
    }

    void request(QString command, QJsonArray params) {
        QJsonDocument json;
        QJsonObject obj;

        obj.insert("jsonrpc", QJsonValue::fromVariant("1.0"));
        obj.insert("id", QJsonValue::fromVariant("xcite"));
        obj.insert("method", QJsonValue::fromVariant(command));
        obj.insert("params", QJsonValue::fromVariant(params));
        json.setObject(obj);

        QNetworkReply *reply = manager->post(req, json.toJson(QJsonDocument::Compact));
        reply->setProperty("command", command);
        reply->setProperty("params", params);
    }

signals:
    void response(QString command, QJsonArray params, QJsonObject res);

public Q_SLOTS:
    void onResponse(QNetworkReply *res) {
        QJsonDocument json = QJsonDocument::fromJson(res->readAll());
        QJsonObject reply = json.object();

        response(res->property("command").toString(), res->property("params").toJsonArray(), reply);
    }

private Q_SLOTS:
    virtual void handleAuthenticationRequired(QNetworkReply *reply, QAuthenticator *authenticator)
    {
        Q_UNUSED(reply)
        authenticator->setUser(m_username);
        authenticator->setPassword(m_password);
    }

private:
    QString m_username;
    QString m_password;
    QNetworkRequest req;
    QNetworkAccessManager *manager;
};

class Testnet : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qlonglong balance MEMBER m_balance NOTIFY walletChanged)
    Q_PROPERTY(qlonglong unconfirmed MEMBER m_unconfirmed NOTIFY walletChanged)
    Q_PROPERTY(TransactionModel *transactions MEMBER m_transactions NOTIFY walletChanged)
    Q_PROPERTY(AddressBookModel *accounts MEMBER m_accounts NOTIFY walletChanged)

public:
    Testnet(QObject *parent = 0) : QObject(parent) {
        client = new HttpClient("http://127.0.0.1:2222");
        connect(client, SIGNAL (response(QString, QJsonArray, QJsonObject)), this, SLOT (onResponse(QString, QJsonArray, QJsonObject)));

        m_transactions = new TransactionModel;

        for (int i = 0; i < 10; i++) {
            qlonglong rnd = (qrand() % 100000) - 50000;
            m_transactions->add(rnd < 0 ? "OUT" : "IN", "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34", "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34", rnd, QDateTime::currentDateTime());
        }

        m_accounts = new AddressBookModel;
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
    void getAccountAddress(QString account);
    void validateAddress(QString);
    void onResponse(QString, QJsonArray, QJsonObject);

public:
    TransactionModel *m_transactions;
    AddressBookModel *m_accounts;
    bool accountsLoaded = false;

private:
    HttpClient *client;
    qlonglong m_balance = 175314;
    qlonglong m_unconfirmed = 0;
};

#endif
