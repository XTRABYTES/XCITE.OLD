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
    color: "#E55541"
    clip: true
    onStateChanged: detectInteraction()

    property int myTracker: networkError

    onMyTrackerChanged: {
        if (networkError == 0) {

        }
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: serverError; anchors.bottomMargin: 0}
            PropertyChanges { target: serverError; height: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: serverError; anchors.bottomMargin: -20}
            PropertyChanges { target: serverError; height: 20}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: serverError; property: "anchors.bottomMargin"; duration: 300; easing.type: Easing.OutCubic}
        }
    ]

    Label {
        id: serverErrorText
        text: "A network error occured, please try again later."
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "#F2F2F2"
        font.pixelSize: 12
        font.family: xciteMobile.name
    }

    Timer {
        id: networkErrorTimer
        interval: 16000
        repeat: false
        running: networkError == 1
        onTriggered:  {
            networkError = 0
        }
    }
}
