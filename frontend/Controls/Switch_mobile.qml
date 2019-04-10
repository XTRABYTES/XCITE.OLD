/**
 * Filename: Switch.qml
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
import QtGraphicalEffects 1.0



Item {
    id: toggleswitch
    width: background.width
    height: background.height

    property bool on: false

    function toggle() {
        if (toggleswitch.state == "on"){
            toggleswitch.state = "off"
        }
        else
            toggleswitch.state = "on"
    }

    function releaseSwitch() {
        if (knob.x == 5) {
            if (toggleswitch.state == "off")
                return
        }
        if (knob.x == 35) {
            if (toggleswitch.state == "on")
                return
        }
        toggle()
    }

    Rectangle {
        id: background
        width: 60
        height: 30
        radius: 15
        color: "black"
        opacity: 0.35
        border.color: "#F2F2F2"
        border.width: 1

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (coinListTracker === 0 && walletListTracker === 0) {
                    toggle()
                }
            }
        }

        InnerShadow {
            anchors.fill: background
            radius: 12
            samples: 17
            horizontalOffset: 0
            verticalOffset: 2
            color: "#2A2C31"
            source: background
        }
    }

    Rectangle {
        id: knob
        width: 20
        height: 20
        radius: 10
        color: "#F2F2F2"
        x: 5
        y: 5

        MouseArea {
            anchors.fill: parent
            drag.target: knob
            drag.axis: Drag.XAxis
            drag.minimumX: 5
            drag.maximumX: 35
            enabled: coinListTracker === 0 && walletListTracker === 0
            onClicked: {
                toggle()
            }
            onReleased: {
                releaseSwitch()
            }
        }
    }

    states: [
        State {
            name: "on"
            PropertyChanges {
                target: knob
                x: 35
            }
            PropertyChanges {
                target: toggleswitch
                on: true
            }
        },
        State {
            name: "off"
            PropertyChanges {
                target: knob
                x: 5
            }
            PropertyChanges {
                target: toggleswitch
                on: false
            }
        }
    ]

    transitions: Transition {
        NumberAnimation {
            properties: "x"
            easing.type: Easing.InOutQuad
            duration: 150
        }
    }
}
