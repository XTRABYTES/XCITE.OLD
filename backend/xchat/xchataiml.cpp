/**
 * Filename: xchataiml.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include "xchataiml.hpp"
#include <QFile>
#include <QDateTime>
#include <QtXml>
#include <QtNetwork>
#include <QDir>
#include <QApplication>

//For windows system execution
#ifdef _WIN32
#include <windows.h>
#include <errno.h>
#include <io.h>
#include <fcntl.h>
#include <ctype.h>
#endif

bool exactMatch(QString regExp, QString str, QStringList &capturedText)
{
    QStringList regExpWords = regExp.split(' ', QString::SkipEmptyParts);
    QStringList strWords = str.split(' ', QString::SkipEmptyParts);
    if ((!regExpWords.count() || !strWords.count()) && (regExpWords.count() != strWords.count()))
        return false;
    if (regExpWords.count() > strWords.count())
        return false;
    QStringList::ConstIterator regExpIt = regExpWords.begin();
    QStringList::ConstIterator strIt = strWords.begin();
    while ((strIt != strWords.end()) && (regExpIt != regExpWords.end()))
    {
        if ( (*regExpIt == "*") || (*regExpIt == "_") )
        {
            regExpIt++;
            QStringList capturedStr;
            if (regExpIt != regExpWords.end())
            {
                QString nextWord = *regExpIt;
                if ( (nextWord != "*") && (nextWord != "_") )
                {
                    while (true)
                    {
                        if (*strIt == nextWord)
                            break;
                        capturedStr += *strIt;
                        if (++strIt == strWords.end())
                            return false;
                    }
                }
                else
                {
                    capturedStr += *strIt;
                    regExpIt --;
                }
            }
            else
            {
                while (true)
                {
                    capturedStr += *strIt;
                    if (++strIt == strWords.end())
                        break;
                }
                capturedText += capturedStr.join(" ");
                return true;
            }
            capturedText += capturedStr.join(" ");
        }
        else if (*regExpIt != *strIt)
            return false;
        regExpIt++;
        strIt++;
    }
    return (regExpIt == regExpWords.end()) && (strIt == strWords.end());
}

QList<QDomNode> elementsByTagName(QDomNode *node, const QString& tagName)
{
    QList<QDomNode> list;
    QDomNodeList childNodes = node->toElement().elementsByTagName(tagName);
    for (int i = 0; i < childNodes.count(); i++)
    {
        QDomNode n = childNodes.item(i);
        if (n.parentNode() == *node)
            list.append(n);
    }
    return list;
}

Leaf::Leaf()
{
    topic = that = "";
}

Node::Node()
{
    word = "";
}

void Node::clear()
{
    while (!childs.isEmpty())
        delete childs.takeFirst();
    while (!leafs.isEmpty())
        delete leafs.takeFirst();
}

Node::~Node()
{
    clear();
}

bool Node::match(QStringList::const_iterator input, const QStringList &inputWords,
                 const QString &currentThat, const QString &currentTopic, QStringList &capturedThatTexts,
                 QStringList &capturedTopicTexts, Leaf *&leaf)
{
    if (input == inputWords.end())
        return false;

    if ((word == "*") || (word == "_"))
    {
        ++input;
        for (;input != inputWords.end(); input++)
        {
            foreach (Node *child, childs)
            {
                if (child->match(input, inputWords, currentThat, currentTopic, capturedThatTexts,
                                 capturedTopicTexts, leaf))
                    return true;
            }
        }
    }
    else
    {
        if (!word.isEmpty())
        {
            if (word != *input)
                return false;
            ++input;
        }
        foreach (Node *child, childs)
        {
            if (child->match(input, inputWords, currentThat, currentTopic, capturedThatTexts,
                             capturedTopicTexts, leaf))
                return true;
        }
    }
    if (input == inputWords.end())
    {
        foreach (leaf, leafs)
        {
            capturedThatTexts.clear();
            capturedTopicTexts.clear();
            if ( (!leaf->that.isEmpty() && !exactMatch(leaf->that, currentThat, capturedThatTexts)) ||
                    (!leaf->topic.isEmpty() && !exactMatch(leaf->topic, currentTopic, capturedTopicTexts)) )
                continue;
            return true;
        }
    }

    return false;
}




void XchatAIML::normalizeString(QString &str)
{
    QString newStr;
    for (int i = 0; i < str.length(); i++)
    {
        QChar c = str.at(i);
        if (c.isLetterOrNumber() || (c == '*') || (c == '_') || (c == ' '))
            newStr += c.toLower();
    }
    str = newStr;
}

XchatAIML::XchatAIML(bool displayTree) : displayTree(displayTree)
{
    indent = 0;
    root.parent = NULL;
    loadSubstitutions();
}

XchatAIML::~XchatAIML()
{
}


bool XchatAIML::loadAIMLSet()

{
	
    QDir dir(":/aiml/");

    // Load all files with the *.aiml extension
    QStringList files = dir.entryList(QStringList("*.aiml"));	
    clear();
    for (QStringList::Iterator it = files.begin(); it != files.end(); ++it) {    
               loadAiml(":/aiml/" + *it);
    }
    return true;
}

void XchatAIML::clear()
{
    inputList.clear();
    thatList.clear();
    indent = 0;
    root.clear();
}

bool XchatAIML::loadSubstitutions()
{
	
    QDomDocument doc;
    QFile file( ":/aiml/substitutions.xml" );
    if ( !file.open( QIODevice::ReadOnly ) )
        return false;
    if ( !doc.setContent( &file ) )
    {
        file.close();
        return false;
    }
    file.close();

    QDomElement docElem = doc.documentElement();
    QDomNodeList subsList = docElem.elementsByTagName ("substitution");
    for (int i = 0; i < subsList.count(); i++)
    {    	  
        QDomElement n = subsList.item(i).toElement();
        subOld.append(QRegExp(n.namedItem("old").firstChild().nodeValue(), Qt::CaseInsensitive));
        subNew.append(n.namedItem("new").firstChild().nodeValue());
    }
    
    return true;
}


bool XchatAIML::loadAiml(const QString &filename)
{

    QDomDocument doc( "mydocument" );
    QFile file( filename );
    if ( !file.open( QIODevice::ReadOnly ) )
        return false;

    QXmlInputSource src(&file);
    QXmlSimpleReader reader;
    reader.setFeature("http://trolltech.com/xml/features/report-whitespace-only-CharData", true);

    QString msg;
    int line, col;
    if ( !doc.setContent( &src, &reader, &msg, &line, &col ) )
    {
        file.close();
        return false;
    }
    file.close();

    QDomElement docElem = doc.documentElement();
    QDomNodeList categoryList = docElem.elementsByTagName ("category");
    for (int i = 0; i < categoryList.count(); i++)
    {
        QDomNode n = categoryList.item(i);
        parseCategory(&n);
    }
    return true;
}

//parses a category and creates a correspondant element
void XchatAIML::parseCategory(QDomNode* categoryNode)
{
    QDomNode patternNode = categoryNode->namedItem("pattern");
    QString pattern = resolveNode(&patternNode);
    normalizeString(pattern);
    //find where to insert the new node
    QStringList words = pattern.split(' ', QString::SkipEmptyParts);
    Node *whereToInsert = &root;
    for ( QStringList::ConstIterator it = words.begin(); it != words.end(); ++it )
    {
        bool found = false;
        foreach (Node* child, whereToInsert->childs)
        {
            if (child->word == *it)
            {
                whereToInsert = child;
                found = true;
                break;
            }
        }
        if (!found)
        {
            for (; it != words.end(); ++it )
            {
                Node *n = new Node;
                n->word = *it;
                n->parent = whereToInsert;
                int index = 0;
                if (*it == "*")
                    index = whereToInsert->childs.count();
                else if ((*it != "_") && whereToInsert->childs.count() &&
                         (whereToInsert->childs.at(0)->word == "_"))
                    index = 1;
                whereToInsert->childs.insert(index, n);
                whereToInsert = n;
            }
            break;
        }
    }

    //Now insert the leaf
    Leaf *leaf = new Leaf;
    leaf->parent = whereToInsert;
    QDomNode thatNode = categoryNode->namedItem("that");
    if (!thatNode.isNull())
    {
        leaf->that = thatNode.firstChild().toText().nodeValue();
        normalizeString(leaf->that);
    }
    leaf->tmplate = categoryNode->namedItem("template");
    QDomNode parentNode = categoryNode->parentNode();
    if (!parentNode.isNull() && (parentNode.nodeName() == "topic"))
    {
        leaf->topic = parentNode.toElement().attribute("name");
        normalizeString(leaf->topic);
    }
    int index = 0;
    int leafWeight = !leaf->that.isEmpty() + !leaf->topic.isEmpty() * 2;
    foreach (Leaf* childLeaf, whereToInsert->leafs)
    {
        int childLeafWeight = !childLeaf->that.isEmpty() + !childLeaf->topic.isEmpty() * 2;
        if (leafWeight >= childLeafWeight)
            break;
        index++;
    }
    whereToInsert->leafs.insert(index, leaf);
}

//recursively replace all the values & return the QString result
QString XchatAIML::resolveNode(QDomNode* node, const QStringList &capturedTexts,
                                const QStringList &capturedThatTexts, const QStringList &capturedTopicTexts)
{
    QString result("");
    QString nodeName = node->nodeName();
    QDomElement element = node->toElement();
    if (nodeName == "random")
    {
        QList<QDomNode> childNodes = elementsByTagName(node, "li");
        uint childCount = childNodes.count();
        uint random = rand() % childCount;
        QDomNode child = childNodes[random];
        result = resolveNode(&child, capturedTexts, capturedThatTexts, capturedTopicTexts);
    }
    else if (nodeName == "condition")
    {
        QString name("");
        uint condType = 2;
        if (element.hasAttribute("name"))
        {
            condType = 1;
            name = element.attribute("name");
            if (element.hasAttribute("value"))
            {
                condType = 0;
                QString value = element.attribute("value").toUpper();
                QStringList dummy;
            }
        }
        if (condType)
        {
            QList<QDomNode> childNodes = elementsByTagName(node, "li");
            for (int i = 0; i < childNodes.count(); i++)
            {
                QDomNode n = childNodes[i];
                if (n.toElement().hasAttribute("value"))
                {
                    if (condType == 2)
                        name = n.toElement().attribute("name");
                    QString value = n.toElement().attribute("value").toUpper();
                    QStringList dummy;
                }
                else
                {
                    result = resolveNode(&n, capturedTexts, capturedThatTexts, capturedTopicTexts);
                    break;
                }
            }
        }
    }
    else
    {
        bool htmlTag = false;
        if (nodeName.startsWith("html:"))
        {
            QString xmlTag;
            QTextStream ts(&xmlTag);
            htmlTag = true;
            ts << '<' << nodeName;
            const QDomNamedNodeMap &attributes = node->attributes();
            for (int i = 0; i < attributes.count(); i++)
            {
                ts << ' ';
                attributes.item(i).save(ts, 0);
            }
            ts << '>';
            result += xmlTag;
        }

        QDomNode n = node->firstChild();
        while (!n.isNull())
        {
            result += resolveNode(&n, capturedTexts, capturedThatTexts, capturedTopicTexts);
            n = n.nextSibling();
        }
        if (htmlTag)
        {
            result += "</" + nodeName + ">";
            return result;
        }
        else if (node->isText())
            result = node->toText().nodeValue();
        else if (nodeName == "srai")
            result = getResponse(result, true);
        else if (nodeName == "think")
            result = "";
        else if (nodeName == "learn")
        {
            loadAiml(result);
            result = "";
        }
        else if (nodeName == "uppercase")
        {
            result = result.toUpper();
        }
        else if (nodeName == "lowercase")
        {
            result = result.toLower();
        }
        else if (!node->hasChildNodes())
        {
            if (nodeName == "star")
            {
                int index = element.attribute("index", "1").toInt() - 1;
                result = index < capturedTexts.count() ? capturedTexts[index] : QString("");
            }
            else if (nodeName == "thatstar")
            {
                int index = element.attribute("index", "1").toInt() - 1;
                result = index < capturedThatTexts.count() ? capturedThatTexts[index] : QString("");
            }
            else if (nodeName == "topicstar")
            {
                int index = element.attribute("index", "1").toInt() - 1;
                result = index < capturedTopicTexts.count() ? capturedTopicTexts[index] : QString("");
            }
            else if (nodeName == "that")
            {
                QString indexStr = element.attribute("index", "1,1");
                if (!indexStr.contains(","))
                    indexStr = "1," + indexStr;
                int index1 = indexStr.section(',', 0, 0).toInt()-1;
                int index2 = indexStr.section(',', 1, 1).toInt()-1;
                result = (index1 < thatList.count()) && (index2 < thatList[index1].count()) ?
                         thatList[index1][index2] : QString("");
            }
            else if (nodeName == "sr")
                result = getResponse(capturedTexts.count() ? capturedTexts[0] : QString(""), true);
            else if (nodeName == "br")
                result = "\n";
            else if ( (nodeName == "person") || (nodeName == "person2") || (nodeName == "gender") )
                result = capturedTexts.count() ? capturedTexts[0] : QString("");
            else if (nodeName == "input")
            {
                int index = element.attribute("index", "1").toInt() - 1;
                result = index < inputList.count() ? inputList[index] : QString("");
            }
            //the following just to avoid warnings !
            else if (nodeName == "li") {

            }
        }
        //the following just to avoid warnings !
        else if ((nodeName == "template") || (nodeName == "pattern") || (nodeName == "li")
                 || (nodeName == "person") || (nodeName == "person2") || (nodeName == "gender")
                 || (nodeName == "parsedCondition")) {

        }
    }
    return result;
}

QString XchatAIML::getResponse(QString input, const bool &srai)
{

    if (srai)
        indent ++;
    QString indentSpace = QString().fill(' ', 2*indent);
    //perform substitutions for input string
    QList<QRegExp>::Iterator itOld = subOld.begin();
    QStringList::Iterator itNew = subNew.begin();
    for (; itOld != subOld.end(); ++itOld, ++itNew )
        input.replace(*itOld, *itNew);
    if (!srai)
    {
        inputList.prepend(input);
        if (inputList.count() > MAX_LIST_LENGTH)
            inputList.pop_back();
    }

    QStringList capturedTexts, capturedThatTexts, capturedTopicTexts;
    Leaf *leaf = NULL;
    QString result("");
    QStringList sentences = input.split(QRegExp("[\\.\\?!;\\x061f]"), QString::SkipEmptyParts);
    QStringList::Iterator sentence = sentences.begin();
    while (sentence != sentences.end())
    {
        if (!(*sentence).trimmed().isEmpty())
        {
            *sentence = (*sentence).toLower();
            QStringList inputWords = sentence->split(' ', QString::SkipEmptyParts);
            QStringList::ConstIterator it = inputWords.begin();
            if (!root.match(it, inputWords, thatList.count() && thatList[0].count() ?
                            thatList[0][0] : QString(""), QString(""), capturedThatTexts,
                            capturedTopicTexts, leaf))
                return "Interpreter error :-(";
            Node *parentNode = leaf->parent;
            QString matchedPattern = parentNode->word;
            while (parentNode->parent->parent)
            {
                parentNode = parentNode->parent;
                matchedPattern = parentNode->word + " " + matchedPattern;
            }
            capturedTexts.clear();
            exactMatch(matchedPattern, *sentence, capturedTexts);
            //strip whitespaces from the beggining and the end of result
            if (indent >= MAX_RECURSION)
                result += "Too much recursion (Probable infinite loop)!";
            else
                result += resolveNode(&leaf->tmplate, capturedTexts, capturedThatTexts,
                                      capturedTopicTexts).trimmed();
        }
        sentence++;
        if (sentence != sentences.end())
            result += " ";
    }
    if (!srai)
    {
        QString tempResult = result.trimmed();
        //get the sentences of the result splitted by: . ? ! ; and "arabic ?"
        QStringList thatSentencesList = tempResult.split(QRegExp("[\\.\\?!;\\x061f]"), QString::SkipEmptyParts);
        QStringList inversedList;
        for (QStringList::Iterator it = thatSentencesList.begin(); it != thatSentencesList.end(); ++it)
        {
            //perform substitutions for that string
            itOld = subOld.begin();
            itNew = subNew.begin();
            for (; itOld != subOld.end(); ++itOld, ++itNew )
                tempResult.replace(*itOld, *itNew);
            normalizeString(*it);
            inversedList.prepend(*it);
        }
        thatList.prepend(inversedList);
        if (thatList.count() > MAX_LIST_LENGTH)
            thatList.pop_back();
    }
    if (srai)
        indent --;

    return result;
}

