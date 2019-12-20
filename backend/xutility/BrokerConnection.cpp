#include "BrokerConnection.h"
BrokerConnection broker;
static QQueue<QString> queues;

BrokerConnection::BrokerConnection(QObject *parent) :
    QObject(parent)
{
}


void BrokerConnection::Initialize() {
    m_client.setHost("69.51.23.182");
    m_client.setPort(5672);
    m_client.setUsername("xchat");
    m_client.setPassword("nopwd");
    m_client.setVirtualHost("xtrabytes");

    connect(&m_client, SIGNAL(connected()), this, SLOT(clientConnected()));
    m_client.connectToHost();

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
    if (m_client.isConnected()){
        QAmqpExchange *exchange = m_client.createExchange(queueName);
            exchange->setProperty("queue",queueName);
            connect(exchange, SIGNAL(declared()), this, SLOT(exchangeDeclared()));
            exchange->declare(QAmqpExchange::FanOut);
    }else{
        qDebug() << "not connected connect";
    }
}

   void BrokerConnection::exchangeDeclared() {
       QAmqpExchange *exchange = qobject_cast<QAmqpExchange*>(sender());
       QAmqpQueue *temporaryQueue = m_client.createQueue();
       temporaryQueue->setProperty("queue",exchange->property("queue"));
       connect(temporaryQueue, SIGNAL(declared()), this, SLOT(queueDeclared()));
       connect(temporaryQueue, SIGNAL(bound()), this, SLOT(queueBound()));
       connect(temporaryQueue, SIGNAL(messageReceived()), this, SLOT(messageReceived()));
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
           qDebug() << "not connected send";
       }
   }

