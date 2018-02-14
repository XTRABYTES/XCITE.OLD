import QtQuick 2.0

Rectangle {
    id: root
    // export button properties
    property alias text: label.text
    signal buttonClicked
    property string backgroundColor: "transparent"
    property string foregroundColor: "#10B9C5"
    property string hoverBackgroundColor: root.color
    property string hoverForegroundColor: label.color

    width: 250
    height: 40
    border.color: "#10B9C5"
    border.width: 2
    color: backgroundColor

    Text {
        id: label
        anchors.centerIn: parent
        text: "Start"
        font.family: "Roboto Thin"
        font.pointSize: 12
        color: foregroundColor
        opacity: 0.9
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            root.buttonClicked()
        }
        hoverEnabled: true
        onHoveredChanged: {
            if (containsMouse) {
                root.color = hoverBackgroundColor
                label.color = hoverForegroundColor
            }
            else {
                root.color = backgroundColor
                label.color = foregroundColor
            }
        }
    }
}
