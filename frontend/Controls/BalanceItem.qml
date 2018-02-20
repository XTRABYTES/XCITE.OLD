import QtQuick 2.0
import QtQuick.Controls 2.2
import "../Controls" as Controls

Item {
    readonly property color cBalanceValue: "#d5d5d5"

    property alias text: label.text
    property alias value: value.text
    property alias valueFont: value.font
    property alias valueColor: value.color
    property alias valuePrefix: prefix.text
    property alias valueWidth: value.width

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

    Label {
        id: value
        color: cBalanceValue
        font.family: 'Roboto Condensed'
        font.weight: Font.Light
        font.pixelSize: 54
        minimumPixelSize: 10
        fontSizeMode: Text.Fit
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        anchors.right: parent.right
        leftPadding: 30

        Label {
            id: prefix
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            color: "#e3e3e3"
            font.pixelSize: 14
            font.family: "Roboto"
            font.weight: Font.Light
        }
    }
}
