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
#include <QDebug>
#include "../backend/staticnet/staticnet.hpp"
#include "../backend/xutility/xutility.hpp"
#include "../backend/xchat/xchat.hpp"
#include "../backend/xgames/XGames.hpp"
#include "../backend/XCITE/nodes/nodetransaction.h"
#include "../backend/addressbook/addressbookmodel.hpp"
#include "../backend/support/ClipboardProxy.hpp"
#include "../backend/support/globaleventfilter.hpp"
#include "../backend/support/Settings.hpp"
#include "../backend/support/ReleaseChecker.hpp"
#include "../backend/integrations/MarketValue.hpp"
#include "../backend/integrations/Explorer.hpp"
#include "../backend/integrations/Cex.hpp"
#include "../backend/integrations/xutility_integration.hpp"
#include "../backend/integrations/staticnet_integration.hpp"
#include "../backend/support/ttt.h"
#include "../backend/support/pdfprinter.hpp"
#include "../backend/xutility/BrokerConnection.h"

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

    //qmlRegisterType<AddressBookModel>("AddressBookModel", 0, 1, "AddressBookModel");
    qmlRegisterType<ClipboardProxy>("Clipboard", 1, 0, "Clipboard");
    qmlRegisterType<Settings>("xtrabytes.xcite.settings", 1, 0, "XCiteSettings");

    QQmlApplicationEngine engine;
    QZXing::registerQMLImageProvider(engine);
    engine.addImportPath("qrc:/");

//#if defined(Q_OS_ANDROID) || defined(Q_OS_IOS)
//    qDebug() << "MOBILE DEVICE";
//    QQmlFileSelector *selector = new QQmlFileSelector(&engine);
//    selector->setExtraSelectors(QStringList() << "mobile");
//#endif

    // wire-up market value
    MarketValue marketValue;
    engine.rootContext()->setContextProperty("marketValue", &marketValue);
    qDebug() << "MARKETVALUE WIRED UP";

    // wire-up Explorer
    Explorer explorer;
    engine.rootContext()->setContextProperty("explorer", &explorer);

    // wire-up cex
    Cex cex;
    engine.rootContext()->setContextProperty("cex", &cex);
    qDebug() << "CEX WIRED UP";

    // wire-up xutility_integration
    xutility_integration xUtil_int;
    engine.rootContext()->setContextProperty("xUtil_int", &xUtil_int);    
    engine.rootContext()->setContextProperty("xUtility", &xUtility);
    qDebug() << "XUTILITY WIRED UP";

    // wire-up xchat
    // XchatObject xChat;
    xchatRobot.Initialize();
    engine.rootContext()->setContextProperty("xChat", &xchatRobot);
    qDebug() << "XCHAT WIRED UP";

    broker.Initialize();
    engine.rootContext()->setContextProperty("broker",&broker);
    if (broker.isConnected()) {
        qDebug() << "Broker WIRED UP";
    }

    xgames.Initialize();
    engine.rootContext()->setContextProperty("xGames", &xgames);
    qDebug() << "XGames WIRED UP";

    // wire-up staticnet_integration
    staticNet.Initialize();
    engine.rootContext()->setContextProperty("StaticNet", &staticNet);
    staticnet_integration static_int;
    engine.rootContext()->setContextProperty("static_int", &static_int);
    qDebug() << "STATICNET WIRED UP";


    // wire-up ClipboardProxy
    ClipboardProxy clipboardProxy;
    engine.rootContext()->setContextProperty("clipboardProxy", &clipboardProxy);
    qDebug() << "CLIPBOARD WIRED UP";

    // wire-up Tictactoe
    Ttt tictactoe;
    engine.rootContext()->setContextProperty("tictactoe", &tictactoe);
    qDebug() << "TTT WIRED UP";

    // wire-up pdf printer
    pdfPrinter pdfprinter;
    engine.rootContext()->setContextProperty("pdfprinter", &pdfprinter);
    qDebug() << "pdf printer WIRED UP";

    // set app version
    QString APP_VERSION = QString("%1.%2.%3").arg(VERSION_MAJOR).arg(VERSION_MINOR).arg(VERSION_BUILD);
    engine.rootContext()->setContextProperty("AppVersion", APP_VERSION);
    qDebug() << "APP VERSION SET";

    // register event filter
    engine.rootContext()->setContextProperty("EventFilter", &eventFilter);
    qDebug() << "EVENT FILTER SET";

    //ReleaseChecker releaseChecker(APP_VERSION);
    //engine.rootContext()->setContextProperty("ReleaseChecker", &releaseChecker);
    //releaseChecker.checkForUpdate();

    QSettings appSettings;
    Settings settings(&engine, &appSettings);
    engine.rootContext()->setContextProperty("UserSettings", &settings);
    qDebug() << "USER SETTINGS SET";

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }
    qDebug() << "MAIN.QML LOADED";

    QObject *rootObject = engine.rootObjects().first();

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
    QObject::connect(rootObject, SIGNAL(restoreAccount(QString, QString)), &settings, SLOT(RestoreAccount(QString,QString)));
    QObject::connect(rootObject, SIGNAL(exportAccount(QString)), &settings, SLOT(ExportWallet(QString)));
    QObject::connect(rootObject, SIGNAL(checkSessionId()), &settings, SLOT(CheckSessionId()));
    QObject::connect(rootObject, SIGNAL(checkCamera()), &settings, SLOT(CheckCamera()));
    QObject::connect(rootObject, SIGNAL(checkWriteAccess()), &settings, SLOT(CheckWriteAccess()));
    QObject::connect(rootObject, SIGNAL(changePassword(QString, QString)), &settings, SLOT(changePassword(QString, QString)));
    QObject::connect(rootObject, SIGNAL(downloadImage(QString)), &settings, SLOT(downloadImage(QString)));


    // connect QML signals for market value
    QObject::connect(rootObject, SIGNAL(marketValueChangedSignal(QString)), &marketValue, SLOT(findCurrencyValue(QString)));
    QObject::connect(rootObject, SIGNAL(findAllMarketValues()), &marketValue, SLOT(findAllCurrencyValues()));

    // connect QML signals for Explorer access
    QObject::connect(rootObject, SIGNAL(updateBalanceSignal(QString, QString)), &explorer, SLOT(getBalanceEntireWallet(QString, QString)));
    QObject::connect(rootObject, SIGNAL(updateTransactions(QString, QString, QString)), &explorer, SLOT(getTransactionList(QString, QString, QString)));
    QObject::connect(rootObject, SIGNAL(getDetails(QString, QString)), &explorer, SLOT(getDetails(QString, QString)));
    QObject::connect(rootObject, SIGNAL(walletUpdate(QString, QString, QString)), &explorer, SLOT(WalletUpdate(QString, QString, QString)));
    QObject::connect(rootObject, SIGNAL(checkTxStatus(QString)), &explorer, SLOT(checkTxStatus(QString)));

    // connect QML signals for Cex access
    QObject::connect(rootObject, SIGNAL(getCoinInfo(QString, QString)), &cex, SLOT(getCoinInfo(QString, QString)));
    QObject::connect(rootObject, SIGNAL(getRecentTrades(QString, QString, QString)), &cex, SLOT(getRecentTrades(QString, QString, QString)));
    QObject::connect(rootObject, SIGNAL(getOrderBook(QString, QString)), &cex, SLOT(getOrderBook(QString, QString)));
    QObject::connect(rootObject, SIGNAL(getOlhcv(QString, QString, QString)), &cex, SLOT(getOlhcv(QString, QString, QString)));
    QObject::connect(rootObject, SIGNAL(updateOlhcv(QString)), &cex, SLOT(updateOlhcv(QString)));

    // connect QML signal for ClipboardProxy
    QObject::connect(rootObject, SIGNAL(copyText2Clipboard(QString)), &clipboardProxy, SLOT(copyText2Clipboard(QString)));

    // connect QML signals for walletFunctions
    QObject::connect(rootObject, SIGNAL(createKeyPair(QString)), &xUtility, SLOT(createKeypairEntry(QString)));
    QObject::connect(rootObject, SIGNAL(importPrivateKey(QString, QString)), &xUtility, SLOT(importPrivateKeyEntry(QString, QString)));
    QObject::connect(rootObject, SIGNAL(helpMe()), &xUtility, SLOT(helpEntry()));
    QObject::connect(rootObject, SIGNAL(sendCoins(QString)), &static_int, SLOT(sendCoinsEntry(QString)));
    QObject::connect(&staticNet, SIGNAL(ResponseFromStaticnet(QJsonObject)), &static_int, SLOT(onResponseFromStaticnetEntry(QJsonObject)),Qt::QueuedConnection);      
    QObject::connect(rootObject, SIGNAL(setNetwork(QString)), &xUtility, SLOT(networkEntry(QString)));

    // connect QML signals for dicom
    QObject::connect(rootObject, SIGNAL(dicomRequest(QString)), &static_int, SLOT(dicomRequestEntry(QString)));
    QObject::connect(rootObject, SIGNAL(clearUtxoList()), &static_int, SLOT(clearUtxoList()));
    QObject::connect(rootObject, SIGNAL(setQueue(QString)), &static_int, SLOT(setQueue(QString)));
    QObject::connect(rootObject, SIGNAL(requestQueue()), &static_int, SLOT(requestQueue()));

    //QObject::connect(rootObject, SIGNAL(staticPopup(QString, QString)), &staticNet, SLOT(staticPopup(QString, QString)));

    // connect QML signals for pdfprinter

    // connect signals for X-CHAT
    QObject::connect(rootObject, SIGNAL(xChatSend(QString,QString,QString,QString, QString, QString, QString)), &xchatRobot, SLOT(xchatInc(QString,QString,QString,QString, QString, QString, QString)));
    QObject::connect(rootObject, SIGNAL(xChatTypingSignal(QString,QString,QString)), &xchatRobot, SLOT(sendTypingToQueue(QString,QString,QString)));
    QObject::connect(rootObject, SIGNAL(checkXChatSignal()), &xchatRobot, SLOT(mqtt_StateChanged()));
    QObject::connect(&settings, SIGNAL(xchatConnectedLogin(QString,QString,QString)), &xchatRobot, SLOT(sendTypingToQueue(QString,QString,QString)));
    QObject::connect(rootObject, SIGNAL(pingXChatServers()), &xchatRobot, SLOT(pingXchatServers()));
    QObject::connect(rootObject, SIGNAL(xChatReconnect()), &xchatRobot, SLOT(forcedReconnect()));
    QObject::connect(rootObject, SIGNAL(xchatPopup(QString,QString)), &xchatRobot, SLOT(xchatPopup(QString,QString)));
    //QObject::connect(rootObject, SIGNAL(sendGameToQueue(QString,QString,QString,QString)), &xgames, SLOT(sendGameToQueue(QString,QString,QString,QString)));
    //QObject::connect(rootObject, SIGNAL(confirmGameSend(QString,QString,QString,QString,QString)), &xgames, SLOT(confirmGameSend(QString,QString,QString,QString,QString)));
    //QObject::connect(rootObject, SIGNAL(sendGameInvite(QString,QString,QString,QString)), &xgames, SLOT(sendGameInvite(QString,QString,QString,QString)));
    //QObject::connect(rootObject, SIGNAL(confirmGameInvite(QString,QString,QString,QString,QString)), &xgames, SLOT(confirmGameInvite(QString,QString,QString,QString,QString)));

    // connect signals for TTT
    QObject::connect(rootObject, SIGNAL(tttSetUsername(QString)), &tictactoe, SLOT(setUsername(QString)));
    QObject::connect(rootObject, SIGNAL(tttGetScore()), &tictactoe, SLOT(getScore()));
    QObject::connect(rootObject, SIGNAL(tttResetScore(QString,QString,QString)), &tictactoe, SLOT(resetScore(QString,QString,QString)));
    QObject::connect(rootObject, SIGNAL(tttNewGame()), &tictactoe, SLOT(newGame()));
    QObject::connect(rootObject, SIGNAL(tttQuitGame()), &tictactoe, SLOT(quitGame()));
    QObject::connect(rootObject, SIGNAL(tttGetMoveID(QString)), &tictactoe, SLOT(getMoveID(QString)));
    QObject::connect(rootObject, SIGNAL(tttButtonClicked(QString)), &tictactoe, SLOT(buttonClicked(QString)));
    QObject::connect(rootObject, SIGNAL(tttNewMove(QString,QString)), &tictactoe, SLOT(newMove(QString,QString)));
    QObject::connect(rootObject, SIGNAL(tttcreateGameId(QString,QString)), &tictactoe, SLOT(createGameID(QString,QString)));

    // Fetch currency values
    //marketValue.findAllCurrencyValues();

    // Set last locale
    settings.setLocale(appSettings.value("locale").toString());

#if defined(Q_OS_ANDROID) || defined(Q_OS_IOS)
#else
#endif

    return app.exec();
}
