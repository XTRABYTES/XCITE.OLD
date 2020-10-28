/**
* Filename: WalletInfo.qml
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
    id: backgroundBackup
    z: 1
    width: appWidth/6 * 5
    height: appHeight
    anchors.right: parent.right
    anchors.top: parent.top
    color: "transparent"

    Label {
        id: walletInfoLabel
        text: "BACKUP - " + walletList.get(walletIndex).name + " " + walletList.get(walletIndex).label
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        color: themecolor
        font.letterSpacing: 2
        horizontalAlignment: Text.AlignRight
        elide: Text.ElideRight
    }

    Rectangle {
        width: seperatortop.width
        anchors.left: seperatortop.left
        anchors.right: seperatortop.right
        anchors.top: seperatortop.bottom
        anchors.bottom: seperatorBottom.top
        color: "transparent"

        Image {
            id: icon
            source: getLogo(coinName.text)
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height*2/3
            fillMode: Image.PreserveAspectFit
        }

        Label {
            id: coinName
            anchors.left: icon.right
            anchors.leftMargin: appWidth/96
            anchors.top: parent.top
            anchors.topMargin: parent.height/6
            text: walletList.get(walletIndex).name
            font.pixelSize: parent.height/3
            font.family: xciteMobile.name
            font.bold: true
            color: themecolor
        }

        Label {
            id: walletName
            anchors.right: parent.right
            anchors.rightMargin: appWidth/96
            anchors.left: coinName.right
            anchors.leftMargin: appWidth/96
            anchors.top: parent.top
            anchors.topMargin: parent.height/6
            text: walletList.get(walletIndex).label
            font.pixelSize: parent.height/3
            font.family: xciteMobile.name
            font.bold: true
            color: themecolor
            elide: Text.ElideRight
        }

        Label {
            id: addressLabel
            anchors.right: parent.right
            anchors.rightMargin: appWidth/96
            anchors.left: coinName.left
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height/6
            text: walletList.get(walletIndex).address
            font.pixelSize: parent.height/3 *0.8
            font.family: xciteMobile.name
            color: themecolor
            elide: Text.ElideRight
        }
    }

    Rectangle {
        id: seperatortop
        height: 0.5
        anchors.top: walletInfoLabel.bottom
        anchors.topMargin: appWidth/12
        anchors.right: walletInfoLabel.right
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        color: themecolor
        opacity: 0.1
    }

    Rectangle {
        id: seperatorBottom
        height: 0.5
        anchors.top: seperatortop.bottom
        anchors.topMargin: appHeight/12
        anchors.right: walletInfoLabel.right
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        color: themecolor
        opacity: 0.1
    }

    Rectangle {
        id: qrBackground
        width: seperatorBottom.width
        anchors.top: seperatorBottom.bottom
        anchors.bottom: bottomBar.top
        anchors.left: seperatorBottom.left
        color: "transparent"

        Rectangle {
            id: addressArea
            height: parent.height*2/3
            width: height
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: appWidth/12
            color: "transparent"
            border.width: 0.5
            border.color: themecolor

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: appHeight/72
                text: "Your wallet ADDRESS"
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                color: themecolor
            }

            Rectangle {
                id: qrPlaceholder1
                width: addressArea.width/2
                height: width
                anchors.horizontalCenter: addressArea.horizontalCenter
                anchors.top: addressArea.top
                anchors.topMargin: appWidth/24
                color: "white"
                border.color: themecolor
                border.width: 1

                Image {
                    width: parent.width*0.95
                    height: parent.height*0.95
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    source: "image://QZXing/encode/" + walletList.get(walletIndex).address
                    cache: false
                }
            }

            Text {
                width: parent.width*0.8
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: appHeight/36
                text: walletList.get(walletIndex).address
                maximumLineCount: 2
                wrapMode: Text.WrapAnywhere
                font.pixelSize: appHeight/54
                font.family: xciteMobile.name
                color: themecolor
            }
        }

        Rectangle {
            id: privateArea
            height: parent.height*2/3
            width: height
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: appWidth/12
            color: "transparent"
            border.width: 0.5
            border.color: themecolor

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: appHeight/72
                text: "Your wallet PRIVATE KEY"
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                color: themecolor
            }

            Rectangle {
                id: qrPlaceholder2
                width: privateArea.width/2
                height: width
                anchors.horizontalCenter: privateArea.horizontalCenter
                anchors.top: privateArea.top
                anchors.topMargin: appWidth/24
                color: "white"
                border.color: themecolor
                border.width: 1

                Image {
                    width: parent.width*0.95
                    height: parent.height*0.95
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    source: "image://QZXing/encode/" + walletList.get(walletIndex).privatekey
                    cache: false
                }
            }

            Text {
                width: parent.width*0.8
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: appHeight/36
                text: walletList.get(walletIndex).privatekey
                maximumLineCount: 2
                wrapMode: Text.WrapAnywhere
                font.pixelSize: appHeight/54
                font.family: xciteMobile.name
                color: themecolor
            }
        }
    }

    Rectangle {
        id: bottomBar
        height: appWidth/24
        width: parent.width
        anchors.bottom: parent.bottom
        color: darktheme == true? "#14161B" : "#FDFDFD"
    }
}
