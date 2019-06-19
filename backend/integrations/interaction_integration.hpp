/**
 * Filename: interaction_integration.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef INTERACTION_INTEGRATION_HPP
#define INTERACTION_INTEGRATION_HPP

#include <QMainWindow>
#include <QObject>
#include <QJsonArray>
#include <QJsonObject>
#include <QWidget>

class interaction_integration : public QObject {
        Q_OBJECT

public:
    explicit interaction_integration(QObject *parent = nullptr);

};


#endif // INTERACTION_INTEGRATION_HPP
