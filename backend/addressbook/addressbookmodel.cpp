/**
 * Filename: addressbookmodel.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

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

int AddressBookModel::append(QString name, QString address)
{
    Address *addr = new Address;
    addr->m_name = name;
    addr->m_address = address;

    int idx = items.size();

    beginInsertRows(QModelIndex(), idx, idx);
    items.append(addr);
    endInsertRows();

    return idx;
}

int AddressBookModel::remove(int idx)
{
    Address *addr = items.at(idx);
    if (addr != NULL) {
        beginRemoveRows(QModelIndex(), idx, idx);
        items.remove(idx);
        endRemoveRows();
        free(addr);
    }

    return (idx > 0 ? idx : 0);
}

void AddressBookModel::update(int idx, QString name, QString address)
{
    Address *addr = items.at(idx);
    if (addr == NULL) {
        return;
    }

    addr->m_name = name;
    addr->m_address = address;

    emit dataChanged(index(idx), index(idx));
}

void AddressBookModel::updateAccountAddress(QString account, QString address) {
    for (int i = 0; i < items.size(); i++) {
        if (items[i]->m_name == account) {
            update(i, account, address);
            return;
        }
    }

    // TODO: This is just a quick hack to make adding addresses work. Ought to be in a proper method
    int idx = append(account, address);
    emit setCurrentIndex(idx);
}

void AddressBookModel::clear()
{
    beginRemoveRows(QModelIndex(), 0, items.size());
    items.clear();
    endRemoveRows();
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


