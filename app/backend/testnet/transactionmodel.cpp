#include "transactionmodel.hpp"

Transaction::Transaction(QObject *parent) :
    QObject(parent)
{
}

Transaction::Transaction(QString type, QString txid, QString address, qlonglong amount, QDateTime dt, QObject *parent) :
    QObject(parent)
{
    m_type = type;
    m_txid = txid;
    m_address = address;
    m_amount = amount;
    m_dt = dt;
}

TransactionModel::TransactionModel(QObject *parent) :
    QAbstractListModel(parent)
{
}

void TransactionModel::add(QString type, QString txid, QString address, qlonglong amount, QDateTime dt)
{
    Transaction *t = new Transaction(type, txid, address, amount, dt);

    beginInsertRows(QModelIndex(), 0, 0);
    m_transactions.push_front(t);
    endInsertRows();
}

QHash<int, QByteArray> TransactionModel::roleNames() const {
    QHash<int, QByteArray> roles;

    roles[AddressRole] = "address";
    roles[TransactionIDRole] = "txid";
    roles[AmountRole] = "amount";
    roles[TimestampRole] = "timestamp";
    roles[TypeRole] = "type";

    return roles;
}

QVariantMap TransactionModel::get(int row)
{
    QHash<int,QByteArray> names = roleNames();
    QHashIterator<int, QByteArray> i(names);
    QModelIndex idx = index(row, 0);
    QVariantMap res;

    while (i.hasNext()) {
        i.next();
        QVariant data = idx.data(i.key());
        res[i.value()] = data;
    }

    return res;
}

QVariant TransactionModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    switch (role) {
    case TransactionIDRole:
        return QVariant(m_transactions[index.row()]->m_txid);
    case TypeRole:
        return QVariant(m_transactions[index.row()]->m_type);
    case AddressRole:
        return QVariant(m_transactions[index.row()]->m_address);
    case AmountRole:
        return QVariant(m_transactions[index.row()]->m_amount);
    case TimestampRole:
        return QVariant(m_transactions[index.row()]->m_dt);
    }

    return QVariant();
}

