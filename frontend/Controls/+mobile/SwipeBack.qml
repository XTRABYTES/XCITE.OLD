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

import "qrc:/Controls" as Controls

Rectangle {
    id: swipeArea
    height: appHeight
    width: 25
    color: "transparent"
    anchors.right: Screen.right
    z: 100

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
        id: swipeZone
        anchors.fill: parent

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
}
