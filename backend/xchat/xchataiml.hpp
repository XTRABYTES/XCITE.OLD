/**
 * Filename: xchataiml.hpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#ifndef XCHATAIML_H
#define XCHATAIML_H

#include <QDomNode>
#include <QMap>
#include <QList>
#include <QStringList>
#include <QRegExp>
#include <QObject>

#define MAX_LIST_LENGTH 50
#define MAX_RECURSION   50


struct Node;

struct Leaf
{
    Node *parent;
    QDomNode tmplate;
    QString topic;
    QString that;
    Leaf();
};

struct Node
{
    Node *parent;
    QString word;
    QList<Node*> childs;
    QList<Leaf*> leafs;
    Node();
    ~Node();
    void clear();
    bool match(QStringList::const_iterator, const QStringList&,
               const QString&, const QString&, QStringList &, QStringList &, Leaf *&);
};

class XchatAIML : public QObject
{
    Q_OBJECT
public:
    XchatAIML(bool displayTree = false);
    virtual ~XchatAIML();
    void clear();
    bool loadAiml(const QString&);
    bool loadAIMLSet();
    QString getResponse(QString, const bool & = false);
private:
    bool loadSubstitutions();
    QString resolveNode(QDomNode*, const QStringList & = QStringList(),
                        const QStringList & = QStringList(), const QStringList & = QStringList());
    void parseCategory(QDomNode*);
    void normalizeString(QString &);

private:
    QList<QRegExp> subOld;
    QStringList subNew;
    QStringList inputList;
    QList<QStringList> thatList;
    Node root;
    int indent;
    bool displayTree;
    quint16 blockSize;
};

#endif
