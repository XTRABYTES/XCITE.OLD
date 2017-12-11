#ifndef IOBJECT_H
#define IOBJECT_H

#include <QObject>
#include <QVariant>

class iObject : public QObject
{
Q_OBJECT
public:
explicit iObject(QObject *parent = 0);

signals:
void setTextFieldSignal(QVariant text);

public slots:
void PressMeCall(const QString &msg);
private:
QObject *window;
};

#endif // IOBJECT_H
