/**
 * Filename: SideMenuButtonSmall.qml
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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3

import "../Theme" 1.0

Label {
    id: button

    property string name: "xCite.settings"
    property bool isActive: false
    property bool isLit: false
    signal buttonClicked

    background: Rectangle {
        color: isActive ? "#2F3238" : "transparent"
    }

    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 2
        color: "#2B2C31"
    }

    Rectangle {
        visible: isActive
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: 5
        color: Theme.secondaryHighlight
    }

    font.pixelSize: 10
    color: (isLit || isActive) ? Theme.primaryHighlight : "#A9AAAD"
    topPadding: 2
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    states: [
        State {
            name: "Hovering"
            PropertyChanges {
                target: button
                color: Theme.primaryHighlight
            }
        },
        State {
            name: "Default"
            PropertyChanges {
                target: button
                color: getDefaultColor()
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

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: buttonClicked()

        hoverEnabled: true
        onHoveredChanged: containsMouse ? button.state = "Hovering" : button.state = "Default"
    }

    function getDefaultColor() {
        return (isLit || isActive) ? Theme.primaryHighlight : "#A9AAAD"
    }
}
