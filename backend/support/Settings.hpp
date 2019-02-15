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

public slots:
    void onLocaleChange(QString);
    void onClearAllSettings();
    void login(QString username, QString password);
    bool SaveSettings();
    void LoadSettings();
    bool UserExists(QString username);
    void CreateUser(QString username, QString password);
    void SaveAddresses(QString addresslist);
    void onSavePincode(QString pincode);
    bool checkPincode(QString pincode);
    bool RestAPIPostCall(QString apiURL, QByteArray payload);
    QByteArray RestAPIGetCall(QString apiURL, QUrlQuery urlQuery);

signals:
    void loginSucceededChanged();
    void loginFailedChanged();
    void userCreationSucceeded();
    void userCreationFailed();
    void userAlreadyExists();
    void usernameAvailable();
    void settingsServerError();

private:
    QTranslator m_translator;
    QQmlApplicationEngine *m_engine;
    QSettings *m_settings;
    QString m_addresses;
    QString m_pincode;
    QString m_username;
    QString m_password;

private slots:
    QSqlDatabase OpenDBConnection();

};

#endif // SETTINGS_HPP
