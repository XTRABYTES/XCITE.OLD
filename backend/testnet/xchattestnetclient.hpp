/**
 * Filename: xchattestnetclient.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef XCHATTESTNETCLIENT_H
#define XCHATTESTNETCLIENT_H

#include "../xchat/xchat.hpp"


class XchatTestnetClient : QObject
{
    Q_OBJECT

public:
    void WriteBalance(QString account);
    void CompleteWriteBalance(XchatObject *xchatobject, QString balance);

    void WriteDumpprivkey(QString account);
    void CompleteDumpprivkey(XchatObject *xchatobject, QString privkey);

    void WriteGetBlock(QString blockhash);
    void CompleteGetBlock(XchatObject *xchatobject, QJsonArray blockdata);

private:
    XchatObject *xchatobject;
};

#endif // XCHATTESTNETCLIENT_H
