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

   private:
       QNetworkRequest req;
       QNetworkAccessManager *manager;    
	    
};


class StaticNet : public QObject {
    Q_OBJECT

	public:
    	StaticNet(QObject *parent = 0) : QObject(parent) {}
    	~StaticNet() {}
    	void Initialize();   
    	void CmdParser(const QJsonArray *params);
    	bool CheckUserInputForKeyWord(const QString msg);

	public Q_SLOTS:
    	void request(const QJsonArray *params);
    	void onResponse(QJsonArray params, QJsonObject );

	signals:
    	void response(QVariant response);

	private:
	   int requestID;
    	StaticNetHttpClient *client;
};

extern StaticNet staticNet;

#endif  // STATICNET_HPP
