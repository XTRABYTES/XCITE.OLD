import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../Theme" 1.0

RowLayout {
    id: popup
    property string title: "Pop-up!"
    property string message: "Warnings, messages and other stuff here!"

    height: 56.28
    spacing: 20

    Rectangle {
        anchors.fill: parent
        color: Theme.primaryHighlight
        radius: 2
    }

    Text {
        text: title
        font.family: "Roboto"
        font.weight: Font.Bold
        font.pixelSize: 20
    }

    Text {
        font.family: "Roboto"
        font.pixelSize: 16
        text: message
    }

    IconButton {
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        Layout.preferredWidth: 40

        icon.source: "../icons/cross.svg"
        icon.sourceSize.width: 10

        onClicked: {
            popup.visible = false
        }
    }
}
