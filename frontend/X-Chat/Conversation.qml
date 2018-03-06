import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import XChatConversationModel 0.1
import "../Theme" 1.0

ColumnLayout {
    Connections {
        target: xcite
        onXChatMessageReceived: {
            add(message, datetime, false)
        }

        // TODO: Temporary placeholder content
        Component.onCompleted: {
            var now = Date.now()

            add("Heading downtown?", new Date(now - 180000), true)
            add("Absolutely, catching a show.", new Date(now - 120000), false)
            add("We'll catch up later!", new Date(now), true)
        }
    }

    function add(message, datetime, isMine) {
        conversation.model.addMessage(message, datetime, isMine)
    }

    ListView {
        id: conversation
        spacing: 12

        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.leftMargin: 18.9
        Layout.rightMargin: 18.9
        Layout.topMargin: 5
        Layout.bottomMargin: 5

        verticalLayoutDirection: ListView.BottomToTop
        model: XChatConversationModel {
        }

        clip: true

        delegate: Column {
            anchors.left: isMine ? undefined : parent.left
            anchors.right: isMine ? parent.right : undefined
            spacing: 4.7

            Row {
                anchors.left: isMine ? undefined : parent.left
                anchors.right: isMine ? parent.right : undefined

                Label {
                    id: messageText
                    topPadding: 7.3
                    bottomPadding: 6
                    leftPadding: 7.05
                    rightPadding: 8.05

                    background: Rectangle {
                        color: isMine ? "transparent" : Theme.primaryHighlight
                        border.color: isMine ? "#727989" : "transparent"
                        anchors.fill: parent
                        radius: 2
                    }

                    text: model.message
                    color: isMine ? "white" : "black"
                    font.family: "Roboto"
                    font.pixelSize: 11
                    lineHeight: 1.2
                    wrapMode: Label.WordWrap

                    Component.onCompleted: {
                        if (paintedWidth > conversation.width) {
                            width = conversation.width
                        }
                    }
                }
            }

            Label {
                font.pixelSize: 10
                font.family: "Roboto"
                anchors.left: isMine ? undefined : parent.left
                anchors.right: isMine ? parent.right : undefined
                text: Qt.formatDateTime(model.datetime, 'h:mm ap')
                color: "white"
            }
        }

        ScrollBar.vertical: ScrollBar {
        }
    }
}
