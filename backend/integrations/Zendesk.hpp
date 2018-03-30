#ifndef ZENDESK_HPP
#define ZENDESK_HPP

#include <QObject>
#include <QSettings>
#include <QUrl>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

class Zendesk : public QObject
{
    Q_OBJECT
public:
    explicit Zendesk(QSettings *settings, QObject *parent = nullptr);
    void listTickets();

signals:

public slots:
    void onAccessTokenSet(QString);
    void onFinished(QNetworkReply* response);

private:
    QUrl getURL(QString);
    QNetworkRequest getRequest(QString);

    QString m_accessToken;
    QSettings *m_settings;
};

#endif // ZENDESK_HPP
