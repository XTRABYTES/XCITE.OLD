import QtQuick 2.7

Item {
    id: toggleswitch
    width: background.width
    height: background.height

    property bool on: false

    function toggle() {
        if (toggleswitch.state == "on")
            toggleswitch.state = "off"
        else
            toggleswitch.state = "on"
    }

    function releaseSwitch() {
        if (knob.x == 1) {
            if (toggleswitch.state == "off")
                return
        }
        if (knob.x == 78) {
            if (toggleswitch.state == "on")
                return
        }
        toggle()
    }

    Image {
        id: background
        source: "../../icons/Rectangle7.png"
        MouseArea {
            anchors.fill: parent
            onClicked: toggle()
        }
    }

    Image {
        id: knob
        x: 5
        y: 2
        source: "../../icons/Rectangle8.png"

        MouseArea {
            anchors.fill: parent
            drag.target: knob
            drag.axis: Drag.XAxis
            drag.minimumX: 5
            drag.maximumX: 30
            onClicked: toggle()
            onReleased: releaseSwitch()
        }
    }

    states: [
        State {
            name: "on"
            PropertyChanges {
                target: knob
                x: 30
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
            duration: 200
        }
    }
}
