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
