import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../../Controls" as Controls

ColumnLayout {

    Layout.fillWidth: true
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    Layout.preferredHeight: 93
    Rectangle {
        Layout.fillWidth: true
        height: 1
        color: "#535353"
    }

    RowLayout {
        anchors.fill: parent
        Controls.IconButton {
            id: messageChatButton
            height: parent.height
            icon.source: "../../icons/circle-cross.svg"
            icon.sourceSize.width: 29
            Layout.preferredWidth: 40
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
            }
        }

        Controls.TextInput {
            id: chatInput
            color: "#A9AAAD"
            font.pixelSize: 18
            text: qsTr("Write something here...")
            //Layout.preferredWidth: 909
            Layout.fillWidth: true
            Layout.preferredHeight: 56
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: messageChatButton.right
            anchors.leftMargin: 15
            anchors.right: messageEmojiButton.left
            anchors.rightMargin: 15
        }

        Controls.IconButton {
            id: messageEmojiButton
            height: parent.height
            icon.source: "../../icons/circle-cross.svg"
            iconColor: "#9FA0A3"
            hoverColor: "red"
            icon.sourceSize.width: 29
            Layout.preferredWidth: 40
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
            }
        }
    }
}
