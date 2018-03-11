#include "releasechecker.hpp"

#include <QDebug>

ReleaseChecker::ReleaseChecker(QString currentVersion, QObject *parent)
    : QObject(parent)
{
    m_currentVersion = currentVersion.remove(QRegExp("[^\\d]")).toInt();
    m_url = "https://api.github.com/repos/borzalom/xcite/releases";
}

ReleaseChecker::~ReleaseChecker() {
}

void ReleaseChecker::checkForUpdate() {
    qDebug() << "checking for update...";
    m_downloader = new FileDownloader(m_url, this);
    connect(m_downloader, SIGNAL(downloaded()), this, SLOT(dataLoaded()));
}

void ReleaseChecker::dataLoaded() {
    QJsonDocument releaseInfo(QJsonDocument::fromJson(m_downloader->downloadedData()));
    if (!releaseInfo.isArray()) {
        qWarning("Failed to parse release data from GitHub");
        return;
    }

    QJsonArray entries = releaseInfo.array();
    if (entries.count() > 0) {
        QJsonObject latestRelease = entries[0].toObject();
        int latestVersion = latestRelease["tag_name"].toString().remove(QRegExp("[^\\d]")).toInt();
        if (m_currentVersion < latestVersion) {
            qDebug() << "update available";
            emit xciteUpdateAvailable();
        } else {
            qDebug() << "no update available";
        }
    }
}
