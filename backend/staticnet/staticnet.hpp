/**
 * Filename: staticnet.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef STATICNET_HPP
#define STATICNET_HPP

#include <QObject>

#include <QSslConfiguration>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QSignalMapper>
#include <QJsonObject>
#include <QJsonArray>
#include <QThread>

#include <boost/thread/mutex.hpp>

class StaticNetHttpClient:  public QObject  {
    Q_OBJECT
    
public:
    StaticNetHttpClient(const QString &endpoint, QObject *parent = 0 );
    ~StaticNetHttpClient() {}
    QNetworkReply *reply;
    void request(const QJsonArray *params);

public Q_SLOTS:
    void slotNetworkError(QNetworkReply::NetworkError error);
    void onResponse(QNetworkReply *res);

signals:
    void response(QJsonArray params, QJsonObject res);
    void error(QNetworkReply::NetworkError); // FIXMEEE

private:
    QNetworkRequest req;
    QNetworkAccessManager *manager;

};

class SendcoinWorker : public QObject {
    Q_OBJECT

public:
    SendcoinWorker(const QJsonArray *params);
    ~SendcoinWorker();

public slots:
    void process();

signals:
    void finished();
    void confirmed();
    void error(QString err);
    void sendcoinFailed();

public Q_SLOTS:
    void unspent_request(const QJsonArray *params);
    void unspent_onResponse(QJsonArray params, QJsonObject );
    void confirm_request(const QJsonArray *params);
    void confirm_onResponse(QJsonArray params, QJsonObject );
    void txbroadcast_request(const QJsonArray *params);
    void txbroadcast_onResponse(QJsonArray params, QJsonObject );


private:
    std::string secret;
    std::string hexscript;
    std::string sender_address;
    std::string target_address;
    std::string value_str;
    QString trace_id;
    StaticNetHttpClient *client;
};


class SnetKeyWordWorker : public QObject {
    Q_OBJECT

public:
    SnetKeyWordWorker(const QString *_msg);
    ~SnetKeyWordWorker();

public slots:
    void process();

signals:
    void finished();
    void error(QString err);
    void response(QVariant response);

public Q_SLOTS:
    void request(const QJsonArray *params);
    void onResponse(QJsonArray params, QJsonObject );
    int errorString(QString errorstr);

private:
    QString msg;
    void CmdParser(const QJsonArray *params);
    StaticNetHttpClient *client;
    void help();
    void sendcoin(const QJsonArray *params);
};


class StaticNet : public QObject {
    Q_OBJECT

public:
    StaticNet(QObject *parent = 0) : QObject(parent) {}
    ~StaticNet() {}
    void Initialize();
    bool CheckUserInputForKeyWord(const QString msg, int *traceID);

    QString GetConnectStr() {
        return ConnectStr;
    };

    int GetNewTraceID() {
        boost::unique_lock<boost::mutex> scoped_lock(m_traceid);
        return ++traceID;
    };


public slots:
    void errorString(const QString error);
    void onResponseFromStaticnet(QJsonObject response) {
        qDebug() << "staticnet response recevied";       
    }

signals:
	 void ResponseFromStaticnet(QJsonObject);

private:
    boost::mutex m_traceid;
    int traceID;
    QString ConnectStr;
};


extern StaticNet staticNet;

#endif  // STATICNET_HPP
