/**
 * Filename: ButtonSimple.qml
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

Rectangle {
    id: root
    // export button properties
    property alias text: label.text
    signal buttonClicked
    property string backgroundColor: "transparent"
    property string foregroundColor: "#10B9C5"
    property string hoverBackgroundColor: root.color
    property string hoverForegroundColor: label.color

    width: 250
    height: 40
    border.color: "#10B9C5"
    border.width: 2
    color: backgroundColor
    state: "Default"

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            root.buttonClicked()
        }
        hoverEnabled: true
        onHoveredChanged: containsMouse ? root.state = "Hovering" : root.state = "Default"
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: "Start"
        font.family: "Roboto Thin"
        font.pointSize: 12
        color: foregroundColor
        opacity: 0.9
    }

    // Hovering animations
    Behavior on scale {
        NumberAnimation {
            duration: 150
            easing.type: Easing.InOutQuad
        }
    }

    states: [
        State {
            name: "Hovering"
            PropertyChanges {
                target: root
                color: hoverBackgroundColor
            }
            PropertyChanges {
                target: label
                color: hoverForegroundColor
            }
        },
        State {
            name: "Default"
            PropertyChanges {
                target: root
                color: backgroundColor
            }
            PropertyChanges {
                target: root
                color: backgroundColor
            }
        }
    ]

    transitions: [
        Transition {
            from: "Default"
            to: "Hovering"
            ColorAnimation {
                duration: 150
            }
        },
        Transition {
            from: "Hovering"
            to: "Default"
            ColorAnimation {
                duration: 300
            }
        }
    ]
}
