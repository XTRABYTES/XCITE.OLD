/**
* Filename: PlayerNotAvailable.qml
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
    id: notAvailableModal
    width: Screen.width
    height: Screen.height
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    visible: playerNotAvailable == 1

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
            width: notificationText.width + 15
            height: notificationText.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                id: notificationText
                text: "Player not available!"
                color: "#F2F2F2"
                font.pixelSize: 16
                font.family: xciteMobile.name
                anchors.verticalCenter: notification.verticalCenter
                anchors.horizontalCenter: notification.horizontalCenter
            }
        }
    }

    Timer {
        id: notAvailableTimer
        interval: 2000
        repeat: false
        running: playerNotAvailable == 1

        onTriggered: {
            playerNotAvailable = 0
        }
    }
}

