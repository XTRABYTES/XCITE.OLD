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

bool AddressBookModel::save()
{
    QString savePath = QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation);
    QDir path = QDir(savePath);

    if (!path.exists())
    {
        path.mkpath(".");
    }

    // TODO: Must be a QT way to create paths in a better fashion
    QFile f(savePath + "/" + "addresses.json");

    if (!f.open(QIODevice::WriteOnly)) {
        qWarning("Unable to save addressbook");
        return false;
    }

    QJsonArray addresses;
    for (int i = 0; i < items.size(); i++) {
        QJsonObject entry;
        entry["name"] = items[i]->m_name;
        entry["address"] = items[i]->m_address;
        addresses.append(entry);
    }

    QJsonDocument doc(addresses);
    f.write(doc.toJson());

    return true;
}

bool AddressBookModel::load()
{
    QString loadPath = QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation);
    QFile f(loadPath + "/" + "addresses.json");

    if (!f.open(QIODevice::ReadOnly)) {
        // TODO: Temporary pre-populate addressbook to make life easier for testing
        append("dedpull", "XV3Goey53xDt51oAZ6LfGm8G51k5QmMXmR");
        append("enervey", "XZhRoyup9cbVguuqDUWWBuqhLmE483FtXW");
        append("james87uk", "XLGSfK2RhjvEbkGMe4WVk2R8k9auLESAsv");
        append("nrocy", "XYjAvodSHYRBzWv1WGb1bCtmVfMvGDSYAJ");
        append("posey", "XJmqWTfBQwZk2QgU3eFnbtenUHXXPmsgPa");

        return false;
    }

    QJsonDocument json(QJsonDocument::fromJson(f.readAll()));
    if (!json.isArray()) {
        qWarning("Load addressbook failed, expected array in addresses.json");
        return false;
    }

    QJsonArray entries = json.array();
    for (int i = 0; i < entries.size(); i++) {
        QJsonObject entry = entries[i].toObject();
        append(entry["name"].toString(), entry["address"].toString());
    }

    return true;
}

