#include "DownloadManager.hpp"
#include <QtCore>
#include <QtNetwork>

#include <cstdio>

QT_BEGIN_NAMESPACE
class QSslError;
QT_END_NAMESPACE

using namespace std;
DownloadManager *DownloadManager::instance = 0;
static QQueue<URLObject*> downloadQueue;


bool DownloadManager::isHttpRedirect(QNetworkReply *reply)
{
    int statusCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    return statusCode == 301 || statusCode == 302 || statusCode == 303
           || statusCode == 305 || statusCode == 307 || statusCode == 308;
}

void DownloadManager::append( URLObject *url)
{
    if (downloadQueue.isEmpty()){
        downloadQueue.enqueue(url);
        doDownload();
    }else{
        downloadQueue.enqueue(url);

    }
}

void DownloadManager::doDownload(){
    if (downloadQueue.isEmpty()) {
           return;
       }
    URLObject *url = downloadQueue.dequeue();
    QNetworkRequest request(url->getUrl());
    request.setAttribute(QNetworkRequest::User,count++);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json; charset=utf-8");

    QNetworkReply *reply;
    if (url->hasProperty("POST")){
        reply = manager.post(request,url->getProperty("payload").toByteArray());

    }else{
        reply = manager.get(request);

    }

  //  QTimer *timeout = new QTimer(reply);
//    timeout->setProperty("count",count);
//    timeout->start(10000);

    reply->setProperty("properties",url->getProperties());

       connect(reply, SIGNAL(finished()),this,SLOT(downloadFinished()),Qt::QueuedConnection);

   //  connect(reply, SIGNAL(finished()),timeout,SLOT(stop()),Qt::QueuedConnection);
 //    connect(timeout, SIGNAL(timeout()), reply, SLOT(abort()),Qt::QueuedConnection); //connect reply to this to abort in handleTimeout


#if QT_CONFIG(ssl)
    connect(reply, SIGNAL(sslErrors(QList<QSslError>)),
            SLOT(sslErrors(QList<QSslError>)));
#endif

}
void DownloadManager::sslErrors(const QList<QSslError> &sslErrors)
{
#if QT_CONFIG(ssl)
    for (const QSslError &error : sslErrors)
        qDebug() << "SSL ERROR: " + error.errorString();
#else
    Q_UNUSED(sslErrors);
#endif
}



void DownloadManager::downloadFinished(){

     QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
  //   QTimer *t = reply->findChild<QTimer*>();
    QUrl url = reply->url();

    if (reply->error()) {
        saveToDisk(reply);
    } else {
//        if (t->isActive()){
//                 t->stop();
//        }
        if (isHttpRedirect(reply)) {
            qDebug() << "Request was redirected." ;
        } else {

            saveToDisk(reply);
        }
    }
    doDownload();

}

void DownloadManager::saveToDisk( QNetworkReply *reply){
    QMap<QString,QVariant> props = reply->property("properties").toMap();

   if (reply->error() && reply->errorString() == "Operation canceled"){

       emit readTimeout(props);
   }else{

       QByteArray response = reply->readAll();
       emit readFinished(response,props);
   }
}

