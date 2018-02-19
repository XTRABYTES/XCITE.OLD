
#include "ClipboardProxy.hpp"

ClipboardProxy::ClipboardProxy(QObject *parent)
    : QObject(parent)
{
}

void ClipboardProxy::setDataText(const QString &text)
{
    QGuiApplication::clipboard()->setText(text, QClipboard::Clipboard);
}

QString ClipboardProxy::dataText() const
{
    return QGuiApplication::clipboard()->text(QClipboard::Clipboard);
}
