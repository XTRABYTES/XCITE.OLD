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
#include "../backend/integrations/xutility_integration.hpp"
#include "../backend/integrations/staticnet_integration.hpp"

int main(int argc, char *argv[])
{

    QZXing::registerQMLTypes();
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    app.setOrganizationName("Xtrabytes");
    app.setOrganizationDomain("xtrabytes.global");
    app.setApplicationName("XCITE");

//    app.setFont(QFont("Roboto")); !!! FIXMEEE need load the font from resources before set
       
// load font example       
    Q_INIT_RESOURCE(resources);
    QFile file(":/dejavusans"); 
    if(!file.open(QIODevice::ReadOnly)) {
       qDebug()<<"filenot opened"<<endl;
    } else {
        int fontId = QFontDatabase::addApplicationFontFromData(file.readAll());
        if (fontId != -1) {
            QFont font("DefaultFont");
            app.setFont(font);
        }
    }
    file.close();
// end example

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

    // wire-up testnet wallet
    Testnet wallet;
    engine.rootContext()->setContextProperty("wallet", &wallet);

    // wire-up market value
    MarketValue marketValue;
    engine.rootContext()->setContextProperty("marketValue", &marketValue);

    // wire-up Explorer
    Explorer explorer;
    engine.rootContext()->setContextProperty("explorer", &explorer);

    // wire-up xutility_integration
    xutility_integration xUtil_int;
    engine.rootContext()->setContextProperty("xUtil_int", &xUtil_int);    
    engine.rootContext()->setContextProperty("xUtility", &xUtility);

    // wire-up staticnet_integration
    staticNet.Initialize();
    engine.rootContext()->setContextProperty("StaticNet", &staticNet);
    staticnet_integration static_int;
    engine.rootContext()->setContextProperty("static_int", &static_int);


    // wire-up ClipboardProxy
    ClipboardProxy clipboardProxy;
    engine.rootContext()->setContextProperty("clipboardProxy", &clipboardProxy);

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

    QObject::connect(rootObject, SIGNAL(checkOS()), &settings, SLOT(onCheckOS()));
    QObject::connect(rootObject, SIGNAL(userLogin(QString, QString)), &settings, SLOT(login(QString, QString)));
    QObject::connect(rootObject, SIGNAL(createUser(QString, QString)), &settings, SLOT(CreateUser(QString, QString)));
    QObject::connect(rootObject, SIGNAL(userExists(QString)), &settings, SLOT(UserExists(QString)));
    QObject::connect(rootObject, SIGNAL(localeChange(QString)), &settings, SLOT(onLocaleChange(QString)));
    QObject::connect(rootObject, SIGNAL(clearAllSettings()), &settings, SLOT(onClearAllSettings()));
    QObject::connect(rootObject, SIGNAL(initialisePincode(QString)), &settings, SLOT(initialisePincode(QString)));
    QObject::connect(rootObject, SIGNAL(savePincode(QString)), &settings, SLOT(onSavePincode(QString)));
    QObject::connect(rootObject, SIGNAL(checkPincode(QString)), &settings, SLOT(checkPincode(QString)));
    QObject::connect(rootObject, SIGNAL(saveAddressBook(QString)), &settings, SLOT(SaveAddresses(QString)));
    QObject::connect(rootObject, SIGNAL(saveContactList(QString)), &settings, SLOT(SaveContacts(QString)));
    QObject::connect(rootObject, SIGNAL(saveAppSettings()), &settings, SLOT(SaveSettings()));
    QObject::connect(rootObject, SIGNAL(saveWalletList(QString, QString)), &settings, SLOT(SaveWallet(QString, QString)));
    QObject::connect(rootObject, SIGNAL(updateAccount(QString, QString, QString, QString)), &settings, SLOT(UpdateAccount(QString, QString, QString, QString)));
    QObject::connect(rootObject, SIGNAL(importAccount(QString, QString)), &settings, SLOT(ImportWallet(QString,QString)));
    QObject::connect(rootObject, SIGNAL(exportAccount(QString)), &settings, SLOT(ExportWallet(QString)));
    QObject::connect(rootObject, SIGNAL(checkSessionId()), &settings, SLOT(CheckSessionId()));
    QObject::connect(rootObject, SIGNAL(checkCamera()), &settings, SLOT(CheckCamera()));
    QObject::connect(rootObject, SIGNAL(changePassword(QString, QString)), &settings, SLOT(changePassword(QString, QString)));


    // connect QML signals for market value
    QObject::connect(rootObject, SIGNAL(marketValueChangedSignal(QString)), &marketValue, SLOT(findCurrencyValue(QString)));

    // connect QML signals for Explorer
    QObject::connect(rootObject, SIGNAL(updateBalanceSignal(QString, QString)), &explorer, SLOT(getBalanceEntireWallet(QString, QString)));
    QObject::connect(rootObject, SIGNAL(updateTransactions(QString, QString, QString)), &explorer, SLOT(getTransactionList(QString, QString, QString)));
    QObject::connect(rootObject, SIGNAL(getDetails(QString, QString)), &explorer, SLOT(getDetails(QString, QString)));
    QObject::connect(rootObject, SIGNAL(walletUpdate(QString, QString, QString)), &explorer, SLOT(WalletUpdate(QString, QString, QString)));
    QObject::connect(rootObject, SIGNAL(checkTxStatus(QString)), &explorer, SLOT(checkTxStatus(QString)));

    // connect QML signal for ClipboardProxy
    QObject::connect(rootObject, SIGNAL(copyText2Clipboard(QString)), &clipboardProxy, SLOT(copyText2Clipboard(QString)));

    // connect QML signals for walletFunctions
    QObject::connect(rootObject, SIGNAL(createKeyPair(QString)), &xUtility, SLOT(createKeypairEntry(QString)));
    QObject::connect(rootObject, SIGNAL(importPrivateKey(QString, QString)), &xUtility, SLOT(importPrivateKeyEntry(QString, QString)));
    QObject::connect(rootObject, SIGNAL(helpMe()), &xUtility, SLOT(helpEntry()));
    QObject::connect(rootObject, SIGNAL(sendCoins(QString)), &static_int, SLOT(sendCoinsEntry(QString)));
    QObject::connect(&staticNet, SIGNAL(ResponseFromStaticnet(QJsonObject)), &static_int, SLOT(onResponseFromStaticnetEntry(QJsonObject)),Qt::QueuedConnection);      
    QObject::connect(rootObject, SIGNAL(setNetwork(QString)), &xUtility, SLOT(networkEntry(QString)));

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
