import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.1

Item {
    readonly property bool hasLabel: labelText.length > 0
    property string labelText
    property bool isSelected: false
    property bool changeColorOnClick: true
    property int size: 40
    property int imageOffsetX: 0

    property alias imageSource: image.source
    property alias hoverEnabled: mouseArea.hoverEnabled
    property alias cursorShape: mouseArea.cursorShape

    id: button
    height: hasLabel ? childrenRect.height : image.height
    width: size

    signal buttonClicked

    function getColor() {
        switch (state) {
        case 'hover':
            return "#0eefe9";
        default:
            return isSelected ? "#0ED8D2" : "#A9AAAD";
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: buttonClicked()
        cursorShape: Qt.PointingHandCursor

        hoverEnabled: true
        onEntered: { button.state = 'hover' }
        onExited: { button.state = '' }
    }

    states: [
        State { name: "hover" }
    ]

    Image {
        id: image

        smooth: true
        mipmap: true
        anchors.horizontalCenter: parent.horizontalCenter
        transform: Translate { x: imageOffsetX }

        fillMode: Image.PreserveAspectFit
        height: size

        sourceSize.width: size
        sourceSize.height: size
    }

    ColorOverlay {
        anchors.fill: image
        source: image
        color: getColor()

        transform: Translate { x: imageOffsetX }
    }

    Text {
        id: label
        visible: hasLabel
        text: labelText
        width: parent.width

        anchors.top: image.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

        horizontalAlignment: Text.AlignHCenter

        font.family: "Roboto"
        font.pixelSize: 12
        wrapMode: Text.WordWrap

        color: getColor()
    }
}
