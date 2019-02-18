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
    Q_PROPERTY(QString marketValueBTC READ marketValueBTC WRITE setMarketValueBTC NOTIFY marketValueBTCChanged)
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

    void setMarketValueBTC(const QString &value) {
        if (value != m_marketValue) {
            m_marketValueBTC = value;
            emit marketValueBTCChanged();
        }
    }
    QString marketValueBTC() const {
        return m_marketValueBTC;
    }

signals:
    void marketValueChanged();
    void marketValueBTCChanged();
public slots:
    void findXBYValue(QString currency);
    void findBTCValue(QString currency);
    void onFinished(QNetworkReply* reply);
    void onBTCFinished(QNetworkReply* reply);
private:
    QString m_marketValue;
    QString m_marketValueBTC;
};

#endif // MARKETVALUE_HPP
