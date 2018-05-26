/**
 * Filename: ComboBox.qml
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
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0

ComboBox {
    id: control
    contentItem: Text {
        text: control.displayText
        color: control.pressed ? "white" : "#d5d5d5"
        verticalAlignment: Text.AlignVCenter
        font.weight: Font.Light
        font.pixelSize: 16
        leftPadding: 10
        rightPadding: 10
        elide: Text.ElideRight
    }

    onHoveredChanged: {
        hovered ? background.state = "Hovering" : background.state = "Default"
    }

    property string defaultBackgroundColor: "#2A2C31"
    property string hoveringBackgroundColor: "#46464b"

    background: Rectangle {
        id: background
        radius: 6
        color: "#2A2C31"
        implicitHeight: 47

        state: "Default"

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
                    target: background
                    color: hoveringBackgroundColor
                }
            },
            State {
                name: "Default"
                PropertyChanges {
                    target: background
                    color: defaultBackgroundColor
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
}
