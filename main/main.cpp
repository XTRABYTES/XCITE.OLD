#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickWindow>
#include <QQmlFileSelector>
#include <QSettings>
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
#include "../backend/support/settings.hpp"

int main(int argc, char *argv[])
{
    QString APP_VERSION = QString("%1.%2.%3").arg(VERSION_MAJOR).arg(VERSION_MINOR).arg(VERSION_BUILD);

    QtQrCodeQuickItem::registerQmlTypes();

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    app.setOrganizationName("Xtrabytes");
    app.setOrganizationDomain("xtrabytes.global");
    app.setApplicationName("XCITE");

    app.setFont(QFont("Roboto"));

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

    XchatObject xchatobj;
    xchatobj.Initialize();

    Testnet wallet;
    engine.rootContext()->setContextProperty("wallet", (QObject *)&wallet);

    app.setWindowIcon(QIcon("xcite.ico"));

    //app.set
    engine.rootContext()->setContextProperty("AppVersion", APP_VERSION);
    engine.rootContext()->setContextProperty("EventFilter", &eventFilter);

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    Settings settings(&engine);
    QObject::connect(engine.rootObjects().first(), SIGNAL(localeChange(QString)), &settings, SLOT(onLocaleChange(QString)));

    // Set last locale
    QSettings appSettings;
    settings.setLocale(appSettings.value("locale").toString());

#if defined(Q_OS_ANDROID) || defined(Q_OS_IOS)
#else
    // X-Chat
    // connect QML signals to C++ slots
    QObject::connect(engine.rootObjects().first(),SIGNAL(xchatSubmitMsgSignal(QString)),&xchatobj,SLOT(SubmitMsgCall(QString)));
    // connect C++ signals to QML slots
    QObject::connect(&xchatobj, SIGNAL(xchatResponseSignal(QVariant)),engine.rootObjects().first(), SLOT(xchatResponse(QVariant)));

    // FauxWallet
    QObject::connect(engine.rootObjects().first(), SIGNAL(testnetRequest(QString)), &wallet, SLOT(request(QString)));
    QObject::connect(engine.rootObjects().first(), SIGNAL(testnetSendFrom(QString, QString, qreal)), &wallet, SLOT(sendFrom(QString, QString, qreal)));
    QObject::connect(engine.rootObjects().first(), SIGNAL(testnetSendToAddress(QString, qreal)), &wallet, SLOT(sendToAddress(QString, qreal)));
    QObject::connect(engine.rootObjects().first(), SIGNAL(testnetGetAccountAddress(QString)), &wallet, SLOT(getAccountAddress(QString)));
    QObject::connect(engine.rootObjects().first(), SIGNAL(testnetValidateAddress(QString)), &wallet, SLOT(validateAddress(QString)));
    QObject::connect(&wallet, SIGNAL(response(QVariant)), engine.rootObjects().first(), SLOT(testnetResponse(QVariant)));
    QObject::connect(&wallet, SIGNAL(walletError(QVariant)), engine.rootObjects().first(), SLOT(walletError(QVariant)));
    QObject::connect(&wallet, SIGNAL(walletSuccess(QVariant)), engine.rootObjects().first(), SLOT(walletSuccess(QVariant)));
#endif

    return app.exec();
}
