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
        color: "black"
        opacity: 0.9
    }

    Label {
        id: serverErrorText
        text: "A network error occured, please try again later."
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        color: "#FD2E2E"
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
        color: "#1B2934"
        opacity: 0.5

        LinearGradient {
            anchors.fill: parent
            source: parent
            start: Qt.point(x, y)
            end: Qt.point(x, parent.height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 1.0; color: "#0ED8D2" }
            }
        }


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

    Rectangle {
        width: doubbleButtonWidth / 2
        height: 34
        anchors.horizontalCenter: okButton.horizontalCenter
        anchors.bottom: okButton.bottom
        color: "transparent"
        opacity: 0.5
        border.width: 1
        border.color: "#0ED8D2"
    }

    Rectangle {
        width: parent.width
        height: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        color: bgcolor
    }
}