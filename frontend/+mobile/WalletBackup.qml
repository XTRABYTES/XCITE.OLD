/**
 * Filename: WalletBackup.qml
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
import QtMultimedia 5.8

import "qrc:/Controls" as Controls

Rectangle {
    id: backupModal
    width: Screen.width
    height: Screen.height
    color: bgcolor

    MouseArea {
        anchors.fill: parent
    }

    Text {
        id: backupModalLabel
        text: "WALLET BACK-UP"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Label {
        id:selectLabel
        text: "Select a wallet to back up"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: backupModalLabel.bottom
        anchors.topMargin: 20
        font.pixelSize: 18
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Rectangle {
        id: walletScrollArea
        width: parent.width
        anchors.bottom: closeBackupModal.top
        anchors.top: selectLabel.bottom
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        clip: true

        Controls.WalletDetailList {
            id: myWallets
        }
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
        id: closeBackupModal
        z: 10
        text: "CLOSE"
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
                backupTracker = 0
                selectedPage = "home"
                mainRoot.pop()
            }
        }
    }

    Controls.ScreenshotModal {
        id: myScreenshotModal
        z: 10
    }
}