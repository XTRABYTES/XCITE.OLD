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

#include <QSettings>
#include "Explorer.hpp"
#include "../xchat/xchat.hpp"
#include <QWindow>


Explorer::Explorer(QObject *parent) : QObject(parent)
{
}
void Explorer::DownloadManagerHandler(URLObject *url){
    DownloadManager *manager = manager->getInstance();
    url->addProperty("url",url->getUrl());
    url->addProperty("class","Explorer");
    manager->append(url);
    //  connect(manager,  SIGNAL(readTimeout(QMap<QString,QVariant>)),this,SLOT(internetTimeout(QMap<QString,QVariant>)),Qt::UniqueConnection);

    connect(manager,  SIGNAL(readFinished(QByteArray,QMap<QString,QVariant>)), this,SLOT(DownloadManagerRouter(QByteArray,QMap<QString,QVariant>)),Qt::UniqueConnection);


}

void Explorer::DownloadManagerRouter(QByteArray response, QMap<QString,QVariant> props){
    if (props.value("class").toString() == "Explorer"){
        QString route = props.value("route").toString();

        if (route == "getTransactionList"){
            getTransactionDetailsSlot(response);
        }else if (route == "getDetails"){
            getDetailsSlot(response,props);
        }else if (route == "getBalanceAddressXBYSlot"){
            getBalanceAddressXBYSlot(response,props);
        }else if (route == "getBalanceAddressExtSlot"){
            getBalanceAddressExtSlot(response,props);
        }else if (route == "getTransactionStatusSlot"){
            getTransactionStatusSlot(response,props);
        }else if (route == "checkInternetSlot"){
            checkInternetSlot(response,props);
        }
    }
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
                if (checkInternet("https://xtrabytes.global")) {

                    QString balance = "";
                    QString url = "https://xtrabytes.global/api/"+ coin.toLower() + "/address/" + address;
                    URLObject urlObj {QUrl(url)};
                    urlObj.addProperty("route","getBalanceAddressXBYSlot");
                    urlObj.addProperty("coin",coin);
                    urlObj.addProperty("address",address);
                    DownloadManagerHandler(&urlObj);
                }
                else {
                    qDebug() << "no connection to XTRABYTES blockexplorer for wallet balance";
                    emit noInternet();
                }
            } else if(((coin == "btc") || (coin == "eth")) && wallets == "all"){
                if (checkInternet("https://api.blockcypher.com")) {
                    QString url = "https://api.blockcypher.com/v1/"+ coin + "/main/addrs/" + address;
                    URLObject urlObj {QUrl(url)};
                    urlObj.addProperty("route","getBalanceAddressExtSlot");
                    urlObj.addProperty("coin",coin);
                    urlObj.addProperty("address",address);
                    DownloadManagerHandler(&urlObj);
                }
                else {
                    qDebug() << "no connection to Blockcypher blockexplorer";
                    emit noInternet();
                }
            }
        }
    }
    emit walletChecked();
    return;
}


void Explorer::getTransactionList(QString coin, QString address, QString page){
    if (checkInternet("https://xtrabytes.global")) {
        QString selectedCoin = coin.toLower();
        if (selectedCoin == "xtest") {
            selectedCoin = "xfuel-testnet";
        }
        if (selectedCoin.length() > 0){
            if ((selectedCoin == "xby") || (selectedCoin == "xfuel") || (selectedCoin == "xfuel-testnet")){
                QString balance = "";
                QString url = "https://xtrabytes.global/api/"+ selectedCoin + "/address/" + address + "?page=" + page;

                URLObject urlObj {QUrl(url)};
                urlObj.addProperty("route","getTransactionList");
                DownloadManagerHandler(&urlObj);
                return;
            }
            return;
        }
    }
    else {
        qDebug() << "no connection to XTRABYTES blockexplorer for transaction list";
        noInternet();
        return;
    }
}

void Explorer::getDetails(QString coin, QString transaction) {
    if (checkInternet("https://xtrabytes.global")) {
        emit explorerBusy();

        QString selectedCoin = coin.toLower();
        if (selectedCoin == "xtest") {
            selectedCoin = "xfuel-testnet";
        }
        if (selectedCoin.length() > 0){
            if ((selectedCoin == "xby") || (selectedCoin == "xfuel") || (selectedCoin == "xfuel-testnet")){
                QString url = "https://xtrabytes.global/api/"+ selectedCoin + "/transaction/" + transaction;
                URLObject urlObj {QUrl(url)};
                urlObj.addProperty("route","getDetails");
                DownloadManagerHandler(&urlObj);
            }
        }
        emit detailsCollected();
        return;
    }
    else {
        qDebug() << "no connection to XTRABYTES blockexplorer for transaction details";
        emit noInternet();
        return;
    }
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
    if (checkInternet("https://xtrabytes.global")) {
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

                QString url = "https://xtrabytes.global/api/"+ coin + "/transaction/" + transaction;

                URLObject urlObj {QUrl(url)};
                urlObj.addProperty("route","getTransactionStatusSlot");
                urlObj.addProperty("coin",coin);
                urlObj.addProperty("address",address);
                urlObj.addProperty("transaction",transaction);

                DownloadManagerHandler(&urlObj);

            }
        }
        emit allTxChecked();
        return;
    }
    else {
        qDebug() << "no connection to XTRABYTES blockexplorer for transaction status";
        emit noInternet();
        return;
    }
}
// SLOTS //
void Explorer::getTransactionDetailsSlot(QByteArray response){
    QJsonDocument jsonResponse = QJsonDocument::fromJson(response);
    QJsonObject meta = jsonResponse.object().value("meta").toObject();
    int totalPages = meta.value("pages").toInt();

    QJsonObject result = jsonResponse.object().value("result").toObject();
    QJsonArray transactions = result.value("transactions").toArray();
    QJsonDocument doc;
    doc.setArray(transactions);
    QString transactionString(doc.toJson(QJsonDocument::Compact));

    emit updateTransactions(transactionString, QString::number(totalPages));
}

void Explorer::getDetailsSlot(QByteArray response, QMap<QString,QVariant> props){
    QJsonDocument jsonResponse = QJsonDocument::fromJson(response);
    QJsonObject result = jsonResponse.object().value("result").toObject();
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

void Explorer::getBalanceAddressXBYSlot(QByteArray response, QMap<QString,QVariant> props){
    QString coin = props.value("coin").toString();
    QString address = props.value("address").toString();

    QJsonDocument jsonResponse = QJsonDocument::fromJson(response);
    QJsonObject result = jsonResponse.object().value("result").toObject();
    QString balance = result.value("balance_current").toString();
    balance = balance.insert(balance.length() - 8, ".");
    if (coin == "xfuel-testnet") {
        coin = "xtest";
    }
    emit updateBalance(coin.toUpper(),address, balance);
}

void Explorer::getBalanceAddressExtSlot(QByteArray response, QMap<QString,QVariant> props){
    QJsonDocument jsonResponse = QJsonDocument::fromJson(response);
    QString coin = props.value("coin").toString();
    QString address = props.value("address").toString();

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

        emit updateBalance(coin,address, balance);
    }
}


void Explorer::getTransactionStatusSlot(QByteArray response, QMap<QString,QVariant> props){

    QString coin = props.value("coin").toString();
    QString address = props.value("address").toString();
    QString transaction = props.value("transaction").toString();


    QJsonDocument jsonResponse = QJsonDocument::fromJson(response);

    qDebug() << jsonResponse;

    if (coin == "xfuel-testnet") {
        coin = "xtest";
    }

    coin = coin.toUpper();

    if (jsonResponse.object().contains("message")) {
        qDebug() << "transaction not found";
        emit txidNotFound(coin, address, transaction, "rejected");
        xchatRobot.SubmitMsg("dicom - explorer - transaction not found, coin: " + coin + " address: " + address + " txid: " + transaction);
    }
    else if (jsonResponse.object().contains("result")) {
        qDebug() << "transaction found";

        QJsonObject result = jsonResponse.object().value("result").toObject();
        int confirms = result.value("confirmations").toInt();
        qDebug() << "confirmations: " << confirms;

        if (confirms >= 1 && confirms < 3) {
            emit txidConfirmed(coin, address, transaction, "true");
            xchatRobot.SubmitMsg("dicom - explorer - transaction confirmed, coin: " + coin + " address: " + address + " txid: " + transaction + " confirmations: " + QString::number(confirms));
        }
        else if (confirms >= 3) {
            emit txidConfirmed(coin, address, transaction, "confirmed");
            xchatRobot.SubmitMsg("dicom - explorer - transaction confirmed, coin: " + coin + " address: " + address + " txid: " + transaction + " confirmations: " + QString::number(confirms));
        }
        else {
            emit txidExists(coin, address, transaction, "false");
            xchatRobot.SubmitMsg("dicom - explorer - transaction found, coin: " + coin + " address: " + address + " txid: " + transaction);
        }
    }
}

bool Explorer::checkInternet(QString url){
    bool internetStatus = false;
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);
    if(manager->networkAccessible() == QNetworkAccessManager::Accessible) {
        QTimer timeout;
        QEventLoop loop;
        timeout.setSingleShot(true);
        timeout.start(6000);
        connect(&timeout, SIGNAL(timeout()), &loop, SLOT(quit()),Qt::QueuedConnection);
        auto connectionHandler = connect(this, &Explorer::internetStatusSignal, [&internetStatus, &loop](bool checked) {
            internetStatus = checked;
            loop.quit();

        });

        URLObject urlObj {QUrl(url)};
        urlObj.addProperty("route","checkInternetSlot");
        DownloadManagerHandler(&urlObj);

        loop.exec();
        disconnect(connectionHandler);
        timeout.deleteLater();

        return internetStatus;
    }
    else {
        return internetStatus;
    }
}

void Explorer::checkInternetSlot(QByteArray response, QMap<QString,QVariant> props){
    if (response != ""){
        emit internetStatusSignal(true);
    }else{
        emit internetStatusSignal(false);
    }
}
