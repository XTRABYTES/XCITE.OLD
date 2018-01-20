import QtQuick 2.0

Rectangle {
    id: root
    property alias text: label.text
    signal buttonClicked
    property bool isSelected: false

    anchors.verticalCenter: parent.Center
    width: label.width + 40
    color: "transparent"
    radius: 5
    onIsSelectedChanged: {
        if (isSelected) {
            color = "#0DD8D2"
            label.color = "#38414A"
        } else {
            color = "transparent"
            label.color = "#62DED6"
        }
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
            if (!isSelected) {
                if (containsMouse) {
                    root.color= "#302f2f"
                }
                else {
                    root.color= "transparent"
                }
            }
        }
    }
}
