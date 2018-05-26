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

signals:
    void xchatResponseSignal(QVariant text);

public slots:
    void SubmitMsgCall(const QString &msg);
    void SubmitMsg(const QString &msg);
    bool CheckUserInputForKeyWord(const QString msg);
    bool CheckAIInputForKeyWord(const QString msg);
    QString HarmonizeKeyWords(const QString msg);

private:
    QObject *window;
    XchatAIML *m_pXchatAiml;
    bool m_bIsInitialized;
};

#endif // XCHAT_H
