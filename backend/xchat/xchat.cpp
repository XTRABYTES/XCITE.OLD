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
//#include "../testnet/xchattestnetclient.hpp"
#include <QString>
#include <set>
#include <QtNetwork>



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
//    mqtt_client->setKeepAlive(10);
    qDebug() << "INITIALIZE XCHAT";
    connect(mqtt_client, &QMqttClient::stateChanged, this, &XchatObject::mqtt_StateChanged);
    connect(mqtt_client, &QMqttClient::pingResponseReceived, this, &XchatObject::pingReceived);


    connect(mqtt_client, &QMqttClient::messageReceived, this, [this](const QByteArray &message, const QMqttTopicName &topic) {
      //  const QString content = topic.name() + QLatin1String(": ") + message + QLatin1Char('\n');
        const QString content = message;

        if(content.startsWith("$#$#")){  // message when user starts typing
            addToTyping(content.toUtf8());
        }else if(content.startsWith("%&%&")){ // message sent when user stops typing
            removeFromTyping(content.toUtf8());

        }else if(content.startsWith("**#* ")){ //message sent every minute to stay online
            addToOnline(content.toUtf8(), false);

        }else if(content.startsWith("^^&^ ")){ // message sent when user logs in
            addToOnline(content.toUtf8(), true);

        }else{
            emit xchatSuccess(content + QLatin1Char('\n'));
        }
    });



    m_bIsInitialized = true;
    mqtt_StateChanged();
}

void XchatObject::xchatInc(const QString &msg) {

     if (!msg.isEmpty() && msg.front()=="@") {
         if (mqtt_client->publish(topic, msg.mid(2).toUtf8()) == -1) {
            xchatRobot.SubmitMsg("@mqtt-ERROR: Could not publish message.");
         }
       return;
    }
}

void XchatObject::sendTypingToQueue(const QString msg) {
    mqtt_client->publish(topic, msg.toUtf8());
}

void XchatObject::addToTyping(const QString msg) {
    addToOnline(msg, true);
    QString cutName = msg.right(msg.length() - 5);
    QDateTime now = QDateTime::currentDateTime();
    typing.insert(cutName, now);
    sendTypingToFront(typing);
}

void XchatObject::addToOnline(const QString msg, bool active) {

    QString cutName = msg.right(msg.length() - 5);
    QDateTime now = QDateTime::currentDateTime();
    if (cutName.size() > 1){
        OnlineUser user;
        if (onlineUsers.contains(cutName)){
            user = onlineUsers.value(cutName);

        }else{
            user.setUsername(cutName);
            user.setStatus("online");
        }
        user.setDateTime(now);

        if (active){
            user.setStatus("online");
            user.setLastTyped(now);
        }

        onlineUsers.insert(cutName,user);
        sendOnlineUsers();
     }
}

void XchatObject::removeFromTyping(const QString msg) {

    QString cutName = msg.right(msg.length() - 5);
    if(typing.contains(cutName)){
        typing.remove(cutName);
    }

    sendTypingToFront(typing);
}

void XchatObject::cleanTypingList(){
    QDateTime now = QDateTime::currentDateTime();
    for (QString key : typing.keys()){
        if (typing.value(key).secsTo(now) > 10){
            typing.remove(key);
            sendTypingToFront(typing);

        }
    }
}

void XchatObject::cleanOnlineList(){
    QDateTime now = QDateTime::currentDateTime();
    for (QString key : onlineUsers.keys()){
        OnlineUser onlineUser = onlineUsers.value(key);
        if ( onlineUser.getDateTime().secsTo(now) > 10 * 60){ //remove from online after 10 minutes
            onlineUsers.remove(key);
        }
        if (onlineUser.getLastTyped().secsTo(now) > 5 *60){ // if they haven't typed in 5 minutes, set status to idle
            onlineUser.setStatus("idle");
            onlineUsers.insert(key,onlineUser);
        }

    }
    sendOnlineUsers();

}
void XchatObject::sendTypingToFront(const QMap<QString, QDateTime> typing){
    QString whoIsTyping = "";
    switch(typing.count()){
        case 0:
            break;
        case 1:
            whoIsTyping = typing.keys().first() + " is typing...";

            break;
        case 2:

            whoIsTyping = typing.keys().first() + " and " + typing.keys().last() + " are typing...";
            break;
        default:
            whoIsTyping = QString::number(typing.count()) + " others are typing...";
            break;
    }
    emit xchatTypingSignal(whoIsTyping);
}

void XchatObject::xchatTyping(const QString &msg) {

     if (!msg.isEmpty()) {
         if (mqtt_client->publish(topic, msg.mid(2).toUtf8()) == -1) {
            xchatRobot.SubmitMsg("@mqtt-ERROR: Could not publish message.");
         }
       return;
    }
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
//    if (!((staticNet.CheckUserInputForKeyWord(msg,&staticNet_traceID)) || (xUtility.CheckUserInputForKeyWord(msg)))) {

//        bool keyWordUsedUserInput = this->CheckUserInputForKeyWord(msg);
//        bool keyWordUsedAIInput = this->CheckAIInputForKeyWord(m_pXchatAiml->getResponse(msg));

//        if (keyWordUsedUserInput || keyWordUsedAIInput)
//        {
//            QString harmonizedMessage = this->HarmonizeKeyWords(m_pXchatAiml->getResponse(msg));
//            if (keyWordUsedUserInput)
//                harmonizedMessage = this->HarmonizeKeyWords(msg);

//            m_lastUserMessage = harmonizedMessage;

//            XchatTestnetClient client;
//            if (harmonizedMessage.contains("$_WALLET_BALANCE_XBY$"))
//            {
//                m_BalanceRequested = true;
//                client.WriteBalance(QString(""));
//            }
//            else if (harmonizedMessage.contains("$_WALLET_DUMPPRIVKEY$"))
//            {
//                QStringList stringList = harmonizedMessage.split(" ");
//                int getBlockIndex = stringList.indexOf("$_WALLET_DUMPPRIVKEY$");
//                if (stringList.length()-1 > getBlockIndex)
//                    client.WriteDumpprivkey(QString(stringList[getBlockIndex+1]));
//                else
//                    emit xchatResponseSignal(m_pXchatAiml->getResponse("PARAMETER MISSING"));
//            }
//            else if (harmonizedMessage.contains("$_WALLET_GETBLOCK$"))
//            {
//                QStringList stringList = harmonizedMessage.split(" ");
//                int getBlockIndex = stringList.indexOf("$_WALLET_GETBLOCK$");
//                if (stringList.length()-1 > getBlockIndex)
//                    client.WriteGetBlock(QString(stringList[getBlockIndex+1]));
//                else
//                    emit xchatResponseSignal(m_pXchatAiml->getResponse("PARAMETER MISSING"));
//            }
//        }
//        else
//        {
//            emit xchatResponseSignal(m_pXchatAiml->getResponse(msg));
//        }
//    }
}

void XchatObject::SubmitMsg(const QString &msg) {
    emit xchatResponseSignal(msg);
}

void XchatObject::pingReceived() {
    qDebug() << "ping received";
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
    if (checkInternet()){
        //    xchatRobot.SubmitMsg("@mqtt: State Changed");
            if (mqtt_client->state() == QMqttClient::Disconnected) {
             //    xchatRobot.SubmitMsg("@mqtt: Server disconnected. Attempt to reconnect.");
               emit xchatConnectionFail();
               mqtt_client->setHostname(findServer());
               mqtt_client->setPort(1883);
               mqtt_client->connectToHost();
            }

            if (mqtt_client->state() == QMqttClient::Connecting) {
                emit xchatConnecting();
            //   xchatRobot.SubmitMsg("@mqtt: Connecting...");
            }

            if (mqtt_client->state() == QMqttClient::Connected) {
                qDebug() << "connected to  XCHAT";
         //      xchatRobot.SubmitMsg("@mqtt: Connected.");
               emit xchatConnectionSuccess();
               auto subscription = mqtt_client->subscribe(topic);
               if (!subscription) {
               } else {

               }
            }

    }


}
void XchatObject::sendOnlineUsers(){
    QJsonArray onlineJson;
    QDateTime now = QDateTime::currentDateTime();

    for (QString user : onlineUsers.keys()){
        QJsonObject userObj ;
        OnlineUser onlineUser = onlineUsers.value(user);
        userObj.insert("username",user);
        userObj.insert("date",onlineUser.getDate().toString());
        userObj.insert("time",onlineUser.getTime().toString());
        userObj.insert("status",onlineUser.getStatus());

        onlineJson.append(userObj);
    }
    QJsonDocument doc;
    doc.setArray(onlineJson);
    QString onlineString(doc.toJson(QJsonDocument::Compact));
    emit onlineUsersSignal(onlineString);
}


bool XchatObject::checkInternet(){
    cleanTypingList();
    cleanOnlineList();
    bool connected = false;
    QNetworkAccessManager nam;
    QNetworkRequest req(QUrl("http://www.google.com"));
    QNetworkReply* reply = nam.get(req);
    QEventLoop loop;
    QTimer getTimer;
    QTimer::connect(&getTimer,SIGNAL(timeout()),&loop, SLOT(quit()));

    connect(reply, SIGNAL(finished()), &loop, SLOT(quit()));

    getTimer.start(4000);
    loop.exec();
    if (reply->bytesAvailable()){
        //emit xchatConnectionSuccess();
        emit xchatInternetOk();

        connected=true;
    }else{
        emit xchatConnectionFail();
        emit xchatNoInternet();
    }

    reply->close();
    delete reply;

    return connected;

}

QString XchatObject::findServer(){
    QString fastestServer;
    qint64 fastestTime = 0;
    QElapsedTimer timer;

    for(QString server : servers){

        QTcpSocket tester;
        tester.connectToHost(server, 1883);
        timer.start();
        bool online = true;
        if(tester.waitForConnected(1000)) {
            qDebug() << "Server: " + server + " up";
        } else {
            online=false;
        }
        qint64 timeTaken = timer.nsecsElapsed();
        qDebug() << server + " timer: " + QString::number(timeTaken);
        if (!online){
            qDebug() << "Server: " + server + " down";
        }else if (fastestTime == 0 || fastestTime > timeTaken){
            fastestServer = server;
            fastestTime = timeTaken;
        }

        tester.close();
    }

    qDebug() << "Connecting to " + fastestServer;
    return fastestServer;
}



