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
#include "../backend/staticnet/staticnet.hpp"
#include "../backend/xutility/xutility.hpp"
#include "../backend/XCITE/nodes/nodetransaction.h"
#include "../backend/addressbook/addressbookmodel.hpp"
#include "../backend/support/ClipboardProxy.hpp"
#include "../backend/testnet/testnet.hpp"
#include "../backend/support/globaleventfilter.hpp"
#include "../backend/support/Settings.hpp"
#include "../backend/support/ReleaseChecker.hpp"
#include "../backend/integrations/MarketValue.hpp"
#include "../backend/integrations/Explorer.hpp"

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
        
    xchatRobot.Initialize();
    engine.rootContext()->setContextProperty("XChatRobot", &xchatRobot);
        
    staticNet.Initialize();
    engine.rootContext()->setContextProperty("StaticNet", &staticNet);    

    Xutility xUtil;
    engine.rootContext()->setContextProperty("xUtil", &xUtil);

    // wire-up testnet wallet
    Testnet wallet;
    engine.rootContext()->setContextProperty("wallet", &wallet);

    // wire-up market value
    MarketValue marketValue;
    engine.rootContext()->setContextProperty("marketValue", &marketValue);

    // wire-up Explorer
    Explorer explorer;
    engine.rootContext()->setContextProperty("explorer", &explorer);

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
    QObject::connect(rootObject, SIGNAL(saveAppSettings()), &settings, SLOT(SaveSettings()));
    QObject::connect(rootObject, SIGNAL(saveWalletList(QString)), &settings, SLOT(SaveWallet(QString)));


    // connect QML signals for market value
    QObject::connect(rootObject, SIGNAL(marketValueChangedSignal(QString)), &marketValue, SLOT(findCurrencyValue(QString)));

    // connect QML signals for Explorer
    QObject::connect(rootObject, SIGNAL(updateBalanceSignal(QString)), &explorer, SLOT(getBalanceEntireWallet(QString)));

    // connect QML signals for xUtility
    QObject::connect(rootObject, SIGNAL(createKeyPair(QString)), &xUtil, SLOT(createKeyPairEntry(QString)));

    // Fetch currency values
    marketValue.findAllCurrencyValues();

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
