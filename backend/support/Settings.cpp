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
    QUrlQuery queryString;
    queryString.addQueryItem("userId", username);

    QString userinfo = RestAPIGetCall("/v1/user", queryString);
    if (userinfo != ""){
        emit userAlreadyExists();
        return true;
    }else {
        emit usernameAvailable();
        return false;
    }
}

void Settings::CreateUser(QString username, QString password){
    if(UserExists(username)){
        return;
    }

    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB);
    QByteArray encodedText = encryption.encode(QString("<xtrabytes>").toUtf8(), (password + "xtrabytesxtrabytes").toUtf8());

    QVariantMap feed;
    feed.insert("dateCreated", QDateTime::currentDateTime());
    feed.insert("dateUpdated", QDateTime::currentDateTime());
    feed.insert("settings", encodedText);
    feed.insert("username", username);
    feed.insert("id", "1");
    QByteArray payload = QJsonDocument::fromVariant(feed).toJson();
    qDebug() << QVariant(payload).toString();

    bool success = RestAPIPostCall("/v1/user", payload);

    if (UserExists(username))
        emit userCreationSucceeded();
    else
        emit userCreationFailed();

}

void Settings::login(QString username, QString password){
    QUrlQuery queryString;
    queryString.addQueryItem("userId", username);

    QString result = RestAPIGetCall("/v1/user", queryString);

    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB);
    QByteArray decodedSettings = encryption.decode(result, (password + "xtrabytesxtrabytes").toUtf8());
    if(decodedSettings.startsWith("<xtrabytes>")){
        m_username = username;
        m_password = password;
        LoadSettings();
        emit loginSucceededChanged();
    }
    else
        emit loginFailedChanged();
}

// User setting functions
bool Settings::SaveSettings(){
    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB);
    QString settings;

    //settings += m_addresses + ",";
    settings += "pincode: " + m_pincode + " ";

    qCritical() << settings;

    QByteArray encodedText = encryption.encode((QString("<xtrabytes>1") + settings).toUtf8(), (m_password + "xtrabytesxtrabytes").toUtf8());

    QSqlDatabase db = OpenDBConnection();
    QSqlQuery query;
    query.prepare("UPDATE xciteSettings set settings = ? where username = ?");
    query.addBindValue(m_username);
    query.addBindValue(encodedText);
    query.exec();
    qCritical() << query.lastError();
    db.close();

    return true;
}

void Settings::LoadSettings(){
    QByteArray result;
    QSqlDatabase db = OpenDBConnection();
    QSqlQuery query;
    query.prepare("SELECT settings from xciteSettings where username = ?");
    query.addBindValue(m_username);
    query.exec();
    while (query.next()) {
           result = query.value(0).toByteArray();
    }
    db.close();

    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB);
    QByteArray decodedSettings = encryption.decode(result, (m_password + "xtrabytesxtrabytes").toUtf8());
    qCritical() << decodedSettings;
    if(decodedSettings.startsWith("<xtrabytes>")){
        QString settings = QString::fromUtf8(decodedSettings);
        qCritical() << decodedSettings;

        QByteArray jsonBytes = settings.toUtf8();
        auto json_doc = QJsonDocument::fromJson(jsonBytes);

        if (json_doc.isNull())
            qCritical() << "Failed to create JSON doc";
        if (!json_doc.isObject())
            qCritical() << "JSON is not an object";

        QJsonObject json_obj = json_doc.object();
    }
}

void Settings::SaveAddresses(QString addresslist){
    addresslist.remove(0, 1);
    addresslist.remove(addresslist.length()-1, addresslist.length());
    addresslist.insert(0, "{ \"addresslist\": ");
    addresslist.append("}");
    m_addresses = addresslist;
    SaveSettings();
}

void Settings::onSavePincode(QString pincode){
    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB);
    m_pincode = "5000"; //encryption.encode((QString("<xtrabytes>") + pincode).toUtf8(), (m_password + "xtrabytesxtrabytes").toUtf8());
    SaveSettings();
}

bool Settings::checkPincode(QString pincode){
    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB);
    QString enc_pincode = encryption.encode((QString("<xtrabytes>") + pincode).toUtf8(), (m_password + "xtrabytesxtrabytes").toUtf8());
    if (enc_pincode == m_pincode)
        return true;
    else
        return false;
}

// General functions

bool Settings::RestAPIPostCall(QString apiURL, QByteArray payload){

    QUrl Url;
    Url.setScheme("http");
    Url.setHost("localhost");
    Url.setPort(8080);
    Url.setPath(apiURL);
    qDebug() << Url.toString();

    QNetworkRequest request;
    request.setUrl(Url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QNetworkAccessManager *restclient;
    restclient = new QNetworkAccessManager(this);
    QNetworkReply *reply = restclient->post(request, payload);
    qDebug() << reply->readAll();

    return true;
}

QString Settings::RestAPIGetCall(QString apiURL, QUrlQuery urlQuery){

    QUrl Url;
    Url.setScheme("http");
    Url.setHost("localhost");
    Url.setPort(8080);
    Url.setPath(apiURL);
    Url.setQuery(urlQuery);

    QNetworkRequest request;
    request.setUrl(Url);

    QNetworkAccessManager *restclient;
    restclient = new QNetworkAccessManager(this);
    QNetworkReply *reply = restclient->get(request);
    qDebug() << reply->readAll();

    return reply->readAll();
}

QSqlDatabase Settings::OpenDBConnection(){
    // Development database in use
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("/Users/tuukkapeltoniemi/Documents-NotCloud/Development/XtraBytes/xcite-tuukkapel/XCITE/dev-db/xtrabytes");

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
