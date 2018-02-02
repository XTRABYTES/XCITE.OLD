import QtQuick 2.0

Item {
    readonly property color cHeaderText: "#e2e2e2"
    readonly property color cHeaderLine: "#535353"

    property alias menuLabelText: menuLabel.text
    property alias text: label.text

    height: 44.5
    width: parent.width

    Text {
        id: label
        anchors.left: parent.left
        anchors.leftMargin: 20.68
        anchors.verticalCenter: parent.verticalCenter
        color: cHeaderText
        font.family: "Roboto Regular"
        font.pixelSize: 15
    }

    Rectangle {
        width: parent.width
        anchors.top: parent.bottom
        height: 1
        color: cHeaderLine
    }

    Item {
        id: currencyDropdownWidget
        anchors.right: parent.right
        height: parent.height

        Rectangle {
            color: cHeaderLine
            width: 1
            height: 22.06
            anchors.right: parent.right
            anchors.rightMargin: 40.87
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: menuLabel
            color: cHeaderText
            font.family: "Roboto"
            font.pixelSize: 12
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 55
        }
    }
}
