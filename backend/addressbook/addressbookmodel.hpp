/**
 * Filename: addressbookmodel.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef ADDRESSMODEL_HPP
#define ADDRESSMODEL_HPP

#include <QAbstractListModel>
#include <QFile>
#include <QDir>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QStandardPaths>

class Address : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name MEMBER m_name)
    Q_PROPERTY(QString address MEMBER m_address)

public:
    Address(QObject *parent = 0);
    Address(QString name, QString address, QObject *parent = 0);

    // TODO: Add getters/setters once we know more
public:
     QString m_name;
     QString m_address;
};


class AddressBookModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum AddressBookRoles {
        NameRole = Qt::UserRole + 1,
        AddressRole = Qt::UserRole + 2,
    };

    explicit AddressBookModel(QObject *parent = 0);

    virtual int rowCount(const QModelIndex &) const { return items.size(); }
    virtual QVariant data(const QModelIndex &index, int role) const;

    Q_INVOKABLE QVariantMap get(int idx);

    QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE int append(QString, QString);
    Q_INVOKABLE void update(int, QString, QString);
    Q_INVOKABLE int remove(int);
    Q_INVOKABLE void clear();
    Q_INVOKABLE bool save();
    Q_INVOKABLE bool load();

    void updateAccountAddress(QString, QString);

    QVector<Address*> items;

signals:
    void setCurrentIndex(int idx);
};

#endif // ADDRESSMODEL_HPP
