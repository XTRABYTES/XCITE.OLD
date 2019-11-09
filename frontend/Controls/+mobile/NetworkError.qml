/**
 * Filename: NetworkError.qml
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
    id: serverError
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.top
    width: Screen.width
    state: networkError == 0? "up" : "down"
    color: "transparent"
    clip: true
    onStateChanged: detectInteraction()

    states: [
        State {
            name: "up"
            PropertyChanges { target: serverError; anchors.bottomMargin: 0}
            PropertyChanges { target: serverError; height: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: serverError; anchors.bottomMargin: -100}
            PropertyChanges { target: serverError; height: 100}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: serverError; property: "anchors.bottomMargin"; duration: 300; easing.type: Easing.OutCubic}
        }
    ]

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height
        color: "#2A2C31"
    }

    Label {
        id: serverErrorText
        text: "A network error occured, please try again later."
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        color: "#F2F2F2"
        font.pixelSize: 18
        font.family: xciteMobile.name
    }

    Rectangle {
        id: okButton
        width: doubbleButtonWidth / 2
        height: 34
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        color: "transparent"
        border.width: 1
        border.color: "#0ED8D2"

        MouseArea {
            anchors.fill: parent

            onPressed: {
                detectInteraction()
            }

            onReleased: {
                networkError = 0
            }
        }
    }

    Text {
        id: okButtonText
        text: "OK"
        font.family: xciteMobile.name
        font.pointSize: 14
        color: "#F2F2F2"
        font.bold: true
        anchors.horizontalCenter: okButton.horizontalCenter
        anchors.verticalCenter: okButton.verticalCenter
    }

    DropShadow {
        anchors.fill: bottomLine
        source: bottomLine
        samples: 9
        radius: 4
        color: darktheme == true? "#000000" : "#727272"
        horizontalOffset:0
        verticalOffset: 0
        spread: 0
        visible: parent.anchors.bottomMargin < 0
    }

    Rectangle {
        id: bottomLine
        width: parent.width
        height: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        color: "#34363D"
    }

    Timer {
        id: networkErrorTimer
        interval: 10000
        repeat: false
        running: networkError == 1
        onTriggered:  {
            networkError = 0
        }
    }
}
