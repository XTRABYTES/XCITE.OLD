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
  m_bIsInitialized = false;
  m_pXchatAiml = NULL;
}

XchatObject::~XchatObject() {
	
  if (NULL != m_pXchatAiml)
    {
        m_pXchatAiml->clear();
        delete m_pXchatAiml;
        m_pXchatAiml = NULL;
    }
}

void XchatObject::Initialize() {
    m_pXchatAiml = new XchatAIML;
    m_pXchatAiml->loadAIMLSet();
    m_bIsInitialized = true;
}


void XchatObject::SubmitMsgCall(const QString &msg, const QString &resp) {
	
	     QString qsBotResponse = m_pXchatAiml->getResponse(msg);
	     QString ret;
	     ret = resp + "<br/><b>you:</b>" + msg;
	     ret = ret + "<br/><b>xcite:</b>" + qsBotResponse ;
        emit xchatResponseSignal(ret);
}


