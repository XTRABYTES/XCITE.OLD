#ifndef XCHAT_H
#define XCHAT_H

#include <QObject>
#include <QString>
#include <QVariant>


class Xchat : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString messageTXT READ messageTXT WRITE setmessageTXT NOTIFY messageTXTChanged)

public:
    explicit Xchat(QObject *parent = nullptr);

    QString messageTXT();
    void setmessageTXT(const QString &messageTXT);

signals:
    void messageTXTChanged();

private:
    QString m_messageTXT;
};




class XchatObject : public QObject
{
Q_OBJECT
public:
explicit XchatObject(QObject *parent = 0);

signals:
void xchatResponseSignal(QVariant text);

public slots:
void SubmitMsgCall(const QString &msg, const QString &resp);
private:
QObject *window;
};


#endif // XCHAT_H