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
import QtQuick.Layouts 1.3
import "Controls" as Controls
import "Onboarding" as Onboarding
import "XCITE" as XCITE
import "X-Change" as XChange
import "X-Vault" as XVault
import "tools" as Tools
import "Settings" as Settings


// TODO: Currently this is a low-performance proof of concept demonstrating scalability.
// For production, this should be refactored to make proper use of Loaders, limit the use of JavaScript functions, etc.
// More information: http://doc.qt.io/qt-5/scalability.html
Item {
    width: appWidth
    height: appHeight
    clip: true

    Rectangle {
        id: sideMenuArea
        width: appWidth/4 * 1.2
        height: appHeight
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        color: "#14161B"

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
                anchors.leftMargin: 28
                source: 'qrc:/icons/mobile/logout-icon_01.svg'
                width: 30
                height: 30
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: logoutText
                text: "LOG OUT"
                color: maincolor
                font.family: xciteMobile.name
                font.pixelSize: 18
                anchors.verticalCenter: logoutIcon.verticalCenter
                anchors.left: logoutIcon.right
                anchors.leftMargin: 10
                font.bold: true
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
        color: "#2A2C31"
    }
}
