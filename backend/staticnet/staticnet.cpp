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
#include <QMessageBox>
#include <QGuiApplication>
#include <QScreen>
#include <QTimer>
#include <QLabel>
#include <QLayout>
#include <QHBoxLayout>
#include "staticnet.hpp"
#include "../xchat/xchat.hpp"
#include "../xutility/xutility.hpp"
#include "../xutility/crypto/ctools.h"
#include "../xutility/transaction/transaction.h"
#include "../support/Settings.hpp"
#include "../xutility/BrokerConnection.h"


StaticNet staticNet;
QStringList usedUtxo;
QStringList pendingUtxo;
QString queue_name  = "dicom_testqueue_v4";
QJsonObject commandList;

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
    } else if (command == "requestQueue") {
        emit staticNet.returnQueue(queue_name);
    } else if (command == "setQueue") {
        queue_name = params->at(2).toString();
        xchatRobot.SubmitMsg("dicom - backend - New queue set: " + queue_name);
    } else if (command == "dicom") {
        srequest(params);
    } else if (command == "echo") {
        request(params);
    } else if (command == "clearUtxo") {
        usedUtxo.clear();
        pendingUtxo.clear();
    } else if (command == "addUtxo") {
        QString newUtxo = params->at(2).toString();
        QStringList newUtxoList = newUtxo.split("-");
        for (int i = 0; i < newUtxoList.count(); i++) {
            pendingUtxo.append(newUtxoList.at(i));
        }
    } else if (command == "sendcoin") {
        target_addr = params->at(2).toString();
        send_amount = params->at(3).toString();
        priv_key = params->at(4).toString();
        sendcoin(params);
    } else {
        xchatRobot.SubmitMsg("dicom - backend - Bad !!staticnet command. Ignored.");
    }
}

void SnetKeyWordWorker::help() {
    xchatRobot.SubmitMsg("!!staticnet usage informations:");
    xchatRobot.SubmitMsg("!!staticnet ping");
    xchatRobot.SubmitMsg("!!staticnet echo [string]");
    xchatRobot.SubmitMsg("!!staticnet sendcoin [target] [amount] [privatekey]");
}

// NOT NEEDED ANYMORE (I THINK) ----
void SnetKeyWordWorker::request(const QJsonArray *params){

    xchatRobot.SubmitMsg("Command forwarded to STaTiC network. Wait for reply. ID: #"+params->last().toString());
    client = new StaticNetHttpClient(staticNet.GetConnectStr());
    connect(client, SIGNAL (response( QJsonArray, QJsonObject)), this, SLOT (onResponse( QJsonArray, QJsonObject)));

    client->request(params);
}

void SendcoinWorker::unspent_request(const QJsonArray *params) {

}

void SendcoinWorker::txbroadcast_request(const QJsonArray *params) {

}

void SendcoinWorker::txbroadcast_onResponse(QJsonArray params, QJsonObject ) {

}

// ----

void SnetKeyWordWorker::srequest(const QJsonArray *params) {

    std::string q_name = queue_name.toStdString();
    xchatRobot.SubmitMsg("dicom - backend - queue: " + QString::fromStdString(q_name));
    int paramSize = params ->count();
    QString xparams;
    for (int i = 2; i < paramSize - 1; i++) {
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
    QString xpayload;
    int repeat = 1;
    if (xdapp != "ping") {
        xpayload = requestObject.value("payload").toString().toLatin1();
    }
    else {
        QString pingPayload = requestObject.value("payload").toString().toLatin1();
        QStringList payloadPing = pingPayload.split("_");
        repeat = payloadPing.last().toInt();
        for (int e = 0; e < payloadPing.length()-1; e++){
            xpayload = xpayload + "_" + payloadPing.at(e);
        }
    }
    if (requestObject.contains("target")){
        target_addr = requestObject.value("target").toString();
    }
    if (requestObject.contains("send_amount")){
        send_amount = requestObject.value("send_amount").toString();
    }
    if (requestObject.contains("secret")){
        priv_key = requestObject.value("secret").toString();
    }

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
    xchatRobot.SubmitMsg("dicom - " + fullCommand);

    for (int i = 0; i < repeat; i++){
        // I would like to move this to a worker so we don't have to wait until a request is completed before sending a new one.
        //sendToDicom(docByteArray, queue_name, params);
        sendToDicom(docByteArray, xid, params);
    }
}

QString SnetKeyWordWorker::selectNode(){
    // for now ...
    selectedNode = Germany_02;
    //
    return selectedNode;
}

void SnetKeyWordWorker::sendToDicom(QByteArray docByteArray, QString msgID, const QJsonArray *params) {
    //std::string q_name = queueName.toStdString();
    //std::string strJson = docByteArray.toStdString();
    QString strJson = QString::fromStdString(docByteArray.toStdString());

    broker.connectQueue("xcite");
    broker.sendDicomMessage("",strJson);

    commandList.insert(msgID, QJsonValue::fromVariant(params->toVariantList()));

    /*
    std::string selectedCore = selectNode().toStdString();
    const std::string correlation(xUtility.get_uuid());
    SimplePocoHandler handler(selectedCore, 5672);
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
        channel.publish("",q_name,env);
    };

    channel.declareQueue(AMQP::exclusive).onSuccess(callback);

    auto receiveCallback = [&](const AMQP::Message &message,
            uint64_t deliveryTag,
            bool redelivered)
    {
        if(message.correlationID() != correlation)
            return;
        std::string stdMsg(message.body(),message.bodySize());
        QString msg = QString::fromStdString(stdMsg);
        processReply(msg, params);
        handler.quit();
    };

    channel.consume("", AMQP::noack).onReceived(receiveCallback);

    handler.loop();*/
}

void StaticNet::replyFromNetwork(QString msg) {
    QJsonDocument replyDoc = QJsonDocument::fromJson(msg.toUtf8());
    QJsonObject replyObject = replyDoc.object();
    QString replyId = replyObject.value("id").toString().toLatin1();
    QString payload = replyObject.value("payload").toString().toLatin1();

    if (commandList.contains(replyId)) {
        qDebug() << "reply to request: " << replyId << ", reply: " << payload;
        //xchatRobot.SubmitMsg("dicom - backend - reply: " + payload);
        //const QJsonArray *params = QJsonArray::fromVariantList(commandList.value(replyId).toVariantList());
    }
}

void SnetKeyWordWorker::processReply(QString msg, const QJsonArray *params) {
    QJsonDocument replyDoc = QJsonDocument::fromJson(msg.toUtf8());
    QJsonObject replyObject = replyDoc.object();
    QString dapp = replyObject.value("xdapp").toString().toLatin1();
    QString replyId = replyObject.value("id").toString().toLatin1();
    QString replyMethod = replyObject.value("method").toString().toLatin1();
    QString replyMsg = replyObject.value("payload").toString().toLatin1();
    xchatRobot.SubmitMsg("dicom - " + dapp + ":" + replyMethod + " id:" + replyId + " reply:" + replyMsg);
    QJsonDocument msgDoc = QJsonDocument::fromJson(replyMsg.toUtf8());
    QJsonObject msgObj = msgDoc.object();

    xchatRobot.SubmitMsg("dicom - " + dapp + ":" + replyMethod + " reply:" + msg);


    if (replyMethod == "getutxo") {
        if (replyMsg == "rpc error" || msgObj.contains("error")) {
            emit staticNet.utxoError();
            //staticNet.staticPopup("static-net", "error retrieving UTXO");
        }
        else {
            SendcoinWorker* worker = new SendcoinWorker(params);
            worker->unspent_onResponse(replyId, replyMsg, target_addr, send_amount, priv_key,usedUtxo);
        }
    }
    else if (replyMethod == "sendrawtransaction") {
        if (replyMsg == "rpc error" || msgObj.contains("error")) {
            emit staticNet.txFailed(replyId);
            //staticNet.staticPopup("static-net", "transaction not accepted");
        }
        else {
            replyMsg = replyMsg.replace("\"","");
            replyMsg = replyMsg.trimmed();
            emit staticNet.txSuccess(replyId, replyMsg);
            //staticNet.staticPopup("static-net", ("transaction accepted, txid: " + replyMsg));
            for (int i = 0; i < pendingUtxo.count(); i++) {
                QStringList confirmedUtxo = pendingUtxo.at(i).split(",");
                if (confirmedUtxo.at(1) == replyId) {
                    usedUtxo.append(pendingUtxo.at(i));
                }
            }
        }
    }
    else if (replyMethod == "gettxvouts") {
        if (replyMsg == "rpc error" || msgObj.contains("error")) {
            emit staticNet.txVoutError();
            //staticNet.staticPopup("static-net", "error retrieving vouts");
        }
        else {
            QJsonDocument voutDoc = QJsonDocument::fromJson(replyMsg.toUtf8());
            QJsonObject voutObj = voutDoc.object();
            bool voutspent = voutObj.value("spent").toBool();
            bool vouttxdb = voutObj.value("txdb").toBool();
            int txAmount = voutObj.value("value").toInt();
            QString spent;
            if(!voutspent){
                spent = "false";
            }
            else {
                spent = "true";
            }
            QString txdb;
            if(!vouttxdb){
                txdb = "false";
            }
            else {
                txdb = "true";
            }
            xchatRobot.SubmitMsg("dicom - " + dapp + ":txvout" + " spent:" + spent + " txdb:" + txdb + " value:" + QString::number(txAmount));
            emit staticNet.txVoutInfo(spent, txdb, txAmount);
        }
    }
}

void SnetKeyWordWorker::onResponse( QJsonArray params, QJsonObject res)
{
    if (!res["error"].isNull()) {
        xchatRobot.SubmitMsg("STaTiC network error. ID: #"+params.last().toString());
    } else {
        QJsonDocument doc(res);
        QString formattedJsonString = doc.toJson(QJsonDocument::Indented);
        xchatRobot.SubmitMsg("Recevied reply from STaTiC network: " + formattedJsonString);
    }
    emit finished();
}

void SnetKeyWordWorker::sendcoin(const QJsonArray *params) {

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

    // FIXMEE need validate each params
    module = params->at(1).toString();
    if (module == "sendcoin") {
        target_address = params->at(2).toString().toStdString();
        value_str = params->at(3).toString().toStdString();
        secret = params->at(4).toString().toStdString();
        trace_id = params->at(5).toString();
    }
}

SendcoinWorker::~SendcoinWorker() {	
}

void SendcoinWorker::process() {

    xchatRobot.SubmitMsg("dicom - backend - selected network: " + QString::fromStdString(xUtility.getSelectedNetworkName()));

    if (xUtility.getSelectedNetworkid() != 0 && module == "sendcoin") {

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

            QJsonDocument doc;
            QJsonObject obj;
            QString payloadstr = "{\"chain\":\"" + netWork + "\",\"address\":\"" + QString::fromUtf8(sender_address.c_str()) + "\"}";
            obj.insert("id",QJsonValue::fromVariant(trace_id));
            obj.insert("xdapp", QJsonValue::fromVariant("explorer"));
            obj.insert("method", QJsonValue::fromVariant("getutxo"));
            obj.insert("payload", QJsonValue::fromVariant(payloadstr));
            obj.insert("target",QString::fromStdString(target_address));
            obj.insert("send_amount",QString::fromStdString(value_str));
            obj.insert("secret",QString::fromStdString(secret));


            doc.setObject(obj);

            int _traceID;
            QString payload(doc.toJson(QJsonDocument::Compact));
            QString getUtxo = "!!staticnet dicom " + payload;

            if (staticNet.CheckUserInputForKeyWord(getUtxo,&_traceID)) {
                //qDebug() << "staticnet command accepted";
            } else {
                //qDebug() << "staticnet command not accepted";
            }

        } else {
            xchatRobot.SubmitMsg("dicom - backend - Bad private key.");
            emit sendcoinFailed();
            //staticNet.staticPopup("static-net", "failed sending coins, bad private key");
            emit finished();
        }


    } else {
        xchatRobot.SubmitMsg("dicom - backend - Bad or mising network ID.");
        emit sendcoinFailed();
        //staticNet.staticPopup("static-net", "failed sending coins, network ID error");
        emit finished();
    }
}

void SendcoinWorker::unspent_onResponse( QString id, QString res, QString target, QString amount, QString privkey, QStringList used_Utxo)
{
    QJsonDocument doc = QJsonDocument::fromJson(res.toUtf8());
    QJsonObject resObj = doc.object();
    std::string output_address = target.toStdString();
    std::string input_key = privkey.toStdString();
    std::string send_amount = amount.toStdString();

    CXCiteSecret xciteSecret;
    bool fGood = xciteSecret.SetString(input_key,xUtility.getSelectedNetworkid());
    if (fGood) {
        CKey key = xciteSecret.GetKey();
        CPubKey pubkey = key.GetPubKey();
        CKeyID keyID = pubkey.GetID();
        CXCiteAddress _address = CXCiteAddress(keyID,xUtility.getSelectedNetworkid());
        CScript scriptPubKey;
        scriptPubKey.SetDestination(_address.Get());

        hexscript = HexStr(scriptPubKey);
        sender_address = _address.ToString();
        secret = privkey.toStdString();
    } else {
        xchatRobot.SubmitMsg("dicom - backend - Bad private key.");
        emit sendcoinFailed();
        //staticNet.staticPopup("static-net", "failed sending coins, bad private key");
        emit finished();
    }

    QJsonObject response;
    response.insert("sender", QJsonValue::fromVariant("SendcoinWorker::unspent_onResponse"));
    response.insert("traceID", QJsonValue::fromVariant(id));
    response.insert("params", QJsonValue::fromVariant(res));
    QMetaObject::invokeMethod(&staticNet, "ResponseFromStaticnet", Qt::DirectConnection, Q_ARG(QJsonObject, response));

    if (resObj.contains("error")){
        xchatRobot.SubmitMsg("dicom - backend - getutxo error. ID: #"+ id);
        emit finished();
    } else {

        RawTransaction = "";
        int64 send_value = AmountFromStr(send_amount.c_str());
        nMinFee = 1;

        QString formattedJsonString = doc.toJson(QJsonDocument::Indented);
        qDebug() << doc;

        std::vector<std::string> inputs;
        std::vector<std::string> outputs;
        std::string inputString;
        std::string outputString;
        QString inputStr;
        QString outputStr;
        QString outptStr;
        QStringList inputStringList;
        QStringList outputStringList;
        QStringList outptStringList;
        inputs.clear();
        int64 inputs_sum = 0;
        int inptCount = 0;
        int returnedUtxo = resObj.keys().count();

        foreach(const QString& key, resObj.keys()) {
            inptCount = inptCount + 1;
            outputs.clear();

            QJsonValue value = resObj.value(key);
            int64 tx_value = AmountFromStr(value.toString().toStdString().c_str());

            std::string input_tx = key.toStdString();
            std::vector<std::string> tx_details;
            boost::split(tx_details, input_tx , [](char c){return c == ':';});
            if (used_Utxo.count() != 0) {
                bool used = false;
                for (int i = 0; i < used_Utxo.count(); i++) {
                    std::string utxoID = used_Utxo.at(i).toStdString();
                    std::vector<std::string> utxo_details;
                    boost::split(utxo_details, utxoID, [](char c){return c == ',';});
                    if (tx_details.at(0) == utxo_details.at(2) && xUtility.getSelectedNetworkName() == utxo_details.at(0)) {
                        used = true;
                    }
                }
                if (!used) {
                    inputs_sum = inputs_sum + tx_value;

                    std::string detailed_input_tx = tx_details.at(0) + ","
                            + tx_details.at(1) + ","
                            + hexscript + ","
                            + value.toString().toStdString();

                    inputs.push_back(detailed_input_tx);
                }
            }
            else {
                inputs_sum = inputs_sum + tx_value;

                std::string detailed_input_tx = tx_details.at(0) + ","
                        + tx_details.at(1) + ","
                        + hexscript + ","
                        + value.toString().toStdString();

                inputs.push_back(detailed_input_tx);
            }
            // adjust for batch transactions
            QStringList targetStrLst = target.split(";");
            QStringList newTarget;
            std::string newReceiver;
            std::string newAmount;
            for (int i = 0; i < targetStrLst.count(); i++) {
                newTarget = targetStrLst.at(i).split("-");
                newReceiver = newTarget.at(0).toStdString();
                newAmount = newTarget.at(1).toStdString();
                outputs.push_back(newReceiver + "," + newAmount);
            }
            int64 leftover = inputs_sum - (send_value + (nMinFee * nBaseFee));
            if (leftover >= dust_soft_limit) {
                outputs.push_back(sender_address + "," + StrFromAmount(leftover));
            }

            // recalculate fee_value based on inputs
            inputStringList.clear();
            for (auto element : inputs) {
                inputStringList.append(QString::fromStdString(element));
            }
            inputStr = inputStringList.join(" ");

            outputStringList.clear();
            for (auto element : outputs) {
                outputStringList.append(QString::fromStdString(element));
            }
            outputStr = outputStringList.join(" ");

            calculate_fee(inputStr, outputStr);
            if (tooBig) {
                emit txTooBig();
                emit sendcoinFailed();
                //staticNet.staticPopup("static-net", "failed sending coins, transaction is too big");
                return;
            }
            int64 checkInputs = inputs_sum - (send_value + (nMinFee * nBaseFee));
            if (checkInputs >= 0) break;
        }

        if ((inputs_sum - (send_value + (nMinFee * nBaseFee))) < 0) {
            //emit staticNet.fundsLow();
            if (returnedUtxo == 50) {
                xchatRobot.SubmitMsg("dicom - backend - not enough utxo available to complete transaction, only 50 utxo are returned. Lower the amount of your transaction.");
                emit staticNet.fundsLow("Not enough utxo available");
                //staticNet.staticPopup("static-net", "failed sending coins, not enough UTXO available");
            }
            else if (returnedUtxo < 50 && inptCount == returnedUtxo) {
                xchatRobot.SubmitMsg("dicom - backend - your available coins are currently used for unconfirmed transactions. Wait until your previous transactions are confirmed");
                emit staticNet.fundsLow("Not enough coins available");
                //staticNet.staticPopup("static-net", "failed sending coins, not enough coins available");
            }
        } else {
            if (secret != ""){
                qDebug() << "Creating RAW transaction...";
                std::vector<std::string> outpts;
                xchatRobot.SubmitMsg("dicom - backend - input_sum: : " + QString::number(inputs_sum));
                xchatRobot.SubmitMsg("dicom - backend - send_value: " + QString::number(send_value));
                xchatRobot.SubmitMsg("dicom - backend - final fee: " + QString::number(nMinFee * nBaseFee));
                outpts.clear();
                QStringList targetStrLst = target.split(";");
                QStringList newTarget;
                std::string newReceiver;
                std::string newAmount;
                for (int i = 0; i < targetStrLst.count(); i++) {
                    newTarget = targetStrLst.at(i).split("-");
                    newReceiver = newTarget.at(0).toStdString();
                    newAmount = newTarget.at(1).toStdString();
                    outpts.push_back(newReceiver + "," + newAmount);
                }
                //outpts.push_back(output_address + "," + StrFromAmount(send_value));
                int64 change = inputs_sum - (send_value + (nMinFee * nBaseFee));
                if (change >= dust_soft_limit) {
                    xchatRobot.SubmitMsg("dicom - backend - change: " + QString::number(change));
                    outpts.push_back(sender_address + "," + StrFromAmount(change));
                }
                outptStringList.clear();
                for (auto element : outpts) {
                    outptStringList.append(QString::fromStdString(element));
                }
                outptStr = outptStringList.join(" ");
                qDebug() << "final fee: " << (nMinFee * nBaseFee);
                //usedUtxo = used_Utxo;
                QStringList reservedUtxo;
                QString network = QString::fromStdString(xUtility.getSelectedNetworkName());
                for (int i = 0; i < inputStringList.count(); i++) {
                    reservedUtxo.append(network + "," + id + "," + inputStringList.at(i));
                }
                RawTransaction = CreateRawTransaction( xUtility.getSelectedNetworkid(), inputs, outpts, secret);

                if (RawTransaction.length()) {
                    qDebug() << "raw TX: " << QString::fromStdString(RawTransaction);
                    xchatRobot.SubmitMsg("dicom - backend - inputs: " + inputStr);
                    xchatRobot.SubmitMsg("dicom - backend - outputs: " + outptStr);
                    xchatRobot.SubmitMsg("dicom - backend - raw TX: " + QString::fromStdString(RawTransaction));
                    double send_Amount = send_value/100000000;
                    double send_Fee = (nMinFee * nBaseFee)/100000000;
                    double send_UsedCoins = inputs_sum/100000000;
                    int _traceID;
                    QString updateUtxo = "!!staticnet addUtxo " + reservedUtxo.join("-");
                    QString usedCoins = QString::number(send_UsedCoins);
                    xchatRobot.SubmitMsg("dicom - backend - used coins: " + usedCoins);
                    if (staticNet.CheckUserInputForKeyWord(updateUtxo,&_traceID)) {
                        //
                    } else {
                        xchatRobot.SubmitMsg("dicom - backend - update UTXO list command not accepted");
                    }
                    QString rawTx = "[\"" + QString::fromStdString(RawTransaction) + "\"]";
                    emit staticNet.sendFee(QString::number(send_Fee), rawTx, target, QString::fromStdString(sender_address),usedCoins,amount, id);
                } else {
                    QJsonObject response;
                    response.insert("sender", QJsonValue::fromVariant("SendcoinWorker::unspent_onResponse"));
                    response.insert("traceID", QJsonValue::fromVariant(id));
                    response.insert("error", "Invalid RAW transaction.");
                    QMetaObject::invokeMethod(&staticNet, "ResponseFromStaticnet", Qt::DirectConnection, Q_ARG(QJsonObject, response));
                    emit staticNet.rawTxFailed();
                    //staticNet.staticPopup("static-net", "failed sending coins, invalid raw transaction");
                }
            }
            else {
                xchatRobot.SubmitMsg("dicom - backend - error: no private key");
                //staticNet.staticPopup("static-net", "failed sending coins, no private key available");
            }
        }
    }
}

void SendcoinWorker::calculate_fee(const QString inputStr, const QString outputStr)
{
    tooBig = false;
    QStringList outputList = outputStr.split(' ');
    QStringList inputList = inputStr.split(' ');
    int outputCount = outputList.count();
    int inputCount = inputList.count();
    int outputSize = 33;
    int inputSize = 146;
    int maxSize = 100000;
    int nBaseValue= 1;
    double outCount = 0;
    int nBytes;
    double dbCount = 0;
    int intCount = 0;
    int countFee = 0;

    // estimate size of the transaction
    nBytes = (inputSize * inputCount) + (outputSize * outputCount) + 10;
    xchatRobot.SubmitMsg("dicom - backend - TX size: " + QString::number(nBytes) + " bytes");

    // reject transactions bigger than 100k
    if (nBytes > maxSize) {
        tooBig = true;
        return;
    }
    nMinFee = (1 + (nBytes / 1000)) * nBaseValue;
    xchatRobot.SubmitMsg("dicom - backend - fee after size check: " + QString::number(nMinFee));

    // count number of outputs and check if outvalues are higher than dust_soft_limit
    for (int i = 0; i < outputList.count(); i++) {
        outCount += 1;
        QString output = outputList.at(i);
        QStringList outputSplit = output.split(',');
        QString outputValue = outputSplit.last();
        int64 outputvalue =  AmountFromStr(outputValue.toStdString().c_str());
        if ( outputvalue < dust_soft_limit){
            nMinFee += nBaseValue;
        }
    }

    // check if the nMinFee is lower than the expected fee based on the number of outputs
    qDebug() << "number of outputs: " << outCount;
    dbCount = (outCount/3);
    qDebug() << "double calculation: " << outCount << "/" << 3 << " = " << dbCount;
    intCount = (outCount/3);
    qDebug() << "integer calculation: " << outCount << "/" << 3 << " = " << intCount;
    if (dbCount > intCount) {
        countFee = (intCount + 1)*nBaseValue;
    }
    else {
        countFee = intCount*nBaseValue;
    }
    qDebug() << "output count based fee: " << countFee;

    //adjust fee for outputs
    if (nMinFee < countFee) {
        nMinFee = countFee ;
    }
    xchatRobot.SubmitMsg("dicom - backend - fee after output check: " + QString::number(nMinFee));

    xchatRobot.SubmitMsg("dicom - backend - calculated fee: " + QString::number(nMinFee));
}
/*
void StaticNet::staticPopup(QString author, QString msg){
    QString osType = QSysInfo::productType();
    QString device = "desktop";
    if (osType == "android" || osType == "ios") {
        device = "mobile";
    }
    if (device == "desktop") {
        QWidget *dialog = new QWidget;
        QHBoxLayout *msgBox = new QHBoxLayout;
        QLabel *message = new QLabel;
        message->setMaximumWidth(400);
        message->setMaximumHeight(68);
        message->setStyleSheet("font: 10pt; color:rgb(242,242,242);");
        message->setAlignment(Qt::AlignLeft | Qt::AlignTop);
        message->setWordWrap(true);
        QString auth = "<font color='#0ED8D2'><b>" + author + "</b></font>";
        QString xchatMsg = auth + ":<br><i>" + msg + "</i>";
        message->setText(xchatMsg);
        QSize size = QGuiApplication::screens()[0]->size();
        int xBox = size.width(); int yBox = size.height();
        QPoint recB;
        int xBottom; int yBottom;
        xBottom = xBox - 5; yBottom = yBox - 50;
        recB.setX(xBottom); recB.setY(yBottom);
        QPoint recT;
        int xTop; int yTop;
        xTop = xBox - 405; yTop = yBox - 118;
        recT.setX(xTop); recT.setY(yTop);
        QRect rec;
        rec.setTopLeft(recT); rec.setBottomRight(recB);
        dialog->setGeometry(rec);
        dialog->setStyleSheet("background-color:rgb(20,22,27);");
        dialog->setWindowFlags(Qt::Window | Qt::FramelessWindowHint |Qt::WindowStaysOnTopHint);
        msgBox->addWidget(message);
        dialog->setLayout(msgBox);
        dialog->show();
        QTimer::singleShot(3000, dialog, SLOT(hide()));
    }
}*/
