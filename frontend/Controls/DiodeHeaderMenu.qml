import QtQuick 2.8
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

RowLayout {
    id: currencyDropdownWidget

    property alias text: menuLabel.text

    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    height: parent.height
    spacing: 0

    Text {
        id: menuLabel
        color: cHeaderText
        font.family: "Roboto"
        font.pixelSize: 12
        rightPadding: 10
    }

    Rectangle {
        color: cHeaderLine
        width: 1
        height: 22.06
        anchors.verticalCenter: parent.verticalCenter
    }

    IconButton {
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        Layout.preferredWidth: 40

        img.source: "../icons/dropdown-arrow.svg"
        img.sourceSize.width: 10
    }
}
