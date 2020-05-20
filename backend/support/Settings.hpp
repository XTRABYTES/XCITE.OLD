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
#include "DownloadManager.hpp"
#include <openssl/rsa.h>
#include <string>
#include <iostream>
#include "../xutility/BrokerConnection.h"

class Settings : public QObject
{
    Q_OBJECT

public:
    Settings(QObject *parent = 0);
    Settings(QQmlApplicationEngine *engine, QSettings *settings, QObject *parent = 0);
    void setLocale(QString);
    QString CheckStatusCode(QString);
    void SaveFile(QString, QString, QString);
    void BackupFile(QString, QString, QString);
    QString LoadFile(QString, QString);
    std::pair<QByteArray, QByteArray> createKeyPair();
    int rsaEncrypt(const unsigned char *message, size_t messageLength, unsigned char **encryptedMessage, unsigned char **encryptedKey,
          size_t *encryptedKeyLength, unsigned char **iv, size_t *ivLength);

    std::pair<int, QByteArray> encryptAes(QString text, unsigned char *key, unsigned char *iv);
    RSA * createRSA(unsigned char * key,int public1);
    QString createRandNum();
    void loginFile(QString username, QString password, QString fileLocation);
    void NoWalletFile();
    void NoBackupFile();
    void DownloadManagerHandler(URLObject *url);

public slots:
    void onLocaleChange(QString);
    void onClearAllSettings();
    void login(QString username, QString password);
    void changePassword(QString oldPassword, QString newPassword);

    bool SaveSettings();
    void ImportWallet(QString, QString);
    void RestoreAccount(QString, QString);
    void LoadSettings(QByteArray settings, QString location);
    bool UserExists(QString username);
    void CreateUser(QString username, QString password);
    void SaveAddresses(QString addresslist);
    void SaveContacts(QString contactlist);
    void SaveWallet(QString walletlist, QString addresslist);
    void ExportWallet(QString walletlist);
    void UpdateAccount(QString addresslist, QString contactlist, QString walletlist, QString pendinglist);
    bool checkInternet(QString url);

    void onCheckOS();
    void initialisePincode(QString pincode);
    void onSavePincode(QString pincode);
    bool checkPincode(QString pincode);
    QString RestAPIPostCall(QString apiURL, QByteArray payload);
    void CheckSessionId();
    void CheckCamera();
    void CheckWriteAccess();

    void downloadImage(QString imgUrl);
    void DownloadManagerRouter(QByteArray,QMap<QString,QVariant>);
    void internetTimeout(QMap<QString,QVariant>);
    void userExistsSlot(QByteArray,QMap<QString,QVariant>);
    void checkInternetSlot(QByteArray,QMap<QString,QVariant>);
    void apiPostSlot(QByteArray,QMap<QString,QVariant>);

signals:
    void oSReturned(const QString os);
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
    void pendingLoaded(const QString &pending);
    void noInternet();
    void clearSettings();
    void pincodeCorrect();
    void pincodeFalse();
    void saveSucceeded();
    void saveFailed();
    void saveFileSucceeded();
    void saveFileFailed();
    void sessionIdCheck(const QString &sessionAlive);
    void checkUsername();
    void createUniqueKeyPair();
    void receiveSessionEncryptionKey();
    void saveAccountSettings();
    void checkIdentity();
    void receiveSessionID();
    void loadingSettings();
    void saveFailedDBError();
    void saveFailedAPIError();
    void saveFailedInputError();
    void saveFailedUnknownError();
    void walletNotFound();
    void settingsNotFound();
    void cameraCheckFailed();
    void cameraCheckPassed();
    void writeCheckFailed();
    void writeCheckPassed();
    void passwordChangedSucceeded();
    void passwordChangedFailed();
    void xchatConnectedLogin(QString username, QString route, QString status);
    void userExistsSignal(bool);
    void internetStatusSignal(bool);
    void apiPostSignal(bool,QByteArray);

private:
    QTranslator m_translator;
    QQmlApplicationEngine *m_engine;
    QSettings *m_settings;
    QString m_addresses;
    QString m_contacts;
    QString m_wallet;
    QString m_pending;
    QString m_oldPincode;
    QString m_pincode;
    QString m_username;
    QString m_password;
    QString sessionId;
    std::pair<QByteArray,QByteArray> keyPair;
    unsigned char backendKey[32];
    unsigned char iiiv[16];
    bool internetActive = true;
    QQueue<int> saveSettingsQueue;
    int settingsCount = 0;
};

#endif // SETTINGS_HPP
