import QtQuick 2.0

Rectangle {
    id: root
    signal buttonClicked
    width: 250; height: 25
    color: "transparent"

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.buttonClicked()
        }
        hoverEnabled: true
        onHoveredChanged: {
            if (containsMouse) {
                underline.visible = true
            }
            else {
                underline.visible = false
            }
        }
    }

    Rectangle {
        id: underline
        height: 1
        width: parent.width
        color: "#10B9C5"
        anchors.bottom: parent.bottom
        visible: false
    }
}
