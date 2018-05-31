/**
 * Filename: transactionmodel.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef TRANSACTIONMODEL_HPP
#define TRANSACTIONMODEL_HPP

#include <QObject>
#include <QAbstractListModel>
#include <QDateTime>
#include <QDebug>

class Transaction : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString address MEMBER m_address)
    Q_PROPERTY(QString txid MEMBER m_txid)

public:
    Transaction(QObject *parent = 0);
    Transaction(QString m_type, QString txid, QString address, qlonglong amount, QDateTime dt, QObject *parent = 0);

    QString m_type;
    QString m_txid;
    QString m_address;
    qlonglong m_amount;
    QDateTime m_dt;
};

class TransactionModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum TransactionRoles {
        TypeRole = Qt::UserRole + 1,
        TransactionIDRole = Qt::UserRole + 2,
        AddressRole = Qt::UserRole + 3,
        AmountRole = Qt::UserRole + 4,
        TimestampRole = Qt::UserRole + 5,
    };

    explicit TransactionModel(QObject *parent = 0);

    virtual int rowCount(const QModelIndex &) const { return m_transactions.size(); }
    virtual QVariant data(const QModelIndex &index, int role) const;

    Q_INVOKABLE QVariantMap get(int idx);

    QHash<int, QByteArray> roleNames() const;

    void add(QString, QString, QString, qlonglong, QDateTime);

public:
    QVector<Transaction*> m_transactions;
};

#endif // TRANSACTIONMODEL_HPP
