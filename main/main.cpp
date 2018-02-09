#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickWindow>
#include <qqmlcontext.h>
#include <qqml.h>
#include "../backend/xchat/xchat.hpp"
#include "../backend/xchat/xchatconversationmodel.hpp"
#include "../frontend/support/sortfilterproxymodel.hpp"
#include "../backend/xboard/nodes/nodetransaction.h"

#include "../backend/testnet/testnet.hpp"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<Xchat>("xtrabytes.xcite.xchat", 1, 0, "Xchat");
    qmlRegisterType<SortFilterProxyModel>("SortFilterProxyModel", 0, 1, "SortFilterProxyModel");
    qmlRegisterType<XChatConversationModel>("XChatConversationModel", 0, 1, "XChatConversationModel");

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/");

    XchatObject xchatobj;
    xchatobj.Initialize();

    Testnet wallet;
    wallet.request("getbalance");
    wallet.request("listtransactions");
    engine.rootContext()->setContextProperty("wallet", (QObject *)&wallet);

    app.setWindowIcon(QIcon(":/xcite.ico"));

    QList<QObject*> transactionList;
    transactionList.append(new NodeTransaction("xghl32lk8dfss577g734j34","12:45 PM GMT 0","12:45 PM GMT 0","12:45 PM GMT 0",NodeTransaction::NodeTransactionType::XChat));
    transactionList.append(new NodeTransaction("xghlasdasdsadasdas32lk8dfss577g734j34","12:45 PM GMT 0","12:45 PM GMT 0","12:45 PM GMT 0",NodeTransaction::NodeTransactionType::XCite));
    transactionList.append(new NodeTransaction("xghl32lk8dfss577g734j34","12:45 PM GMT 0","12:45 PM GMT 0","12:45 PM GMT 0",NodeTransaction::NodeTransactionType::XChange));
    transactionList.append(new NodeTransaction("xghl32lk8dfss577g734j34","12:45 PM GMT 0","12:45 PM GMT 0","12:45 PM GMT 0",NodeTransaction::NodeTransactionType::XChange));
    transactionList.append(new NodeTransaction("xghl32lk8dfss577g734j34","12:45 PM GMT 0","12:45 PM GMT 0","12:45 PM GMT 0",NodeTransaction::NodeTransactionType::XCite));
    transactionList.append(new NodeTransaction("xghlasdasdsadasdas32lk8dfss577g734j34","12:45 PM GMT 0","12:45 PM GMT 0","12:45 PM GMT 0",NodeTransaction::NodeTransactionType::XCite));
    transactionList.append(new NodeTransaction("xghl32lk8dfss577g734j34","12:45 PM GMT 0","12:45 PM GMT 0","12:45 PM GMT 0",NodeTransaction::NodeTransactionType::XChange));
    transactionList.append(new NodeTransaction("xghl32lk8dfss577g734j34","12:45 PM GMT 0","12:45 PM GMT 0","12:45 PM GMT 0",NodeTransaction::NodeTransactionType::XChange));
    transactionList.append(new NodeTransaction("xghl32lk8dfss577g734j34","12:45 PM GMT 0","12:45 PM GMT 0","12:45 PM GMT 0",NodeTransaction::NodeTransactionType::XCite));
    //app.set
    engine.rootContext()->setContextProperty("nodeTransactionModel", QVariant::fromValue(transactionList));

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    // X-Chat
    // connect QML signals to C++ slots
    QObject::connect(engine.rootObjects().first(),SIGNAL(xchatSubmitMsgSignal(QString)),&xchatobj,SLOT(SubmitMsgCall(QString)));
    // connect C++ signals to QML slots
    QObject::connect(&xchatobj, SIGNAL(xchatResponseSignal(QVariant)),engine.rootObjects().first(), SLOT(xchatResponse(QVariant)));

    // FauxWallet
    QObject::connect(engine.rootObjects().first(), SIGNAL(testnetRequest(QString)), &wallet, SLOT(request(QString)));
    QObject::connect(&wallet, SIGNAL(response(QVariant)), engine.rootObjects().first(), SLOT(testnetResponse(QVariant)));

    return app.exec();
}
