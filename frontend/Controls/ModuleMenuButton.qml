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

    color: isSelected ? "transparent" : (state == "hover" ? "#302f2f" : Theme.panelBackground)
    radius: panelBorderRadius

    states: [
        State {
            name: "hover"
            PropertyChanges {
                target: button
                color: isSelected ? "#0DD8D2" : (state == "hover" ? "#302f2f" : "transparent")
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
}
