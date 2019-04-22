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

    property int walletsExported: 0
    property int walletsExportedFailed: 0
    property bool exportInitiated: false

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

    Rectangle {
        id: exportWallet
        height: 34
        width: doubbleButtonWidth
        anchors.top: backupModalLabel.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        color: darktheme == true? "#14161B" : "#F2F2F2"
        opacity: 0.5
        visible: userSettings.localKeys

        MouseArea {
            anchors.fill: parent

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onReleased: {
            }

            onCanceled: {
            }

            onClicked: {
                if (exportInitiated == false){
                    exportInitiated = true
                    exportWallets()
                }
            }

            Connections {
                target: UserSettings

                onSaveFileSucceeded: {
                      if (exportInitiated == true) {
                          walletsExported = 1
                          exportInitiated = false
                      }
                }

                onSaveFileFailed: {
                    if (exportInitiated == true) {
                        walletsExportedFailed = 1
                        exportInitiated = false
                    }
                }
            }
        }
    }

    Label {
        text: "EXPORT WALLETS"
        font.family: xciteMobile.name
        font.pointSize: 14
        font.bold: true
        color: exportInitiated == false? (darktheme == true? "#F2F2F2" : maincolor) : "#979797"
        anchors.horizontalCenter: exportWallet.horizontalCenter
        anchors.verticalCenter: exportWallet.verticalCenter
        visible: userSettings.localKeys
    }

    Rectangle {
        height: 34
        anchors.left: exportWallet.left
        anchors.bottom: exportWallet.bottom
        anchors.right: exportWallet.right
        color: "transparent"
        opacity: 0.5
        border.color: exportInitiated == false? (maincolor) : "#979797"
        border.width: 1
        visible: userSettings.localKeys
    }

    Label {
        id:selectLabel
        text: "Select a wallet to back up"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: userSettings.localKeys === true? exportWallet.bottom : backupModalLabel.bottom
        anchors.topMargin: 30
        font.pixelSize: 18
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Rectangle {
        id: walletScrollArea
        width: parent.width
        anchors.bottom: closeBackupModal.top
        anchors.top: selectLabel.bottom
        anchors.topMargin: 10
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
        height: myOS === "android"? 125 : 145
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
        anchors.bottomMargin: myOS === "android"? 50 : 70
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

    Item {
        z: 10
        id: exportPopup
        height: 50
        width:exportPopupText.width + 56
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        visible: walletsExported == 1

        Rectangle {
            height: 50
            width: exportPopup.width + 56
            color: "#34363D"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: exportPopupText
            text: "Walletfile exported to download folder!"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Timer {
            repeat: false
            running: walletsExported == 1
            interval: 2000

            onTriggered: walletsExported = 0
        }
    }

    Item {
        z: 10
        id: exportPopupFail
        height: 50
        width: exportPopupFailText.width + 56
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        visible: walletsExportedFailed == 1

        Rectangle {
            height: 50
            width: exportPopupFail.width + 56
            color: "#34363D"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: exportPopupFailText
            text: "Wallet export failed!"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: "#E55541"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Timer {
            repeat: false
            running: walletsExportedFailed == 1
            interval: 2000

            onTriggered: walletsExportedFailed = 0
        }
    }

    Controls.ScreenshotModal {
        id: myScreenshotModal
        z: 10
    }
}
