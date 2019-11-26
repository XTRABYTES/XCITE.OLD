/**
* Filename: XChatDndNotification.qml
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
import SortFilterProxyModel 0.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.11
import QtQuick.Window 2.2

import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: xchatDndModal
    width: Screen.width
    height: Screen.height
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    visible: dndTracker == 1

    MouseArea {
        anchors.fill: parent
    }

    Rectangle {
        width: Screen.width
        height: Screen.height
        color: "black"
        opacity: 0.5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
    }

    DropShadow {
        anchors.fill: notificationBox
        source: notificationBox
        samples: 9
        radius: 4
        color: darktheme == true? "#000000" : "#727272"
        horizontalOffset:0
        verticalOffset: 0
        spread: 0
    }

    Rectangle {
        id: notificationBox
        width: notification.width + 56
        height: 50
        color: darktheme == true? "#2A2C31" : "#F2F2F2"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50

        Item {
            id: notification
            width: notificationIcon.width + notificationText.width + 15
            height: notificationIcon.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: notificationIcon
                source: 'qrc:/icons/mobile/warning-icon_01_yellow.svg'
                height: 30
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: notification.verticalCenter
                anchors.left: notification.left
            }

            Label {
                id: notificationText
                text: "<font color='#0ED8D2'><b>" + dndUser + "</b></font>" + " does not want to be disturbed"
                color: themecolor
                font.pixelSize: 12
                font.family: xciteMobile.name
                anchors.verticalCenter: notification.verticalCenter
                anchors.right: notification.right
            }
        }
    }

    Timer {
        id: dndTimer
        interval: 2000
        repeat: false
        running: dndTracker == 1

        onTriggered: {
            dndTracker = 0
            dndUser = ""
        }
    }
}

