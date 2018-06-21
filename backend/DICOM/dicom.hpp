/**
 * Filename: dicom.hpp
 *
 * DICOM
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XtraBYtes developers
 *
 * This file is part of xtrabytes project.
 *
 */

#ifndef DICOM_HPP
#define DICOM_HPP

#include <openssl/rsa.h>
#include <openssl/pem.h>

#include <QString>
#include <QObject>

#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QSignalMapper>
#include <QJsonDocument>
#include <QJSValue>
#include <QQmlEngine>
#include <QJsonObject>
#include <QSslConfiguration>

#include "key.hpp"
#include "util.hpp"

namespace dicom {

class HttpClient : public QObject
{
    Q_OBJECT
public:
    HttpClient(const QString &endpoint, QQmlEngine *engine, QObject *parent = 0)
        : QObject(parent), m_engine(engine)
    {
        QSslConfiguration sslConf = QSslConfiguration::defaultConfiguration();
        sslConf.setPeerVerifyMode(QSslSocket::VerifyNone);
        QSslConfiguration::setDefaultConfiguration(sslConf);

        req.setUrl(QUrl(endpoint));
        req.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
        manager = new QNetworkAccessManager(this);

        connect(manager, SIGNAL (finished(QNetworkReply*)), this, SLOT (onResponse(QNetworkReply*)));
    }

     ~HttpClient() {}

    void request(QString r, QJSValue callback) {
        QByteArray requestBytes;
        requestBytes.append(r);

        QNetworkReply *reply = manager->post(req, requestBytes);
        reply->setProperty("callback", QVariant::fromValue(callback)); //.toVariant());
    }

signals:
    void response(QJsonObject res, QJSValue callback);

public Q_SLOTS:
    void onResponse(QNetworkReply *res) {
        QJsonDocument json = QJsonDocument::fromJson(res->readAll());
        QJsonObject reply = json.object();

        QJSValue callback = m_engine->toScriptValue<QVariant>(res->property("callback"));
        response(reply, callback);
    }

private:
    QQmlEngine *m_engine;
    QNetworkRequest req;
    QNetworkAccessManager *manager;
};


class keypair {
public:
    std::string priv;
    std::string pub;
};

class request {
public:
    request(std::string payload) : m_version("1.0"), m_payload(payload) {
    }

private:
    std::string m_version;
    std::string m_payload;
    std::string m_signature;
};

class sessionkey {
public:
    sessionkey();
    bool generate();
    std::string sign(std::string payload);
    std::string pub() {
        return key.pub;
    }

private:
    bool RSASign(RSA* rsa, const unsigned char* Msg, size_t MsgLen, unsigned char** EncMsg, size_t* MsgLenEnc);
    RSA* createPrivateRSA(std::string key);

    keypair key;
};

class client : public QObject {
    Q_OBJECT
public:
    client(QQmlEngine *engine, QObject *parent = 0) : QObject(parent) {
        http = new HttpClient("https://172.16.144.133:8080/v1.0/dicom", engine);
        connect(http, SIGNAL (response(QJsonObject, QJSValue)), this, SLOT (onResponse(QJsonObject, QJSValue)));
    }

    void execute(QString payload, QJSValue callback);

    Q_INVOKABLE void sessionCreate(QJSValue callback);
    Q_INVOKABLE void userLogin(QString username, QString password, QJSValue callback);
    Q_INVOKABLE void userCreate(QString username, QString password, QJSValue callback);
    Q_INVOKABLE void sendRequest(QVariantMap args, QJSValue callback);
    Q_INVOKABLE void sendRequest(QString r, QJSValue callback);

    Q_INVOKABLE bool hasValidSession() {
        return m_sessionId != "";
    }

    Q_INVOKABLE QString privateKey() {
        return m_bip38;
    }

    ~client() {}

signals:
    //void response(QVariant response, QJSValue callback);

public Q_SLOTS:
    //void request(QString, QJSValue);
    void onResponse(QJsonObject, QJSValue);

private:
    QString m_sessionId;
    QString m_serverPubKey;
    QString m_bip38;
    QString m_username;
    sessionkey skey;
    HttpClient *http;
};

}

#endif
