import QtQuick 2.8
import QtQuick.Controls 2.3
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

    ButtonIcon {
        width: 40
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        imageOffsetY: parent.height / 2 - 2.5 // TODO: This shouldn't be necessary but need to refactor ButtonIcon first

        imageSource: "../icons/dropdown-arrow.svg"
        size: 5
    }
}
