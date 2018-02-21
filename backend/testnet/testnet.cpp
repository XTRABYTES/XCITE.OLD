
#include <QDebug>
#include "testnet.hpp"

void Testnet::sendFrom(QString account, QString address, qreal amount) {
    QJsonArray params = {account, address, amount};

    client->request("sendfrom", params);
}

void Testnet::getAccountAddress(QString account) {
    QJsonArray params = {
        account
    };

    client->request("getaccountaddress", params);
}

void Testnet::validateAddress(QString address) {
    QJsonArray params = {
        address
    };

    client->request("validateaddress", params);
}

void Testnet::onResponse(QString command, QJsonArray params, QJsonObject res)
{
    QVariantMap reply = res.toVariantMap();

    if (!res["error"].isNull()) {
        qDebug() << res;
        walletError(res["error"].toObject()["message"].toString());
        return;
    }

    if (command == "getbalance") {
        setProperty("balance", reply["result"]);
    } else if (command == "listtransactions") {
        QJsonArray transactionList = res["result"].toArray();

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
        QJsonObject accounts = res["result"].toObject();

        accountsLoaded = true;
        m_accounts->clear();

        QStringList keys = accounts.keys();
        for (int i = 0; i < keys.count(); i++) {
            QString name = keys.at(i);
            QString address = "";

            m_accounts->append(name, address);
        }

        m_accounts->setCurrentIndex(0);
    } else if (command == "getaccountaddress") {
        m_accounts->updateAccountAddress(params[0].toString(), res["result"].toString());
    } else if (command == "validateaddress") {
        if (!res["result"].toObject()["isvalid"].toBool()) {
            walletError("Invalid address: " + params[0].toString());
        }
    } else if (command == "sendfrom") {
        walletSuccess(res["result"].toString());
    }
}

void Testnet::request(QString command) {
    // Wonky performance hack to avoid the overhead of pulling accounts continually
    if ((command == "listaccounts") && accountsLoaded) {
        return;
    }

    client->request(command, QJsonArray());
}
