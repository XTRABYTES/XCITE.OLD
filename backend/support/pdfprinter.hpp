#ifndef PDFPRINTER_HPP
#define PDFPRINTER_HPP

#include <QObject>
#include <QTranslator>
#include <QCoreApplication>
#include <QQmlApplicationEngine>
#include <QSettings>
#include <QtSql>
#include <QDateTime>
#include <QNetworkReply>
#include <QtCore>
#include <QtGui>
#include <QQuickItem>

class pdfPrinter : public QObject
{
    Q_OBJECT

private:

public:

    explicit pdfPrinter(QObject *parent = nullptr);
    void getSize (QString fileName);

public slots:
    void createPaperWalletImage(QString coin, QString address, QQuickItem *wallet);

signals:
    void paperWalletCreated(QString fileName);
    void paperWalletFailed();

public slots:
};

#endif // PDFPRINTER_HPP
