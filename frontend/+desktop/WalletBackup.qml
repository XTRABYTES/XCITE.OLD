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
    anchors.right: xcite.right
    anchors.top: xcite.top
    color: bgcolor

    property int walletsExported: 0
    property int walletsExportedFailed: 0
    property bool exportInitiated: false
    property int myTracker: backupTracker
    property bool myTheme: darktheme

    onMyThemeChanged: {

    }

    onMyTrackerChanged: {
        walletsExported = 0
        walletsExportedFailed = 0
    }

    Label {
        id: walletBackupLabel
        text: "BACKUP"
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        color: themecolor
        font.letterSpacing: 2
    }

    Rectangle {
        id: exportWallet
        height: appHeight/24
        width: appWidth/6*1.5
        radius: height/2
        anchors.top: walletBackupLabel.bottom
        anchors.topMargin: appHeight/24
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        border.width: 1
        border.color: themecolor
        visible: userSettings.localKeys

        Rectangle {
            id: selectExport
            anchors.fill: parent
            radius: height/2
            color: maincolor
            opacity: 0.3
            visible: false
        }

        Label {
            id: exportWalletLabel
            text: exportInitiated == false? "EXPORT ALL WALLETS" : "EXPORTING WALLETS ..."
            font.family: xciteMobile.name
            font.pointSize: parent.height/2
            color: themecolor
            anchors.horizontalCenter: exportWallet.horizontalCenter
            anchors.verticalCenter: exportWallet.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onEntered: {
                if (exportInitiated == false) {
                    selectExport.visible = true
                }
            }

            onExited: {
               selectExport.visible = false
            }

            onClicked: {
                if (exportInitiated == false){
                    exportInitiated = true
                    exportWallets()
                }
            }

            Timer {
                id: timer1
                running: false
                repeat: false
                interval: 3000

                onTriggered: {
                    walletsExported = 0
                }
            }

            Connections {
                target: UserSettings

                onSaveFileSucceeded: {
                      if (exportInitiated == true) {
                          walletsExported = 1
                          exportInitiated = false
                          timer1.start()
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

    Rectangle {
        id: walletArea
        width: parent.width
        anchors.top: walletBackupLabel.bottom
        anchors.topMargin: appHeight/8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: appWidth/24
        anchors.left: parent.left
        color: "transparent"
        clip: true

        Desktop.WalletDetailList {
            id: myWalletList
            anchors.top: parent.top
        }
    }

    Rectangle {
        id: walletInfoArea
        width: parent.width
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: appWidth/24
        anchors.left: parent.left
        color: bgcolor
        clip: true
        state: screenshotTracker == 1? "up" : "down"

        states: [
            State {
                name: "up"
                PropertyChanges { target: walletInfoArea; anchors.topMargin: 0}
            },
            State {
                name: "down"
                PropertyChanges { target: walletInfoArea; anchors.topMargin: appHeight}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: walletInfoArea; properties: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
            }
        ]

        MouseArea {
            anchors.fill: parent
        }

        Desktop.WalletInfo {
            id: myWalletInfo
            anchors.top: parent.top
        }
    }

    Rectangle {
        height: appWidth/24
        width: parent.width
        anchors.bottom: parent.bottom
        color: darktheme == true? "#14161B" : "#FDFDFD"
    }

    Rectangle {
        id: exportReplyModal
        width: parent.width
        height: parent.height
        color: "transparent"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        state: (walletsExported == 1 || walletsExportedFailed == 1)? "up" : "down"

        onStateChanged: {
            detectInteraction()
        }

        states: [
            State {
                name: "up"
                PropertyChanges { target: exportReplyModal; anchors.topMargin: 0}
            },
            State {
                name: "down"
                PropertyChanges { target: exportReplyModal; anchors.topMargin: exportReplyModal.height}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: exportReplyModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
            }
        ]

        Rectangle {
            anchors.fill: parent
            color: bgcolor
            opacity: 0.9

            MouseArea {
                anchors.fill: parent
            }
        }

        //export wallets failed

        Rectangle {
            id: exportWalletsFailed
            width: parent.width/3
            height: exportFailedLabel.height + exportFailedLabel.anchors.topMargin +
                    (closeFailed.height*2) + closeFailed.anchors.topMargin
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: darktheme == true? "#0B0B09" : "#FFFFFF"
            border.color: maincolor
            border.width: 2
            visible: walletsExportedFailed == 1

            Label {
                id: exportFailedLabel
                text: "Failed to export your wallets!"
                color: themecolor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: appHeight/9
                font.pixelSize: appHeight/36*0.8
                font.family: xciteMobile.name
            }

            Rectangle {
                id: closeFailed
                width: appWidth/6
                height: appHeight/18
                radius: height/2
                color: "transparent"
                anchors.top: exportFailedLabel.bottom
                anchors.topMargin: appHeight/18
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1
                border.color: maincolor

                Rectangle {
                    id: selectClose
                    anchors.fill: parent
                    radius: height/2
                    color: maincolor
                    opacity: 0.3
                    visible: false
                }

                MouseArea {
                    anchors.fill: closeFailed
                    hoverEnabled: true

                    onEntered: {
                        selectClose.visible = true
                    }

                    onExited: {
                        selectClose.visible = false
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        walletsExportedFailed = 0;
                    }
                }

                Text {
                    text: "TRY AGAIN"
                    font.family: xciteMobile.name
                    font.pointSize: parent.height/2
                    color: maincolor
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        //export wallets succeeded

        Rectangle {
            id: exportWalletsSucceed
            width: parent.width/3
            height: appHeight*9/36
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: darktheme == true? "#0B0B09" : "#FFFFFF"
            border.color: maincolor
            border.width: 2
            visible: walletsExported == 1

            Label {
                id: exportSuccessLabel
                text: "Wallets exported to device!"
                color: themecolor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: appHeight/9
                font.pixelSize: appHeight/36*0.8
                font.family: xciteMobile.name
            }
        }
    }
}
