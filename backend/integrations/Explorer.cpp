/**
 * Filename: Explorer.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include <QEventLoop>
#include <QSettings>
#include "Explorer.hpp"
#include <QWindow>


Explorer::Explorer(QObject *parent) : QObject(parent)
{
}

void Explorer::getBalanceEntireWallet(QString walletList, QString wallets){

    QJsonArray walletArray = QJsonDocument::fromJson(walletList.toLatin1()).array();
    foreach (const QJsonValue & value, walletArray) {
        QJsonObject obj = value.toObject();
        QString coin = obj.value("name").toString().toLower();
        QString address = obj.value("address").toString();
        if (coin == "xtest") {
            coin = "xfuel-testnet";
        }
        if (coin.length() > 0){
            if ((coin == "xby") || (coin == "xfuel") || (coin == "xfuel-testnet")){
                QString response =  getBalanceAddressXBY(coin,address, "1");
                QJsonDocument jsonResponse = QJsonDocument::fromJson(response.toLatin1());
                qDebug() << coin << ", " << address << ", " << jsonResponse;
                QJsonObject result = jsonResponse.object().value("result").toObject();
                QString balance = result.value("balance_current").toString();
                balance = balance.insert(balance.length() - 8, ".");
                if (coin == "xfuel-testnet") {
                    coin = "xtest";
                }
                emit updateBalance(coin.toUpper(),address, balance);
            } else if(((coin == "btc") || (coin == "eth")) && wallets == "all"){
                QString response =  getBalanceAddressExt(coin,address);
                QJsonDocument jsonResponse = QJsonDocument::fromJson(response.toLatin1());
                qDebug() << coin << ", " << address << ", " << jsonResponse;
                if(jsonResponse.object().contains("balance")) {
                    double balanceLong = jsonResponse.object().value("balance").toDouble();
                    QString balance;
                    if (coin == "eth"){
                        double convertFromWei = balanceLong / 1000000000000000000;
                        balance = QString::number(convertFromWei);
                    }else{
                        double convertFromSAT = balanceLong / 100000000;
                        balance = QString::number(convertFromSAT);
                    }

                    emit updateBalance(coin.toUpper(),address, balance);
                }
            }
        }
    }
}


void Explorer::getTransactionList(QString coin, QString address, QString page){
    QString selectedCoin = coin.toLower();
    if (selectedCoin == "xtest") {
        selectedCoin = "xfuel-testnet";
    }
    if (selectedCoin.length() > 0){
        if ((selectedCoin == "xby") || (selectedCoin == "xfuel") || (selectedCoin == "xfuel-testnet")){
            QString response =  getBalanceAddressXBY(selectedCoin,address, page);
            QJsonDocument jsonResponse = QJsonDocument::fromJson(response.toLatin1());
            QJsonObject meta = jsonResponse.object().value("meta").toObject();
            int totalPages = meta.value("pages").toInt();

            QJsonObject result = jsonResponse.object().value("result").toObject();
            QJsonArray transactions = result.value("transactions").toArray();
            QJsonDocument doc;
            doc.setArray(transactions);
            QString transactionString(doc.toJson(QJsonDocument::Compact));

            emit updateTransactions(transactionString, QString::number(totalPages));

        }
    }
}

void Explorer::getDetails(QString coin, QString transaction) {

    emit explorerBusy();

    QString selectedCoin = coin.toLower();
    if (selectedCoin == "xtest") {
        selectedCoin = "xfuel-testnet";
    }
    if (selectedCoin.length() > 0){
        if ((selectedCoin == "xby") || (selectedCoin == "xfuel") || (selectedCoin == "xfuel-testnet")){
            QString response =  getTransactionDetails(selectedCoin,transaction);
            QJsonDocument jsonResponse = QJsonDocument::fromJson(response.toLatin1());
            QJsonObject result = jsonResponse.object().value("result").toObject();

            qDebug() << jsonResponse;

            QString timestamp = result.value("data").toString();
            QLocale::setDefault(QLocale::English);
            QDateTime date = QLocale().toDateTime(timestamp, "yyyy-MMM-dd HH:mm:ss");
            date.setTimeSpec(Qt::UTC);
            QDateTime local = date.toLocalTime();
            timestamp = local.toString("yyyy-MMMM-dd HH:mm:ss");

            int confirms = result.value("confirmations").toInt();
            QString balance = result.value("amount").toString();
            QJsonArray inputs = result.value("inputs").toArray();
            QJsonDocument inputdoc;
            inputdoc.setArray(inputs);
            QString inputString(inputdoc.toJson(QJsonDocument::Compact));
            QJsonArray outputs = result.value("outputs").toArray();
            QJsonDocument outputdoc;
            outputdoc.setArray(outputs);
            QString outputString(outputdoc.toJson(QJsonDocument::Compact));

            emit updateTransactionsDetails(timestamp, QString::number(confirms), balance, inputString, outputString);

        }
    }

    qDebug() << "all details collected";
    emit detailsCollected();
}

QString Explorer::getTransactionDetails(QString coin, QString transaction) {

    QString url = "https://xtrabytes.global/api/"+ coin + "/transaction/" + transaction;

    QUrl Url;
    Url.setPath(url);

    QEventLoop eventLoop;
    QNetworkAccessManager mgr;
    QObject::connect(&mgr, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    QJsonObject json;

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Accept", "application/json");

    QSslConfiguration conf = request.sslConfiguration();
    conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    request.setSslConfiguration(conf);

    QNetworkReply *reply = mgr.get(request);
    eventLoop.exec();

    QString strReply = (QString)reply->readAll();
    return strReply;
}

QString Explorer::getBalanceAddressXBY(QString coin, QString address, QString page){
    QString balance = "";
    QString url = "https://xtrabytes.global/api/"+ coin + "/address/" + address + "?page=" + page;

    QUrl Url;
    Url.setPath(url);

    QEventLoop eventLoop;
    QNetworkAccessManager mgr;
    QObject::connect(&mgr, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    QJsonObject json;

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Accept", "application/json");

    QSslConfiguration conf = request.sslConfiguration();
    conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    request.setSslConfiguration(conf);

    QNetworkReply *reply = mgr.get(request);
    eventLoop.exec();

    QString strReply = (QString)reply->readAll();
    return strReply;
}

QString Explorer::getBalanceAddressExt(QString coin, QString address){
    QString balance = "";
    QString url = "https://api.blockcypher.com/v1/"+ coin + "/main/addrs/" + address;

    QUrl Url;
    Url.setPath(url);

    QEventLoop eventLoop;
    QNetworkAccessManager mgr;
    QObject::connect(&mgr, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    QJsonObject json;

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Accept", "application/json");

    QSslConfiguration conf = request.sslConfiguration();
    conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    request.setSslConfiguration(conf);

    QNetworkReply *reply = mgr.get(request);
    eventLoop.exec();

    QString strReply = (QString)reply->readAll();
    return strReply;
}

void Explorer::WalletUpdate(QString coin, QString label, QString message){
    QMessageBox *msgBox = new QMessageBox;
    msgBox->setParent(0);
    msgBox->setWindowTitle(coin + " " + label);
    msgBox->setText(message);
    msgBox->setStandardButtons(QMessageBox::Ok);
    msgBox->setWindowFlags(Qt::FramelessWindowHint|Qt::WindowStaysOnTopHint);
    msgBox->show();
}

void Explorer::checkTxStatus(QString pendingList) {

    emit explorerBusy();

    QJsonArray pendingArray = QJsonDocument::fromJson(pendingList.toLatin1()).array();
    foreach (const QJsonValue & value, pendingArray) {

        QJsonObject obj = value.toObject();
        QString coin = obj.value("coin").toString().toLower();
        QString address = obj.value("address").toString();
        QString transaction = obj.value("txid").toString();

        if (coin != ""){
            if (coin == "xtest") {
                coin = "xfuel-testnet";
            }

            QString response =  getTransactionDetails(coin, transaction);
            QJsonDocument jsonResponse = QJsonDocument::fromJson(response.toLatin1());

            qDebug() << jsonResponse;

            if (coin == "xfuel-testnet") {
                coin = "xtest";
            }

            coin = coin.toUpper();

            if (jsonResponse.object().contains("message")) {
                qDebug() << "transaction not found";
                emit txidNotFound(coin, address, transaction, "true");
            }
            else if (jsonResponse.object().contains("result")) {
                qDebug() << "transaction found";

                QJsonObject result = jsonResponse.object().value("result").toObject();
                int confirms = result.value("confirmations").toInt();
                qDebug() << "confirmations: " + confirms;

                if (confirms >= 1) {
                    emit txidConfirmed(coin, address, transaction, "true");
                }
                else {
                    emit txidExists(coin, address, transaction, "false");
                }
            }
        }
    }

    qDebug() << "all tx checked";
    emit allTxChecked();
}
