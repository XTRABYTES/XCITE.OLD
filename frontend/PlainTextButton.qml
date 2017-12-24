import QtQuick 2.0

Rectangle {
    id: root
    // export button properties
    property alias text: label.text
    signal buttonClicked
    property alias textOpacity: label.opacity
    property alias fontPointSize: label.font.pointSize

    width: 250; height: 25
    color: "transparent"

    Text {
        id: label
        anchors.centerIn: parent
        text: "Start"
        font.family: "Roboto Thin"
        font.pointSize: fontPointSize
        color: "#FFFFFF"
        opacity: textOpacity
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.buttonClicked()
        }
        hoverEnabled: true
        onHoveredChanged: {
            if (containsMouse) {
                label.font.bold = true
            }
            else {
                label.font.bold = false
            }
        }
    }
}
