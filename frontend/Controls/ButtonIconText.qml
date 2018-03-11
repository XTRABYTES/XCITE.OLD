import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2

Rectangle {
    id: root

    //Alias
    property alias label: label
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
    property string iconFile: "../../icons/right-arrow2.svg"

    //Signals
    signal buttonClicked

    radius: 6
    width: 250
    height: 29
    border.color: borderColor
    border.width: 1
    color: backgroundColor

    Label {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Uninstantiated Text"
        font.family: "roboto"
        font.pixelSize: 10
        color: textColor
        opacity: 0.9
        leftPadding: 25

        Image {
            fillMode: Image.PreserveAspectFit
            source: iconFile
            width: 19
            height: 13
            sourceSize.width: 19
            sourceSize.height: 13
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }
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
