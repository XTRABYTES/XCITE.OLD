#ifndef DOWNLOADMANAGER_H
#define DOWNLOADMANAGER_H

#include <QtNetwork>
#include <QtCore>
#include "URLObject.hpp"


class DownloadManager: public QObject{
    Q_OBJECT
    static DownloadManager    *instance;

    QNetworkAccessManager manager;
    QVector<QNetworkReply *> currentDownloads;



public:
    int count = 0;

    void doDownload();
    static bool isHttpRedirect(QNetworkReply *reply);
    void append(URLObject *url);


    static DownloadManager *getInstance(){
        if (!instance){
            instance = new DownloadManager();
        }

       return instance;
    }


public slots:
    void downloadFinished();
    void sslErrors(const QList<QSslError> &errors);
    void saveToDisk(QNetworkReply *);


signals:
    void readFinished(QByteArray, QMap<QString,QVariant>);
    void readTimeout(QMap<QString,QVariant>);


private:
    DownloadManager(){
    }

};


#endif


