/**
 * Filename: LogOut.qml
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
    id: confirmLogoutBG
    width: appWidth
    height: appHeight
    color: "transparent"

    MouseArea {
        anchors.fill: parent

        onClicked: clickToLogout = 0
    }

    DropShadow {
        z: 12
        anchors.fill: textPopup
        source: textPopup
        horizontalOffset: 0
        verticalOffset: 4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.4
        transparentBorder: true
    }

    Item {
        id: textPopup
        z: 12
        width: popupClickAgain.width
        height: popupClickAgain.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 75

        Rectangle {
            id: popupClickAgain
            height: 50
            width: popupClickAgainText.width + 20
            color: "#34363D"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: popupClickAgainText
            text: "Press <b>back</b> or <b>swipe left</b> again to log out."
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: "#F2F2F2"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Timer {
        id: clickToLogoutTimer
        interval: 3000
        repeat: false
        running: clickToLogout == 1

        onTriggered: {
            clickToLogout = 0
        }
    }
}
