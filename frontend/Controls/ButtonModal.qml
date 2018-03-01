import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import "../Theme" 1.0

Button {
    id: buttonModalId

    property bool isPrimary: false
    property bool isDanger: false
    property alias label: label
    property string labelText: label.text || qsTr("OK")
    property real buttonHeight: parent.height

    Layout.fillWidth: true
    height: buttonHeight

    signal buttonClicked

    state: "Default"

    states: [
        State {
            name: "Default"
            PropertyChanges {
                target: buttonModalBackgroundId
                opacity: 0.8
                color: getBackgroundColor()
            }
            PropertyChanges {
                target: label
                opacity: 0.8
            }
        },
        State {
            name: "Hovering"
            PropertyChanges {
                target: buttonModalBackgroundId
                opacity: 1.0
                color: !isPrimary ? "#4010B9C5" : getBackgroundColor()
            }
            PropertyChanges {
                target: label
                opacity: 1.0
            }
        }
    ]

    MouseArea {
        anchors.fill: parent
        onClicked: buttonClicked()
        cursorShape: Qt.PointingHandCursor

        hoverEnabled: true
        onHoveredChanged: {
            buttonModalId.state = containsMouse ? "Hovering" : "Default"
        }
    }

    function getBackgroundColor() {
        return isDanger ? "#d80e0e" : (isPrimary ? "#0ED8D2" : "transparent")
    }

    background: Rectangle {
        id: buttonModalBackgroundId
        color: getBackgroundColor()
        radius: 4
        height: buttonHeight
        border.width: 1
        opacity: 0.8
        border.color: isDanger ? "#d80e0e" : (isPrimary ? Theme.primaryHighlight : "#616878")
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: label
        anchors.fill: parent
        opacity: 0.8
        color: isDanger ? "#fff" : (isPrimary ? "#3e3e3e" : "#fff")
        font.pixelSize: 18
        text: labelText
        font.family: "Roboto"
        font.weight: isPrimary ? Font.Medium : Font.Light
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    // Hovering effects
    Behavior on scale {
        NumberAnimation {
            duration: 150
            easing.type: Easing.InOutQuad
        }
        PropertyAnimation {
            property: "opacity"
            duration: 150
            easing.type: Easing.InOutQuad
        }
    }

    transitions: [
        Transition {
            from: "Default"
            to: "Hovering"
            ColorAnimation {
                duration: 150
            }
            PropertyAnimation {
                property: "opacity"
                duration: 150
                to: 1.0
            }
        },
        Transition {
            from: "Hovering"
            to: "Default"

            ColorAnimation {
                duration: 200
            }
            PropertyAnimation {
                property: "opacity"
                duration: 200
                to: 0.8
            }
        }
    ]
}
