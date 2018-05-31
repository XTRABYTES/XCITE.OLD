/**
 * Filename: globaleventfilter.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include "globaleventfilter.hpp"

#include <QEvent>
#include <QApplication>

GlobalEventFilter::GlobalEventFilter(QObject *parent)
    : QObject(parent)
{
}

bool GlobalEventFilter::eventFilter(QObject *target, QEvent *event)
{
    Q_UNUSED(target);

    if (focused == NULL) {
        return false;
    }

    if (event->type() == QEvent::MouseButtonPress || event->type() == QEvent::TouchBegin)
    {
        focused->setProperty("focus", QVariant(false));
        focused = NULL;
    }

    return false;
}

void GlobalEventFilter::focus(QObject *object)
{
    focused = object;
}
