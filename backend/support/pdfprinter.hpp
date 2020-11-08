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
    void createPubQrFile(QQuickItem *item);
    void createPrivQrFile(QQuickItem *item);
    void createDoc();

    QString destDir;
    QString tempDir;
    QString fullName;
    QString qrName;
    QFile qrFile;
    bool qrFileExists;
    QString walletCoin;
    QString walletAddress;
    QString walletPublicKey;
    QString walletPrivateKey;
    QQuickItem *publicQRcode;
    QQuickItem *privateQRcode;
    QString pubQRfullName;
    QString privQRfullName;
    QString qrType;
    bool pubQrReady;
    bool privQrReady;
    bool imageError;

public slots:
    void createPaperWallet(QString coin, QString address, QString publicKey, QString privateKey, QQuickItem *pubQr, QQuickItem *privQr);

signals:
    void paperWalletCreated (QString fileName);
    void paperWalletFailed();

public slots:
};

#endif // PDFPRINTER_HPP
