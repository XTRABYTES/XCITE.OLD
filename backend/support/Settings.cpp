/**
 * Filename: Settings.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include "Settings.hpp"

Settings::Settings(QObject *parent) :
    QObject(parent)
{
}

Settings::Settings(QQmlApplicationEngine *engine, QSettings *settings, QObject *parent) :
    QObject(parent)
{
    m_engine = engine;
    m_settings = settings;
}

void Settings::setLocale(QString locale) {
    if (!m_translator.isEmpty()) {
        QCoreApplication::removeTranslator(&m_translator);
    }

    if (locale != "en_us") {
        QString localeFile = QStringLiteral(":/i18n/lang_") + locale;
        if (!m_translator.load(localeFile)) {
            return;
        }

        QCoreApplication::installTranslator(&m_translator);
    }

    m_engine->retranslate();
}

void Settings::onLocaleChange(QString locale) {
    setLocale(locale);
}

void Settings::onClearAllSettings() {
    bool fallbacks = m_settings->fallbacksEnabled();
    m_settings->setFallbacksEnabled(false);

    m_settings->remove("developer");
    m_settings->remove("xchat");
    m_settings->remove("width");
    m_settings->remove("height");
    m_settings->remove("locale");
    m_settings->remove("x");
    m_settings->remove("y");
    m_settings->remove("onboardingCompleted");
    m_settings->remove("defaultCurrency");
    m_settings->sync();

    m_settings->setFallbacksEnabled(fallbacks);
}

// Onboarding and login functions

bool Settings::UserExists(QString username){
    QSqlDatabase db = OpenDBConnection();
    QSqlQuery query;
    query.prepare("SELECT id from xciteSettings where username = ?");
    query.addBindValue(username);
    query.exec();
    while (query.next()) {
        db.close();
        emit userAlreadyExists();
        return true;
    }
    db.close();
    return false;
}

void Settings::CreateUser(QString username, QString password){
    if(UserExists(username)){
        return;
    }

    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB);
    QByteArray encodedText = encryption.encode(QString("<xtrabytes>").toLocal8Bit(), (password + "xtrabytesxtrabytes").toLocal8Bit());

    QSqlDatabase db = OpenDBConnection();
    QSqlQuery query;
    query.prepare("INSERT INTO xciteSettings (username, dateCreated, dateUpdated, settings) VALUES (?, datetime('now'), strftime('%s','now'), ?)");
    query.addBindValue(username);
    query.addBindValue(encodedText);
    query.exec();
    db.close();

    if (UserExists(username))
        emit userCreationSucceeded();
    else
        emit userCreationFailed();

}

void Settings::login(QString username, QString password){
    QByteArray result;
    QSqlDatabase db = OpenDBConnection();
    QSqlQuery query;
    query.prepare("SELECT settings from xciteSettings where username = ?");
    query.addBindValue(username);
    query.exec();
    while (query.next()) {
           result = query.value(0).toByteArray();
    }
    db.close();

    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB);
    QByteArray decodedSettings = encryption.decode(result, (password + "xtrabytesxtrabytes").toLocal8Bit());
    if(decodedSettings.startsWith("<xtrabytes>"))
        emit loginSucceededChanged();
    else
        emit loginFailedChanged();
}

// User setting functions (Not yet in use)

bool Settings::SaveSettings(){
    QSqlDatabase db = OpenDBConnection();

    return true;
}

QString Settings::LoadSettings(QString username, QString password){
    QByteArray result;
    QSqlDatabase db = OpenDBConnection();
    QSqlQuery query;
    query.prepare("SELECT settings from xciteSettings where username = ?");
    query.addBindValue(username);
    query.exec();
    while (query.next()) {
           result = query.value(0).toByteArray();
    }
    db.close();

    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB);
    QByteArray decodedSettings = encryption.decode(result, (password + "xtrabytesxtrabytes").toLocal8Bit());
    if(decodedSettings.startsWith("<xtrabytes>")){
       QString settings = decodedSettings.left(11);
        return settings;
    }

    return "";
}

// General functions

QSqlDatabase Settings::OpenDBConnection(){
    // Development database in use
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("/users/tuukkapeltoniemi/Documents-NotCloud/Development/XtraBytes/xcite-tuukkapel/XCITE/dev-db/xtrabytes");

    // Release database to be used
    //QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    //db.setHostName("xxx.xxx.xxx.xxx");
    //db.setDatabaseName("xxx");
    //db.setUserName("xxxx");
    //db.setPassword("xxx");

    if (!db.open())
        emit settingsServerError();
    return db;
}
