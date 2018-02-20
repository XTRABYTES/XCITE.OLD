import QtQuick 2.0

Rectangle {
    id: root
    // export button properties
    property alias text: label.text
    signal buttonClicked

    width: 250; height: 40
    border.color: "#10B9C5"
    border.width: 2
    color: "transparent"

    Text {
        id: label
        anchors.centerIn: parent
        text: "Start"
        font.family: "Roboto Thin"
        font.pointSize: 12
        color: "#10B9C5"
        opacity: 0.9
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.buttonClicked()
        }
        hoverEnabled: true
        onHoveredChanged: {
            if (containsMouse) {
                root.color = "#131315"
            }
            else {
                root.color = "transparent"
            }
        }
    }
}
