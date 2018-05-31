/**
 * Filename: FileDownloader.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include "FileDownloader.hpp"

void FileDownloader::download() {
    m_manager = new QNetworkAccessManager;
    connect(m_manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(fileDownloaded(QNetworkReply*)));
    m_manager->get(QNetworkRequest(m_url));
}

FileDownloader::FileDownloader(QUrl url, QObject *parent) :
    QObject(parent)
{
    m_url = url;
}

FileDownloader::~FileDownloader() {
    delete m_manager;
}

void FileDownloader::fileDownloaded(QNetworkReply *reply) {
    m_data = reply->readAll();

    reply->deleteLater();
    emit finished();
}

QByteArray FileDownloader::downloadedData() const {
    return m_data;
}
