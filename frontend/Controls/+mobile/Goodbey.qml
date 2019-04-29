/**
 * Filename: Goodbey.qml
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
    id: goodbeyModal
    width: Screen.width
    state: goodbey == 1? "up" : "down"
    height: Screen.height
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    states: [
        State {
            name: "up"
            PropertyChanges { target: goodbeyModal; visible: true}
        },
        State {
            name: "down"
            PropertyChanges { target: goodbeyModal; visible: false}
        }
    ]

    Label {
        id:goodbeyModalLabel
        text: "GOODBYE"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        state: goodbey == 1? "up" : "down"

        states: [
            State {
                name: "up"
                PropertyChanges { target: goodbeyModalLabel; opacity: 1}
            },
            State {
                name: "down"
                PropertyChanges { target: goodbeyModalLabel; opacity: 0}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: goodbeyModalLabel; property: "opacity"; duration: 500; easing.type: Easing.InCubic}
            }
        ]
    }

    Timer {
        id: logoutTimer
        interval: 2500
        repeat : false
        running: goodbey == 1

        onTriggered: {
            autoLogout = 0
            pinLogout = 0
            networkLogout = 0
            sessionStart = 0
            sessionClosed = 1
            logOut()
        }
    }
}
