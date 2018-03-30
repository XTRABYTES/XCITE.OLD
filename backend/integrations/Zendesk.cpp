#include "Zendesk.hpp"

#include <QDebug>

Zendesk::Zendesk(QSettings *settings, QObject *parent) : QObject(parent)
{
    m_settings = settings;
}

void Zendesk::listTickets() {

    QNetworkAccessManager *nam = new QNetworkAccessManager(this);
    QNetworkRequest request = this->getRequest("/requests.json");

    connect(nam, SIGNAL(finished(QNetworkReply*)), this, SLOT(onFinished(QNetworkReply*)));
    nam->get(request);
}

void Zendesk::onAccessTokenSet(QString accessToken) {
    m_accessToken = accessToken;

    this->listTickets();
}

void Zendesk::onFinished(QNetworkReply* response)
{
    if (response->error()) {
        qDebug() << response->errorString();
        return;
    }

    QJsonDocument doc(QJsonDocument::fromJson(response->readAll()));
    const QJsonArray &tickets = doc["requests"].toArray();

    foreach (const QJsonValue &item, tickets) {
        const QJsonObject &ticket = item.toObject();

        qDebug().noquote() << ticket.value("subject").toString();
        qDebug().noquote() << ticket.value("description").toString();
        qDebug() << "============";
    }
}

QNetworkRequest Zendesk::getRequest(QString path)
{
    QNetworkRequest request(this->getURL(path));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QString bearer("Bearer " + m_accessToken);
    request.setRawHeader(QByteArray("Authorization"), QByteArray(bearer.toUtf8()));

    return request;
}

QUrl Zendesk::getURL(QString path)
{
    return QUrl(QString("https://") + m_settings->value("developer/zendeskCompanyID").toString() + QString(".zendesk.com/api/v2") + path);
}

