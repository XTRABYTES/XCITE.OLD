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
