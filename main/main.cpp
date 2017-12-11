#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickWindow>

#include "../backend/backend.hpp"
#include "../backend/iobject.hpp"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<BackEnd>("xtrabytes.xcite.backend", 1, 0, "BackEnd");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    QQuickWindow *W = (QQuickWindow *)engine.rootObjects().first();
    iObject a(W);

    // connect QML signals to C++ slots
    QObject::connect(engine.rootObjects().first(),SIGNAL(pressMeSignal(QString)),&a,SLOT(PressMeCall(QString)));

    // connect C++ signals to QML slots
    QObject::connect(&a, SIGNAL(setTextFieldSignal(QVariant)),engine.rootObjects().first(), SLOT(setTextFieldCall(QVariant)));

    return app.exec();
}
