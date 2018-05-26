/**
 * Filename: xchatconversationmodel.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include "xchatconversationmodel.hpp"

XChatConversationMessage::XChatConversationMessage(QObject *parent) :
    QObject(parent)
{
}

void XChatConversationModel::addMessage(QString message, QDateTime datetime, bool isMine)
{
    XChatConversationMessage *t = new XChatConversationMessage();
    t->m_datetime = datetime;
    t->m_message = message;
    t->m_isMine = isMine;

    beginInsertRows(QModelIndex(), 0, 0);
    messages.push_front(t);
    endInsertRows();
}

XChatConversationModel::XChatConversationModel(QObject *parent) :
    QAbstractListModel(parent)
{
}

QHash<int, QByteArray> XChatConversationModel::roleNames() const {
    QHash<int, QByteArray> roles;

    roles[MessageRole] = "message";
    roles[DateTimeRole] = "datetime";
    roles[IsMineRole] = "isMine";

    return roles;
}

QVariant XChatConversationModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    switch (role) {
    case MessageRole:
        return QVariant(messages[index.row()]->m_message);
    case DateTimeRole:
        return QVariant(messages[index.row()]->m_datetime);
    case IsMineRole:
        return QVariant(messages[index.row()]->m_isMine);
    }

    return QVariant();
}

