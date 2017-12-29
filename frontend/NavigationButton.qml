import QtQuick 2.0

Rectangle {
    id: root
    property alias text: label.text
    signal buttonClicked
    property alias isSelected: bluebar.visible

    anchors.verticalCenter: parent.Center
    width: label.width + 20
    color: "transparent"

    Rectangle {
        id: bluebar
        width: parent.width
        height: 10
        color: "#64DDD8"
        visible: false
        anchors.top: parent.top
        anchors.left: parent.left
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: "Start"
        font.family: "Roboto"
        font.pixelSize: 21
        color: "#62DED6"
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
                root.color= "#302f2f"
            }
            else {
                root.color= "transparent"
            }
        }
    }
}
