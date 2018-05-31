/**
 * Filename: globaleventfilter.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef GLOBALEVENTFILTER_HPP
#define GLOBALEVENTFILTER_HPP

#include <QObject>

class GlobalEventFilter : public QObject
{
    Q_OBJECT
public:
    GlobalEventFilter(QObject *parent = 0);
    bool eventFilter(QObject *, QEvent *);

    Q_INVOKABLE void focus(QObject *);

private:
    QObject *focused = 0;
};

#endif // GLOBALEVENTFILTER_HPP
