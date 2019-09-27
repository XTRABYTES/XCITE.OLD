/**
 * Filename: Wallet.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef STATICNET_INTEGRATION_HPP
#define STATICNET_INTEGRATION_HPP

#include <QMainWindow>
#include <QObject>
#include <QJsonArray>
#include <QJsonObject>
#include <QWidget>

class staticnet_integration : public QObject {
        Q_OBJECT

public:
    explicit staticnet_integration(QObject *parent = nullptr);

signals:
    void sendCoinsSuccess(QString transactionId, QString traceID);
    void sendCoinsFailure(QString error, QString traceID);
    void badRawTX(QString traceID);
    void validParams(QString traceID);
    void badParams();

public slots:
    void sendCoinsEntry(QString msg);
    void onResponseFromStaticnetEntry(QJsonObject response);
};


#endif // STATICNET_INTEGRATION_HPP
