#include "pdfprinter.hpp"
#include <cstdint>
#include <QTextDocument>
#include <QPrinter>
#include <QApplication>
#include <QQuickItem>
#include <QQuickItemGrabResult>
#include <chrono>     // std::cout
#include <fstream>

pdfPrinter::pdfPrinter(QObject *parent) : QObject(parent)
{

}

void pdfPrinter::createPaperWalletImage(QString coin, QString address, QQuickItem *wallet) {
    QString walletCoin = coin;
    QString walletAddress = address;
    QString destDir = QStandardPaths::standardLocations(QStandardPaths::DocumentsLocation)[0] + "/XCITE_paperwallet";
    QDir dirDest;
    dirDest.mkpath(destDir);
    QString fileName = walletCoin + "_" + walletAddress + ".png";
    qDebug() << " Writing to " + destDir + "/" + fileName;
    QString fullFileName = destDir + "/" + fileName;
    bool exists = QFile::exists(fullFileName);
    if (!exists) {
        QFile file(destDir + "/" + fileName);
    }

    auto grabPrivResult = wallet->grabToImage();
    connect(grabPrivResult.data(), &QQuickItemGrabResult::ready, [=]() {
        grabPrivResult->saveToFile(fullFileName);
    });

    getSize(fullFileName);
}

void pdfPrinter::getSize (QString fileName) {
    QByteArray array = fileName.toLocal8Bit();
    char* fName = array.data();
    std::ifstream is (fName, std::ifstream::binary);
    // (fileName)
    int length;
    if (is) {
        // get length of file:
        is.seekg (0, is.end);
        length = is.tellg();
        is.seekg (0, is.beg);
    }

    if (length > 0) {
        emit paperWalletCreated(fileName);
        qDebug() << "file size: " << length;
        qDebug() << "paper wallet created: " << fileName;
    }
    else {
        emit paperWalletFailed();
        qDebug() << "failed to create paper wallet";
        QFile badFile (fileName);
        badFile.close();
        badFile.remove();
    }
}


