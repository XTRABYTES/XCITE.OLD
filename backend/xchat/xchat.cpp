#include "xchat.hpp"

Xchat::Xchat(QObject *parent) :
    QObject(parent)

{
}

QString Xchat::messageTXT()
{
    return m_messageTXT;
}



void Xchat::setmessageTXT(const QString &messageTXT)
{

    if (messageTXT == m_messageTXT)
        return;

    m_messageTXT = messageTXT;
    emit messageTXTChanged();
}



XchatObject::XchatObject(QObject *parent) :
QObject(parent)
{
  window = parent;
}

void XchatObject::SubmitMsgCall(const QString &msg, const QString &resp) {
	     QString ret;
	     ret = resp + "<br/><b>you:</b>" + msg;
	     ret = ret + "<br/><b>xcite:</b>" + "response from xcite" ;
        emit xchatResponseSignal(ret);
}


