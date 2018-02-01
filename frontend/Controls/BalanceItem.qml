import QtQuick 2.0
import "../Controls" as Controls

Item {
    readonly property color cBalanceValue: "#d5d5d5"

    property alias text: label.text
    property alias value: value.text
    property alias valueFont: value.font
    property alias valueColor: value.color

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.topMargin: 10
    anchors.rightMargin: 15
    anchors.leftMargin: 33.9
    height: 63

    Controls.LabelUnderlined {
        id: label
        pixelSize: 19
        anchors.top: parent.top
        anchors.topMargin: 16
    }

    Text {
        id: value
        color: cBalanceValue
        font.family: 'Roboto Condensed'
        font.weight: Font.Light
        font.pixelSize: 54
        anchors.right: parent.right

        Text {
            anchors.bottom: parent.bottom
            anchors.right: parent.left
            anchors.rightMargin: 6
            anchors.bottomMargin: 10
            color: "#e3e3e3"
            font.pixelSize: 14
            font.family: "Roboto"
            font.weight: Font.Light
            text: qsTr("XBY")
        }
    }
}
