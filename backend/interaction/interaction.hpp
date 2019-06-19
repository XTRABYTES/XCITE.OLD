/**
 * Filename: interaction.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef INTERACTION_HPP
#define INTERACTION_HPP

#include <QObject>

#include <QSslConfiguration>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QSignalMapper>
#include <QJsonObject>
#include <QJsonArray>
#include <QThread>

#include <boost/thread/mutex.hpp>

class InteractionKeyWordWorker : public QObject {
    Q_OBJECT

public:
    InteractionKeyWordWorker(const QString *_msg);
    ~InteractionKeyWordWorker();

signals:
    void finished();
    void error(QString err);

public Q_SLOTS:
    int errorString(QString errorstr);


public slots:
    void process();
    
private:
    QString msg;
    void CmdParser(const QJsonArray *params);
    void help();    

};


class Interaction : public QObject {
    Q_OBJECT

public:
    Interaction(QObject *parent = 0) : QObject(parent) {}
    ~Interaction() {}
    void Initialize();
    bool CheckUserInputForKeyWord(const QString msg, int *traceID);

    int GetNewTraceID() {
        boost::unique_lock<boost::mutex> scoped_lock(m_traceid);
        return ++traceID;
    };


private:
    boost::mutex m_traceid;
    boost::mutex m_keyword;
    int traceID;
};


extern Interaction interaction;

#endif  // INTERACTION_HPP
