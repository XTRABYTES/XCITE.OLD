#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickWindow>

#include "../backend/xchat/xchat.hpp"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<Xchat>("xtrabytes.xcite.xchat", 1, 0, "Xchat");

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/");
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    QQuickWindow *W = (QQuickWindow *)engine.rootObjects().first();
    XchatObject xchatobj(W);
    xchatobj.Initialize();

    // connect QML signals to C++ slots
    QObject::connect(engine.rootObjects().first(),SIGNAL(xchatSubmitMsgSignal(QString,QString)),&xchatobj,SLOT(SubmitMsgCall(QString,QString)));

    // connect C++ signals to QML slots
    QObject::connect(&xchatobj, SIGNAL(xchatResponseSignal(QVariant)),engine.rootObjects().first(), SLOT(xchatResponse(QVariant)));

    app.setWindowIcon(QIcon(":/icons/xbyicon.ico"));

    return app.exec();
}
