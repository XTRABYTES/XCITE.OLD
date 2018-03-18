import QtQuick 2.7
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

Button {
    id: button

    property alias cursorShape: mouseArea.cursorShape
    property alias img: image

    property color iconColor: "#666"
    property color hoverColor: "white"

    text: ""

    background: Item {
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onPressed: mouse.accepted = false
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: {
            button.state = 'hover'
        }
        onExited: {
            button.state = ''
        }
    }

    ColorOverlay {
        id: overlay
        anchors.fill: image
        source: image
        color: button.state === "hover" ? hoverColor : iconColor
    }

    Image {
        id: image
        anchors.centerIn: parent
    }
}
