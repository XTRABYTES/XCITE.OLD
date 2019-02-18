/**
 * Filename: main.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickWindow>
#include <QQmlFileSelector>
#include <QSettings>
#include <QThread>
#include <QFont>
#include <qqmlcontext.h>
#include <qqml.h>
#include <QZXing.h>
#include "../backend/xchat/xchat.hpp"
#include "../backend/xchat/xchatconversationmodel.hpp"
#include "../backend/XCITE/nodes/nodetransaction.h"
#include "../backend/addressbook/addressbookmodel.hpp"
#include "../backend/support/ClipboardProxy.hpp"
#include "../backend/testnet/testnet.hpp"
#include "../backend/support/globaleventfilter.hpp"
#include "../backend/support/Settings.hpp"
#include "../backend/support/ReleaseChecker.hpp"
#include "../backend/integrations/MarketValue.hpp"

int main(int argc, char *argv[])
{

    QZXing::registerQMLTypes();
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    app.setOrganizationName("Xtrabytes");
    app.setOrganizationDomain("xtrabytes.global");
    app.setApplicationName("XCITE");
    app.setFont(QFont("Roboto"));
    app.setWindowIcon(QIcon("xcite.ico"));

    GlobalEventFilter eventFilter;
    app.installEventFilter(&eventFilter);

    qmlRegisterType<Xchat>("xtrabytes.xcite.xchat", 1, 0, "Xchat");
    qmlRegisterType<XChatConversationModel>("XChatConversationModel", 0, 1, "XChatConversationModel");
    qmlRegisterType<AddressBookModel>("AddressBookModel", 0, 1, "AddressBookModel");
    qmlRegisterType<ClipboardProxy>("Clipboard", 1, 0, "Clipboard");
    qmlRegisterType<Settings>("xtrabytes.xcite.settings", 1, 0, "XCiteSettings");

    QQmlApplicationEngine engine;
    QZXing::registerQMLImageProvider(engine);
    engine.addImportPath("qrc:/");

#if defined(Q_OS_ANDROID) || defined(Q_OS_IOS)
    QQmlFileSelector *selector = new QQmlFileSelector(&engine);
    selector->setExtraSelectors(QStringList() << "mobile");
#endif

    XchatObject xchatRobot;
    xchatRobot.Initialize();
    engine.rootContext()->setContextProperty("XChatRobot", &xchatRobot);

    // wire-up testnet wallet
    Testnet wallet;
    engine.rootContext()->setContextProperty("wallet", &wallet);

    // wire-up market value
    MarketValue marketValue;
    engine.rootContext()->setContextProperty("marketValue", &marketValue);

	// set app version
    QString APP_VERSION = QString("%1.%2.%3").arg(VERSION_MAJOR).arg(VERSION_MINOR).arg(VERSION_BUILD);
    engine.rootContext()->setContextProperty("AppVersion", APP_VERSION);

    // register event filter
    engine.rootContext()->setContextProperty("EventFilter", &eventFilter);

    ReleaseChecker releaseChecker(APP_VERSION);
    engine.rootContext()->setContextProperty("ReleaseChecker", &releaseChecker);
    releaseChecker.checkForUpdate();

    QSettings appSettings;
    Settings settings(&engine, &appSettings);
    engine.rootContext()->setContextProperty("UserSettings", &settings);

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    QObject *rootObject = engine.rootObjects().first();

    QObject::connect(rootObject, SIGNAL(userLogin(QString, QString)), &settings, SLOT(login(QString, QString)));
    QObject::connect(rootObject, SIGNAL(createUser(QString, QString)), &settings, SLOT(CreateUser(QString, QString)));
    QObject::connect(rootObject, SIGNAL(userExists(QString)), &settings, SLOT(UserExists(QString)));
    QObject::connect(rootObject, SIGNAL(localeChange(QString)), &settings, SLOT(onLocaleChange(QString)));
    QObject::connect(rootObject, SIGNAL(clearAllSettings()), &settings, SLOT(onClearAllSettings()));
    QObject::connect(rootObject, SIGNAL(savePincode(QString)), &settings, SLOT(onSavePincode(QString)));
    QObject::connect(rootObject, SIGNAL(checkPincode(QString)), &settings, SLOT(checkPincode(QString)));
    QObject::connect(rootObject, SIGNAL(saveAddressBook(QString)), &settings, SLOT(SaveAddresses(QString)));
    QObject::connect(rootObject, SIGNAL(saveContactList(QString)), &settings, SLOT(SaveContacts(QString)));
    QObject::connect(rootObject, SIGNAL(saveAppSettings()), &settings, SLOT(saveSettings()));



    // connect QML signals for market value
    QObject::connect(rootObject, SIGNAL(marketValueChangedSignal(QString)), &marketValue, SLOT(findXBYValue(QString)));

    // Set defaultCurrency
    if(appSettings.contains("defaultCurrency")){
        marketValue.findXBYValue(appSettings.value("defaultCurrency").toString());
        marketValue.findBTCValue(appSettings.value("defaultCurrency").toString());
    }
    else{
        marketValue.findXBYValue("USD");
        marketValue.findBTCValue("USD");
    }

    // Set last locale
    settings.setLocale(appSettings.value("locale").toString());

#if defined(Q_OS_ANDROID) || defined(Q_OS_IOS)
#else
    // X-Chat
    wallet.m_xchatobject = &xchatRobot;

    // FauxWallet
    QObject::connect(&wallet, SIGNAL(response(QVariant)), rootObject, SLOT(testnetResponse(QVariant)));
    QObject::connect(&wallet, SIGNAL(walletError(QVariant, QVariant)), rootObject, SLOT(walletError(QVariant, QVariant)));
    QObject::connect(&wallet, SIGNAL(walletSuccess(QVariant)), rootObject, SLOT(walletSuccess(QVariant)));
#endif

    return app.exec();
}
