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
#include <qqmlcontext.h>
#include <qqml.h>
#include "../backend/xchat/xchat.hpp"
#include "../backend/xchat/xchatconversationmodel.hpp"
#include "../frontend/support/sortfilterproxymodel.hpp"
#include "../backend/XCITE/nodes/nodetransaction.h"
#include "../backend/addressbook/addressbookmodel.hpp"
#include "../backend/support/ClipboardProxy.hpp"
#include "../backend/support/qrcode/qt-qrcode/QtQrCodeQuickItem.hpp"
#include "../backend/testnet/testnet.hpp"
#include "../backend/support/globaleventfilter.hpp"
#include "../backend/support/Settings.hpp"
#include "../backend/support/ReleaseChecker.hpp"
#include "../backend/integrations/MarketValue.hpp"

int main(int argc, char *argv[])
{
    QtQrCodeQuickItem::registerQmlTypes();

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
    qmlRegisterType<SortFilterProxyModel>("SortFilterProxyModel", 0, 1, "SortFilterProxyModel");
    qmlRegisterType<XChatConversationModel>("XChatConversationModel", 0, 1, "XChatConversationModel");
    qmlRegisterType<AddressBookModel>("AddressBookModel", 0, 1, "AddressBookModel");
    qmlRegisterType<ClipboardProxy>("Clipboard", 1, 0, "Clipboard");

    QQmlApplicationEngine engine;
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

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    QObject *rootObject = engine.rootObjects().first();

    QSettings appSettings;
    Settings settings(&engine, &appSettings);
    QObject::connect(rootObject, SIGNAL(localeChange(QString)), &settings, SLOT(onLocaleChange(QString)));
    QObject::connect(rootObject, SIGNAL(clearAllSettings()), &settings, SLOT(onClearAllSettings()));

    // connect QML signals for market value
    QObject::connect(rootObject, SIGNAL(marketValueChangedSignal(QString)), &marketValue, SLOT(findXBYValue(QString)));

    // Set defaultCurrency
    if(appSettings.contains("defaultCurrency"))
        marketValue.findXBYValue(appSettings.value("defaultCurrency").toString());
    else
        marketValue.findXBYValue("USD");

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
