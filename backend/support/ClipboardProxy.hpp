
#ifndef CLIPBOARDPROXY_HPP
#define CLIPBOARDPROXY_HPP

#include <QObject>
#include <QClipboard>
#include <QGuiApplication>

class ClipboardProxy : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text READ dataText WRITE setDataText NOTIFY dataChanged)

public:
    explicit ClipboardProxy(QObject *parent = 0);

    void setDataText(const QString &text);
    QString dataText() const;

signals:
    void dataChanged();
};

#endif
