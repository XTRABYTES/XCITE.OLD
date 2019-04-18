/**
 * Filename: ScreenshotModal.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

import QtQuick.Controls 2.3
import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import Clipboard 1.0
import QZXing 2.3
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: screenShotModal
    width: Screen.width
    state: screenshotTracker == 1? "up" : "down"
    height: Screen.height
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: Screen.height

    states: [
        State {
            name: "up"
            PropertyChanges { target: screenShotModal; anchors.topMargin: 0}
            PropertyChanges { target: screenShotModal; opacity: 1}
        },
        State {
            name: "down"
            PropertyChanges { target: screenShotModal; anchors.topMargin: Screen.height}
            PropertyChanges { target: screenShotModal; opacity: 0}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: screenShotModal; properties: "anchors.topMargin, opacity"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    Text {
        id: screenshotModalLabel
        text: "TAKE A SCREENSHOT TO BACK UP"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 15
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Item {
        id: coinId
        height: coinLogo.height
        width: coinLogo.width + coinName.width + 7
        anchors.top: screenshotModalLabel.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: coinLogo
            source: getLogo(coinName.text)
            height: 30
            width: 30
            anchors.left: parent.left
            anchors.top: parent.top
        }

        Label {
            id: coinName
            anchors.left: coinLogo.right
            anchors.leftMargin: 7
            anchors.verticalCenter: coinLogo.verticalCenter
            text: walletList.get(walletIndex).name
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            font.letterSpacing: 2
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            font.bold: true
        }
    }

    Label {
        id: walletName
        width: doubbleButtonWidth
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: coinId.bottom
        anchors.topMargin: 5
        text: walletList.get(walletIndex).label
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        font.letterSpacing: 2
        color: darktheme == false? "#2A2C31" : "#F2F2F2"
        font.bold: true
        elide: Text.ElideRight
    }

    Label {
        id:addressTextLabel
        text: "Your wallet ADDRESS:"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: walletName.bottom
        anchors.topMargin: 10
        font.pixelSize: 18
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Rectangle {
        id: qrBorder1
        radius: 4
        width: 100
        height: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: addressTextLabel.bottom
        anchors.topMargin: 5
        color: "#FFFFFF"
    }

    Item {
        id: qrPlaceholder1
        width: 90
        height: 90
        anchors.horizontalCenter: qrBorder1.horizontalCenter
        anchors.verticalCenter: qrBorder1.verticalCenter

        Image {
            anchors.fill: parent
            source: "image://QZXing/encode/" + walletList.get(walletIndex).address
            cache: false
        }
    }

    Label {
        id:addressLabel
        text: walletList.get(walletIndex).address
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: qrBorder1.bottom
        anchors.topMargin: 10
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Label {
        id:privateKeyTextLabel
        text: "Your wallet PRIVATE KEY:"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: addressLabel.bottom
        anchors.topMargin: 30
        font.pixelSize: 18
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Rectangle {
        id: qrBorder2
        radius: 4
        width: 150
        height: 150
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: privateKeyTextLabel.bottom
        anchors.topMargin: 5
        color: "#FFFFFF"
    }

    Item {
        id: qrPlaceholder2
        width: 135
        height: 135
        anchors.horizontalCenter: qrBorder2.horizontalCenter
        anchors.verticalCenter: qrBorder2.verticalCenter

        Image {
            anchors.fill: parent
            source: "image://QZXing/encode/" + walletList.get(walletIndex).privatekey
            cache: false
        }
    }

    Label {
        id:privateKeyLabel
        width: doubbleButtonWidth
        text: walletList.get(walletIndex).privatekey
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: qrBorder2.bottom
        anchors.topMargin: 10
        maximumLineCount: 3
        horizontalAlignment: Text.AlignLeft
        wrapMode: Text.WrapAnywhere
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Item {
        z: 3
        width: Screen.width
        height: 125
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(x, y)
            end: Qt.point(x, y + height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.5; color: darktheme == true? "#14161B" : "#FDFDFD" }
                GradientStop { position: 1.0; color: darktheme == true? "#14161B" : "#FDFDFD" }
            }
        }
    }

    Label {
        id: closeScreenshotModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"

        Rectangle{
            id: closeButton
            height: 34
            width: parent.width
            radius: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

        }

        MouseArea {
            anchors.fill: closeButton

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                screenshotTracker = 0
            }
        }
    }
}

