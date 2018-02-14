#ifndef XCHAT_H
#define XCHAT_H

#include <QObject>
#include <QString>
#include <QVariant>

#include "xchataiml.hpp"
#include "xchatconversationmodel.hpp"

class Xchat : public QObject
{
    Q_OBJECT

public:
    explicit Xchat(QObject *parent = nullptr);
};


class XchatObject : public QObject
{
    Q_OBJECT

public:
	explicit XchatObject(QObject *parent = 0);
   ~XchatObject();
    
   void Initialize();

signals:
    void xchatResponseSignal(QVariant text);

public slots:
    void SubmitMsgCall(const QString &msg);

private:
    QObject *window;
    XchatAIML *m_pXchatAiml;
    bool m_bIsInitialized;
};

#endif // XCHAT_H
