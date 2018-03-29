
#include "MarketValue.hpp"

MarketValue::MarketValue(QObject *parent) : QObject(parent)
{
}

void MarketValue::findXBYValue()
{
    QNetworkRequest request(QUrl("https://api.coinmarketcap.com/v1/ticker/xtrabytes/"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QNetworkAccessManager *restclient = new QNetworkAccessManager(this);
    connect(restclient, SIGNAL(finished(QNetworkReply*)), this, SLOT(onFinished(QNetworkReply*)));
    restclient->get(request);
}

void MarketValue::onFinished(QNetworkReply* reply)
{
    if (reply->error()) {
        qDebug() << reply->errorString();
        return;
    }

    QString marketValue = "";
    QString strReply = (QString)reply->readAll();
    QJsonDocument priceDataDoc = QJsonDocument::fromJson(strReply.toUtf8());
    QJsonArray priceDataArray = priceDataDoc.array();
    foreach (const QJsonValue &value, priceDataArray){
        QJsonObject jsonObj = value.toObject();
        marketValue = jsonObj["price_usd"].toString();
    }
    setMarketValue(marketValue);
}

