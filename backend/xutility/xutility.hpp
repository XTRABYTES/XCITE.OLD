/**
 * Filename: xutility.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef XUTILTY_HPP
#define XUTILITY_HPP

#include <QObject>

#include <QJsonDocument>
#include <QSignalMapper>
#include <QJsonObject>
#include <QJsonArray>


class Xutility : public QObject {
    Q_OBJECT

public:
   //   Xutility(QObject *parent = nullptr);
      explicit Xutility(QObject *parent = nullptr);

   //      Xutility(QObject *parent = 0) : QObject(parent) {}
 //   	~Xutility() {}
    	void Initialize();   
    	void CmdParser(const QJsonArray *params);
    	bool CheckUserInputForKeyWord(const QString msg);
    	void set_network(const QJsonArray *params);
    	void help();
        void createkeypair(const QJsonArray *params);
signals:
        void keyPairCreated(const QString &address, const QString &pubKey, const QString &privKey);

public slots:
   //     void createkeypair(const QJsonArray *params);
        void createKeyPairEntry(QString network);


    	
   private:
     std::vector<std::string> networks;
     std::vector<std::string>::iterator network; 	

};

extern Xutility xUtility;

#endif  // XUTILITY_HPP
