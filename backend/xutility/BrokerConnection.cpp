#include "BrokerConnection.h"
BrokerConnection broker;
static QQueue<QString> queues;



BrokerConnection::BrokerConnection(QObject *parent) :
    QObject(parent)
{
}


void BrokerConnection::Initialize(QString user) {
    me = "";
    m_client.setHost("69.51.23.182");
    m_client.setPort(5672);
    m_client.setUsername("xchat");
    m_client.setPassword("nopwd");
    m_client.setVirtualHost("xtrabytes");
    reconnectTimer.setSingleShot(true);
    reconnectTimer.start(10000);
    //m_client.setAutoReconnect(true);

    connect(&m_client, SIGNAL(connected()), this, SLOT(clientConnected()));

    m_client.connectToHost();

}

void BrokerConnection::disconnectMQ(){
    qDebug() << "disconnecting MQ";
    emit xchatConnectionFail();

    m_client.abort();
    m_client.disconnectFromHost();

}
void BrokerConnection::reconnect(){
    if (!reconnectTimer.isActive()){
        reconnectTimer.setSingleShot(true);
        reconnectTimer.start(10000);
        qDebug() << "reconnecting";
        m_client.connectToHost();
    }else{
        qDebug() << "already connecting";
    }
}

bool BrokerConnection::isConnected(){
    return (m_client.isConnected());
}
void BrokerConnection::clientConnected() {
    qDebug() << "Connected to MQ Server";
    connectExchange("xgames");
    connectExchange("xchatsQueue");
   }

void BrokerConnection::connectExchange(QString queueName){
    if (m_client.isConnected() && !me.isEmpty()){
        QAmqpExchange *exchange = m_client.createExchange(queueName);
        disconnect(exchange, 0, 0, 0); // in case this is a reconnect
            exchange->setProperty("queue",queueName);
            connect(exchange, SIGNAL(declared()), this, SLOT(exchangeDeclared()));
            exchange->declare(QAmqpExchange::FanOut);
    }else{
        qDebug() << "not connected connect";
    }
}

   void BrokerConnection::exchangeDeclared() {
       QAmqpExchange *exchange = qobject_cast<QAmqpExchange*>(sender());
       QAmqpQueue *temporaryQueue = m_client.createQueue(exchange->property("queue").toString() + "-" + me);
       disconnect(temporaryQueue, 0, 0, 0); // in case this is a reconnect

       temporaryQueue->setProperty("queue",exchange->property("queue"));
       connect(temporaryQueue, &QAmqpQueue::declared,  this, &BrokerConnection::queueDeclared);
       connect(temporaryQueue, &QAmqpQueue::bound,  this, &BrokerConnection::queueBound);
       connect(temporaryQueue, &QAmqpQueue::messageReceived,  this, &BrokerConnection::messageReceived);

       temporaryQueue->declare(QAmqpQueue::Exclusive);
   }

   void BrokerConnection::queueDeclared() {
       QAmqpQueue *temporaryQueue = qobject_cast<QAmqpQueue*>(sender());
       if (!temporaryQueue)
           return;
       temporaryQueue->bind(temporaryQueue->property("queue").toString(), temporaryQueue->name());
   }

   void BrokerConnection::queueBound() {
       QAmqpQueue *temporaryQueue = qobject_cast<QAmqpQueue*>(sender());
       if (!temporaryQueue)
           return;

       emit xchatInternetOk();
       emit xchatConnectionSuccess();

       qDebug() << " [*] Waiting for logs on " + temporaryQueue->property("queue").toString() + " --- " + temporaryQueue->name() + ".";
       temporaryQueue->consume(QAmqpQueue::coNoAck);
   }

   void BrokerConnection::messageReceived() {
       QAmqpQueue *temporaryQueue = qobject_cast<QAmqpQueue*>(sender());
       if (!temporaryQueue)
           return;

       QAmqpMessage message = temporaryQueue->dequeue();
       if (temporaryQueue->property("queue").toString() == "xchatsQueue"){
           xchatRobot.xchatEntry( message.payload());
       }else if(temporaryQueue->property("queue").toString() == "xgames"){
           xgames.xgamesEntry( message.payload());
       }else{

       }

   }

   void BrokerConnection::sendMessage(QString queue, QString message){

       if (m_client.isConnected()){
           QAmqpExchange *exchange = m_client.createExchange(queue);
           exchange->publish(message, queue);
       }else{
           if(!me.isEmpty()){
               reconnect();
           }else{
             qDebug() << "not connected send";
           }
       }
   }

