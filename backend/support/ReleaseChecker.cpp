/**
 * Filename: ReleaseChecker.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include "ReleaseChecker.hpp"

#include <QDebug>

ReleaseChecker::ReleaseChecker(QString currentVersion, QObject *parent)
    : QObject(parent)
{
    m_currentVersion = currentVersion.remove(QRegExp("[^\\d]")).toInt();
    m_url = QUrl("https://api.github.com/repos/XTRABYTES/XCITE/releases");
}

ReleaseChecker::~ReleaseChecker() {
}

void ReleaseChecker::checkForUpdate() {
    qDebug() << "checking for xcite update...";

    thread = new QThread;
    m_worker = new FileDownloader(m_url);
    m_worker->moveToThread(thread);

    connect(m_worker, SIGNAL(error(QString)), this, SLOT(errorString(QString)));
    connect(thread, SIGNAL(started()), m_worker, SLOT(download()));
    connect(m_worker, SIGNAL(finished()), this, SLOT(dataLoaded()));
    connect(m_worker, SIGNAL(finished()), thread, SLOT(quit()));
    connect(thread, SIGNAL(finished()), thread, SLOT(deleteLater()));
    thread->start();
}

void ReleaseChecker::dataLoaded() {
    QJsonDocument releaseInfo(QJsonDocument::fromJson(m_worker->downloadedData()));
    if (!releaseInfo.isArray()) {
        qWarning("Failed to parse release data from GitHub");
        return;
    }

    QJsonArray entries = releaseInfo.array();
    if (entries.count() > 0) {
        QJsonObject latestRelease = entries[0].toObject();
        int latestVersion = latestRelease["tag_name"].toString().remove(QRegExp("[^\\d]")).toInt();
        qDebug() << "local=" << m_currentVersion << " remote=" << latestVersion;
        if (m_currentVersion < latestVersion) {
            qDebug() << "update available";
            emit xciteUpdateAvailable();
        } else {
            qDebug() << "no update available";
        }
    }

    delete m_worker;
}
