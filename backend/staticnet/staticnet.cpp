/**
 * Filename: staticnet.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include <QDebug>
#include "staticnet.hpp"
#include "../xchat/xchat.hpp"

	
StaticNet staticNet;

void StaticNet::Initialize() {
	
	    // Ignore SSL Errors 
	    // Please comment out before production usage
       QSslConfiguration sslConf = QSslConfiguration::defaultConfiguration();
       sslConf.setPeerVerifyMode(QSslSocket::VerifyNone);
       QSslConfiguration::setDefaultConfiguration(sslConf);

       requestID=0;
	    client = new StaticNetHttpClient("https://87.229.77.126:8443/v1.0/dicom");
       connect(client, SIGNAL (response( QJsonArray, QJsonObject)), this, SLOT (onResponse( QJsonArray, QJsonObject)));
}


void StaticNet::onResponse( QJsonArray params, QJsonObject res)
{

    if (!res["error"].isNull()) {
    	  xchatRobot.SubmitMsg("STaTiC network error. ID: #"+params.last().toString());
        qDebug() << res;
        return;
    }

    QJsonDocument doc(res);
    QString formattedJsonString = doc.toJson(QJsonDocument::Indented);
    xchatRobot.SubmitMsg("Recevied reply from STaTiC network. ID: #"+params.last().toString());
    xchatRobot.SubmitMsg(formattedJsonString);
	
}

void StaticNet::request(const QJsonArray *params) {
		 
    xchatRobot.SubmitMsg("Command forwarded to STaTiC network. Wait for reply. ID: #"+params->last().toString());
    client->request(params);
}


bool StaticNet::CheckUserInputForKeyWord(const QString msg) {
	
	 QStringList args = msg.split(" ");

    QJsonArray params; 
    
    for (QStringList::const_iterator it = args.constBegin(); it != args.constEnd(); ++it) params.append(QJsonValue(*it));
    	 	 	 
	 if (params.at(0).toString() == "!!staticnet") {
	 	 requestID++;	 
	    params.push_back(QString::number(requestID));	    
	    CmdParser(&params);
	    return true;
	 }
	 	      
    return false;
}


void StaticNet::CmdParser(const QJsonArray *params) {
	 
    QString command = params->at(1).toString();
    if ( (command == "ping") || (command == "echo") ) {
    	  request(params);                
    } else if (command == "asdf") {
         xchatRobot.SubmitMsg("Local command wow.");
    } else {
      xchatRobot.SubmitMsg("Bad STaTiC command. Ignored.");
    }
            
}


StaticNetHttpClient::StaticNetHttpClient(const QString &endpoint, QObject *parent ): QObject(parent) {
	
     req.setUrl(QUrl(endpoint));
     req.setHeader(QNetworkRequest::ContentTypeHeader,"application/json;");
     manager = new QNetworkAccessManager();

     connect(manager, SIGNAL (finished(QNetworkReply*)), this, SLOT (onResponse(QNetworkReply*)));
     connect(manager, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(slotNetworkError(QNetworkReply::NetworkError)));
}


void StaticNetHttpClient::request(const QJsonArray *params) {
    	
     QJsonDocument json;
     QJsonObject obj;

     obj.insert("dicom", QJsonValue::fromVariant("1.0"));
     obj.insert("type", QJsonValue::fromVariant("request"));
     obj.insert("method", QJsonValue::fromVariant(params->at(1).toString()));
     obj.insert("params", QJsonValue::fromVariant(params->at(2).toString()));
     json.setObject(obj);

     reply = manager->post(req, json.toJson(QJsonDocument::Compact));    
     reply->setProperty("params", *params);
}
	    

void StaticNetHttpClient::slotNetworkError(QNetworkReply::NetworkError error) {
            QTextStream(stdout) << "error:" << reply->error() << endl;
}

void StaticNetHttpClient::onResponse(QNetworkReply *res) {
    	  
        QJsonDocument json = QJsonDocument::fromJson(res->readAll());
        QJsonObject reply = json.object();

        QJsonArray params = res->property("params").toJsonArray(); 
        response( params , reply);
}
