/**
 * Filename: xchatconversationmodel.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef XCHATCONVERSATIONMODEL_HPP
#define XCHATCONVERSATIONMODEL_HPP

#include <QAbstractListModel>
#include <QDateTime>

class XChatConversationMessage : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString message MEMBER m_message)
    Q_PROPERTY(bool isMine MEMBER m_isMine)
    Q_PROPERTY(QDateTime datetime MEMBER m_datetime)

public:
    XChatConversationMessage(QObject *parent = 0);

// TODO: Make these private with accessors when we know more about the underlying code
    QString m_message;
    QDateTime m_datetime;
    bool m_isMine;
};


class XChatConversationModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum XChatRoles {
        MessageRole = Qt::UserRole + 1,
        DateTimeRole = Qt::UserRole + 2,
        IsMineRole = Qt::UserRole + 3,
    };

    explicit XChatConversationModel(QObject *parent = 0);

    virtual int rowCount(const QModelIndex &) const { return messages.size(); }
    virtual QVariant data(const QModelIndex &index, int role) const;

    QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE void addMessage(QString, QDateTime, bool);

private:
    QVector<XChatConversationMessage*> messages;
};

#endif // XCHATCONVERSATIONMODEL_HPP
