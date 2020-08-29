/**
 * Filename: Explorer.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef CEX_HPP
#define CEX_HPP

#include <QObject>
#include <QtNetwork/QHostInfo>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QtWidgets>
#include "../support/DownloadManager.hpp"

class Cex : public QObject
{
    Q_OBJECT
public:
    explicit Cex(QObject *parent = nullptr);
    void  DownloadManagerHandler(URLObject *url);

signals:
    //

public slots:
    //
    void DownloadManagerRouter(QByteArray, QMap<QString,QVariant>);

private:
    //

};

#endif // CEX_HPP
