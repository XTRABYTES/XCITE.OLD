import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.1

Rectangle {
    id: root
    // export button properties
    readonly property color cDiodeBackground: "#3a3e46"
    property alias text: label.text
    signal buttonClicked
    property string backgroundColor: "transparent"
    property string foregroundColor: "#10B9C5"
    property string hoverBackgroundColor: root.color
    property string hoverForegroundColor: label.color
    property string hoverTextColor:cDiodeBackground
    property string textColor:"#ffffff"
    property string hoverBorderColor:"#10B9C5"
    property string borderColor:"#616878"

    property int size: 40
    property int imageOffsetX: 0

    radius:5
    width: 250
     height:29
    border.color: borderColor
    border.width: 2
    color: backgroundColor

        /*Image {
            id: image

            smooth: true
            mipmap: true
            anchors.horizontalCenter: parent.horizontalCenter
            transform: Translate { x: imageOffsetX }

            fillMode: Image.PreserveAspectFit
            height: size

            sourceSize.width: size
            sourceSize.height: size
        }*/

        Text {
            id: label
            anchors.centerIn: parent
            text: "Uninstantiated Text"
            font.family: "Roboto Thin"
            font.pointSize: 10
            color: textColor
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
                    label.color = hoverTextColor
                    root.border.color = hoverBorderColor
                }
                else {
                    root.color = backgroundColor
                    label.color = textColor
                    root.border.color = borderColor
                }
            }
        }

}
