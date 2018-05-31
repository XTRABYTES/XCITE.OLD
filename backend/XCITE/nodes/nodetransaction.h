/**
 * Filename: nodetransaction.h
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef NODETRANSACTION_H
#define NODETRANSACTION_H

#include <QObject>

class NodeTransaction: public QObject{
    Q_OBJECT
    Q_PROPERTY(QString address READ address CONSTANT FINAL)//The constant indicates that these are read only otherwise we have to specify notify properties
    Q_PROPERTY(QString timeIn READ timeIn CONSTANT FINAL)
    Q_PROPERTY(QString process READ process CONSTANT FINAL)
    Q_PROPERTY(QString executed READ executed CONSTANT FINAL)
    Q_PROPERTY(int type READ type CONSTANT FINAL)
public:
    explicit NodeTransaction(QObject *parent = 0);
    explicit NodeTransaction(const QString &address,QObject* parent = 0);
    explicit NodeTransaction(
            const QString &address,
            const QString &timeIn,
            const QString &process,
            const QString &executed,
            const int &type,
            QObject* parent = 0);
    ~NodeTransaction();
    //Determines the type of transaction this was and is displayed by a color later
    enum NodeTransactionType {XChat, XCite, XChange};

    //Getters
    QString address() const;
    QString timeIn() const;
    QString process() const;
    QString executed() const;
    int type();

private:
    QString m_address;
    QString m_timeIn;
    QString m_process;
    QString m_executed;
    int m_type;




signals:
};

#endif // NODETRANSACTIONITEM_H
