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
    qDebug() << "INITIALIZE XCHAT";
    connect(mqtt_client, &QMqttClient::stateChanged, this, &XchatObject::mqtt_StateChanged);
    connect(mqtt_client, &QMqttClient::pingResponseReceived, this, &XchatObject::pingReceived);


    connect(mqtt_client, &QMqttClient::messageReceived, this, [this](const QByteArray &message, const QMqttTopicName &topic) {
        const QString content = message;
        messageRoute(content);
    });



    m_bIsInitialized = true;
    mqtt_StateChanged();
}
unsigned constexpr const_hash(char const *input) {
    return *input ?
    static_cast<unsigned int>(*input) + 33 * const_hash(input + 1) :
    5381;
}

void XchatObject::messageRoute(QString message){
    QJsonDocument doc = QJsonDocument::fromJson(message.toUtf8());
    QJsonObject obj = doc.object();
    QString route = obj.value("route").toString();
    switch(const_hash(route.toStdString().c_str()))
    {
    case const_hash("addToTyping"):
        addToOnline(obj);
        addToTyping(obj);
        break;
    case const_hash("addToOnline"):
        addToOnline(obj);
        break;
    case const_hash("removeFromTyping"):
        removeFromTyping(obj);
        break;
    case const_hash("sendToFront"):
        sendToFront(obj);
       break;
    default:
        qDebug() << "No Route Found";
        break;
    }


}
void XchatObject::xchatInc(const QString &user, QString platform, QString status, QString message) {
    if (!message.isEmpty()) {

        QString username = user;
        qint64 timeStamp = QDateTime::currentDateTimeUtc().toMSecsSinceEpoch();
        QJsonObject obj;
            obj.insert("username",user);
            obj.insert("platform",platform);
            obj.insert("route","sendToFront");
            obj.insert("status", status);
            obj.insert("message",message);
            obj.insert("messageSentTime", QDateTime::currentDateTime().toString());
            obj.insert("lastActiveTime", QDateTime::currentDateTime().toString());
            obj.insert("uctTimeSinceEpoch", QString::number(timeStamp));
            qDebug() << "Miliseconds since EPoch: " + QString::number(timeStamp);

             QJsonDocument doc(obj);
             QString strJson(doc.toJson(QJsonDocument::Compact));
             mqtt_client->publish(topic, strJson.toUtf8());
           return;
        }
}

void XchatObject::sendTypingToQueue(const QString user, QString route, QString status) {
    QJsonObject obj;
        obj.insert("username",user);
        obj.insert("route",route);
        obj.insert("status",status);
        obj.insert("message","");
        obj.insert("lastActiveTime", QDateTime::currentDateTime().toString());
        QJsonDocument doc(obj);
        QString strJson(doc.toJson(QJsonDocument::Compact));
        mqtt_client->publish(topic, strJson.toUtf8());
}

void XchatObject::addToTyping(QJsonObject obj){
    QString name = obj.value("username").toString().trimmed();
    QDateTime now = QDateTime::currentDateTime();
    typing.insert(name, now);
    sendTypingToFront(typing);
}

void XchatObject::addToOnline(QJsonObject obj) {
    QString name = obj.value("username").toString().trimmed();
    QString status = obj.value("status").toString();

    QDateTime lastActiveTime = QDateTime::fromString(obj.value("lastActiveTime").toString(),"yyyy-MM-dd HH:mm:ss");
    QDateTime now = QDateTime::currentDateTime();

    if (name.size() > 1){
        OnlineUser user;
        if (onlineUsers.contains(name)){
            user = onlineUsers.value(name);

        }else{
            user.setUsername(name);
        }
        user.setDateTime(now);
        user.setStatus(status);

        onlineUsers.insert(name,user);
        sendOnlineUsers();
    }
}


void XchatObject::removeFromTyping(QJsonObject obj) {
    QString name = obj.value("username").toString().trimmed();
    if(typing.contains(name)){
        typing.remove(name);
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
//        if (onlineUser.getLastTyped().secsTo(now) > 5 *60){ // if they haven't typed in 5 minutes, set status to idle
//            onlineUser.setStatus("idle");
//            onlineUsers.insert(key,onlineUser);
//        }  // Don't think we need this anymore

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

void XchatObject::sendToFront(QJsonObject obj){
        //QDateTime dateTime = QDateTime::fromString(obj.value("messageSentTime").toString());
        qint64 dateTimeMs = (obj.value("uctTimeSinceEpoch").toString()).toLongLong();
        QDateTime dateTime02 = QDateTime::fromMSecsSinceEpoch(dateTimeMs);
        dateTime02 = dateTime02.toLocalTime();
        QDate date02 = dateTime02.date();
        QTime time02 = dateTime02.time();
        qDebug() << "local date: " + date02.toString("MMM d") + ", local time: " + time02.toString("H:mm:ss");
        //QDate date = dateTime.date();
        //QTime time = dateTime.time();
        QString author = obj.value("username").toString();
        QString device = obj.value("platform").toString();
        QString message = obj.value("message").toString();
    //emit xchatSuccess(author, date.toString(), time.toString(), device, message);
    //emit xchatSuccess(author, date, time, device, message);
        emit xchatSuccess(author, date02, time02, device, message);
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
                emit xchatConnectionFail();
                emit xchatStateChanged();
                mqtt_client->setHostname(findServer());
                mqtt_client->setPort(1883);
                mqtt_client->connectToHost();
            }

            if (mqtt_client->state() == QMqttClient::Connecting) {
                emit xchatConnecting();
                emit xchatStateChanged();
            }

            if (mqtt_client->state() == QMqttClient::Connected) {
                qDebug() << "connected to  XCHAT";
                emit xchatConnectionSuccess();
                emit xchatStateChanged();
                pingXchatServers();
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

void XchatObject::getOnlineNodes(){
    for(QString server : servers){
        QNetworkAccessManager nam;
        QUrl url("http://" + server + ":15672/api/nodes");
        url.setUserName("guest");
        url.setPassword("guest");
        QNetworkRequest req(url);
        QNetworkReply* reply = nam.get(req);
        QEventLoop loop;
        QTimer getTimer;
        QTimer::connect(&getTimer,SIGNAL(timeout()),&loop, SLOT(quit()));
        connect(reply, SIGNAL(finished()), &loop, SLOT(quit()));
        getTimer.start(4000);
        loop.exec();
        if (reply->bytesAvailable()){
           QByteArray replyBytes = reply->readAll();
           QJsonDocument doc = QJsonDocument::fromJson(replyBytes);
           QJsonArray array = doc.array();
           foreach (const QJsonValue & value, array) {

               QJsonObject obj = value.toObject();
               if (obj.value("running").toBool()){
                    nodesOnline.insert(obj.value("name").toString(),"");
               }
           }
           foreach (const QJsonValue & value1, array) {
               QJsonObject obj = value1.toObject();
               if (!obj.value("cluster_links").toArray().isEmpty()){
                   QJsonArray cluster_links = obj.value("cluster_links").toArray();
                   foreach (const QJsonValue & value2, cluster_links) {
                       QJsonObject obj2 = value2.toObject();
                        if (nodesOnline.contains(obj2.value("name").toString())){
                            nodesOnline.insert(obj2.value("name").toString(),obj2.value("peer_addr").toString());
                        }
                   }
               }
           }
        }
        reply->close();
        delete reply;
    }
}

void XchatObject::pingXchatServers() {
    QElapsedTimer timer;

    getOnlineNodes();
    for(QString server : nodesOnline.values()){

        QTcpSocket tester;
        tester.connectToHost(server, 1883);
        QString pingedServer = matchServer(server);
        timer.start();
        bool online = true;
        if(tester.waitForConnected(1000)) {
            qDebug() << "Server: " + pingedServer + " up";
        } else {
            online=false;
        }
        qint64 timeTaken = timer.nsecsElapsed();
        qDebug() << pingedServer + " timer: " + QString::number(timeTaken);
        QString responseTime = QString::number(timeTaken);
        emit serverResponseTime(pingedServer, responseTime, "up");
        if (!online){
            qDebug() << "Server: " + pingedServer + " down";
            emit xChatServerDown(pingedServer, "down");
        }

        tester.close();
    }
    emit selectedXchatServer(selectedServer);
}

QString XchatObject::matchServer(const QString &server){
    QString xChatServer;
    if (server == "192.227.147.162") {
        xChatServer = "Buffalo (US)";
    }
    else if (server == "85.214.143.20") {
        xChatServer = "Berlin 01 (DE)";
    }
    else if (server == "23.94.145.219") {
        xChatServer = "Los Angeles (US)";
    }
    else if (server == "37.187.99.162") {
        xChatServer = "Roubaix (FR)";
    }
    else if (server == "85.214.78.233") {
        xChatServer = "Berlin 02 (DE)";
    }
    return xChatServer;
}

QString XchatObject::findServer(){
    QString fastestServer;
    qint64 fastestTime = 0;
    QElapsedTimer timer;
    selectedServer = "";
    emit selectedXchatServer(selectedServer);

    getOnlineNodes();
    for(QString server : nodesOnline.values()){

        QTcpSocket tester;
        tester.connectToHost(server, 1883);
        QString pingedServer = matchServer(server);
        timer.start();
        bool online = true;
        if(tester.waitForConnected(1000)) {
            qDebug() << "Server: " + pingedServer + " up";
        } else {
            online=false;
        }
        qint64 timeTaken = timer.nsecsElapsed();
        qDebug() << pingedServer + " timer: " + QString::number(timeTaken);
        QString responseTime = QString::number(timeTaken);
        emit serverResponseTime(pingedServer, responseTime, "up");
        if (!online){
            qDebug() << "Server: " + pingedServer + " down";
            emit xChatServerDown(pingedServer, "down");
        }else if (fastestTime == 0 || fastestTime > timeTaken){
            fastestServer = server;
            fastestTime = timeTaken;
        }

        tester.close();
    }

    selectedServer = matchServer(fastestServer);
    qDebug() << "Connecting to " + selectedServer;
    emit selectedXchatServer(selectedServer);
    return fastestServer;
}



