import QtQuick 2.8
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

RowLayout {
    id: currencyDropdownWidget

    property alias text: menuLabel.text
    property string iconSource: "../icons/dropdown-arrow.svg"
    property int iconSize: 10
    property bool iconOnly: false

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
        visible: !iconOnly
    }

    IconButton {
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        Layout.preferredWidth: 40

        icon.source: iconSource
        icon.sourceSize.width: iconSize
        MouseArea {
            anchors.fill: parent
        }
    }
}
