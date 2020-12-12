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

    chooseServer();
    qDebug() << "Connecting to " + selectedServer;
    m_client.setHost(selectedServer);
    m_client.setPort(5671);
    m_client.setVirtualHost("xtrabytes");
    m_client.setSslConfiguration(createSslConfiguration());
    connect(&m_client, SIGNAL(connected()), this, SLOT(clientConnected()));
    QObject::connect(&m_client, SIGNAL(sslErrors(QList<QSslError>)),
                     &m_client, SLOT(ignoreSslErrors(QList<QSslError>)));
    m_client.connectToHost();


}

QSslConfiguration BrokerConnection::createSslConfiguration()
{


    QSslConfiguration sslConfiguration;
    sslConfiguration.setProtocol(QSsl::TlsV1_2);
    return sslConfiguration;
}

void BrokerConnection::chooseServer(){

    boost::random::mt19937 gen;
    gen.seed(time(NULL));
    boost::random::uniform_int_distribution<> dist(0, servers.size()-1);
    int randIndex = dist(gen);
    selectedServer = servers.at(randIndex);
    qDebug() << "selected: " + selectedServer;

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
      //  chooseServer();
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
   }

void BrokerConnection::connectQueue(QString queueName){
    if ( m_client.isConnected() && !me.isEmpty()){
        try{
            QAmqpQueue *queue = m_client.createQueue(queueName + "_" + me);
            connect(queue, &QAmqpQueue::declared,  this, &BrokerConnection::queueDeclared);
            connect(queue, &QAmqpQueue::bound,  this, &BrokerConnection::queueBound);
            connect(queue, &QAmqpQueue::messageReceived,  this, &BrokerConnection::messageReceived);

            queue->declare();
        }catch(...){
            qDebug() << "Exception in Connect Queue";
        }
    }else{
        qDebug() << "Not connected";
    }
}

   void BrokerConnection::queueDeclared() {
       QAmqpQueue *temporaryQueue = qobject_cast<QAmqpQueue*>(sender());
       if (!temporaryQueue)
           return;
       temporaryQueue->setProperty("x-match","any");
       temporaryQueue->setProperty("dest","xcite_" + me);
       temporaryQueue->setProperty("dest_all","1");
       temporaryQueue->bind("fedcore_exchange","all");
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
       qDebug() << "MEssage Received = " + message.payload();
       if (temporaryQueue->property("queue").toString().startsWith("xcite_")){
           xchatRobot.xchatEntry( message.payload());
       }else if(temporaryQueue->property("queue").toString() == "xgames"){
           //xgames.xgamesEntry( message.payload());
       }else{

       }

   }

   void BrokerConnection::sendMessage(QString queue, QString message, QAmqpTable headers){
    qDebug() << "Sending Message";
       if (m_client.isConnected()){
           QAmqpExchange *exchange = m_client.createExchange(queue);
           QAmqpMessage::PropertyHash properties = QAmqpMessage::PropertyHash();
           properties.insert(QAmqpMessage::Property::ContentType,"application/json");
           QUuid uuid = QUuid::createUuid();
           QAmqpTable headers;
               headers.insert("dest_all", "1");
               headers.insert("type","xchat");
               headers.insert("sender","xcite_" + me);
           properties.insert(QAmqpMessage::Property::Headers,headers);
           exchange->publish(message, "all", properties);
       }else{
           if(!me.isEmpty()){
               //reconnect();
           }else{
             qDebug() << "not connected send";
           }
       }
   }


   void BrokerConnection::sendXChatMessage(QString queue, QString message){
       QAmqpTable headers;
           headers.insert("dest_all", "1");
           headers.insert("type","xchat");
           headers.insert("sender","xcite_" + me);
           this->sendMessage(queue,message,headers);
   }

   void BrokerConnection::sendXChatDMMessage(QString queue, QString receiver, QString message){
       QAmqpTable headers;
           headers.insert("dest", receiver);
           headers.insert("type","xchat");
           headers.insert("sender","xcite_" + me);
           this->sendMessage(queue,message,headers);

   }

   void BrokerConnection::sendDicomMessage(QString queue, QString message){
       QAmqpTable headers;
           headers.insert("dest", "");
           headers.insert("type","dicom");
           headers.insert("sender","xcite_" + me);
           this->sendMessage(queue,message,headers);

   }
