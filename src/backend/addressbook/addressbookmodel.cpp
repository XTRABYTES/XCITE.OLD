#include "addressbookmodel.hpp"

Address::Address(QObject *parent) :
    QObject(parent)
{
}

Address::Address(QString name, QString address, QObject *parent) :
    QObject(parent)
{
    m_name = name;
    m_address = address;
}

void AddressBookModel::add(QString name, QString address)
{
    Address *addr = new Address();
    addr->m_name = name;
    addr->m_address = address;

    beginInsertRows(QModelIndex(), 0, 0);
    items.push_back(addr);
    endInsertRows();
}

AddressBookModel::AddressBookModel(QObject *parent) :
    QAbstractListModel(parent)
{
}

QHash<int, QByteArray> AddressBookModel::roleNames() const {
    QHash<int, QByteArray> roles;

    roles[NameRole] = "name";
    roles[AddressRole] = "address";

    return roles;
}

QVariantMap AddressBookModel::get(int row)
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

QVariant AddressBookModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    switch (role) {
    case NameRole:
        return QVariant(items[index.row()]->m_name);
    case AddressRole:
        return QVariant(items[index.row()]->m_address);
    }

    return QVariant();
}

