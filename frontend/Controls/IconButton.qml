import QtQuick 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

Button {
    id: button

    property alias cursorShape: mouseArea.cursorShape
    property alias icon: image
    property color iconColor: "#666"
    property color hoverColor: "white"

    text: ""

    background: Rectangle {
        color: "transparent"
    }

    state: "Default"

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onPressed: mouse.accepted = false
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: {
            button.state = 'Hovering'
        }
        onExited: {
            button.state = 'Default'
        }
    }

    ColorOverlay {
        id: overlay
        anchors.fill: image
        source: image
    }

    Image {
        id: image
        anchors.centerIn: parent
    }

    // Hovering animations
    Behavior on scale {
        NumberAnimation {
            duration: 100
            easing.type: Easing.InOutQuad
        }
    }

    states: [
        State {
            name: "Hovering"
            PropertyChanges {
                target: overlay
                color: hoverColor
            }
        },
        State {
            name: "Default"
            PropertyChanges {
                target: overlay
                color: iconColor
            }
        }
    ]

    transitions: [
        Transition {
            from: "Default"
            to: "Hovering"
            ColorAnimation {
                duration: 100
            }
        },
        Transition {
            from: "Hovering"
            to: "Default"
            ColorAnimation {
                duration: 200
            }
        }
    ]
}
