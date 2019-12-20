#ifndef BROKERCONNECTION_H
#define BROKERCONNECTION_H

#include <QObject>
#include "qamqpclient.h"
#include "qamqpexchange.h"
#include "qamqpqueue.h"
#include <QJsonObject>
#include "../xchat/xchat.hpp"
#include "../xgames/xgames.hpp"

class BrokerConnection : public QObject
{
    Q_OBJECT
public:
    explicit BrokerConnection(QObject *parent = nullptr);
    void Initialize();
    bool isConnected();

signals:

public slots:
    void queueBound();
    void messageReceived();
    void queueDeclared();
    void exchangeDeclared();
    void clientConnected();
    void sendMessage(QString,QString);
    void connectExchange(QString);

private:
    QAmqpClient m_client;

};
extern BrokerConnection broker;


#endif // BROKERCONNECTION_H
