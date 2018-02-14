#include "qobject.h"
#include "nodetransaction.h"


//Constructors
NodeTransaction::NodeTransaction(QObject* parent)
    : QObject(parent){}

NodeTransaction::NodeTransaction(const QString &address, const QString &timeIn, const QString &process, const QString &executed, const int &type, QObject* parent)
    :QObject(parent)
{
    m_address = address;
    m_timeIn = timeIn;
    m_process = process;
    m_executed = executed;
    m_type = type;

}

NodeTransaction::NodeTransaction(const QString &address, QObject* parent)
    :QObject(parent)
{
    m_address = address;
}
//Destructor
NodeTransaction::~NodeTransaction(){

}

QString NodeTransaction::address() const
{
    return m_address;
}
QString NodeTransaction::timeIn() const
{
    return m_timeIn;
}

QString NodeTransaction::process() const
{
    return m_process;
}

QString NodeTransaction::executed() const
{
    return m_executed;
}

int NodeTransaction::type()
{
    return m_type;
}

