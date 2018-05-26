/**
 * Filename: ModuleMenuButton.qml
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
import "../Theme" 1.0

Rectangle {
    id: button

    property string name
    property string target
    property alias text: label.text

    property bool isSelected: selected === this.name

    height: 49
    width: 123

    color: isSelected ? "transparent" : (state
                                         == "hover" ? Theme.panelBackground : Theme.panelBackground)
    radius: panelBorderRadius

    states: [
        State {
            name: "hover"
            PropertyChanges {
                target: label
                color: isSelected ? Theme.primaryHighlight : (state == "hover" ? Theme.panelBackground : Theme.primaryHighlight)
            }
        }
    ]

    Text {
        id: label
        anchors.centerIn: parent
        font.pixelSize: 16
        font.family: Theme.fontCondensed
        color: isSelected ? Theme.primaryHighlight : "#A9ADAA"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            selectView(target)
        }

        hoverEnabled: true
        onHoveredChanged: {
            button.state = containsMouse ? "hover" : ""
        }
    }

    // Hovering animations
    Behavior on scale {
        NumberAnimation {
            duration: 150
            easing.type: Easing.InOutQuad
        }
    }

    transitions: [
        Transition {
            from: ""
            to: "hover"
            ColorAnimation {
                duration: 150
            }
        },
        Transition {
            from: "hover"
            to: ""
            ColorAnimation {
                duration: 150
            }
        }
    ]

    Rectangle {
        visible: isSelected
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        height: 5
        width: parent.width
        color: Theme.secondaryHighlight
    }
}
