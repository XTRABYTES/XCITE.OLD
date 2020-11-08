#include "pdfprinter.hpp"
#include <cstdint>
#include <QTextDocument>
#include <QPrinter>
#include <QApplication>
#include <QQuickItem>
#include <QQuickItemGrabResult>
#include <chrono>

pdfPrinter::pdfPrinter(QObject *parent) : QObject(parent)
{

}

void pdfPrinter::createPaperWallet(QString coin, QString address, QString publicKey, QString privateKey, QQuickItem *pubQr, QQuickItem *privQr) {
    pubQrReady = false;
    privQrReady = false;
    imageError = false;
    walletCoin = coin;
    walletAddress = address;
    walletPublicKey = publicKey;
    walletPrivateKey = privateKey;
    publicQRcode = pubQr;
    privateQRcode = privQr;
    destDir = QStandardPaths::standardLocations(QStandardPaths::DocumentsLocation)[0] + "/XCITE_paperwallet";
    tempDir = QStandardPaths::standardLocations(QStandardPaths::DocumentsLocation)[0] + "/XCITE_paperwallet/temp";
    QDir dirDest;
    QDir dirTemp;
    dirDest.mkpath(destDir);
    dirTemp.mkpath(tempDir);

    createPubQrFile(publicQRcode);
}

void pdfPrinter::createPubQrFile(QQuickItem *item){

    qrName = "pubQR.png";
    pubQRfullName = tempDir + "/" + qrName;
    qDebug() << " Writing to " + tempDir + "/" + qrName;
    fullName = tempDir + "/" + qrName;
    qrFile.setFileName(tempDir + "/" + qrName);
    qrFileExists = QFile::exists(fullName);
    if (!qrFileExists) {
        QFile newQrFile(tempDir + "/" + qrName);
    }

    auto grabPubResult = item->grabToImage();
    connect(grabPubResult.data(), &QQuickItemGrabResult::ready, [=]() {
        grabPubResult->saveToFile(fullName);
        std::this_thread::sleep_for (std::chrono::seconds(3));
        createPrivQrFile(privateQRcode);
    });
}

void pdfPrinter::createPrivQrFile(QQuickItem *item) {
    qrName = "privQR.png";
    privQRfullName = tempDir + "/" + qrName;
    qDebug() << " Writing to " + tempDir + "/" + qrName;
    fullName = tempDir + "/" + qrName;
    qrFile.setFileName(tempDir + "/" + qrName);
    qrFileExists = QFile::exists(fullName);
    if (!qrFileExists) {
        QFile newQrFile(tempDir + "/" + qrName);
    }

    auto grabPrivResult = item->grabToImage();
    connect(grabPrivResult.data(), &QQuickItemGrabResult::ready, [=]() {
        grabPrivResult->saveToFile(fullName);
        std::this_thread::sleep_for (std::chrono::seconds(3));
        createDoc();
    });
}

void pdfPrinter::createDoc() {
    QTextDocument doc;
    doc.setHtml( "<p align=center><h1>Paper wallet for:</h1> <h2>"
                 + walletAddress
                 + "<br>(" + walletCoin + ")</h2>"
                 + "</p><p align=center><b><h2>Public Key:</h2></b><br>"
                 + "<img src="
                 + pubQRfullName
                 + "><br>"
                 + walletPublicKey
                 + "</p>"
                 + "<p align=center><b><h2>Private Key:</h2></b><br>"
                 + "<img src="
                 + privQRfullName
                 + "><br>"
                 + walletPrivateKey
                 + "</p><p><br><h3>WARNING!!! DO NOT SHOW YOUR WALLET KEYS TO ANYONE ELSE!</h3></p>");
    QPrinter printer;
    QString fileName = walletCoin + "_" + walletAddress + ".pdf";
    qDebug() << " Writing to " + destDir + "/" + fileName;
    QString fullFileName = destDir + "/" + fileName;
    bool exists = QFile::exists(fullFileName);
    if (!exists) {
        QFile file(destDir + "/" + fileName);
    }
    printer.setOutputFileName(fullFileName);
    printer.setOutputFormat(QPrinter::PdfFormat);
    doc.print(&printer);
    printer.newPage();

    emit paperWalletCreated (fullFileName);

    QFile pubQrCode;
    pubQrCode.setFileName(pubQRfullName);
    pubQrCode.close();
    pubQrCode.remove();

    QFile privQrCode;
    privQrCode.setFileName(privQRfullName);
    privQrCode.close();
    privQrCode.remove();
}


