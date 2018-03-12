import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "X-Chat" as XChat

import "Controls" as Controls

Item {
    readonly property color cBackground: "#3a3e47"
    property string mode: "robot"

    id: xChatPopup
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    width: 318
    smooth: true

    state: "minimal"
    states: [
        State {
            name: "minimal"
            PropertyChanges {
                target: xChatPopup
                height: 48
            }
        },

        State {
            name: "full"
            PropertyChanges {
                target: xChatPopup
                height: 639
            }
        }
    ]

    transitions: Transition {
        PropertyAnimation {
            properties: "height"
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }

    function toggle() {
        state = state === 'full' ? 'minimal' : 'full'
    }

    function focus(e) {
        xChatTextInput.forceActiveFocus()
    }

    function onSubmitUserInput(e) {
        var text = xChatTextInput.text.trim()

        if (text.length > 0) {
            conversation.add(text, new Date(), true)
            xchatSubmitMsgSignal(text, '')
            xChatTextInput.text = ''
        }
    }

    Rectangle {
        id: innerPopupContainer
        anchors.fill: parent
        anchors.rightMargin: 15

        color: cBackground
        radius: 4

        ColumnLayout {
            anchors.fill: parent

            XChat.Header {
            }

            XChat.Conversation {
                id: conversation
                Layout.fillHeight: true
            }

            // Bottom controls
            Item {
                id: xChatUserInput
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 18.9
                anchors.rightMargin: 18.9
                height: 61

                Rectangle {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right

                    height: 1
                    color: "#727989"
                }

                RowLayout {
                    width: xChatUserInput.width
                    spacing: 10

                    anchors.verticalCenter: parent.verticalCenter

                    Controls.IconButton {
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height
                        Layout.preferredWidth: 40

                        img.source: "../icons/plus-button.svg"
                        img.sourceSize.width: 28
                    }

                    Rectangle {
                        // User input
                        Layout.fillWidth: true
                        height: 32
                        radius: 4

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.IBeamCursor
                            onClicked: xChatTextInput.forceActiveFocus()
                        }

                        color: "#505a67"

                        TextInput {
                            id: xChatTextInput

                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.right: parent.right

                            anchors.leftMargin: 10.69
                            anchors.rightMargin: 10.69

                            clip: true

                            font.pixelSize: 11
                            color: "#ffffff"

                            Keys.onReturnPressed: onSubmitUserInput()
                        }
                    }

                    Button {
                        id: xChatBtnSend
                        text: qsTr("Send")
                        enabled: xChatTextInput.length > 0

                        onClicked: onSubmitUserInput()

                        // TODO: We'll likely want to make a reusable component for buttons
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onPressed: mouse.accepted = false
                        }

                        contentItem: Text {
                            text: xChatBtnSend.text
                            color: xChatBtnSend.enabled ? (xChatBtnSend.down ? "#ffffff" : "#24B9C3") : "#777"
                            font.pixelSize: 12
                        }

                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
        }
    }

    DropShadow {
        anchors.fill: innerPopupContainer
        horizontalOffset: -5
        verticalOffset: -5
        radius: 10
        samples: 20
        source: innerPopupContainer
        color: "#32373d"
    }
}
