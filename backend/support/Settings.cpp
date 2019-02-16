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
    QString url = "/v1/user/" + username;

    QString userinfo = RestAPIGetCall(url, queryString);
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

    QVariantMap settings;
    settings.insert("app","xtrabytes");
    QByteArray settingsByte =  QJsonDocument::fromVariant(settings).toJson(QJsonDocument::Compact);
    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB);

    QByteArray encodedText = encryption.encode(settingsByte, (password + "xtrabytesxtrabytes").toLatin1());
    QString DataAsString = QString::fromLatin1(encodedText, encodedText.length());

    QVariantMap feed;
    feed.insert("dateCreated", QDateTime::currentDateTime());
    feed.insert("dateUpdated", QDateTime::currentDateTime());
    feed.insert("settings", DataAsString);
    feed.insert("username", username);
    feed.insert("id", "1");

    QByteArray payload =  QJsonDocument::fromVariant(feed).toJson(QJsonDocument::Compact);
    QByteArray decodedSettings = encryption.decode(DataAsString.toLatin1(), (password + "xtrabytesxtrabytes").toLatin1());

    QJsonDocument decodedJsonDoc = QJsonDocument::fromJson(decodedSettings);
    QJsonObject jsonObj = decodedJsonDoc.object();
    QJsonValue jsonVal = jsonObj.value("app");

    bool success = RestAPIPostCall("/v1/user", payload);

    if (UserExists(username))
        emit userCreationSucceeded();
    else
        emit userCreationFailed();

}

void Settings::login(QString username, QString password){
    QUrlQuery queryString;
    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB);
    QString url = "/v1/user/" + username;

    QByteArray result = RestAPIGetCall(url, queryString);
    QByteArray settings = QJsonDocument::fromJson(result).array()[0].toString().toLatin1(); //JSON is returned as a one item array.  Item is the settings value
    QString DataAsString = QString::fromLatin1(settings, settings.length()); //adding settings.length or string is truncated


    QByteArray decodedSettings = encryption.decode(DataAsString.toLatin1(), (password + "xtrabytesxtrabytes").toLatin1());
    int pos = decodedSettings.lastIndexOf(QChar('}')); // find last bracket to mark the end of the json
    decodedSettings = decodedSettings.left(pos+1); //remove everything after the valid json

    QJsonObject decodedJson = QJsonDocument::fromJson(decodedSettings).object();

    if(decodedJson.value("app").toString().startsWith("xtrabytes")){
        m_username = username;
        m_password = password;
        LoadSettings(decodedSettings);
        SaveSettings(); //added here for testing Saving - Don't need it later
        emit loginSucceededChanged();
    }
    else
        emit loginFailedChanged();
}

// User setting functions
bool Settings::SaveSettings(){
    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB);
    QVariantMap settings;

    foreach (const QString &key, m_settings->childKeys()) {//iterate through m_settings to add everything to settings file we write to DB
        qDebug() << key << "and" << m_settings->value(key).toString();
        settings.insert(key,m_settings->value(key).toString());
    }
    settings.insert("pincode", m_pincode); //may be able to remove this

    QByteArray settingsByte =  QJsonDocument::fromVariant(settings).toJson(QJsonDocument::Compact);

    QByteArray encodedText = encryption.encode(settingsByte, (m_password + "xtrabytesxtrabytes").toLatin1());
    QString DataAsString = QString::fromLatin1(encodedText, encodedText.length());

    QVariantMap feed;
    feed.insert("dateUpdated", QDateTime::currentDateTime());
    feed.insert("settings", DataAsString); //only updating time and settings
    // <TODO>
    // Add POST method to update settings based on username
    return true;
}

void Settings::LoadSettings(QByteArray settings){
    QJsonObject json = QJsonDocument::fromJson(settings).object();
    foreach(const QString& key, json.keys()) {
            QJsonValue value = json.value(key);
            m_settings->setValue(key,value.toString());
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

    QEventLoop loop;
    connect(reply, SIGNAL(finished()), &loop, SLOT(quit()));
    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)), &loop, SLOT(quit()));
    loop.exec(); // Adding a loop makes the request go through now.  Prevents user creation being delayed and future GET request not seeing it
    qDebug() << reply->readAll();
    qDebug() << payload;

    return true;
}

QByteArray Settings::RestAPIGetCall(QString apiURL, QUrlQuery urlQuery){

    QUrl Url;
    Url.setScheme("http");
    Url.setHost("localhost");
    Url.setPort(8080);
    Url.setPath(apiURL);

    QNetworkRequest request;
    request.setUrl(Url);

    QNetworkAccessManager *restclient;
    restclient = new QNetworkAccessManager(this);
    request.setRawHeader("Accept", "application/json");

    QNetworkReply *reply = restclient->get(request);
    QByteArray bytes = reply->readAll();

    qDebug() << bytes;

     QEventLoop loop;
     connect(reply, SIGNAL(finished()), &loop, SLOT(quit()));
     connect(reply, SIGNAL(error(QNetworkReply::NetworkError)), &loop, SLOT(quit()));
     loop.exec();

     QByteArray bts = reply->readAll();

    return bts;
}

QSqlDatabase Settings::OpenDBConnection(){
    // Development database in use
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("XCITE/dev-db/xtrabytes");

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
