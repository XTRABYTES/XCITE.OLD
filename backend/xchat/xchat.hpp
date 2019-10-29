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

#include "xchataiml.hpp"
#include "xchatconversationmodel.hpp"


class Xchat : public QObject
{
    Q_OBJECT

public:
    explicit Xchat(QObject *parent = nullptr);
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
   bool checkInternet();


signals:
    void xchatResponseSignal(QVariant text);
    void xchatSuccess(const QString &msg);
    void xchatTypingSignal(const QString &msg);
    void xchatConnectionFail();
    void xchatConnectionSuccess();
    void xchatConnecting();
    void xchatNoInternet();
    void xchatInternetOk();


public slots:
    void SubmitMsgCall(const QString &msg);
    void SubmitMsg(const QString &msg);
    bool CheckUserInputForKeyWord(const QString msg);
    bool CheckAIInputForKeyWord(const QString msg);
    QString HarmonizeKeyWords(const QString msg);
    void xchatInc(const QString &msg);
    void xchatTyping(const QString &msg);
    void removeFromTyping(const QString msg);
    void sendTypingToQueue(const QString msg);
    void pingReceived();




private slots:
    void mqtt_StateChanged();


private:
    QObject *window;
    XchatAIML *m_pXchatAiml;
    QMqttClient *mqtt_client;
    QString topic = "xcite/xchat";
    bool m_bIsInitialized;
    QMap<QString, QDateTime> typing;
    void cleanTypingList();

};

extern XchatObject xchatRobot;

#endif // XCHAT_H
