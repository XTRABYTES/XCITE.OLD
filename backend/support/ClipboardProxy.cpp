/**
 * Filename: ClipboardProxy.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include "ClipboardProxy.hpp"

ClipboardProxy::ClipboardProxy(QObject *parent)
    : QObject(parent)
{
    QClipboard *clipboard = QGuiApplication::clipboard();
    QObject::connect(clipboard, &QClipboard::dataChanged, this, &ClipboardProxy::dataChanged);
}

void ClipboardProxy::setDataText(const QString &text)
{
    QGuiApplication::clipboard()->setText(text, QClipboard::Clipboard);

}

void ClipboardProxy::copyText2Clipboard(QString text)
{
    setDataText(text);
}

QString ClipboardProxy::dataText() const
{
    return QGuiApplication::clipboard()->text(QClipboard::Clipboard);
}
