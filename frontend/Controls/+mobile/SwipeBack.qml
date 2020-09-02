/**
 * Filename: SwipeBack.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0

import "qrc:/Controls" as Controls

Rectangle {
    id: swipeArea
    height: appHeight
    width: 25
    color: "transparent"
    anchors.right: Screen.right
    anchors.top: xcite.top
    z: 100
    visible: logoutTracker == 0 && goodbey == 0 && sessionStart == 1 && transactionInProgress == false

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
    /*
    MouseArea {
        id: swipeZone
        width: 25
        height: parent.height
        anchors.right: parent.right
        anchors.top: parent.top
        propagateComposedEvents: true

        onPressed: {
            resetValues()
            valueX = mouseX
            swipeStart = new Date().getTime()
        }

        onPositionChanged: {
            if (mouseX > (appWidth.width - 25)) {
                newValueX = mouseX
                swipeStop = new Date().getTime()
            }

            else {
                newValueX = appWidth.width - 25
                swipeStop = new Date().getTime()
            }
        }

        onReleased: {
            checkSwipe()
        }
    }
    */
    DropShadow {
        anchors.fill: backButton
        source: backButton
        samples: 9
        radius: 4
        color: darktheme == true? "#000000" : "#727272"
        horizontalOffset:0
        verticalOffset: 0
        spread: 0
        visible: myOS == "ios"
    }
    Rectangle {
        id: backButton2
        height: 50
        width: 50
        radius: 50
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : (isIphoneX()? 70 : 50)
        color: darktheme == true? "#14161B" : "#F2F2F2"
        opacity: 0.25
        visible: myOS == "ios"

        MouseArea {
            anchors.fill: parent

            onClicked: backButtonPressed()
        }
    }
    Image {
        id: backButton
        source: "qrc:/icons/mobile/back-icon_01.svg"
        height: 50
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: backButton2.horizontalCenter
        anchors.verticalCenter: backButton2.verticalCenter
        visible: myOS == "ios"
    }
}
