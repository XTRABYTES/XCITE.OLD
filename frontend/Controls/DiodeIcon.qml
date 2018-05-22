import QtQuick 2.7
import QtGraphicalEffects 1.0
import "../Theme" 1.0

Rectangle {
    property alias title: title.text
    property alias imageSource: image.source
    property alias isButton: mouseArea.visible

    signal buttonClicked

    id: root
    color: Theme.panelBackground
    radius: 5
    layer.enabled: true
    layer.effect: DropShadow {
        horizontalOffset: 0
        verticalOffset: 2
        samples: 5
        radius: 10
        cached: true
        color: "#1A000000"
    }

    MouseArea {
        id: mouseArea
        visible: false
        enabled: mouseArea.visible
        anchors.fill: parent
        onClicked: buttonClicked()
        cursorShape: Qt.PointingHandCursor
        propagateComposedEvents: false
        hoverEnabled: true
        onHoveredChanged: containsMouse ? root.color = "#41454c" : root.color
                                          = Theme.panelBackground
    }

    Image {
        id: image
        smooth: true
        mipmap: true
        anchors.top: parent.top
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        height: 65
        sourceSize.width: 65
        sourceSize.height: 65
    }

    Text {
        id: title
        visible: (this.text !== "")
        anchors.top: image.bottom
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#FFFFFF"
        font.pixelSize: 24
    }
}
