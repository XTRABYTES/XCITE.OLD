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
#include <string>
#include <sstream>

#include <boost/algorithm/string.hpp>

#include <QDebug>
#include <QMetaObject>
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

    traceID=0;
    //ConnectStr="https://127.0.0.1:8080/v1.0/dicom";
    //ConnectStr="https://87.229.77.126:8443/v1.0/dicom";
    ConnectStr="https://87.229.77.126:8442/v1.0/dicom";

}

bool StaticNet::CheckUserInputForKeyWord(const QString msg, int *traceID) {

    *traceID = staticNet.GetNewTraceID();

    qDebug() << "staticnet accessed! traceID= " << *traceID;

    if (!(msg.split(" ").at(0) == "!!staticnet")) {
        return false;
    }
    QString traced_msg = msg + " " + QString::number(*traceID);
    QThread* thread = new QThread;
    SnetKeyWordWorker* worker = new SnetKeyWordWorker(&traced_msg);
    worker->moveToThread(thread);
    connect(worker, SIGNAL (error(QString)), this, SLOT (errorString(QString)));
    connect(thread, SIGNAL (started()), worker, SLOT (process()));
    connect(worker, SIGNAL (finished()), thread, SLOT (quit()));
    connect(worker, SIGNAL (finished()), worker, SLOT (deleteLater()));
    connect(thread, SIGNAL (finished()), thread, SLOT (deleteLater()));
    thread->start();

    return true;

}

void StaticNet::errorString(const QString error) {
    qDebug() << error;
}

StaticNetHttpClient::StaticNetHttpClient(const QString &endpoint, QObject *parent ): QObject(parent) {

    req.setUrl(QUrl(endpoint));
    req.setHeader(QNetworkRequest::ContentTypeHeader,"application/json;");
    manager = new QNetworkAccessManager();

    connect(manager, SIGNAL (finished(QNetworkReply*)), this, SLOT (onResponse(QNetworkReply*)));
    // FIXMEE!
    // connect(manager, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(slotNetworkError(QNetworkReply::NetworkError)));
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


SnetKeyWordWorker::SnetKeyWordWorker(const QString *_msg) {

    this->msg = QString(*_msg);
}

SnetKeyWordWorker::~SnetKeyWordWorker() {
    //xchatRobot.SubmitMsg("SnetKeyWordWorker() worker stopped.");
}

int SnetKeyWordWorker::errorString(QString errorstr) {
    qDebug() << "Error string recevied" << errorstr;
}

void SnetKeyWordWorker::process() {

    qDebug() << "Processing staticnet command: [" << msg << "]";
    
    QStringList args = msg.split(" ");
    QJsonArray params;
    
    for (QStringList::const_iterator it = args.constBegin(); it != args.constEnd(); ++it) params.append(QJsonValue(*it));
    
    CmdParser(&params);

    qDebug() << "Processing done" << &params;

}

void SnetKeyWordWorker::CmdParser(const QJsonArray *params) {

    qDebug() << "reading command";

    QString command = params->at(1).toString();

    QJsonObject response;
    response.insert("sender", QJsonValue::fromVariant("SnetKeyWordWorker::CmdParser"));
    response.insert("params", QJsonValue::fromVariant(*params));
    QMetaObject::invokeMethod(&staticNet, "ResponseFromStaticnet", Qt::DirectConnection, Q_ARG(QJsonObject, response));


    if (command == "help") {
        help();
    } else if (command == "ping") {
        request(params);
    } else if (command == "dicom") {
        qDebug() << "dicom request recognized";
        srequest(params);
    } else if (command == "echo") {
        request(params);
    } else if (command == "sendcoin") {
        qDebug() << "send coin command recognized";
        sendcoin(params);
    } else if (command == "broadcasttx") {
        qDebug() << "broadcast transaction command recognized";
        broadcastTx(params);
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

    //xchatRobot.SubmitMsg("Command forwarded to STaTiC network. Wait for reply. ID: #"+params->last().toString());
    client = new StaticNetHttpClient(staticNet.GetConnectStr());
    connect(client, SIGNAL (response( QJsonArray, QJsonObject)), this, SLOT (onResponse( QJsonArray, QJsonObject)));

    client->request(params);
}

void SnetKeyWordWorker::srequest(const QJsonArray *params) {

    int paramSize = params ->count();
    QString xparams;
    for (int i = 2; i < paramSize - 1; i ++) {
        if (i == 2) {
            xparams = params ->at(i).toString();
        }
        else {
            xparams = xparams + " " + params -> at(i).toString();
        }
    }
    qDebug() << "trimmed params: " << xparams;

    QJsonDocument requestDoc = QJsonDocument::fromJson(xparams.toUtf8());
    QJsonObject requestObject = requestDoc.object();
    QString xdapp = requestObject.value("xdapp").toString().toLatin1();
    QString xmethod = requestObject.value("method").toString().toLatin1();
    QString xpayload = requestObject.value("payload").toString().toLatin1();
    qDebug() << "payload: " << xpayload;
    QString xid = requestObject.value("id").toString().toLatin1();
    if (xid == "") {
        xid = params->last().toString();
    }

    QJsonDocument doc;
    QJsonObject obj;
    obj.insert("dicom", QJsonValue::fromVariant("1.0"));
    obj.insert("type", QJsonValue::fromVariant("request"));
    obj.insert("id", QJsonValue::fromVariant(xid));
    obj.insert("xdapp", QJsonValue::fromVariant(xdapp));
    obj.insert("method", QJsonValue::fromVariant(xmethod));
    obj.insert("payload", QJsonValue::fromVariant(xpayload));
    doc.setObject(obj);

    QByteArray docByteArray = doc.toJson(QJsonDocument::Compact);
    std::string strJson = docByteArray.toStdString();
    QString fullCommand = QString::fromStdString(strJson);
    qDebug() << "full command: " << fullCommand;

    const std::string correlation(xUtility.get_uuid());
    SimplePocoHandler handler("85.214.143.20", 5672);
    AMQP::Connection connection(&handler, AMQP::Login("guest", "guest"), "/");

    AMQP::Channel channel(&connection);
    AMQP::QueueCallback callback = [&](const std::string &name,
            int msgcount,
            int consumercount)
    {
        std::string sping_attrib = strJson;
        AMQP::Envelope env(sping_attrib.c_str(),strlen(sping_attrib.c_str()));
        env.setCorrelationID(correlation);
        env.setReplyTo(name);
        channel.publish("","dicom_testqueue",env);
    };
    qDebug() << "request send to STATIC network";

    channel.declareQueue(AMQP::exclusive).onSuccess(callback);

    auto receiveCallback = [&](const AMQP::Message &message,
            uint64_t deliveryTag,
            bool redelivered)
    {
        if(message.correlationID() != correlation)
            return;
        qDebug() << "ping reply received";
        std::string stdMsg(message.body(),message.bodySize());
        QString msg = QString::fromStdString(stdMsg);
        QJsonDocument replyDoc = QJsonDocument::fromJson(msg.toUtf8());
        QJsonObject replyObject = replyDoc.object();
        QString dapp = replyObject.value("xdapp").toString().toLatin1();
        QString replyId = replyObject.value("id").toString().toLatin1();
        QString replyMethod = replyObject.value("method").toString().toLatin1();
        QString replyMsg = replyObject.value("payload").toString().toLatin1();
        qDebug() << "received reply: " + replyMsg;
        xchatRobot.SubmitMsg(dapp + " reply:" + replyMsg);

        if (dapp == "explorer") {
            if (replyMethod == "getutxo") {
                SendcoinWorker::unspent_onResponse(replyId, replyObject.value("payload"));   // need help here
            }
        }

        handler.quit();
    };

    channel.consume("", AMQP::noack).onReceived(receiveCallback);

    handler.loop();

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

void SnetKeyWordWorker::broadcastTx(const QJsonArray *params) {

    QString netWork = params->at(2).toString().toLatin1();
    QString payload = params->at(3).toString().toLatin1();
    QString id = params->at(4).toString().toLatin1();

    QJsonArray arr;
    QJsonObject idObj;
    idObj.insert("id", QJsonValue::fromVariant(id));
    QJsonObject xdappObj;
    xdappObj.insert("xdapp", QJsonValue::fromVariant(netWork));
    QJsonObject methodObj;
    methodObj.insert("method", QJsonValue::fromVariant("rawtx"));
    QJsonObject payloadObj;
    payloadObj.insert("payload", QJsonValue::fromVariant(payload));
    arr.append(idObj);
    arr.append(xdappObj);
    arr.append(methodObj);
    arr.append(payloadObj);

    SnetKeyWordWorker::srequest(arr); // need help here
}


SendcoinWorker::SendcoinWorker(const QJsonArray *params) { 

    // FIXMEE need validate each params
    target_address = params->at(2).toString().toStdString();
    value_str = params->at(3).toString().toStdString();
    secret = params->at(4).toString().toStdString();
    trace_id = params->at(5).toString();
}

SendcoinWorker::~SendcoinWorker() {	
}


void SendcoinWorker::unspent_request(const QJsonArray *params) {

    QJsonObject response;
    response.insert("sender", QJsonValue::fromVariant("SendcoinWorker::unspent_request"));
    response.insert("traceID", QJsonValue::fromVariant(trace_id));
    response.insert("params", QJsonValue::fromVariant(params));
    QMetaObject::invokeMethod(&staticNet, "ResponseFromStaticnet", Qt::DirectConnection, Q_ARG(QJsonObject, response));

    client = new StaticNetHttpClient(staticNet.GetConnectStr());
    connect(client, SIGNAL (response( QJsonArray, QJsonObject)), this, SLOT (unspent_onResponse( QJsonArray, QJsonObject)));

    client->request(params);
}

// NOT NEEDED ANYMORE
//void SendcoinWorker::txbroadcast_request(const QJsonArray *params) {

//    QJsonObject response;
//    response.insert("sender", QJsonValue::fromVariant("SendcoinWorker::txbroadcast_request"));
//    response.insert("traceID", QJsonValue::fromVariant(trace_id));
//    response.insert("params", QJsonValue::fromVariant(params));
//    QMetaObject::invokeMethod(&staticNet, "ResponseFromStaticnet", Qt::DirectConnection, Q_ARG(QJsonObject, response));

//    client = new StaticNetHttpClient(staticNet.GetConnectStr());
//    connect(client, SIGNAL (response( QJsonArray, QJsonObject)), this, SLOT (txbroadcast_onResponse( QJsonArray, QJsonObject)));

//    client->request(params);
//}


//void SendcoinWorker::txbroadcast_onResponse( QJsonArray params, QJsonObject res)
//{

//    QJsonObject response;
//    response.insert("sender", QJsonValue::fromVariant("SendcoinWorker::txbroadcast_onResponse"));
//    response.insert("traceID", QJsonValue::fromVariant(trace_id));
//    response.insert("params", QJsonValue::fromVariant(res));
//    QMetaObject::invokeMethod(&staticNet, "ResponseFromStaticnet", Qt::DirectConnection, Q_ARG(QJsonObject, response));

//    if (!res["error"].isNull()) {
//        xchatRobot.SubmitMsg("STaTiC network(unspent query) error. ID: #"+params.last().toString());
//        qDebug() << res;
//    } else {

//        QJsonDocument doc(res);
//        QString formattedJsonString = doc.toJson(QJsonDocument::Indented);
//        //xchatRobot.SubmitMsg("Recevied txbroadcast reply from STaTiC network. ID: #"+params.last().toString());
//        xchatRobot.SubmitMsg(formattedJsonString);
//        qDebug() << formattedJsonString;
//    }
//    emit finished();
//}

void SendcoinWorker::calculate_fee(const QJsonArray inputs, const QJsonArray outputs)
{
    int64 nBaseFee = 1;
    int64 outCount = 0;
    int64 dust_soft_limit = 1;
    tooBig = false;

    unsigned int nBytes;
    // calculate nBytes based on inputs & outputs

    if (nBytes > 100000) {
        tooBig = true;
        return;
    }
    nMinFee = (1 + (int64)nBytes / 1000) * nBaseFee;
    // help needed to write the code
    //foreach() {
        // for each output in the list add 1 to outcount
    outCount ++;

    // if ( outputvalue < dust_soft_limit){
        // if the value of the output is lower than dust_soft_limit add 1 nBaseFee to the nMinFee
    //nMinFee += nBaseFee
    // }
    //}
    // check if the nMinFee is lower than the expected fee based on the number of outputs
    if (nMinFee < ((outCount * nBaseFee) / 3 )) nMinFee= (outCount * nBaseFee) / 3 ;
}

void SendcoinWorker::unspent_onResponse( QString id, QJsonObject res)
{
    
    QJsonObject response;
    response.insert("sender", QJsonValue::fromVariant("SendcoinWorker::unspent_onResponse"));
    response.insert("traceID", QJsonValue::fromVariant(id));
    response.insert("params", QJsonValue::fromVariant(res));
    QMetaObject::invokeMethod(&staticNet, "ResponseFromStaticnet", Qt::DirectConnection, Q_ARG(QJsonObject, response));

    if (!res["error"].isNull()) {
        xchatRobot.SubmitMsg("STaTiC network(unspent query) error. ID: #"+ id);
        qDebug() << res;
        emit finished();
    } else {

        RawTransaction = "";
        int64 send_value = AmountFromStr(value_str.c_str());
        int64 fee_value = AmountFromStr("1.00000000");
        nMinFee = fee_value;

        QJsonDocument doc(res);
        QString formattedJsonString = doc.toJson(QJsonDocument::Indented);
        qDebug() << res;
        // the format returned looks like this {"utxo-id:vout-value":"utxo-value", "utxo-id:vout":"utxo-value", "utxo-id:vout":"utxo-value", "utxo-id:vout":"utxo-value", ...}
        //QJsonObject json;

        std::vector<std::string> inputs;
        std::vector<std::string> outputs;

        int64 inputs_sum = 0;
        foreach(const QString& key, res.keys()) {

            outputs.clear();

            QJsonValue value = res.value(key);
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

            outputs.push_back(target_address + "," + StrFromAmount(send_value));

            if ((inputs_sum - (send_value + nMinFee)) >= 1) {
                outputs.push_back(sender_address + "," + StrFromAmount(inputs_sum - (send_value + nMinFee)));
            }

            // recalculate fee_value based on inputs
            if (tooBig) {
                emit txTooBig();
                return;
            }
            if ((inputs_sum - (send_value + nMinFee)) >= 0) break;

        }

        if ((inputs_sum - (send_value + nMinFee)) < 0) {
            emit fundsLow();
        } else {
            qDebug() << "Creating RAW transaction...";
            RawTransaction = CreateRawTransaction( xUtility.getSelectedNetworkid(), inputs, outputs, secret);
            qDebug() << "Created RAW transaction:" << QString::fromUtf8(RawTransaction.c_str());

            if (RawTransaction.length()) {
                emit sendFee(QString::number(nMinFee), QString::fromStdString(RawTransaction), trace_id);
            } else {
                QJsonObject response;
                response.insert("sender", QJsonValue::fromVariant("SendcoinWorker::unspent_onResponse"));
                response.insert("traceID", QJsonValue::fromVariant(trace_id));
                response.insert("error", "Invalid RAW transaction.");
                QMetaObject::invokeMethod(&staticNet, "ResponseFromStaticnet", Qt::DirectConnection, Q_ARG(QJsonObject, response));
                emit finished();
            }
        }
    }
}

void SendcoinWorker::process() { 

    qDebug() << xUtility.getSelectedNetworkid();

    if (xUtility.getSelectedNetworkid() != 0) {

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

            QString netWork = QString::fromStdString(xUtility.getSelectedNetworkName());

            QJsonArray arr;
            QJsonObject explorerPayload;
            explorerPayload.insert("chain", QJsonValue::fromVariant(netWork));
            explorerPayload.insert("address", QString::fromUtf8(sender_address.c_str()));
            QJsonObject idObj;
            idObj.insert("id", QJsonValue::fromVariant(trace_id));
            QJsonObject xdappObj;
            xdappObj.insert("xdapp", QJsonValue::fromVariant("explorer"));
            QJsonObject methodObj;
            methodObj.insert("method", QJsonValue::fromVariant("getutxo"));
            QJsonObject payloadObj;
            payloadObj.insert("payload", explorerPayload);
            arr.append(idObj);
            arr.append(xdappObj);
            arr.append(methodObj);
            arr.append(payloadObj);

            SnetKeyWordWorker::srequest(arr); // need help here

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
