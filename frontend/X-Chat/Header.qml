import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../Controls" as Controls

ColumnLayout {
    anchors.fill: parent

    Controls.BoardHeader {
        text: qsTr("X-CHAT")
        cHeaderText: "#ffffff"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: xChatPopup.visible === false
            cursorShape:Qt.PointingHandCursor

            onClicked: xChatPopup.toggle();

            onHoveredChanged: {
                parent.color = containsMouse ? "#434751" : "#3A3E47"
            }
        }

        RowLayout {
            anchors.right: parent.right
            anchors.rightMargin: 55
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            Controls.ButtonDiode {
                id: xchatUsersButton
                imageSource: "../icons/friend-request.svg"
                size: 25
                isSelected: false
                onButtonClicked: {
                    xchatBotsButton.isSelected = false
                }
            }

            Controls.ButtonDiode {
                id: xchatBotsButton
                imageSource: "../icons/robot.svg"
                size: 25
                isSelected: true
                onButtonClicked: {
                    xchatUsersButton.isSelected = false
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

            Item {
                // < Icon/button goes here
                width: 26
                height: parent.height
            }

            Label {
                Layout.fillWidth: true
                text: "John Doe"
                color: "#e6e6e6"
                font.family: "Roboto"
                font.pixelSize: 12
            }

            Item {
                // Call icon goes here
                width: 50
                height: parent.height
            }
        }
    }
}
