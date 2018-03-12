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
