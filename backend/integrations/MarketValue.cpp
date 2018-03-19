
#include "MarketValue.hpp"

MarketValue::MarketValue(QObject *parent) : QObject(parent)
{

}

void MarketValue::findXBYValue(QString currency)
{
    QNetworkRequest request(QUrl("https://api.coinmarketcap.com/v1/ticker/xtrabytes/?convert="+currency));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QNetworkAccessManager *restclient = new QNetworkAccessManager(this);
    connect(restclient, SIGNAL(finished(QNetworkReply*)), this, SLOT(onFinished(QNetworkReply*)));
    QNetworkReply* reply = restclient->get(request);
    reply->setProperty("selectedCurrency", currency);
}

void MarketValue::onFinished(QNetworkReply* reply)
{
    if (reply->error()) {
        qDebug() << reply->errorString();
        return;
    }

    QString selectedCurrency = reply->property("selectedCurrency").toString();

    QString marketValue = "";
    QString strReply = (QString)reply->readAll();
    QJsonDocument priceDataDoc = QJsonDocument::fromJson(strReply.toUtf8());
    QJsonArray priceDataArray = priceDataDoc.array();
    foreach (const QJsonValue &value, priceDataArray){
        QJsonObject jsonObj = value.toObject();
        marketValue = jsonObj["price_"+selectedCurrency.toLower()].toString();
    }
    setMarketValue(marketValue);
}

