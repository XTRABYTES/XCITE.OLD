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

    property int valueX: 0
    property int newValueX: 0
    property int swipeStart: 0
    property int swipeStop: 0

    function resetValues() {
        valueX = 0
        newValueX = 0
        swipeStart = 0
        swipeStop = 0
    }

    function checkSwipe() {
        if ((valueX - newValueX) > 10) {
            if (swipeStop - swipeStart < 100) {
                resetValues()
                backButtonPressed()
            }
            else {
                resetValues()
            }
        }
        else {
            resetValues()
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: clickToLogout = 0

        onPressed: {
            resetValues()
            valueX = mouseX
            swipeStart = new Date().getTime()
        }

        onPositionChanged: {
            newValueX = mouseX
            swipeStop = new Date().getTime()
        }

        onReleased: {
            checkSwipe()
        }
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
            color: darktheme == true? "#F2F2F2" : "#34363D"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: popupClickAgainText
            text: "Press <b>back</b> to log out."
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: darktheme == true? "#2A2C31" : "#F2F2F2"
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
