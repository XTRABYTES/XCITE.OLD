import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import "../Theme" 1.0

Button {
    property bool isPrimary: false
    property bool isDanger: false
    property alias label: label
    property string labelText: label.text || qsTr("OK")
    property real buttonHeight: 40

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
        color: isDanger ? "#d80e0e" : (isPrimary ? Theme.primaryHighlight : "transparent")
        radius: 4
        height: buttonHeight
        border.width: 1
        border.color: isDanger ? "#d80e0e" : (isPrimary ? Theme.primaryHighlight : "#616878")
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: label
        anchors.fill: parent
        color: isDanger ? "#fff" : (isPrimary ? "#3e3e3e" : "#fff")
        font.pixelSize: 18
        text: labelText
        font.family: "Roboto"
        font.weight: isPrimary ? Font.Medium : Font.Light
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
