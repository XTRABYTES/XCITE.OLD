import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0

ComboBox {
    id: comboBoxId

    onHoveredChanged: {
        hovered ? comboBoxBackgroundId.state = "Hovering" : comboBoxBackgroundId.state = "Default"
    }

    property string defaultBackgroundColor: "#2A2C31"
    property string hoveringBackgroundColor: "#46464b"

    background: Rectangle {
        id: comboBoxBackgroundId
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
                    target: comboBoxBackgroundId
                    color: hoveringBackgroundColor
                }
            },
            State {
                name: "Default"
                PropertyChanges {
                    target: comboBoxBackgroundId
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
