#ifndef SETTINGS_HPP
#define SETTINGS_HPP

#include <QObject>
#include <QTranslator>
#include <QCoreApplication>
#include <QQmlApplicationEngine>

class Settings : public QObject
{
    Q_OBJECT
public:
    Settings(QQmlApplicationEngine *engine, QObject *parent = 0);
    void setLocale(QString);

public slots:
    void onLocaleChange(QString);

private:
    QTranslator m_translator;
    QQmlApplicationEngine *m_engine;
};

#endif // SETTINGS_HPP
