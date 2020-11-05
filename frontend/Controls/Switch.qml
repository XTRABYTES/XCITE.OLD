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

Item {
    id: toggleswitch
    width: background.width
    height: background.height
    state: switchOn? "on" : "off"

    property bool switchOn: false
    property bool switchActive: true

    function toggle() {
        if (toggleswitch.state == "on")
            toggleswitch.state = "off"
        else
            toggleswitch.state = "on"
    }

    function releaseSwitch() {
        if (knob.x == 2) {
            if (toggleswitch.state == "off")
                return
        }
        if (knob.x == (background.width/2 - knob.width/2)) {
            if (toggleswitch.state == "on")
                return
        }
        toggle()
    }

    Rectangle {
        id: background
        width: appWidth/18
        height: appHeight/27
        color: switchOn? maincolor : (darktheme == true? "#000000" : "#FFFFFF")
        border.width: 1
        border.color: themecolor
        radius: height/2
        MouseArea {
            anchors.fill: parent
            enabled: switchActive
            onClicked: toggle()
        }
    }

    Rectangle {
        id: knob
        x: 2
        y: 2
        height: background.height - 4
        width: height
        color: themecolor
        radius: height/2
        MouseArea {
            anchors.fill: parent
            enabled: switchActive
            drag.target: knob
            drag.axis: Drag.XAxis
            drag.minimumX: 2
            drag.maximumX: background.width - (knob.width + 3)
            onClicked: toggle()
            onReleased: releaseSwitch()
        }
    }

    states: [
        State {
            name: "on"
            PropertyChanges {
                target: knob
                x: background.width - (knob.width + 3)
            }
            PropertyChanges {
                target: toggleswitch
                switchOn: true
            }
        },
        State {
            name: "off"
            PropertyChanges {
                target: knob
                x: 3
            }
            PropertyChanges {
                target: toggleswitch
                switchOn: false
            }
        }
    ]

    transitions: Transition {
        NumberAnimation {
            properties: "x"
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }
}
