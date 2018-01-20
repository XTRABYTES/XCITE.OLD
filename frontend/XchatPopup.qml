import QtQuick 2.7
import QtQuick.Controls 2.2
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
    radius: 2

    Rectangle {
        id: innerPopupContainer
        width: 245
        height: 445
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "#3A3E47"
        radius: 2

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

        XchatSummary {
            id: summary
            anchors.top: parent.top
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

            ScrollView {
                id: messageScrollView
                anchors.fill: parent
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                Flickable {
                    id: messageFlickable
                    anchors.fill: parent
                    flickableDirection: Flickable.VerticalFlick
                    contentHeight: content.height
                }

                Text {
                    id: content
                    padding: 5
                    text: responseTXT
                    width: 240
                    wrapMode: TextArea.Wrap
                    font.family: "Roboto"
                    font.pixelSize: 14
                    color: "#DEDEDE"

                    onTextChanged: {
                        messageFlickable.contentY = contentHeight - messageFlickable.height
                    }
                }
            }
        }

        Rectangle {
            anchors.top: frame.bottom
            anchors.topMargin: 15
            anchors.left: frame.left
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            width: 230
            height: 70
            color: "#3A3E47"

            RowLayout {
                width: parent.width

                ScrollView {
                    Layout.fillWidth: true
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                    Layout.maximumHeight: 70

                    TextArea {
                        id: messageField
                        text: xchat.messageTXT
                        onTextChanged: xchat.messageTXT = text
                        font.pixelSize: 16
                        placeholderText: qsTr("Write something here...")
                        wrapMode: TextArea.Wrap
                        Keys.onReturnPressed: {
                            if (messageField.length > 0) {
                                xchatSubmitMsgSignal(xchat.messageTXT,responseTXT)
                                xchat.messageTXT = ""
                            }
                        }
                    }
                }

                Button {
                    Layout.minimumWidth: 32
                    Layout.maximumWidth: 32
                    Layout.minimumHeight: 32
                    Layout.maximumHeight: 32
                    anchors.right: parent.right

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
      horizontalOffset: -5
      verticalOffset: -5
      radius: 10
      samples: 20
      source: innerPopupContainer
      color: "#32373d"
    }
}


