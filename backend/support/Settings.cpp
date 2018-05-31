/**
 * Filename: Settings.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include "Settings.hpp"

Settings::Settings(QQmlApplicationEngine *engine, QSettings *settings, QObject *parent) :
    QObject(parent)
{
    m_engine = engine;
    m_settings = settings;
}

void Settings::setLocale(QString locale) {
    if (!m_translator.isEmpty()) {
        QCoreApplication::removeTranslator(&m_translator);
    }

    if (locale != "en_us") {
        QString localeFile = QStringLiteral(":/i18n/lang_") + locale;
        if (!m_translator.load(localeFile)) {
            return;
        }

        QCoreApplication::installTranslator(&m_translator);
    }

    m_engine->retranslate();
}

void Settings::onLocaleChange(QString locale) {
    setLocale(locale);
}

void Settings::onClearAllSettings() {
    bool fallbacks = m_settings->fallbacksEnabled();
    m_settings->setFallbacksEnabled(false);

    m_settings->remove("developer");
    m_settings->remove("xchat");
    m_settings->remove("width");
    m_settings->remove("height");
    m_settings->remove("locale");
    m_settings->remove("x");
    m_settings->remove("y");
    m_settings->remove("onboardingCompleted");
    m_settings->remove("defaultCurrency");
    m_settings->sync();

    m_settings->setFallbacksEnabled(fallbacks);
}
