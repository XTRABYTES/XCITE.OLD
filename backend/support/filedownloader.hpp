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
    void downloaded();

private slots:
    void fileDownloaded(QNetworkReply *reply);

private:
    QNetworkAccessManager *m_nam;
    QByteArray m_data;
};

#endif // FILEDOWNLOADER_HPP
