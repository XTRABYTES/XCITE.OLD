import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../Controls" as Controls

ColumnLayout {
    anchors.fill: parent

    Controls.DiodeHeader {
        text: qsTr("X-CHAT")
        cHeaderText: "#ffffff"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: xChatPopup.visible === false
            cursorShape: Qt.PointingHandCursor

            onClicked: xChatPopup.toggle()

            onHoveredChanged: {
                parent.color = containsMouse ? "#434751" : "#3A3E47"
            }
        }

        RowLayout {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 55
            spacing: 10

            Controls.ButtonIcon {
                imageSource: "../icons/friend-request.svg"
                size: 22
                isSelected: xChatPopup.mode === "friends"
                onButtonClicked: {
                    xChatPopup.mode = "friends"
                }
            }

            Controls.ButtonIcon {
                imageSource: "../icons/robot.svg"
                size: 25
                isSelected: xChatPopup.mode === "robot"
                onButtonClicked: {
                    xChatPopup.mode = "robot"
                }
            }
        }
    }

    Item {
        // Contact details
        Layout.fillWidth: true
        height: 44.5

        RowLayout {
            anchors.fill: parent
            anchors.rightMargin: 20
            anchors.leftMargin: 5

            Controls.IconButton {
                anchors.verticalCenter: parent.verticalCenter
                img.source: "../icons/left-arrow.svg"
                img.sourceSize.height: 10
                height: parent.height
            }

            Label {
                Layout.fillWidth: true
                text: "John Doe"
                color: "#e6e6e6"
                font.family: "Roboto"
                font.pixelSize: 12
            }

            Controls.IconButton {
                anchors.verticalCenter: parent.verticalCenter
                img.source: "../icons/phone-call.svg"
                img.sourceSize.width: 22
                iconColor: "#acb6ce"
                height: parent.height
            }
        }
    }
}
