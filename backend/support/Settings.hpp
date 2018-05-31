/**
 * Filename: Settings.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef SETTINGS_HPP
#define SETTINGS_HPP

#include <QObject>
#include <QTranslator>
#include <QCoreApplication>
#include <QQmlApplicationEngine>
#include <QSettings>

class Settings : public QObject
{
    Q_OBJECT
public:
    Settings(QQmlApplicationEngine *engine, QSettings *settings, QObject *parent = 0);
    void setLocale(QString);

public slots:
    void onLocaleChange(QString);
    void onClearAllSettings();

private:
    QTranslator m_translator;
    QQmlApplicationEngine *m_engine;
    QSettings *m_settings;
};

#endif // SETTINGS_HPP
