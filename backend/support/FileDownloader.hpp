/**
 * Filename: FileDownloader.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef FILEDOWNLOADER_HPP
#define FILEDOWNLOADER_HPP

#include <QObject>
#include <QByteArray>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>

class FileDownloader : public QObject
{
    Q_OBJECT
public:
    explicit FileDownloader(QUrl url, QObject *parent = 0);
    virtual ~FileDownloader();
    QByteArray downloadedData() const;

signals:
    void finished();
    void error(QString err);

public slots:
    void download();

private slots:
    void fileDownloaded(QNetworkReply *reply);

private:
    QNetworkAccessManager *m_manager;
    QByteArray m_data;
    QUrl m_url;
};

#endif // FILEDOWNLOADER_HPP
