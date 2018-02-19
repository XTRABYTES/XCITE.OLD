import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.1

Rectangle {
    id: root

    //Alias
    property alias text: label.text

    readonly property color cDiodeBackground: "#3a3e46"

    //Properties
    property string backgroundColor: "transparent"
    property string foregroundColor: "#10B9C5"
    property string hoverBackgroundColor: root.color
    property string hoverForegroundColor: label.color
    property string hoverTextColor: cDiodeBackground
    property string textColor: "#ffffff"
    property string hoverBorderColor: "#10B9C5"
    property string borderColor: "#616878"
    property int size: 40
    property int imageOffsetX: 0
    property string iconDirectory: "../../icons/right-arrow2.svg"

    //Signals
    signal buttonClicked

    radius: 5
    width: 250
    height: 29
    border.color: borderColor
    border.width: 2
    color: backgroundColor

    Image {
        fillMode: Image.PreserveAspectFit
        source: iconDirectory
        width: 19
        height: 13
        sourceSize.width: 19
        sourceSize.height: 13
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 11
    }

    Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 12
        text: "Uninstantiated Text"
        font.family: "roboto"
        font.pixelSize: 10
        color: textColor
        opacity: 0.9
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            root.buttonClicked()
        }
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onHoveredChanged: {
            if (containsMouse) {
                root.color = hoverBackgroundColor
                label.color = hoverTextColor
                root.border.color = hoverBorderColor
            } else {
                root.color = backgroundColor
                label.color = textColor
                root.border.color = borderColor
            }
        }
    }
}
