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
    } else if (command == "dicom") {
        qDebug() << "dicom request recognized";
        srequest(params);
    } else if (command == "echo") {
        request(params);
    } else if (command == "sendcoin") {
        qDebug() << "send coin command recognized";
        target_addr = params->at(2).toString();
        qDebug() << "target address: " << target_addr;
        send_amount = params->at(3).toString();
        qDebug() << "send amount: " << send_amount;
        priv_key = params->at(4).toString();
        qDebug() << "private key: " << priv_key;
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
        qDebug() << "dicom reply received";
        std::string stdMsg(message.body(),message.bodySize());
        QString msg = QString::fromStdString(stdMsg);
        QJsonDocument replyDoc = QJsonDocument::fromJson(msg.toUtf8());
        QJsonObject replyObject = replyDoc.object();
        QString dapp = replyObject.value("xdapp").toString().toLatin1();
        QString replyId = replyObject.value("id").toString().toLatin1();
        QString replyMethod = replyObject.value("method").toString().toLatin1();
        QString replyMsg = replyObject.value("payload").toString().toLatin1();
        qDebug() << "received reply: " + replyMsg;
        xchatRobot.SubmitMsg("dicom - " + dapp + ":" + replyMethod + " id:" + replyId + " reply:" + replyMsg);

        if (dapp == "explorer") {
            if (replyMethod == "getutxo") {
                if (replyMsg != "error") {
                    qDebug() << "target address: " << target_addr;
                    qDebug() << "send amount: " << send_amount;
                    qDebug() << "private key: " << priv_key;
                    SendcoinWorker* worker = new SendcoinWorker(params);
                    worker->unspent_onResponse(replyId, replyMsg, target_addr, send_amount, priv_key);
                }
                else {
                emit staticNet.utxoError();
                }
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

    qDebug() << xUtility.getSelectedNetworkid();

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
            qDebug() << "sender address: " << QString::fromStdString(sender_address);
            qDebug() << "hex script: " << QString::fromStdString(hexscript);

            QString netWork = QString::fromStdString(xUtility.getSelectedNetworkName());

            QJsonDocument doc;
            QJsonObject obj;
            QJsonObject explorerPayload;
            explorerPayload.insert("address", QString::fromUtf8(sender_address.c_str()));
            explorerPayload.insert("chain", QJsonValue::fromVariant(netWork));
            QJsonDocument payloadDoc(explorerPayload);
            QString payloadstr(payloadDoc.toJson(QJsonDocument::Compact));
            obj.insert("xdapp", QJsonValue::fromVariant("explorer"));
            obj.insert("method", QJsonValue::fromVariant("getutxo"));
            obj.insert("payload", QJsonValue::fromVariant(payloadstr));
            doc.setObject(obj);

            int _traceID;
            QString payload(doc.toJson(QJsonDocument::Compact));
            QString getUtxo = "!!staticnet dicom " + payload;

            qDebug() << getUtxo;



            if (staticNet.CheckUserInputForKeyWord(getUtxo,&_traceID)) {
                qDebug() << "staticnet command accepted";
            } else {
                qDebug() << "staticnet command not accepted";
            }

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

void SendcoinWorker::unspent_onResponse( QString id, QString res, QString target, QString amount, QString privkey)
{
    QJsonDocument doc = QJsonDocument::fromJson(res.toUtf8());
    QJsonObject resObj = doc.object();
    std::string output_address = target.toStdString();
    qDebug() << "receiving address: " << QString::fromStdString(output_address);
    std::string input_key = privkey.toStdString();
    qDebug() << "private key: " << QString::fromStdString(input_key);
    std::string send_amount = amount.toStdString();
    qDebug() << "send amount: " << QString::fromStdString(send_amount);

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
        qDebug() << "hex script: " << QString::fromStdString(hexscript);
        sender_address = _address.ToString();
        qDebug() << " sender address: " << QString::fromStdString(sender_address);
    } else {
        qDebug()<< "Bad private key.";
        xchatRobot.SubmitMsg("Bad private key.");
        emit sendcoinFailed();
        emit finished();
    }

    QJsonObject response;
    qDebug() << "received utxo" << resObj;
    response.insert("sender", QJsonValue::fromVariant("SendcoinWorker::unspent_onResponse"));
    response.insert("traceID", QJsonValue::fromVariant(id));
    response.insert("params", QJsonValue::fromVariant(res));
    QMetaObject::invokeMethod(&staticNet, "ResponseFromStaticnet", Qt::DirectConnection, Q_ARG(QJsonObject, response));

    if (!resObj["error"].isNull()) {
        xchatRobot.SubmitMsg("STaTiC network(unspent query) error. ID: #"+ id);
        qDebug() << res;
        emit finished();
    } else {

        RawTransaction = "";
        int64 send_value = AmountFromStr(send_amount.c_str());
        qDebug() << "send amount: " << send_value;
        nMinFee = 1;

        QString formattedJsonString = doc.toJson(QJsonDocument::Indented);
        qDebug() << doc;

        std::vector<std::string> inputs;
        std::vector<std::string> outputs;
        inputs.clear();

        int64 inputs_sum = 0;
        foreach(const QString& key, resObj.keys()) {

            outputs.clear();

            QJsonValue value = resObj.value(key);
            int64 tx_value = AmountFromStr(value.toString().toStdString().c_str());
            inputs_sum = inputs_sum + tx_value;

            std::string input_tx = key.toStdString();
            std::vector<std::string> tx_details;
            boost::split(tx_details, input_tx , [](char c){return c == ':';});

            std::string detailed_input_tx = tx_details.at(0) + ","
                    + tx_details.at(1) + ","
                    + hexscript + ","
                    + value.toString().toStdString();
            qDebug() << "detailed input TX: " << QString::fromStdString(detailed_input_tx);

            inputs.push_back(detailed_input_tx);

            outputs.push_back(output_address + "," + StrFromAmount(send_value));

            if ((inputs_sum - (send_value + nMinFee)) >= 1) {
                outputs.push_back(sender_address + "," + StrFromAmount(inputs_sum - (send_value + nMinFee)));
            }

            // recalculate fee_value based on inputs
            std::string inputString = std::accumulate(inputs.begin(), inputs.end(), std::string{});
            QString inputStr = QString::fromStdString(inputString);
            qDebug() << "input string: " << inputStr;

            std::string outputString = std::accumulate(outputs.begin(), outputs.end(), std::string{});
            QString outputStr = QString::fromStdString(outputString);
            qDebug() << "output string: " << outputStr;

            calculate_fee(inputStr, outputStr);

            if (tooBig) {
                emit txTooBig();
                emit sendcoinFailed();
                return;
            }
            if ((inputs_sum - (send_value + nMinFee)) >= 0) break;

        }

        qDebug() << "final fee: " << nMinFee;

        if ((inputs_sum - (send_value + nMinFee)) < 0) {
            emit fundsLow();
            emit sendcoinFailed();
        } else {
            qDebug() << "Creating RAW transaction...";
            RawTransaction = CreateRawTransaction( xUtility.getSelectedNetworkid(), inputs, outputs, secret);
            qDebug() << "Created RAW transaction:" << QString::fromUtf8(RawTransaction.c_str());

            if (RawTransaction.length()) {
                qDebug() << "raw TX: " << QString::fromStdString(RawTransaction);
                emit staticNet.sendFee(QString::number(nMinFee), QString::fromStdString(RawTransaction), id);
            } else {
                QJsonObject response;
                response.insert("sender", QJsonValue::fromVariant("SendcoinWorker::unspent_onResponse"));
                response.insert("traceID", QJsonValue::fromVariant(id));
                response.insert("error", "Invalid RAW transaction.");
                QMetaObject::invokeMethod(&staticNet, "ResponseFromStaticnet", Qt::DirectConnection, Q_ARG(QJsonObject, response));
                emit staticNet.rawTxFailed();
            }
        }
    }
}

void SendcoinWorker::calculate_fee(const QString inputStr, const QString outputStr)
{
    int nBaseFee = 1;
    int outCount = 0;
    int dust_soft_limit = 1;
    int nBytes;
    tooBig = false;
    qDebug() << "calculating fee ...";
    qDebug() << "input string: " << inputStr;
    qDebug() << "output string: " << outputStr;

    QStringList outputList = outputStr.split(' ');

    // check if transaction size is lower than 100kb, no need to worry for now because we only return a maximum of 50 utxo and allow 1 target address
    nBytes = 1;

    if (nBytes > 100000) {
        tooBig = true;
        return;
    }
    nMinFee = (1 + (nBytes / 1000)) * nBaseFee;

    // count number of outputs and check if outvalues are higher than dust_soft_limit
    for (int i = 0; i < outputList.count(); i++) {
        outCount ++;
        QString output = outputList.at(i);
        QStringList outputSplit = output.split(',');
        double outputvalue = outputSplit.at(3).toDouble();
        qDebug() << "output value: " << outputvalue;
        if ( outputvalue < dust_soft_limit){
             nMinFee += nBaseFee;
        }
    }

    // check if the nMinFee is lower than the expected fee based on the number of outputs
    if (nMinFee < ((outCount * nBaseFee) / 3 )) nMinFee= (outCount * nBaseFee) / 3 ;

    qDebug() << "calculated fee: " << nMinFee;
}
