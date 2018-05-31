/**
 * Filename: xchattestnetclient.cpp
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
#include "xchattestnetclient.hpp"
#include "testnet.hpp"

void XchatTestnetClient::WriteBalance(QString account)
{
    QVariantList params = { account };

    Testnet wallet;
    wallet.request("chat", "getbalance", params);
}

void XchatTestnetClient::CompleteWriteBalance(XchatObject *xchatobject, QString balance)
{
    xchatobject->SubmitMsg(xchatobject->m_lastUserMessage.replace("$_WALLET_BALANCE_XBY$", balance));
}

void XchatTestnetClient::WriteDumpprivkey(QString account)
{
    QVariantList params = { account };

    Testnet wallet;
    wallet.request("chat", "dumpprivkey", params);
}

void XchatTestnetClient::CompleteDumpprivkey(XchatObject *xchatobject, QString dumpprivkey)
{
    xchatobject->SubmitMsg(xchatobject->m_lastUserMessage.replace("$_WALLET_DUMPPRIVKEY$", dumpprivkey));
}

void XchatTestnetClient::WriteGetBlock(QString blockHash)
{
    QVariantList params = { blockHash };

    Testnet wallet;
    wallet.request("chat", "getblock", params);
}

void XchatTestnetClient::CompleteGetBlock(XchatObject *xchatobject, QJsonArray blockdata)
{
    QString message;
    for (int i = 0; i < blockdata.size(); i++) {
        QJsonObject entry = blockdata[i].toObject();
        message.append(entry["name"].toString() + " : " + entry["address"].toString());
        message.append("\n");
    }
    xchatobject->SubmitMsg(xchatobject->m_lastUserMessage.replace("$_WALLET_GETBLOCK$", message));
}
