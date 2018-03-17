
#include "fiatvalueintegration.hpp"


FiatValueIntegration::FiatValueIntegration(QObject *parent) : QObject(parent)
{

}

void FiatValueIntegration::findXBYValue()
{
    QUrl coinmarket;
    coinmarket.setScheme("https");
    coinmarket.setHost("api.coinmarketcap.com");
    coinmarket.setPath("/v1/ticker/xtrabytes/");

    QNetworkRequest request;
    request.setUrl(coinmarket);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QNetworkAccessManager *restclient = new QNetworkAccessManager(this);
    connect(restclient, SIGNAL(finished(QNetworkReply*)), this, SLOT(onFinished(QNetworkReply*)));
    restclient->get(request);
}

void FiatValueIntegration::onFinished(QNetworkReply* reply)
{
    if (reply->error()) {
        qDebug() << reply->errorString();
        return;
    }

    QString fiatValue = "";
    QString strReply = (QString)reply->readAll();
    QJsonDocument json_doc = QJsonDocument::fromJson(strReply.toUtf8());
    QJsonArray jsonArray2 = json_doc.array();
    foreach (const QJsonValue &value, jsonArray2){
        QJsonObject json_obj = value.toObject();
        fiatValue = json_obj["price_usd"].toString();
    }
    setFiatValue(fiatValue);
}

