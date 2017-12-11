#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>

class BackEnd : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString loremIpsum READ loremIpsum WRITE setLoremIpsum NOTIFY loremIpsumChanged)

public:
    explicit BackEnd(QObject *parent = nullptr);

    QString loremIpsum();
    void setLoremIpsum(const QString &loremIpsum);

signals:
    void loremIpsumChanged();

private:
    QString m_loremIpsum;
};

#endif // BACKEND_H