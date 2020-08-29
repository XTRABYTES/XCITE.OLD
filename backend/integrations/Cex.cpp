/**
 * Filename: Cex.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include <QSettings>
#include "Cex.hpp"
#include "../xchat/xchat.hpp"
#include <QWindow>


Cex::Cex(QObject *parent) : QObject(parent)
{
}

void Cex::DownloadManagerHandler(URLObject *url){
    DownloadManager *manager = manager->getInstance();
    url->addProperty("url",url->getUrl());
    url->addProperty("class","Explorer");
    manager->append(url);
    //  connect(manager,  SIGNAL(readTimeout(QMap<QString,QVariant>)),this,SLOT(internetTimeout(QMap<QString,QVariant>)),Qt::UniqueConnection);

    connect(manager,  SIGNAL(readFinished(QByteArray,QMap<QString,QVariant>)), this,SLOT(DownloadManagerRouter(QByteArray,QMap<QString,QVariant>)),Qt::UniqueConnection);
}

void Cex::DownloadManagerRouter(QByteArray response, QMap<QString,QVariant> props){

}
