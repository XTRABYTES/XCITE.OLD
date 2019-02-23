/**
 * Filename: Settings.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef SETTINGS_HPP
#define SETTINGS_HPP

#include <QObject>
#include <QTranslator>
#include <QCoreApplication>
#include <QQmlApplicationEngine>
#include <QSettings>
#include <QtSql>
#include <QDateTime>
#include <QNetworkReply>
#include "qaesencryption.h"

class Settings : public QObject
{
    Q_OBJECT

public:
    Settings(QObject *parent = 0);
    Settings(QQmlApplicationEngine *engine, QSettings *settings, QObject *parent = 0);
    void setLocale(QString);
    QString CheckStatusCode(QString);
    void SaveFile(QString, QString);
    QString LoadFile(QString);




public slots:
    void onLocaleChange(QString);
    void onClearAllSettings();
    void login(QString username, QString password);
    bool SaveSettings();
    void LoadSettings(QByteArray settings);
    bool UserExists(QString username);
    void CreateUser(QString username, QString password);
    void SaveAddresses(QString addresslist);
    void SaveContacts(QString contactlist);
    void SaveWallet(QString walletlist);

    void onSavePincode(QString pincode);
    bool checkPincode(QString pincode);
    QString RestAPIPostCall(QString apiURL, QByteArray payload);
    QString RestAPIPutCall(QString apiURL, QByteArray payload);
    QByteArray RestAPIGetCall(QString apiURL);


signals:
    void loginSucceededChanged();
    void loginFailedChanged();
    void userCreationSucceeded();
    void userCreationFailed();
    void userAlreadyExists();
    void usernameAvailable();
    void settingsServerError();
    void contactsLoaded(const QString &contacts);
    void addressesLoaded(const QString &addresses);
    void settingsLoaded(const QVariantMap &settings);
    void walletLoaded(const QString &wallets);
    void clearSettings();
    void pincodeCorrect();
    void pincodeFalse();
    void saveSucceeded();
    void saveFailed();



private:
    QTranslator m_translator;
    QQmlApplicationEngine *m_engine;
    QSettings *m_settings;
    QString m_addresses;
    QString m_contacts;
    QString m_wallet;
    QString m_pincode;
    QString m_username;
    QString m_password;

};

#endif // SETTINGS_HPP
