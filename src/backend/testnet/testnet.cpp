
#include <QDebug>
#include "testnet.hpp"

void Testnet::sendFrom(QString account, QString address, qreal amount) {
    qDebug() << "SendFrom: " << account << ", " << address << "<" << amount;

    QJsonArray args;
    args.push_back(account);
    args.push_back(address);
    args.push_back(amount);
    qDebug() << args;

    QJsonRpcMessage message = QJsonRpcMessage::createRequest("sendfrom", args);
    QJsonRpcMessage res = client->sendMessageBlocking(message);

    if (res.type() == QJsonRpcMessage::Error) {
        walletError(res.errorMessage());
        return;
    }

    walletSuccess(res.result().toString());

    qDebug() << res;
}

void Testnet::getAccountAddress(QString account) {
    qDebug() << "getAccountAddress: " << account;

    QJsonArray args;
    args.push_back(account);

    QJsonRpcMessage message = QJsonRpcMessage::createRequest("getaccountaddress", args);
    QJsonRpcMessage res = client->sendMessageBlocking(message);

    if (res.type() == QJsonRpcMessage::Error) {
        walletError(res.errorMessage());
        return;
    }

    m_accounts->updateAccountAddress(account, res.result().toString());
}

void Testnet::request(QString command) {
    // Wonky performance hack to avoid the overhead of pulling accounts continually
    if ((command == "listaccounts") && accountsLoaded) {
        return;
    }

    qDebug() << "Request: " << command;

    QJsonRpcMessage message = QJsonRpcMessage::createRequest(command);
    QJsonRpcMessage res = client->sendMessageBlocking(message);

    if (res.type() == QJsonRpcMessage::Error) {
        walletError(res.errorData().toString());
        qDebug() << res;
        return;
    }

    if (command == "getbalance") {
        setProperty("balance", res.result());
    } else if (command == "listtransactions") {
        QJsonArray transactionList = res.toObject()["result"].toArray();

        m_transactions->removeRows(0, m_transactions->m_transactions.size());

        foreach (const QJsonValue &row, transactionList) {
            QJsonObject tx = row.toObject();
            QDateTime dt;

            qlonglong amount = tx["amount"].toDouble();
            dt.setTime_t(tx["time"].toInt());

            m_transactions->add(
                amount >= 0 ? "IN" : "OUT",
                tx["txid"].toString(),
                tx["address"].toString(),
                tx["amount"].toDouble(),
                dt
            );
        }
    } else if (command == "listaccounts") {
        QJsonObject accounts = res.toObject()["result"].toObject();

        accountsLoaded = true;
        m_accounts->clear();

        QStringList keys = accounts.keys();
        for (int i = 0; i < keys.count(); i++) {
            QString name = keys.at(i);
            QString address = "";

            m_accounts->append(name, address);
        }

        m_accounts->setCurrentIndex(0);
    }
}
