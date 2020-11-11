/**
* Filename: PaperWallet.qml
*
* XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
* blockchain protocol to host decentralized applications
*
* Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
*
* This file is part of an XTRABYTES Ltd. project.
*
*/

import QtQuick 2.7
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop

Rectangle {
    color: "white"
    clip: true

    property string coin: ""
    property int coinNr: 0
    property string address: ""
    property string publicKey: ""
    property string privateKey: ""
    property string walletLabel: ""
    property string walletAmount: ""

    Image {
        id: background
        source: "qrc:/backgrounds/Asset 4bg wallet.png"
        width: parent.width
        fillMode: Image.PreserveAspectFit
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
        id: addressArea
        height: parent.height
        width: parent.width/3
        anchors.left: parent.left
        anchors.top: parent.top
        clip: true

        DropShadow {
            anchors.fill: xbyCircle
            source: xbyCircle
            horizontalOffset: 4
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.3
            transparentBorder: true
        }

        Rectangle {
            id: xbyCircle
            width: parent.width
            height: width
            radius: height/2
            color: "#0ed8d2"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -height*0.4
            anchors.left: parent.left
            anchors.leftMargin: -height*0.4
        }

        Image {
            source: "qrc:/icons/white logo.png"
            height: downloadQr.height
            fillMode: Image.PreserveAspectFit
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.width*0.1
        }

        Rectangle {
            id: addressQrBg
            height: width
            width: parent.width*0.8
            color: "transparent"
            border.width: 1
            border.color: "black"
            opacity: 0.3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: parent.width*0.1
        }

        Rectangle {
            width: addressQrBg.width*0.6
            height: width
            color: "white"
            anchors.horizontalCenter: addressQrBg.horizontalCenter
            anchors.top: addressQrBg.top
            anchors.topMargin: addressQrBg.width*0.1

            Image {
                width: parent.width*0.9
                height: parent.height*0.9
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: "image://QZXing/encode/" + address
                cache: false
            }
        }

        Label {
            id: addressString
            text: address
            color: "black"
            font.family: xciteMobile.name
            font.pixelSize: addressQrBg.width*0.1/2.25
            anchors.right: addressQrBg.right
            anchors.rightMargin: font.pixelSize
            anchors.left: addressQrBg.left
            anchors.leftMargin: font.pixelSize
            anchors.bottom: addressQrBg.bottom
            anchors.bottomMargin: font.pixelSize/2
        }

        Label {
            text: "Wallet address (" + coin + ")"
            color: "black"
            font.family: xciteMobile.name
            font.pixelSize: addressString.font.pixelSize*2
            anchors.left: addressString.left
            anchors.bottom: addressString.top
        }
    }

    Item {
        id: detailArea
        z:2
        height: parent.height
        width: parent.width/3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.width: 1
            border.color: "black"
            opacity: 0.1
        }

        Rectangle {
            id: downloadQr
            width: parent.width/4
            height: width
            color: "white"
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.05
            anchors.top: parent.top
            anchors.topMargin: parent.width*0.05

            Image {
                width: parent.width*0.9
                height: parent.height*0.9
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: "image://QZXing/encode/" + "https://xtrabytes.global/wallets"
                cache: false
            }
        }

        Text {
            id: downloadLabel
            text: "Go to XTRABYTES <sup>TM</sup><br> download page"
            color: "black"
            font.family: xciteMobile.name
            font.pixelSize: downloadQr.height/6
            textFormat: Text.RichText
            maximumLineCount: 2
            anchors.left: downloadQr.right
            anchors.leftMargin: font.pixelSize/2
            anchors.verticalCenter: downloadQr.verticalCenter
        }

        Image {
            id: xbyLogo
            source: getLogoBig(coin)
            width: parent.width/3
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: -height/2
        }

        Text {
            id: xbyLabel
            text: getFullName(getCoinID(coin))
            color: "black"
            font.pixelSize: nameLabel.font.pixelSize*1.5
            font.letterSpacing: 2
            font.capitalization: Font.AllUppercase
            anchors.horizontalCenter: xbyLogo.horizontalCenter
            anchors.top: xbyLogo.bottom
            anchors.topMargin: font.pixelSize/2
        }

        Text {
            id: tmLabel
            text: "<sup>TM</sup>"
            color: "black"
            font.pixelSize: xbyLabel.font.pixelSize/2
            textFormat: Text.RichText
            leftPadding: 1
            anchors.left: xbyLabel.right
            anchors.bottom: xbyLabel.verticalCenter
            visible: coin == "XBY" || coin == "XFUEL"
        }

        Label {
            id: amountValue
            text: walletAmount
            color: "black"
            font.family: xciteMobile.name
            font.pixelSize: downloadLabel.font.pixelSize
            font.bold: true
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.05
            anchors.bottom: parent.bottom
            anchors.bottomMargin: font.pixelSize/2
        }

        Label {
            id: amountLabel
            text: coin + " amount:"
            color: "black"
            font.family: xciteMobile.name
            font.pixelSize: downloadLabel.font.pixelSize
            anchors.left: amountValue.left
            anchors.bottom: amountValue.top
            anchors.bottomMargin: font.pixelSize/2
        }

        Rectangle {
            id: divider
            height: 2
            width: parent.width - parent.width*0.1
            color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: amountLabel.top
            anchors.topMargin: parent.width*0.15
        }

        Label {
            id: walletName
            text: walletLabel
            color: "black"
            font.family: xciteMobile.name
            font.pixelSize: downloadLabel.font.pixelSize*2.5
            font.bold: true
            anchors.left: amountValue.left
            anchors.bottom: divider.top
            anchors.bottomMargin: font.pixelSize/4
        }

        Label {
            id: nameLabel
            text: "Wallet name:"
            color: "black"
            font.family: xciteMobile.name
            font.pixelSize: downloadLabel.font.pixelSize*1.5
            anchors.left: amountValue.left
            anchors.bottom: walletName.top
            anchors.bottomMargin: font.pixelSize/4
        }
    }

    Item {
        id: keyArea
        height: parent.height
        width: parent.width/3
        anchors.right: parent.right
        anchors.top: parent.top
        clip: true

        DropShadow {
            anchors.fill: xfuelCircle
            source: xfuelCircle
            horizontalOffset: 4
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.3
            transparentBorder: true
        }

        Rectangle {
            id: xfuelCircle
            width: parent.width
            height: width
            radius: height/2
            color: "#ffae11"
            anchors.top: parent.top
            anchors.topMargin: -height*0.4
            anchors.right: parent.right
            anchors.rightMargin: -height*0.4
        }

        Image {
            source: "qrc:/icons/white logo.png"
            height: downloadQr.height
            fillMode: Image.PreserveAspectFit
            anchors.right: parent.right
            anchors.rightMargin: parent.width*0.1
            anchors.top: parent.top
            anchors.topMargin: parent.width*0.1
        }

        Rectangle {
            id: keyQrBg
            height: width
            width: parent.width*0.8
            color: "transparent"
            border.width: 1
            border.color: "black"
            opacity: 0.3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.width*0.1
        }

        Rectangle {
            width: keyQrBg.width*0.6
            height: width
            color: "white"
            anchors.horizontalCenter: keyQrBg.horizontalCenter
            anchors.top: keyQrBg.top
            anchors.topMargin: keyQrBg.width*0.1

            Image {
                width: parent.width*0.9
                height: parent.height*0.9
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: "image://QZXing/encode/" + privateKey
                cache: false
            }
        }

        Label {
            id: keyString
            text: privateKey
            color: "black"
            font.family: xciteMobile.name
            font.pixelSize: keyQrBg.width*0.1/2.25
            maximumLineCount: 2
            wrapMode: Text.WrapAnywhere
            anchors.right: keyQrBg.right
            anchors.rightMargin: font.pixelSize
            anchors.left: keyQrBg.left
            anchors.leftMargin: font.pixelSize
            anchors.bottom: keyQrBg.bottom
            anchors.bottomMargin: font.pixelSize/2
        }

        Label {
            text: "Private key"
            color: "black"
            font.family: xciteMobile.name
            font.pixelSize: keyString.font.pixelSize*2
            anchors.left: keyString.left
            anchors.bottom: keyString.top
        }
    }
}
