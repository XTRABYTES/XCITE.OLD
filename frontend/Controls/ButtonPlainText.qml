/**
 * Filename: ButtonPlainText.qml
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

    signal buttonClicked
    width: 250
    height: 25
    color: "transparent"

    property string defaultUnderlineColor: "transparent"
    property string hoveringUnderlineColor: "#10B9C5"

    state: "Default"

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.buttonClicked()
        }
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onHoveredChanged: containsMouse ? root.state = "Hovering" : root.state = "Default"
    }

    Rectangle {
        id: underline
        height: 1
        width: parent.width
        color: defaultUnderlineColor
        anchors.bottom: parent.bottom
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
                target: underline
                color: hoveringUnderlineColor
            }
        },
        State {
            name: "Default"
            PropertyChanges {
                target: underline
                color: defaultUnderlineColor
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
