import QtQuick 2.8
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "../Theme" 1.0

Rectangle {
    property color cHeaderText: "#e2e2e2"
    readonly property color cHeaderLine: "#2A2C31"

    property alias menuLabelText: menuLabel.text
    property alias text: label.text

    color: Theme.diodeHeaderBackground
    height: diodeHeaderHeight
    width: parent.width

    Text {
        id: label
        anchors.left: parent.left
        anchors.leftMargin: 20.68
        anchors.verticalCenter: parent.verticalCenter
        color: cHeaderText
        font.pixelSize: 15
    }

    DiodeHeaderMenu {
        id: menuLabel
        visible: menuLabelText.length > 0
    }

    layer.enabled: true
    layer.effect: DropShadow {
        horizontalOffset: 0
        verticalOffset: 2
        radius: 10
        color: "#1A000000"
    }
}
