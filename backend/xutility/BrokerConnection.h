#ifndef BROKERCONNECTION_H
#define BROKERCONNECTION_H

#include <QObject>
#include "qamqpclient.h"
#include "qamqpmessage.h"

#include "qamqpexchange.h"
#include "qamqpqueue.h"
#include <QJsonObject>
#include "../xchat/xchat.hpp"
#include "../xgames/XGames.hpp"

class BrokerConnection : public QObject
{
    Q_OBJECT
public:
    explicit BrokerConnection(QObject *parent = nullptr);
    void Initialize(QString);
    bool isConnected();
    QAmqpClient m_client;
    QString me;


signals:
    void xchatConnectionFail();
    void xchatInternetOk();
    void xchatConnectionSuccess();
    void selectedXchatServer(QString server);


public slots:
    void queueBound();
    void messageReceived();
    void queueDeclared();
    void exchangeDeclared();
    void clientConnected();
    void sendMessage(QString,QString);
    void connectExchange(QString);
    void reconnect();
    void disconnectMQ();
    void chooseServer();

private:
    QTimer reconnectTimer;
    QString selectedServer;
//    QStringList servers = (QStringList() << "85.214.78.233");
    QStringList servers = (QStringList() << "176.123.4.83" << "69.51.23.182" <<
                           "185.122.58.178"<<"85.214.143.20"<<"85.214.78.233"<<
                           "37.187.99.162"<<"103.205.143.174"<<"217.144.53.84"<<
                           "185.177.21.73"<<"144.172.126.16"<<"92.63.57.175"<<"151.80.38.9");


};
extern BrokerConnection broker;


#endif // BROKERCONNECTION_H
