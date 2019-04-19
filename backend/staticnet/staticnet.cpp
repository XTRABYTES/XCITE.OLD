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

#include <stdio.h>
#include <iostream>

#include <boost/algorithm/string.hpp>

#include <QDebug>
#include "staticnet.hpp"
#include "../xchat/xchat.hpp"
#include "../xutility/xutility.hpp"
#include "../xutility/crypto/ctools.h"
#include "../xutility/transaction/transaction.h"

	
StaticNet staticNet;

void StaticNet::Initialize() {
	
	    // Ignore SSL Errors 
	    // Please comment out before production usage
       QSslConfiguration sslConf = QSslConfiguration::defaultConfiguration();
       sslConf.setPeerVerifyMode(QSslSocket::VerifyNone);
       QSslConfiguration::setDefaultConfiguration(sslConf);

       requestID=0;
       //ConnectStr="https://127.0.0.1:8080/v1.0/dicom";
       //ConnectStr="https://87.229.77.126:8443/v1.0/dicom";
       ConnectStr="https://87.229.77.126:8442/v1.0/dicom";

}

bool StaticNet::CheckUserInputForKeyWord(const QString msg) {

    qDebug() << "staticnet accessed!";
      
      if (!(msg.split(" ").at(0) == "!!staticnet")) return false;
      
		QThread* thread = new QThread;
		SnetKeyWordWorker* worker = new SnetKeyWordWorker(&msg);
		worker->moveToThread(thread);
        connect(worker, SIGNAL (error(QString)), this, SLOT (errorString(QString)));
		connect(thread, SIGNAL (started()), worker, SLOT (process()));
		connect(worker, SIGNAL (finished()), thread, SLOT (quit()));
		connect(worker, SIGNAL (finished()), worker, SLOT (deleteLater()));
		connect(thread, SIGNAL (finished()), thread, SLOT (deleteLater()));
		thread->start();
      return true;
	
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

     std::cout << "params->at(1):" << params->at(1).toString().toStdString() << std::endl;
     std::cout << "params->at(2):" << params->at(2).toString().toStdString() << std::endl;

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


SnetKeyWordWorker::SnetKeyWordWorker(const QString *msg) { 
    this->msg = msg;
}

SnetKeyWordWorker::~SnetKeyWordWorker() {
	//xchatRobot.SubmitMsg("SnetKeyWordWorker() worker stopped."); 
}

void SnetKeyWordWorker::process() {

    qDebug() << "Processing staticnet command";

    const QString _msg = *msg;
	 QStringList args = msg->split(" ");
    QJsonArray params; 
    
    for (QStringList::const_iterator it = args.constBegin(); it != args.constEnd(); ++it) params.append(QJsonValue(*it));
    params.push_back(QString::number(staticNet.GetNewRequestID()));
    
    CmdParser(&params);

    qDebug() << "Processing done";
    	 	 	      
}

void SnetKeyWordWorker::CmdParser(const QJsonArray *params) {

    qDebug() << "reading command";

    QString command = params->at(1).toString();

    if (command == "help") {
        help();

    } else if (command == "ping") {
        request(params);
    } else if (command == "echo") {
        request(params);
    } else if (command == "sendcoin") {
        qDebug() << "send coin command recognized";
        sendcoin(params);          
    } else {
        xchatRobot.SubmitMsg("Bad !!staticnet command. Ignored.");
        xchatRobot.SubmitMsg("More informations: !!staticnet help");
    }
  
}

void SnetKeyWordWorker::help() {
    xchatRobot.SubmitMsg("!!staticnet usage informations:");
    xchatRobot.SubmitMsg("!!staticnet ping");
    xchatRobot.SubmitMsg("!!staticnet echo [string]");
    xchatRobot.SubmitMsg("!!staticnet sendcoin [target] [amount] [privatekey]");
}


void SnetKeyWordWorker::request(const QJsonArray *params) {
		 
   // xchatRobot.SubmitMsg("Command forwarded to STaTiC network. Wait for reply. ID: #"+params->last().toString());
	 client = new StaticNetHttpClient(staticNet.GetConnectStr());
    connect(client, SIGNAL (response( QJsonArray, QJsonObject)), this, SLOT (onResponse( QJsonArray, QJsonObject)));

    client->request(params);
}

void SnetKeyWordWorker::onResponse( QJsonArray params, QJsonObject res)
{
    
    if (!res["error"].isNull()) {
    	  xchatRobot.SubmitMsg("STaTiC network error. ID: #"+params.last().toString());
        qDebug() << res;
        
    } else {

    QJsonDocument doc(res);
    QString formattedJsonString = doc.toJson(QJsonDocument::Indented);
    //xchatRobot.SubmitMsg("Recevied reply from STaTiC network. ID: #"+params.last().toString());
    //xchatRobot.SubmitMsg(formattedJsonString);
	}
	
	emit finished();
}

void SnetKeyWordWorker::sendcoin(const QJsonArray *params) {

        qDebug() << "Initiate sending coins";

		QThread* thread = new QThread;
		SendcoinWorker* worker = new SendcoinWorker(params);
		worker->moveToThread(thread);
        connect(worker, SIGNAL (error(QString)), this, SLOT (errorString(QString)));
		connect(thread, SIGNAL (started()), worker, SLOT (process()));
		connect(worker, SIGNAL (finished()), thread, SLOT (quit()));
		connect(worker, SIGNAL (finished()), worker, SLOT (deleteLater()));
		connect(thread, SIGNAL (finished()), thread, SLOT (deleteLater()));
		thread->start();
      emit finished();
 
}


SendcoinWorker::SendcoinWorker(const QJsonArray *params) { 

      target_address = params->at(2).toString().toStdString();
      value_str = params->at(3).toString().toStdString();
      secret = params->at(4).toString().toStdString();
      req_id = params->at(5).toString();       
}

SendcoinWorker::~SendcoinWorker() {
	//xchatRobot.SubmitMsg("SendcoinWorker() worker stopped."); 
}


void SendcoinWorker::unspent_request(const QJsonArray *params) {
		 
	 client = new StaticNetHttpClient(staticNet.GetConnectStr());
    connect(client, SIGNAL (response( QJsonArray, QJsonObject)), this, SLOT (unspent_onResponse( QJsonArray, QJsonObject)));

    client->request(params);
}

void SendcoinWorker::txbroadcast_request(const QJsonArray *params) {
		 
	 client = new StaticNetHttpClient(staticNet.GetConnectStr());
    connect(client, SIGNAL (response( QJsonArray, QJsonObject)), this, SLOT (txbroadcast_onResponse( QJsonArray, QJsonObject)));

    client->request(params);
}


void SendcoinWorker::txbroadcast_onResponse( QJsonArray params, QJsonObject res)
{
    
    if (!res["error"].isNull()) {
    	  xchatRobot.SubmitMsg("STaTiC network(unspent query) error. ID: #"+params.last().toString());
        qDebug() << res;    
    } else {

    QJsonDocument doc(res);
    QString formattedJsonString = doc.toJson(QJsonDocument::Indented);
    //xchatRobot.SubmitMsg("Recevied txbroadcast reply from STaTiC network. ID: #"+params.last().toString());
    xchatRobot.SubmitMsg(formattedJsonString);
    qDebug() << formattedJsonString;
    }
    emit finished();
}

void SendcoinWorker::unspent_onResponse( QJsonArray params, QJsonObject res)
{
    
    if (!res["error"].isNull()) {
    	  xchatRobot.SubmitMsg("STaTiC network(unspent query) error. ID: #"+params.last().toString());
        qDebug() << res;
        emit finished();     
    } else {

    QJsonDocument doc(res);
    QString formattedJsonString = doc.toJson(QJsonDocument::Indented);
    //xchatRobot.SubmitMsg("Recevied unspent reply from STaTiC network. ID: #"+params.last().toString());
    //xchatRobot.SubmitMsg(formattedJsonString);

    int64 send_value = AmountFromStr(value_str.c_str());    
    int64 fee_value = AmountFromStr("1.00000000");    
    
    QJsonObject json = res["unspents"].toObject();   
    
    
    std::vector<std::string> inputs;
    std::vector<std::string> outputs;
           
    int64 inputs_sum = 0;        
    foreach(const QString& key, json.keys()) {
    
        QJsonValue value = json.value(key);
        int64 tx_value = AmountFromStr(value.toString().toStdString().c_str());
        inputs_sum = inputs_sum + tx_value;
        
        std::string input_tx = key.toStdString();
        std::vector<std::string> tx_details;
        boost::split(tx_details, input_tx , [](char c){return c == ':';});
                        
        std::string detailed_input_tx = tx_details.at(0) + "," 
                        + tx_details.at(1) + "," 
                        + hexscript + "," 
                        + value.toString().toStdString();
                        
                        
        inputs.push_back(detailed_input_tx);
        if ((inputs_sum - (send_value + fee_value)) >= 0) break;
         
    }

    outputs.push_back(target_address + "," + StrFromAmount(send_value));
    outputs.push_back(sender_address + "," + StrFromAmount(inputs_sum - (send_value + fee_value)));

    std::string RawTransaction = CreateRawTransaction( inputs, outputs, secret);
    qDebug() << "Created RAW transaction:" << QString::fromUtf8(RawTransaction.c_str());
     
   QJsonArray req_params; 
   req_params.push_back("!!staticnet");
   req_params.push_back("txbroadcast");   
   req_params.push_back("rawtx:"+QString::fromUtf8(RawTransaction.c_str()));
	req_params.push_back(staticNet.GetNewRequestID()); 
	
	txbroadcast_request(&req_params);
    
	}
	
	
}

void SendcoinWorker::process() { 
                  
      //	!!staticnet sendcoin	[target-address] [sending-amount] [sender-privatekey]
      // example:
      // !!staticnet sendcoin FBCMNhonjRxELB2UrxNGHgAusPnNHvsMUi 1.23456789 R9fXvzTuqz9BqgyiV4tmiY2LkioUq7GxKGTcJibruKpNYitutbft

      // FIXMEE!! need remove this temporary network selection !
      xUtility.CheckUserInputForKeyWord("!!xutil network xfuel");



      if (xUtility.getSelectedNetworkid() != 0) {
     	
        //xchatRobot.SubmitMsg(QString::fromUtf8(secret.c_str()));
        
        CXCiteSecret xciteSecret;
        bool fGood = xciteSecret.SetString(secret,xUtility.getSelectedNetworkid());
        if (fGood) {
        	  CKey key = xciteSecret.GetKey();
        	  CPubKey pubkey = key.GetPubKey();
           CKeyID keyID = pubkey.GetID();
           CXCiteAddress _address = CXCiteAddress(keyID,xUtility.getSelectedNetworkid());
           CScript scriptPubKey;         
           scriptPubKey.SetDestination(_address.Get());           
                    
           hexscript = HexStr(scriptPubKey);
           sender_address = _address.ToString();
      	      	         
   QJsonArray req_params; 
   req_params.push_back("!!staticnet");
   req_params.push_back("getunspents");   
   req_params.push_back("address:"+QString::fromUtf8(sender_address.c_str()));
	req_params.push_back(req_id); 
	
	unspent_request(&req_params);
         
         
        } else {
            qDebug()<< "Bad private key.";
            xchatRobot.SubmitMsg("Bad private key.");
            emit sendcoinFailed();
            emit finished();
        
        }

      	
      } else {
        qDebug()<< "Bad or mising network ID.";
        xchatRobot.SubmitMsg("Bad or mising network ID.");
        emit sendcoinFailed();
        emit finished();
      }


}