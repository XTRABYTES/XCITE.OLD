/**
 * Filename: interaction.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include <stdio.h>
#include <iostream>

#include <boost/algorithm/string.hpp>

#include <QDebug>
#include <QMetaObject>
#include "interaction.hpp"
#include "../xchat/xchat.hpp"
#include "../xutility/xutility.hpp"
#include "../xutility/crypto/ctools.h"
#include "../xutility/transaction/transaction.h"

	
Interaction interaction;

void Interaction::Initialize() {
	
       traceID=0;
}

bool Interaction::CheckUserInputForKeyWord(const QString msg, int *traceID) {

      boost::unique_lock<boost::mutex> scoped_lock(m_keyword);
      *traceID = interaction.GetNewTraceID();
      qDebug() << "interaction accessed!" << " traceID=" << *traceID;
      
      if (!(msg.split(" ").at(0) == "!!interaction")) {
         return false;
      }      
         QString traced_msg = msg + " " + QString::number(*traceID);
			QThread* thread = new QThread;
			InteractionKeyWordWorker* worker = new InteractionKeyWordWorker(&traced_msg);
			worker->moveToThread(thread);
	      connect(worker, SIGNAL (error(QString)), this, SLOT (errorString(QString)));
			connect(thread, SIGNAL (started()), worker, SLOT (process()));
			connect(worker, SIGNAL (finished()), thread, SLOT (quit()));
			connect(worker, SIGNAL (finished()), worker, SLOT (deleteLater()));
			connect(thread, SIGNAL (finished()), thread, SLOT (deleteLater()));
			thread->start();
	   
      return true;
	
}


InteractionKeyWordWorker::InteractionKeyWordWorker(const QString *_msg) {
		
    this->msg = QString(*_msg);
}

InteractionKeyWordWorker::~InteractionKeyWordWorker() {
	xchatRobot.SubmitMsg("InteractionKeyWordWorker() worker stopped."); 
}

int InteractionKeyWordWorker::errorString(QString errorstr) {
    qDebug() << "InteractionError string recevied" << errorstr;
}

void InteractionKeyWordWorker::process() {

    qDebug() << "Processing interaction command: [" << msg << "]";
    
    QStringList args = msg.split(" ");
    QJsonArray params; 
    
    for (QStringList::const_iterator it = args.constBegin(); it != args.constEnd(); ++it) params.append(QJsonValue(*it));
    
    CmdParser(&params);

    qDebug() << "Processing done";
    	 	 	      
}

void InteractionKeyWordWorker::CmdParser(const QJsonArray *params) {

    qDebug() << "reading command";

    QString command = params->at(1).toString();

    if (command == "help") {
        help();

    } else if (command == "list") {
        // list the pending interactions
        qDebug() << "interaction list...";
    } else if (command == "create") {
        // create one new interaction
        qDebug() << "interaction create...";
    } else if (command == "confirm") {
        qDebug() << "interaction confirmation...";         
    } else {
        xchatRobot.SubmitMsg("Bad !!interaction command. Ignored.");
        xchatRobot.SubmitMsg("More informations: !!interaction help");
    }
  
}

void InteractionKeyWordWorker::help() {
    xchatRobot.SubmitMsg("!!interaction usage informations:");
    xchatRobot.SubmitMsg("!!interaction create");
    xchatRobot.SubmitMsg("!!interaction list");
    xchatRobot.SubmitMsg("!!interaction confirm [id]");
}

