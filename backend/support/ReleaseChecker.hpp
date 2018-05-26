/**
 * Filename: ReleaseChecker.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef RELEASECHECKER_HPP
#define RELEASECHECKER_HPP

#include <QObject>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QThread>
#include "FileDownloader.hpp"

#include <QDebug>

class ReleaseChecker : public QObject
{
    Q_OBJECT
    QThread *thread;

public:
    ReleaseChecker(QString currentVersion, QObject *parent = 0);
    ~ReleaseChecker();

signals:
    void xciteUpdateAvailable();

public slots:
    void checkForUpdate();
    void dataLoaded();

    void errorString(QString err) {
        qDebug() << "error" << err;
    }

private:
    FileDownloader *m_worker;
    int m_currentVersion;
    QUrl m_url;
};

#endif // RELEASECHECKER_HPP
