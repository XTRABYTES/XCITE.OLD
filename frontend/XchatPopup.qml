import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Rectangle {
    id: xchatpopup
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    width: 250
    height: 450
    smooth: true
    color: "#3A3E47"
    state: "visible"

    Rectangle {
        id: innerPopupContainer
        width: 245
        height: 445
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "#3A3E47"

        states: [
            State {
                name: "invisible"
                PropertyChanges { target: xchatpopup; opacity: 0 }
            },

            State {
                name: "visible"
                PropertyChanges { target: xchatpopup; opacity: 1.0 }
            }
        ]

        transitions: Transition {
            NumberAnimation { properties: "opacity"; duration: 100 }
        }

        function toggle() {
            if (state == "visible")
                state = "invisible";
            else
                state = "visible";
        }


        DockButton {
            id: dockbutton
            anchors.top: parent.top
            //anchors.left: xchatpopup.left
            height: 13
            width: 250
            onButtonClicked: {
                xchatpopup.visible = false
            }
        }


        XchatSummary {
            id: summary
            anchors.top: dockbutton.bottom
            //anchors.top: parent.top
            //anchors.left: xchatpopup.left
            width: 250
        }


        Rectangle {
            id: frame
            clip: true
            anchors.top: summary.bottom
            anchors.topMargin: 5
            color: "#3A3E47"
            width: 240
            height: 317
            x: 5
            y: 5

            Text {
                id: content
                padding: 5
                text: responseTXT
                font.family: "Roboto"
                font.pixelSize: 13
                y: -vbar.position * height
                color: "#DEDEDE"

            }

            ScrollBar {
                id: vbar
                hoverEnabled: true
                active: hovered || pressed
                orientation: Qt.Vertical
                size: frame.height / content.height
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }

        }

        Pane {
            id: pane
            width: 240
            y: 380
            x: 5


            RowLayout {
                width: parent.width

                TextField {
                    id: messageField
                    text: xchat.messageTXT
                    onTextChanged: xchat.messageTXT = text
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    placeholderText: qsTr("Write something here...")
                    wrapMode: TextArea.Wrap
                    Keys.onReturnPressed: {
                        if (messageField.length > 0) {
                            xchatSubmitMsgSignal(xchat.messageTXT,responseTXT)
                            xchat.messageTXT = ""
                        }
                    }
                }

                Button {
                    Layout.minimumWidth: 32
                    Layout.maximumWidth: 32
                    Layout.minimumHeight: 32
                    Layout.maximumHeight: 32

                    Text {
                        text: qsTr("Send")
                        anchors.centerIn: parent
                        font.family: "Roboto"
                        font.weight: Font.Bold
                        font.pixelSize: 12
                        color: "#62DED6"
                    }

                    id: sendMsgButton
                    enabled: messageField.length > 0
                    onClicked: {
                        xchatSubmitMsgSignal(xchat.messageTXT,responseTXT)
                        xchat.messageTXT = ""
                    }
                }
            }
        }
    }

    DropShadow {
      anchors.fill: innerPopupContainer
      horizontalOffset: 2
      verticalOffset: 2
      radius: 5
      samples: 5
      source: innerPopupContainer
      color: "black"
    }
}


