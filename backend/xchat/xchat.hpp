/**
 * Filename: xchat.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef XCHAT_H
#define XCHAT_H

#include <QObject>
#include <QString>
#include <QVariant>

#include <QtMqtt/QMqttClient>
#include <QNetworkConfigurationManager>

#include "xchataiml.hpp"
#include "xchatconversationmodel.hpp"


class Xchat : public QObject
{
    Q_OBJECT

public:
    explicit Xchat(QObject *parent = nullptr);
};

class OnlineUser {
  private:
    // Private attribute
    QString status;
    QString username;
    QDateTime dateTime;
    QDateTime lastTyped;

  public:
    // Setter
    void setStatus(QString status) {
      this->status = status;
    }
    void setUsername(QString username) {
      this->username = username;
    }
    void setDateTime(QDateTime dateTime) {
      this->dateTime = dateTime;
    }
    void setLastTyped(QDateTime lastTyped) {
      this->lastTyped = lastTyped;
    }

    // Getter
    QString getStatus() {
      return status;
    }
    QString getUsername() {
      return username;
    }
    QDateTime getDateTime() {
      return dateTime;
    }
    QTime getTime() {
      return dateTime.time();
    }
    QDate getDate() {
        return dateTime.date();
    }
    QDateTime getLastTyped() {
      return lastTyped;
    }
};

class XchatObject : public QObject
{
    Q_OBJECT

public:
    explicit XchatObject(QObject *parent = 0);
   ~XchatObject();

   void Initialize();
   bool m_BalanceRequested = false;
   QString m_lastUserMessage;
   void sendTypingToFront(const QMap<QString, QDateTime> typing);
   void addToTyping(const QString msg);
   bool checkInternet(QString url);
   void messageRoute(QString message);



signals:
    void xchatResponseSignal(QVariant text);
    void xchatSuccess( QString author, QString date, QString time, QString device, QString message, QString link, QString image, QString quote, QString msgID);
    void xchatTypingSignal(const QString &msg);
    void xchatConnectionFail();
    void xchatConnectionSuccess();
    void xchatConnecting();
    void xchatNoInternet();
    void xchatInternetOk();
    void xchatStateChanged();
    void onlineUsersSignal(QString online);
    void serverResponseTime(QString server, QString responseTime, QString serverStatus);
    void selectedXchatServer(QString server);
    void xChatServerDown(QString server, QString serverStatus);
    void clearOnlineNodeList();
    void sendNewMoveSucceed(QString player, QString game, QString gameID, QString move, QString moveID);
    void newMoveReceived(QString player, QString game, QString gameID, QString move, QString moveID);
    void newMoveConfirmed(QString player, QString game, QString gameID, QString move, QString moveID);
    void sendGameInviteSucceed(QString user, QString opponent, QString game, QString gameID);
    void newGameInvite(QString player1, QString player2, QString game, QString gameID);
    void sendConfirmGameInviteSucceed(QString user, QString opponent, QString game, QString gameID, QString accept);
    void responseGameInvite(QString user, QString game, QString gameID, QString accept);
    void gameCommandFailed();


public slots:
    void SubmitMsg(const QString &msg);
    bool CheckUserInputForKeyWord(const QString msg);
    bool CheckAIInputForKeyWord(const QString msg);
    QString HarmonizeKeyWords(const QString msg);
    void xchatInc(const QString &user, QString platform, QString status, QString message, QString webLink, QString image, QString quote);
    void sendTypingToQueue(const QString user, QString route, QString status);
    void sendGameToQueue(const QString player, QString game, QString gameID, QString move);
    void confirmGameSend(const QString player, QString game, QString gameID, QString move, QString moveID);
    void sendGameInvite(const QString user, QString opponent, QString game, QString gameID);
    void confirmGameInvite(const QString user, QString opponent, QString game, QString gameID, QString accept);
    void pingReceived();
    void pingXchatServers();
    void forcedReconnect();




private slots:
    void mqtt_StateChanged();


private:
    QObject *window;
    XchatAIML *m_pXchatAiml;
    QMqttClient *mqtt_client;
    QString topic = "xcite/xchat";
    QString me = "";
    QString fastestServer = "";
    QString connectedServer = "";
    QString selectedServer = "";
    bool m_bIsInitialized;
    bool forced_connect;
    QMap<QString, QDateTime> typing;
    QMap<QString,QString> nodesOnline;
    void cleanTypingList();
    void cleanOnlineList();
    QString findServer();
    QString Berlin_01 = "85.214.143.20";
    QString Berlin_02 = "85.214.78.233";
    QString matchServer(const QString &server);
    QList<QString> servers{Berlin_01,Berlin_02};
    QMap<QString, OnlineUser> onlineUsers;
    void addToOnline(const QString msg, bool typed);
    void addToOnline(QJsonObject);
    void addToTyping(QJsonObject);
    void removeFromTyping(QJsonObject);
    void sendToFront(QJsonObject);
    void sendToGame(QJsonObject);
    void confirmGameReceived(QJsonObject);
    void receiveGameInvite(QJsonObject);
    void receiveGameInviteResponse(QJsonObject);
    void getOnlineNodes();
    void sendOnlineUsers();
};



extern XchatObject xchatRobot;

#endif // XCHAT_H
