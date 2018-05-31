/**
 * Filename: MarketValue.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef MARKETVALUE_HPP
#define MARKETVALUE_HPP

#include <QObject>
#include <QtNetwork/QHostInfo>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

class MarketValue : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString marketValue READ marketValue WRITE setMarketValue NOTIFY marketValueChanged)
public:
    explicit MarketValue(QObject *parent = nullptr);

    void setMarketValue(const QString &value) {
        if (value != m_marketValue) {
            m_marketValue = value;
            emit marketValueChanged();
        }
    }
    QString marketValue() const {
        return m_marketValue;
    }

signals:
    void marketValueChanged();
public slots:
    void findXBYValue(QString currency);
    void onFinished(QNetworkReply* reply);
private:
    QString m_marketValue;
};

#endif // MARKETVALUE_HPP
