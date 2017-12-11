#include "iobject.hpp"

iObject::iObject(QObject *parent) :
QObject(parent)
{
  window = parent;
}

void iObject::PressMeCall(const QString &msg) {
        emit setTextFieldSignal(msg);
}


