#ifndef RELEASECHECKER_HPP
#define RELEASECHECKER_HPP

#include <QObject>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include "filedownloader.hpp"

class ReleaseChecker : public QObject
{
    Q_OBJECT
public:
    ReleaseChecker(QString currentVersion, QObject *parent = 0);
    ~ReleaseChecker();

signals:
    void xciteUpdateAvailable();

public slots:
    void checkForUpdate();
    void dataLoaded();

private:
    FileDownloader *m_downloader;
    int m_currentVersion;
    QUrl m_url;
};

#endif // RELEASECHECKER_HPP
