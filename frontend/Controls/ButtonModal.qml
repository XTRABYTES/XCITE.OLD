import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Button {
    property bool isPrimary: false
    property alias label: label
    property alias labelText: label.text
    property real buttonHeight: parent.height

    Layout.fillWidth: true
    height: buttonHeight

    signal buttonClicked

    MouseArea {
        anchors.fill: parent
        onClicked: buttonClicked()
        cursorShape: Qt.PointingHandCursor

        hoverEnabled: true
    }

    background: Rectangle {
        color: isPrimary ? "#0ED8D2" : "transparent"
        radius: 4
        height: buttonHeight
        border.width: 1
        border.color: isPrimary ? "#0ED8D2" : "#616878"
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: label
        anchors.fill: parent
        color: isPrimary ? "#3e3e3e" : "#fff"
        font.pixelSize: 18
        font.family: "Roboto"
        font.weight: isPrimary ? Font.Medium : Font.Light
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
