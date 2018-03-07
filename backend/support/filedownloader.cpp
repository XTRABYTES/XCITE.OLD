#include "filedownloader.hpp"

#include <QDebug>

FileDownloader::FileDownloader(QUrl url, QObject *parent) :
    QObject(parent)
{
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);
    connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(fileDownloaded(QNetworkReply*)));

    manager->get(QNetworkRequest(url));
}

FileDownloader::~FileDownloader() {}

void FileDownloader::fileDownloaded(QNetworkReply *reply) {
    m_data = reply->readAll();

    reply->deleteLater();
    emit downloaded();
}

QByteArray FileDownloader::downloadedData() const {
    return m_data;
}
