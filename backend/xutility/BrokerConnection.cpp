#include "BrokerConnection.h"
#include <boost/random/uniform_int_distribution.hpp>
#include <boost/random/mersenne_twister.hpp>


BrokerConnection broker;
static QQueue<QString> queues;



BrokerConnection::BrokerConnection(QObject *parent) :
    QObject(parent)
{
}


void BrokerConnection::Initialize(QString user) {
    me = "";
//    chooseServer();
//    qDebug() << "Connecting to " + selectedServer;
//    m_client.setHost(selectedServer);
//    m_client.setPort(5672);
//    m_client.setUsername("xchat");
//    m_client.setPassword("nopwd");
//    m_client.setVirtualHost("xtrabytes");
//    reconnectTimer.setSingleShot(true);
//    reconnectTimer.start(10000);
//    //m_client.setAutoReconnect(true);
//    connect(&m_client, SIGNAL(connected()), this, SLOT(clientConnected()));

//    m_client.connectToHost();

}

void BrokerConnection::chooseServer(){
//    boost::random::mt19937 gen;
//    gen.seed(time(NULL));
//    boost::random::uniform_int_distribution<> dist(0, servers.size()-1);
//    int randIndex = dist(gen);
//    selectedServer = servers.at(randIndex);
//    qDebug() << "selected: " + selectedServer;
}

void BrokerConnection::disconnectMQ(){
    if(m_client.isConnected()){
        qDebug() << "disconnecting MQ";
        emit xchatConnectionFail();
        m_client.disconnectFromHost();
    }

}
void BrokerConnection::reconnect(){
    if (!reconnectTimer.isActive()){
        reconnectTimer.setSingleShot(true);
        reconnectTimer.start(10000);
        qDebug() << "reconnecting";
        chooseServer();
        m_client.setHost(selectedServer);
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
    emit selectedXchatServer(selectedServer);

    connectExchange("xgames");
    connectExchange("xchats");
   }

void BrokerConnection::connectExchange(QString queueName){
    if ( m_client.isConnected() && !me.isEmpty()){
        try{
            QAmqpExchange *exchange = m_client.createExchange(queueName);
            disconnect(exchange, 0, 0, 0); // in case this is a reconnect
            exchange->setProperty("queue",queueName);
            connect(exchange, SIGNAL(declared()), this, SLOT(exchangeDeclared()));
            QAmqpTable exchangeProps;
            exchangeProps.insert("x-cache-size",500);
            exchange->declare(QAmqpExchange::Deduplication, QAmqpExchange::Durable, exchangeProps);
        }catch(...){
            qDebug() << "Exception in Connect Exchange";

        }
    }else{
        qDebug() << "Not connected";
    }
}

   void BrokerConnection::exchangeDeclared() {
       QAmqpExchange *exchange = qobject_cast<QAmqpExchange*>(sender());
       QAmqpQueue *temporaryQueue = m_client.createQueue(exchange->property("queue").toString() + "-" + me); //

       disconnect(temporaryQueue, 0, 0, 0); // in case this is a reconnect

       temporaryQueue->setProperty("queue",exchange->property("queue"));
       connect(temporaryQueue, &QAmqpQueue::declared,  this, &BrokerConnection::queueDeclared);
       connect(temporaryQueue, &QAmqpQueue::bound,  this, &BrokerConnection::queueBound);
       connect(temporaryQueue, &QAmqpQueue::messageReceived,  this, &BrokerConnection::messageReceived);
       temporaryQueue->declare(QAmqpQueue::AutoDelete);
   }

   void BrokerConnection::queueDeclared() {
       QAmqpQueue *temporaryQueue = qobject_cast<QAmqpQueue*>(sender());
       if (!temporaryQueue)
           return;
       temporaryQueue->bind(temporaryQueue->property("queue").toString(), "xcite.xchat");
   }

   void BrokerConnection::queueBound() {
       try {
           QAmqpQueue *temporaryQueue = qobject_cast<QAmqpQueue*>(sender());
           if (!temporaryQueue)
               return;

           emit xchatInternetOk();
           emit xchatConnectionSuccess();

           qDebug() << " [*] Waiting for logs on " + temporaryQueue->property("queue").toString() + " --- " + temporaryQueue->name() + ".";
           temporaryQueue->consume(QAmqpQueue::coNoAck);
       } catch (...) {
           qDebug() << "Exception here queue bound";
       }

   }

   void BrokerConnection::messageReceived() {
       QAmqpQueue *temporaryQueue = qobject_cast<QAmqpQueue*>(sender());
       if (!temporaryQueue)
           return;

       QAmqpMessage message = temporaryQueue->dequeue();
       if (temporaryQueue->property("queue").toString() == "xchats"){
           xchatRobot.xchatEntry( message.payload());
       }else if(temporaryQueue->property("queue").toString() == "xgames"){
           xgames.xgamesEntry( message.payload());
       }else{

       }

   }

   void BrokerConnection::sendMessage(QString queue, QString message){

       if (m_client.isConnected()){
           QAmqpExchange *exchange = m_client.createExchange(queue);
           QAmqpMessage::PropertyHash properties = QAmqpMessage::PropertyHash();
           properties.insert(QAmqpMessage::Property::ContentType,"application/json");
           QUuid uuid = QUuid::createUuid();
           QAmqpTable headers;
               headers.insert("x-deduplication-header", uuid.toString(QUuid::Id128));
               headers.insert("x-dicom-version","1.0.0");
               headers.insert("x-dicom-msgtype","xchat");
               headers.insert("x-cache-size",500);
               headers.insert("x-cache-ttl",10000);

           properties.insert(QAmqpMessage::Property::Headers,headers);
           exchange->publish(message, "xcite.xchat", properties);
       }else{
           if(!me.isEmpty()){
               reconnect();
           }else{
             qDebug() << "not connected send";
           }
       }
   }
