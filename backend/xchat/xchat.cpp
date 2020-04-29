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
#include <QNetworkAccessManager>
#include <QMessageBox>
#include <QDesktopWidget>
#include <QGuiApplication>
#include <QScreen>
#include <QTimer>
#include <QLabel>
#include <QLayout>
#include <QHBoxLayout>
#include <unistd.h>




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
   unsigned constexpr const_hash(char const *input) {
       return *input ?
                   static_cast<unsigned int>(*input) + 33 * const_hash(input + 1) :
                   5381;
   }

   void XchatObject::xchatEntry(QByteArray obj){
        QJsonDocument json = QJsonDocument::fromJson(obj);
        QJsonObject jsonObj = json.object();
        QString route = jsonObj.value("route").toString();
       switch(const_hash(route.toStdString().c_str()))
       {
       case const_hash("addToTyping"):
           addToOnline(jsonObj);
           addToTyping(jsonObj);
           break;
       case const_hash("addToOnline"):
           addToOnline(jsonObj);
           break;
       case const_hash("removeFromTyping"):
           removeFromTyping(jsonObj);
           break;
       case const_hash("sendToFront"):
           sendToFront(jsonObj);
           break;
       default:
           qDebug() << "No Route Found";
           break;
       }
   }


void XchatObject::Initialize() {

//    m_pXchatAiml = new XchatAIML;
//    m_pXchatAiml->loadAIMLSet();
//    mqtt_client = new QMqttClient(this);
//    qDebug() << "INITIALIZE XCHAT";
//    connect(mqtt_client, &QMqttClient::stateChanged, this, &XchatObject::mqtt_StateChanged);
//    connect(mqtt_client, &QMqttClient::pingResponseReceived, this, &XchatObject::pingReceived);


//    connect(mqtt_client, &QMqttClient::messageReceived, this, [this](const QByteArray &message, const QMqttTopicName &topic) {
//        const QString content = message;
//        messageRoute(content);
//    });


//    forced_connect = false;
//    m_bIsInitialized = true;
//   mqtt_StateChanged();
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
    default:
        qDebug() << "No Route Found";
        break;
    }
}

void XchatObject::xchatPopup(QString author, QString msg){
    QString osType = QSysInfo::productType();
    device = "desktop";
    if (osType == "android" || osType == "ios") {
        device = "mobile";
    }
    if (device == "desktop") {
        QWidget *dialog = new QWidget;
        QHBoxLayout *msgBox = new QHBoxLayout;
        QLabel *message = new QLabel;
        message->setMaximumWidth(400);
        message->setMaximumHeight(68);
        message->setStyleSheet("font: 10pt; color:rgb(242,242,242);");
        message->setAlignment(Qt::AlignLeft | Qt::AlignTop);
        message->setWordWrap(true);
        QString auth = "<font color='#F2C94C'><b>" + author + "</b></font>";
        QString xchatMsg = auth + ":<br><i>" + msg + "</i>";
        message->setText(xchatMsg);
        QSize size = QGuiApplication::screens()[0]->size();
        int xBox = size.width(); int yBox = size.height();
        QPoint recB;
        int xBottom; int yBottom;
        xBottom = xBox - 5; yBottom = yBox - 50;
        recB.setX(xBottom); recB.setY(yBottom);
        QPoint recT;
        int xTop; int yTop;
        xTop = xBox - 405; yTop = yBox - 118;
        recT.setX(xTop); recT.setY(yTop);
        QRect rec;
        rec.setTopLeft(recT); rec.setBottomRight(recB);
        dialog->setGeometry(rec);
        dialog->setStyleSheet("background-color:rgb(20,22,27);");
        dialog->setWindowFlags(Qt::Window | Qt::FramelessWindowHint |Qt::WindowStaysOnTopHint);
        msgBox->addWidget(message);
        dialog->setLayout(msgBox);
        dialog->show();
        QTimer::singleShot(7000, dialog, SLOT(hide()));
    }
}

void XchatObject::xchatInc(const QString &user, QString platform, QString status, QString message, QString webLink, QString image, QString quote) {
    if (!message.isEmpty() && broker.isConnected()) {
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
        broker.sendMessage("xchats",strJson);
        return;
    }
}

void XchatObject::sendTypingToQueue(const QString user, QString route, QString status) {
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);
    if(manager->networkAccessible() == QNetworkAccessManager::Accessible) {
        me = user;
        QJsonObject obj;
        obj.insert("username",user);
        obj.insert("route",route);
        obj.insert("status",status);
        obj.insert("message","");
        obj.insert("lastActiveTime", QDateTime::currentDateTime().toString());
        QJsonDocument doc(obj);
        QString strJson(doc.toJson(QJsonDocument::Compact));
        broker.sendMessage("xchats",strJson);

        return;
    }
    else {
        return;
    }
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
        if ( onlineUser.getDateTime().secsTo(now) > 5 * 60){ //remove from online after 5 minutes
            onlineUsers.remove(key);
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
    emit xchatSuccess(author, date, time, device, message, link, image, quote, msgID);
}

void XchatObject::SubmitMsg(const QString &msg) {
    emit xchatResponseSignal(msg);
    qDebug() << msg;
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
    return;
}

void XchatObject::mqtt_StateChanged() {
    if (broker.isConnected()){
      emit xchatInternetOk();
      emit xchatConnectionSuccess();
      emit xchatStateChanged();

    }else{
     //   broker.reconnect();
        emit xchatConnectionFail();
        emit xchatStateChanged();
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
//    for(QString server : servers){
//        QNetworkAccessManager nam;
//        QUrl url("http://" + server + ":15672/api/nodes");
//        url.setUserName("xchat");
//        url.setPassword("xtrabytes");
//        URLObject urlObj {QUrl(url)};
//        urlObj.addProperty("route","getOnlineNodesSlot");
//        DownloadManagerHandler(&urlObj);
//    }
}

void XchatObject::pingXchatServers() {

//    QElapsedTimer timer;

//    getOnlineNodes();
//    for(QString server : nodesOnline.values()){

//        QTcpSocket tester;
//        tester.connectToHost(server, 1883);
//        QString pingedServer = matchServer(server);
//        timer.start();
//        bool online = true;
//        if(tester.waitForConnected(1000)) {
//            qDebug() << "Server: " + pingedServer + " up";
//        } else {
//            online=false;
//        }
//        qint64 timeTaken = timer.nsecsElapsed();
//        qDebug() << pingedServer + " timer: " + QString::number(timeTaken);
//        QString responseTime = QString::number(timeTaken);
//        emit serverResponseTime(pingedServer, responseTime, "up");
//        if (!online){
//            qDebug() << "Server: " + pingedServer + " down";
//            emit xChatServerDown(pingedServer, "down");
//        }

//        tester.close();
//    }
//    emit selectedXchatServer(selectedServer);
}

QString XchatObject::matchServer(const QString &server){
    QString xChatServer = "unknown";
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

//    getOnlineNodes();
//    for(QString server : nodesOnline.values()){
//        QTcpSocket tester;
//        tester.connectToHost(server, 1883);
//        QString pingedServer = matchServer(server);
//        timer.start();
//        bool online = true;
//        if(tester.waitForConnected(1000)) {
//            qDebug() << "Server: " + pingedServer + " up";
//        } else {
//            online=false;
//        }
//        qint64 timeTaken = timer.nsecsElapsed();
//        qDebug() << pingedServer + " timer: " + QString::number(timeTaken);
//        QString responseTime = QString::number(timeTaken);
//        emit serverResponseTime(pingedServer, responseTime, "up");
//        if (!online){
//            qDebug() << "Server: " + pingedServer + " down";
//            emit xChatServerDown(pingedServer, "down");
//        }else if (fastestTime == 0 || fastestTime > timeTaken){
//            fastestServer = server;
//            fastestTime = timeTaken;
//            selectedServer = matchServer(fastestServer);
//            connectedServer = fastestServer;
//            qDebug() << "Fastest server:  " + selectedServer;
//            emit selectedXchatServer(selectedServer);
//        }

//        tester.close();
//    }
//    emit selectedXchatServer(selectedServer);
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
