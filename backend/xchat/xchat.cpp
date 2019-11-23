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


    forced_connect = false;
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
    qDebug() << obj;
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
    case const_hash("sendToGame"):
        sendToGame(obj);
        break;
    case const_hash("confirmGameReceived"):
        confirmGameReceived(obj);
        break;
    case const_hash("receiveGameInvite"):
        receiveGameInvite(obj);
        break;
    case const_hash("receiveGameInviteResponse"):
        receiveGameInviteResponse(obj);
        break;
    default:
        qDebug() << "No Route Found";
        break;
    }
}

void XchatObject::sendGameToQueue(const QString user, QString game, QString gameID, QString move) {
    if (mqtt_client->state() == QMqttClient::Connected) {
        qint64 timeStamp = QDateTime::currentDateTimeUtc().toMSecsSinceEpoch();
        QString moveID = QString::number(timeStamp);
        QJsonObject obj;
        obj.insert("player", user);
        obj.insert("route","sendToGame");
        obj.insert("game", game);
        obj.insert("gameID", gameID);
        obj.insert("move",move);
        obj.insert("moveID", moveID);
        QJsonDocument doc(obj);
        QString strJson(doc.toJson(QJsonDocument::Compact));
        mqtt_client->publish(topic, strJson.toUtf8());
    }
    else {
        emit gameCommandFailed();
    }
}

void XchatObject::sendToGame(QJsonObject obj) {
    QString player = obj.value("player").toString();
    QString game = obj.value("game").toString();
    QString gameID = obj.value("gameID").toString();
    QString move = obj.value("move").toString();
    QString moveID = obj.value("moveID").toString();

    emit newMoveReceived(player, game, gameID, move, moveID);
}

void XchatObject::confirmGameSend(const QString user, QString game, QString gameID, QString move, QString moveID) {
    if (mqtt_client->state() == QMqttClient::Connected) {
        QJsonObject obj;
        obj.insert("player", user);
        obj.insert("route","confirmGameReceived");
        obj.insert("game", game);
        obj.insert("gameID", gameID);
        obj.insert("move",move);
        obj.insert("moveID", moveID);
        QJsonDocument doc(obj);
        QString strJson(doc.toJson(QJsonDocument::Compact));
        mqtt_client->publish(topic, strJson.toUtf8());
    }
    else {
        emit gameCommandFailed();
    }
}

void XchatObject::confirmGameReceived(QJsonObject obj) {
    QString player = obj.value("player").toString();
    QString game = obj.value("game").toString();
    QString gameID = obj.value("gameID").toString();
    QString move = obj.value("move").toString();
    QString moveID = obj.value("moveID").toString();

    emit newMoveConfirmed(player, game, gameID, move, moveID);
}

void XchatObject::sendGameInvite(const QString user, QString opponent, QString game, QString gameID) {
    if (mqtt_client->state() == QMqttClient::Connected) {
        QJsonObject obj;
        obj.insert("player1", user);
        obj.insert("player2", opponent);
        obj.insert("route","receiveGameInvite");
        obj.insert("game", game);
        obj.insert("gameID", gameID);
        QJsonDocument doc(obj);
        QString strJson(doc.toJson(QJsonDocument::Compact));
        mqtt_client->publish(topic, strJson.toUtf8());
    }
    else {
        emit gameCommandFailed();
    }
}

void XchatObject::receiveGameInvite(QJsonObject obj) {
    QString opponent = obj.value("player1").toString();
    QString user = obj.value("player2").toString();
    QString game = obj.value("game").toString();
    QString gameID = obj.value("gameID").toString();

    emit newGameInvite(user, opponent, game, gameID);
}

void XchatObject::confirmGameInvite(const QString user, QString opponent, QString game, QString gameID, QString accept) {
    if (mqtt_client->state() == QMqttClient::Connected) {
        QJsonObject obj;
        obj.insert("username", user);
        obj.insert("opponent", opponent);
        obj.insert("route","receiveGameInviteResponse");
        obj.insert("game", game);
        obj.insert("gameID", gameID);
        obj.insert("accept", accept);
        QJsonDocument doc(obj);
        QString strJson(doc.toJson(QJsonDocument::Compact));
        mqtt_client->publish(topic, strJson.toUtf8());
    }
    else {
        emit gameCommandFailed();
    }
}

void XchatObject::receiveGameInviteResponse(QJsonObject obj) {
    QString user = obj.value("username").toString();
    QString game = obj.value("game").toString();
    QString gameID = obj.value("gameID").toString();
    QString accept = obj.value("accept").toString();

    emit responseGameInvite(user, game, gameID, accept);
}

void XchatObject::xchatInc(const QString &user, QString platform, QString status, QString message, QString webLink, QString image, QString quote) {
    if (!message.isEmpty() && mqtt_client->state() == QMqttClient::Connected) {
        qDebug() << "link: " + webLink + ", image: " + image + ", quote: " + quote;
        QString username = user;
        qint64 timeStamp = QDateTime::currentDateTimeUtc().toMSecsSinceEpoch();
        QJsonObject obj;
        obj.insert("username",user);
        obj.insert("platform",platform);
        obj.insert("route","sendToFront");
        obj.insert("status", status);
        obj.insert("message",message);
        obj.insert("link", webLink);
        obj.insert("image", image);
        obj.insert("quote", quote);
        obj.insert("messageSentTime", QString::number(timeStamp));
        obj.insert("lastActiveTime", QDateTime::currentDateTime().toString());

        QJsonDocument doc(obj);
        QString strJson(doc.toJson(QJsonDocument::Compact));
        mqtt_client->publish(topic, strJson.toUtf8());
        return;
    }
}

void XchatObject::sendTypingToQueue(const QString user, QString route, QString status) {
    me = user;
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
    if (name != me){
        typing.insert(name, now);
        sendTypingToFront(typing);
    }
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
    QString msgID = obj.value("messageSentTime").toString();
    qint64 dateTimeMs = (msgID).toLongLong();
    QDateTime dateTime = QDateTime::fromMSecsSinceEpoch(dateTimeMs);
    dateTime = dateTime.toLocalTime();
    QDate date02 = dateTime.date();
    QTime time02 = dateTime.time();
    QString date = date02.toString("MMM d");
    QString time = time02.toString("H:mm:ss");
    QString author = obj.value("username").toString();
    QString device = obj.value("platform").toString();
    QString message = obj.value("message").toString();
    QString link = obj.value("link").toString();
    QString image = obj.value("image").toString();
    QString quote = obj.value("quote").toString();
    qDebug() << "local date: " + date02.toString("MMM d") + ", local time: " + time02.toString("H:mm:ss");
    emit xchatSuccess(author, date, time, device, message, link, image, quote, msgID);
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

void XchatObject::forcedReconnect() {
    qDebug() << "force reconnect";
    if (mqtt_client->state() == QMqttClient::Connecting) {
        qDebug() << "connection attempt detected";
        mqtt_client->disconnectFromHost();
        qDebug() << mqtt_client->state();
        mqtt_StateChanged();
        return;
    }
    qDebug() << "no connection attempt detected";
    mqtt_StateChanged();
    return;
}

void XchatObject::mqtt_StateChanged() {
    if (mqtt_client->state() == QMqttClient::Disconnected) {
        qDebug() << "X-CHAT not connected";
        emit xchatConnectionFail();
        emit xchatStateChanged();
        if (findServer() != "") {
            qDebug() << "trying to connect to server " + connectedServer;
            mqtt_client->setHostname(connectedServer);
            mqtt_client->setPort(1883);
            mqtt_client->connectToHost();
        }
        else {
            qDebug() << "no servers available";
        }
    }

    if (mqtt_client->state() == QMqttClient::Connecting) {
        qDebug() << "X-CHAT connecting to " + connectedServer;
        emit xchatConnecting();
        emit xchatStateChanged();
    }

    if (mqtt_client->state() == QMqttClient::Connected) {
        qDebug() << "connected to  XCHAT via: " + connectedServer;
        emit xchatInternetOk();
        emit xchatConnectionSuccess();
        emit xchatStateChanged();
        auto subscription = mqtt_client->subscribe(topic);
        if (!subscription) {
            qDebug() << "not subscribed to topic";
        } else {
            qDebug() << "subscribed to topic: " + topic;
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

void XchatObject::getOnlineNodes(){
    cleanTypingList();
    cleanOnlineList();
    for(QString server : servers){
        QNetworkAccessManager nam;
        QUrl url("http://" + server + ":15672/api/nodes");
        url.setUserName("xchat");
        url.setPassword("xtrabytes");
        URLObject urlObj {QUrl(url)};
        urlObj.addProperty("route","getOnlineNodesSlot");
        DownloadManagerHandler(&urlObj);
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
        xChatServer = "Buffalo 01 (US)";
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
    else if (server == "198.46.193.44") {
        xChatServer = "Buffalo 02 (US)";
    }
    return xChatServer;
}

QString XchatObject::findServer(){
    qint64 fastestTime = 0;
    QElapsedTimer timer;
    fastestServer = "";

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
            selectedServer = matchServer(fastestServer);
            connectedServer = fastestServer;
            qDebug() << "Fastest server:  " + selectedServer;
            emit selectedXchatServer(selectedServer);
        }

        tester.close();
    }
    emit selectedXchatServer(selectedServer);
    return fastestServer;
}


void XchatObject::DownloadManagerHandler(URLObject *url){
    DownloadManager *manager = manager->getInstance();
    url->addProperty("url",url->getUrl());
    url->addProperty("class","xchat");
    manager->append(url);
    connect(manager,  SIGNAL(readTimeout(QMap<QString,QVariant>)),this,SLOT(internetTimeout(QMap<QString,QVariant>)),Qt::UniqueConnection);

    connect(manager,  SIGNAL(readFinished(QByteArray,QMap<QString,QVariant>)), this,SLOT(DownloadManagerRouter(QByteArray,QMap<QString,QVariant>)),Qt::UniqueConnection);


}


void XchatObject::internetTimeout(QMap<QString,QVariant> props){

    if (props.value("class").toString() == "xchat"){
        internetActive = false;
        qDebug() << "timeout caught in xchat";
        emit xchatNoInternet();

    }
}
void XchatObject::DownloadManagerRouter(QByteArray response, QMap<QString,QVariant> props){
    internetActive = true;
    emit xchatInternetOk();

    if (props.value("class").toString() == "xchat"){
        QString route = props.value("route").toString();

            if (route == "getOnlineNodesSlot"){
                   getOnlineNodesSlot(response,props);
             }

    }
}


void XchatObject::getOnlineNodesSlot(QByteArray response, QMap<QString,QVariant> props){
    QJsonDocument doc = QJsonDocument::fromJson(response);
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

