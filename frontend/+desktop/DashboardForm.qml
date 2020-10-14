/**
 * Filename: DashboardForm.qml
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
import "qrc:/Controls/+mobile" as Mobile

Item {
    width: appWidth
    height: appHeight
    clip: true

    Rectangle {
        id: sideMenuArea
        width: appWidth/6
        height: appHeight
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        color: "#0B0B09"

        Item {
            id: appID
            width: parent.width
            height: appName.height + appVersion.height + 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: parent.width/3

            Item {
                id: appName
                width: xciteLabel.width + trademark.width + 5
                height: xciteLabel.height
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    id: xciteLabel
                    text: "XCITE"
                    color: themecolor
                    font.pixelSize: appID.width/6
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    textFormat: Text.RichText
                }

                Label {
                    id: trademark
                    text: "TM"
                    color: themecolor
                    font.family: xciteMobile.name
                    font.pixelSize: xciteLabel.font.pixelSize/3
                    anchors.top: xciteLabel.top
                    anchors.topMargin: font.pixelSize/2 * 0.75
                    anchors.right: parent.right
                    font.bold: true
                }            }

            Label {
                id: appVersion
                text: "v " + versionNR
                color: themecolor
                font.family: xciteMobile.name
                font.pixelSize: xciteLabel.font.pixelSize/3
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
            }
        }

        Item {
            id: sideMenu
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: appID.bottom
            anchors.topMargin: parent.width/3
            anchors.bottom: logoutSection.top
            anchors.bottomMargin: parent.width/3

            Rectangle {
                id: walletSection
                width: parent.width
                height: parent.height/6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                color: "transparent"

                Rectangle {
                    width: parent.width
                    height: parent.height*0.85
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    color: "#14161B"

                    Image {
                        id: walletIcon
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        source: 'qrc:/icons/mobile/wallet-icon_01.svg'
                        height: parent.height/2
                        width: parent.height/2
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        text: "WALLET"
                        color: maincolor
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/4
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: parent.height
                    }
                }
            }

            Rectangle {
                id: backupSection
                width: parent.width
                height: parent.height/6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: walletSection.bottom
                color: "transparent"

                Rectangle {
                    width: parent.width
                    height: parent.height*0.85
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    color: "#14161B"

                    Image {
                        id: backupIcon
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        source: 'qrc:/icons/mobile/wallet-backup-icon_01.svg'
                        height: parent.height/2
                        width: parent.height/2
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        text: "BACKUP"
                        color: maincolor
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/4
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: parent.height
                    }
                }
            }

            Rectangle {
                id: appsSection
                width: parent.width
                height: parent.height/6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: backupSection.bottom
                color: "transparent"

                Rectangle {
                    width: parent.width
                    height: parent.height*0.85
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    color: "#14161B"

                    Image {
                        id: appsIcon
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        source: 'qrc:/icons/mobile/dapps-icon_01.svg'
                        height: parent.height/2
                        width: parent.height/2
                        fillMode: Image.PreserveAspectFit
                    }
                    Label {
                        text: "APPS"
                        color: maincolor
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/4
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: parent.height
                    }
                }
            }

            Rectangle {
                id: alertSection
                width: parent.width
                height: parent.height/6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: appsSection.bottom
                color: "transparent"

                Rectangle {
                    width: parent.width
                    height: parent.height*0.85
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    color: "#14161B"

                    Image {
                        id: alertIcon
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        source: 'qrc:/icons/mobile/notification-icon_01.svg'
                        height: parent.height/2
                        width: parent.height/2
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        text: "ALERTS"
                        color: maincolor
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/4
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: parent.height
                    }
                }
            }

            Rectangle {
                id: addressbookSection
                width: parent.width
                height: parent.height/6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: alertSection.bottom
                color: "transparent"

                Rectangle {
                    width: parent.width
                    height: parent.height*0.85
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    color: "#14161B"

                    Image {
                        id: addressbookIcon
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        source: 'qrc:/icons/mobile/addressbook-icon_01.svg'
                        height: parent.height/2
                        width: parent.height/2
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        text: "ADDRESSBOOK"
                        color: maincolor
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/4
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: parent.height
                    }
                }
            }

            Rectangle {
                id: settingsSection
                width: parent.width
                height: parent.height/6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: addressbookSection.bottom
                color: "transparent"

                Rectangle {
                    width: parent.width
                    height: parent.height*0.85
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    color: "#14161B"

                    Image {
                        id: settingsIcon
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        source: 'qrc:/icons/mobile/settings-icon_01.svg'
                        height: parent.height/2
                        width: parent.height/2
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: settingsLabel
                        text: "SETTINGS"
                        color: maincolor
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/4
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: parent.height
                    }
                }
            }
        }

        Item {
            id: logoutSection
            width: sideMenuArea.width
            height: logoutIcon.height
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15

            Image {
                id: logoutIcon
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: 10
                source: 'qrc:/icons/mobile/logout-icon_01.svg'
                width: settingsIcon.width
                height: settingsIcon.height
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: logoutText
                text: "LOG OUT"
                color: maincolor
                font.family: xciteMobile.name
                font.pixelSize: settingsLabel.font.pixelSize
                anchors.verticalCenter: logoutIcon.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: settingsSection.height*0.85
            }

            Rectangle {
                id: logoutButtonArea
                anchors.fill: parent
                color: "transparent"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        click01.play()
                        detectInteraction()
                        sessionStart = 0
                        sessionTime = 0
                        manualLogout = 1
                        logoutTracker = 1
                    }
                }
            }
        }
    }

    Rectangle {
        id: mainArea
        height: appHeight
        anchors.left: sideMenuArea.right
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        color: "#14161B"

        Image {
            id: combinationMark
            source: 'qrc:/icons/xby_logo_with_name.png'
            width: appWidth*0.3
            fillMode: Image.PreserveAspectFit
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: -50
        }
    }

    Mobile.ClickToLogout {
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
        visible: clickToLogout == 1
    }
}
