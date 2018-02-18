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

    property string selectedColor: "#0ED8D2"
    property string notSelectedColor: "#A9AAAD"
    property string hoveringColor: "#0eefe9"

    id: button
    height: hasLabel ? childrenRect.height : image.height
    width: size

    signal buttonClicked

    function getDefaultColor() {
        return isSelected ? selectedColor : notSelectedColor;
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: buttonClicked()
        cursorShape: Qt.PointingHandCursor

        hoverEnabled: true
        onHoveredChanged: containsMouse ? button.state = "Hovering" : button.state = "Default"
    }

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
        id: colorOverlay
        anchors.fill: image
        source: image
        color: getDefaultColor()

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

        color: getDefaultColor()
    }

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
                target: colorOverlay
                color: hoveringColor
            }
            PropertyChanges {
                target: label
                color: hoveringColor
            }
        },
        State {
            name: "Default"
            PropertyChanges {
                target: colorOverlay
                color: getDefaultColor()
            }
            PropertyChanges {
                target: label
                color: getDefaultColor()
            }
        }
    ]

    transitions: [
        Transition {
            from: "Default"; to: "Hovering"
            ColorAnimation { duration: 150 }
        },
        Transition {
            from: "Hovering"; to: "Default"
            ColorAnimation { duration: 300 }
        }
    ]
}
