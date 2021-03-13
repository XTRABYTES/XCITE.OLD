/**
 * Filename: xutility.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include <iostream>
#include <vector>
#include <thread>
#include <chrono>
#include <cstring>
#include <cassert>
#include <QDebug>

#include <Poco/Net/StreamSocket.h>

#include "xutility.hpp"
#include "../xchat/xchat.hpp"
#include "../staticnet/staticnet.hpp"
#include "./crypto/ctools.h"
#include "./transaction/transaction.h"


Xutility xUtility;

namespace
{
    class Buffer
    {
    public:
        Buffer(size_t size) :
                m_data(size, 0),
                m_use(0)
        {
        }

        size_t write(const char* data, size_t size)
        {
            if (m_use == m_data.size())
            {
                return 0;
            }

            const size_t length = (size + m_use);
            size_t write =
                    length < m_data.size() ? size : m_data.size() - m_use;
            memcpy(m_data.data() + m_use, data, write);
            m_use += write;
            return write;
        }

        void drain()
        {
            m_use = 0;
        }

        size_t available() const
        {
            return m_use;
        }

        const char* data() const
        {
            return m_data.data();
        }

        void shl(size_t count)
        {
            assert(count<m_use);

            const size_t diff = m_use - count;
            std::memmove(m_data.data(), m_data.data()+count, diff);
            m_use = m_use - count;
        }

    private:
        std::vector<char> m_data;
        size_t m_use;
    };
}


Xutility::Xutility(QObject *parent) : QObject(parent) {
    this->Initialize();
}

void Xutility::Initialize() {

    if (!xutility_initialised) {
        networks.push_back("nothing");
        networks.push_back("xfuel");
        networks.push_back("xtrabytes");
        networks.push_back("testnet");
        network=networks.begin();
        xutility_initialised = true;
    }
}

unsigned char Xutility::getNetworkid(std::vector<std::string>::iterator network_iterator ) const {
    std::string selected_network = *network_iterator;
    if ( selected_network.compare("xfuel") == 0 ) return 35;
    if ( selected_network.compare("xtrabytes") == 0 ) return 25;
    if ( selected_network.compare("testnet") == 0 ) return 38;
    return 0;
}


unsigned char Xutility::getSelectedNetworkid() const {
    return getNetworkid(network);
}


std::string Xutility::getSelectedNetworkName() const {
	return *network; 
}

bool Xutility::CheckUserInputForKeyWord(const QString msg) {

    QStringList args = msg.split(" ");

    QJsonArray params;
    
    for (QStringList::const_iterator it = args.constBegin(); it != args.constEnd(); ++it) params.append(QJsonValue(*it));

    if (params.at(0).toString() == "!!xutil") {
        CmdParser(&params);
        return true;
    }

    return false;
}

void Xutility::CmdParser(const QJsonArray *params) {

    QString command = params->at(1).toString();

    if (command == "help") {
        help();

    } else if (command == "network") {
        set_network(params);
    } else if (command == "createkeypair") {
        createkeypair(params);
    } else if (command == "privkey2address") {
        privkey2address(params);
    } else {
        xchatRobot.SubmitMsg("Bad !!xutil command. Ignored.");
        xchatRobot.SubmitMsg("More informations: !!xutil help");
    }
}

void Xutility::help() {
    xchatRobot.SubmitMsg("!!xutil usage informations:");
    xchatRobot.SubmitMsg("!!xutil network [net]");
    QString help1 = "!!xutil network";
    xchatRobot.SubmitMsg("!!xutil createkeypair");
    QString help2 = "!!xutil createkeypair [xtrabytes/xfuel]";
    xchatRobot.SubmitMsg("!!xutil privkey2address [privkey]");
    QString help3 = "!!xutil privkey2address [xtrabytes/xfuel] [privkey]";
    QString help4 = "!!staticnet sendcoin [target] [amount] [privatekey]";

    emit helpReply(help1, help2, help3, help4);

}


void Xutility::privkey2address(const QJsonArray *params) {

    if (getNetworkid(network) != 0) {

        std::string secret = params->at(2).toString().toStdString();
        QString privKey = params->at(2).toString();
        CXCiteSecret xciteSecret;
        bool fGood = xciteSecret.SetString(secret,getNetworkid(network));
        if (!fGood) {
            qDebug()<< "Invalid private key";
            xchatRobot.SubmitMsg("Invalid private key");

            emit badKey();

        } else {

            CKey key = xciteSecret.GetKey();
            CPubKey xcpubkey = key.GetPubKey();
            std::string pubkeyHex = HexStr(xcpubkey.begin(), xcpubkey.end());
            std::vector<unsigned char> pubkeyBin = ParseHexcstr(pubkeyHex.c_str());
            std::string pubkeyBase58 = EncodeBase58(pubkeyBin);
            qDebug() << "Public key: "+QString::fromStdString(pubkeyBase58);
            xchatRobot.SubmitMsg("Public key: "+QString::fromStdString(pubkeyBase58));
            QString pubKey = QString::fromStdString(pubkeyBase58);

            CKeyID xciteAddresskeyID = xcpubkey.GetID();
            std::string XciteGenAddressStr = CXCiteAddress(xciteAddresskeyID,getNetworkid(network)).ToString();
            qDebug() << "Address: "+QString::fromStdString(XciteGenAddressStr);
            xchatRobot.SubmitMsg("Address: "+QString::fromStdString(XciteGenAddressStr));
            QString addressID = QString::fromStdString(XciteGenAddressStr);

            emit addressExtracted(privKey, pubKey, addressID);

        }

    } else {
        qDebug()<< "Bad or mising network ID.";
        xchatRobot.SubmitMsg("Bad or mising network ID.");
    }
}

void Xutility::createKeypairEntry(QString network) {

    QString setNetwork = "!!xutil network " + network;
    QString createKeys = "!!xutil createkeypair";
    
    this->CheckUserInputForKeyWord(setNetwork);
    this->CheckUserInputForKeyWord(createKeys);

}

void Xutility::helpEntry() {

    help();
}

void Xutility::networkEntry(QString netwrk) {

    qDebug() << "accessing xutil";
    QString setNetwork = "!!xutil network " + netwrk;
    this->CheckUserInputForKeyWord(setNetwork);
}

void Xutility::importPrivateKeyEntry(QString network, QString privKey) {

    QString setNetwork = "!!xutil network " + network;
    QString importKeys = "!!xutil privkey2address " + privKey;

    this->CheckUserInputForKeyWord(setNetwork);
    this->CheckUserInputForKeyWord(importKeys);

}

void Xutility::createkeypair(const QJsonArray *params) {

    qDebug()<< "New keypaird for ["+QString::fromStdString(*network)+"] network:";
    xchatRobot.SubmitMsg("New keypaird for ["+QString::fromStdString(*network)+"] network:");

    if (getNetworkid(network) != 0) {

        CKey key;
        CPubKey pubkey;
        key.MakeNewKey(false);
        pubkey = key.GetPubKey();
        CKeyID keyID = pubkey.GetID();

        std::string pubkeyHex = HexStr(pubkey.begin(), pubkey.end());
        std::vector<unsigned char> pubkeyBin = ParseHexcstr(pubkeyHex.c_str());
        std::string pubkeyBase58 = EncodeBase58(pubkeyBin);

        QString address = QString::fromStdString(CXCiteAddress(keyID,getNetworkid(network)).ToString());
        QString pubKey = QString::fromStdString(pubkeyBase58);
        QString privKey = QString::fromStdString(CXCiteSecret(key,getNetworkid(network)).ToString());
        qDebug()<< "Private key: "+ privKey;
        qDebug()<< "Public key: "+ pubKey;
        qDebug()<< "Address: "+ address;

        emit keyPairCreated(address, pubKey, privKey);


        xchatRobot.SubmitMsg("Private key: "+QString::fromStdString(CXCiteSecret(key,getNetworkid(network)).ToString()));
        xchatRobot.SubmitMsg("Public key: "+QString::fromStdString(pubkeyBase58));
        xchatRobot.SubmitMsg("Address: "+QString::fromStdString(CXCiteAddress(keyID,getNetworkid(network)).ToString()));
    } else {
        qDebug()<< "Bad or mising network ID.";
        xchatRobot.SubmitMsg("Bad or mising network ID.");

        emit createKeypairFailed();

    }
}

void Xutility::set_network(const QJsonArray *params) {

    if (params->at(2).toString()=="") {
        xchatRobot.SubmitMsg("Active network: "+QString::fromStdString(*network));
        QString myNetwork = ("Active network: "+QString::fromStdString(*network));
        emit networkStatus(myNetwork);


    } else {
        bool param_valid=false;
        QString networktypes;
        QString currentNetwork;
        for(std::vector<std::string>::iterator i = networks.begin(); i != networks.end(); ++i) {
            networktypes += ( (i != networks.begin()) ? ",":"" ) + QString::fromStdString(*i);
            if ( params->at(2).toString() == QString::fromStdString(*i) ) {
                param_valid=true;
                network=i;
            }
        }

        if (param_valid) {
            xchatRobot.SubmitMsg("New active network: "+QString::fromStdString(*network));
            currentNetwork = ("Current network: "+QString::fromStdString(*network));
            qDebug() << currentNetwork;
            emit newNetwork(currentNetwork);

        } else {
            xchatRobot.SubmitMsg("("+params->at(2).toString()+") is invalid network type. Existing types are:"+networktypes);
            xchatRobot.SubmitMsg("Active network: "+QString::fromStdString(*network));
            QString networkFault = ("("+params->at(2).toString()+") is invalid network type. Existing types are:"+networktypes);
            qDebug() << networkFault;
            emit badNetwork(networkFault);

        }

    }
    
}

unsigned int random_char() {
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(0, 255);
    return dis(gen);
}

std::string generate_hex(const unsigned int len) {
    std::stringstream ss;
    for (auto i = 0; i < len; i++) {
        const auto rc = random_char();
        std::stringstream hexstream;
        hexstream << std::hex << rc;
        auto hex = hexstream.str();
        ss << (hex.length() < 2 ? '0' + hex : hex);
    }
    return ss.str();
}

std::string Xutility::get_uuid() {

    std::stringstream ss;

    return ss.str();
}







struct SimplePocoHandlerImpl
{
    SimplePocoHandlerImpl() :
            connected(false),
            connection(nullptr),
            quit(false),
            inputBuffer(SimplePocoHandler::BUFFER_SIZE),
            outBuffer(SimplePocoHandler::BUFFER_SIZE),
            tmpBuff(SimplePocoHandler::TEMP_BUFFER_SIZE)
    {
    }

    Poco::Net::StreamSocket socket;
    bool connected;
    AMQP::Connection* connection;
    bool quit;
    Buffer inputBuffer;
    Buffer outBuffer;
    std::vector<char> tmpBuff;
};
SimplePocoHandler::SimplePocoHandler(const std::string& host, uint16_t port) :
        m_impl(new SimplePocoHandlerImpl)
{
    const Poco::Net::SocketAddress address(host, port);
    m_impl->socket.connect(address);
    m_impl->socket.setKeepAlive(true);
}

SimplePocoHandler::~SimplePocoHandler()
{
    close();
}

void SimplePocoHandler::loop()
{
    try
    {
        while (!m_impl->quit)
        {
            if (m_impl->socket.available() > 0)
            {
                size_t avail = m_impl->socket.available();
                if(m_impl->tmpBuff.size()<avail)
                {
                    m_impl->tmpBuff.resize(avail,0);
                }

                m_impl->socket.receiveBytes(&m_impl->tmpBuff[0], avail);
                m_impl->inputBuffer.write(m_impl->tmpBuff.data(), avail);

            }
            if(m_impl->socket.available()<0)
            {
                std::cerr<<"SOME socket error!!!"<<std::endl;
            }

            if (m_impl->connection && m_impl->inputBuffer.available())
            {
                size_t count = m_impl->connection->parse(m_impl->inputBuffer.data(),
                        m_impl->inputBuffer.available());

                if (count == m_impl->inputBuffer.available())
                {
                    m_impl->inputBuffer.drain();
                } else if(count >0 ){
                    m_impl->inputBuffer.shl(count);
                }
            }
            sendDataFromBuffer();

            std::this_thread::sleep_for(std::chrono::milliseconds(10));
        }

        if (m_impl->quit && m_impl->outBuffer.available())
        {
            sendDataFromBuffer();
        }

    } catch (const Poco::Exception& exc)
    {
        std::cerr<< "Poco exception " << exc.displayText();
    }
}

void SimplePocoHandler::quit()
{
    m_impl->quit = true;
}

void SimplePocoHandler::SimplePocoHandler::close()
{
    m_impl->socket.close();
}

void SimplePocoHandler::onData(
        AMQP::Connection *connection, const char *data, size_t size)
{
    m_impl->connection = connection;
    const size_t writen = m_impl->outBuffer.write(data, size);
    if (writen != size)
    {
        sendDataFromBuffer();
        m_impl->outBuffer.write(data + writen, size - writen);
    }
}

void SimplePocoHandler::onConnected(AMQP::Connection *connection)
{
    m_impl->connected = true;
}

void SimplePocoHandler::onError(
        AMQP::Connection *connection, const char *message)
{
    std::cerr<<"AMQP error "<<message<<std::endl;
}

void SimplePocoHandler::onClosed(AMQP::Connection *connection)
{
    std::cout<<"AMQP closed connection"<<std::endl;
    m_impl->quit  = true;
}

bool SimplePocoHandler::connected() const
{
    return m_impl->connected;
}

void SimplePocoHandler::sendDataFromBuffer()
{
    if (m_impl->outBuffer.available())
    {
        m_impl->socket.sendBytes(m_impl->outBuffer.data(), m_impl->outBuffer.available());
        m_impl->outBuffer.drain();
    }
}
