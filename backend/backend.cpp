#include "backend.hpp"

BackEnd::BackEnd(QObject *parent) :
    QObject(parent)
{
}

QString BackEnd::loremIpsum()
{
    return m_loremIpsum;
}

void BackEnd::setLoremIpsum(const QString &loremIpsum)
{

    if (loremIpsum == m_loremIpsum)
        return;

    m_loremIpsum = loremIpsum;
    emit loremIpsumChanged();
}