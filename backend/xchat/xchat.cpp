/**
 * Filename: xchat.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include "xchat.hpp"
#include "../staticnet/staticnet.hpp"
#include "../xutility/xutility.hpp"
#include "../testnet/xchattestnetclient.hpp"

XchatObject xchatRobot;

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

    mqtt_client = new QMqttClient(this);
     
    connect(mqtt_client, &QMqttClient::stateChanged, this, &XchatObject::mqtt_StateChanged);

    connect(mqtt_client, &QMqttClient::messageReceived, this, [this](const QByteArray &message, const QMqttTopicName &topic) {
        const QString content = topic.name() + QLatin1String(": ") + message + QLatin1Char('\n');
        xchatRobot.SubmitMsg("@mqtt://" + content);
    });
            
    m_bIsInitialized = true;
    mqtt_StateChanged();
}


void XchatObject::SubmitMsgCall(const QString &msg) {
	
	 
	 if (!msg.isEmpty() && msg.front()=="@") {
	 	 if (mqtt_client->publish(topic, msg.toUtf8()) == -1) {
	 	    xchatRobot.SubmitMsg("@mqtt-ERROR: Could not publish message.");
	 	 }
       return;
    }

    QString message;
    xUtility.Initialize();
    
    int staticNet_traceID;
    if (!((staticNet.CheckUserInputForKeyWord(msg,&staticNet_traceID)) || (xUtility.CheckUserInputForKeyWord(msg)))) {
    
        bool keyWordUsedUserInput = this->CheckUserInputForKeyWord(msg);
        bool keyWordUsedAIInput = this->CheckAIInputForKeyWord(m_pXchatAiml->getResponse(msg));
	
        if (keyWordUsedUserInput || keyWordUsedAIInput)
        {
            QString harmonizedMessage = this->HarmonizeKeyWords(m_pXchatAiml->getResponse(msg));
            if (keyWordUsedUserInput)
                harmonizedMessage = this->HarmonizeKeyWords(msg);
	
            m_lastUserMessage = harmonizedMessage;
	
            XchatTestnetClient client;
            if (harmonizedMessage.contains("$_WALLET_BALANCE_XBY$"))
            {
                m_BalanceRequested = true;
                client.WriteBalance(QString(""));
            }
            else if (harmonizedMessage.contains("$_WALLET_DUMPPRIVKEY$"))
            {
                QStringList stringList = harmonizedMessage.split(" ");
                int getBlockIndex = stringList.indexOf("$_WALLET_DUMPPRIVKEY$");
                if (stringList.length()-1 > getBlockIndex)
                    client.WriteDumpprivkey(QString(stringList[getBlockIndex+1]));
                else
                    emit xchatResponseSignal(m_pXchatAiml->getResponse("PARAMETER MISSING"));
            }
            else if (harmonizedMessage.contains("$_WALLET_GETBLOCK$"))
            {
                QStringList stringList = harmonizedMessage.split(" ");
                int getBlockIndex = stringList.indexOf("$_WALLET_GETBLOCK$");
                if (stringList.length()-1 > getBlockIndex)
                    client.WriteGetBlock(QString(stringList[getBlockIndex+1]));
                else
                    emit xchatResponseSignal(m_pXchatAiml->getResponse("PARAMETER MISSING"));
            }
        }
        else
        {
            emit xchatResponseSignal(m_pXchatAiml->getResponse(msg));
        }
    }
}

void XchatObject::SubmitMsg(const QString &msg) {
    emit xchatResponseSignal(msg);
}

bool XchatObject::CheckUserInputForKeyWord(const QString msg)
{
    return msg.contains("getbalance")
            || msg.contains("dumpprivkey")
            || msg.contains("getblock");
}

bool XchatObject::CheckAIInputForKeyWord(const QString msg)
{
    return msg.contains("$_WALLET_BALANCE_XBY$")
            || msg.contains("$_WALLET_DUMPPRIVKEY$")
            || msg.contains("$_WALLET_GETBLOCK$");
}

QString XchatObject::HarmonizeKeyWords(QString msg)
{
    return msg.replace("getbalance", "$_WALLET_BALANCE_XBY$ XBY")
            .replace("dumpprivkey", "$_WALLET_DUMPPRIVKEY$")
            .replace("getblock", "$_WALLET_GETBLOCK$");
}

void XchatObject::mqtt_StateChanged() {

    xchatRobot.SubmitMsg("@mqtt: State Changed");
    if (mqtt_client->state() == QMqttClient::Disconnected) {
    	 xchatRobot.SubmitMsg("@mqtt: Server disconnected. Attempt to reconnect.");
       mqtt_client->setHostname("85.214.78.233");
       mqtt_client->setPort(1883);
       mqtt_client->connectToHost();
    }
    
    if (mqtt_client->state() == QMqttClient::Connecting) {
       xchatRobot.SubmitMsg("@mqtt: Connecting...");
    }
    
    if (mqtt_client->state() == QMqttClient::Connected) {
       xchatRobot.SubmitMsg("@mqtt: Connected.");
       auto subscription = mqtt_client->subscribe(topic);
       if (!subscription) {
       } else {
       
       }
    }
    
        

}