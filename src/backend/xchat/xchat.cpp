#include "xchat.hpp"

Xchat::Xchat(QObject *parent) :
    QObject(parent)
{
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

void XchatObject::SubmitMsgCall(const QString &msg) {
    emit xchatResponseSignal(m_pXchatAiml->getResponse(msg));
}


