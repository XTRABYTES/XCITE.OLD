/**
 * Filename: XChat.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

import QtQuick.Controls 2.3
import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtMultimedia 5.8
import QtQuick.Layouts 1.11

import "qrc:/Controls" as Controls
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: xchatModal
    width: Screen.width
    state: xchatTracker == 1? "up" : "down"
    height: Screen.height
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    onStateChanged: detectInteraction()

    LinearGradient {
        anchors.fill: parent
        start: Qt.point(0, 0)
        end: Qt.point(0, parent.height)
        opacity: 0.05
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 1.0; color: maincolor }
        }
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: xchatModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: xchatModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: xchatModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    property int xchatError: 0

    Text {
        id: xchatModalLabel
        text: "X-CHAT"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Rectangle {
        id: msgWindow
        width: Screen.width - 56
        anchors.top: xchatModalLabel.bottom
        anchors.topMargin: 30
        anchors.bottom: typingLabel.top
        anchors.bottomMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        clip: true

        Mobile.XChatList {
            id: myXchat
        }
    }
    Label {
        id: typingLabel
        text: typing
        //anchors.top: myXchat.bottom
        anchors.bottom: sendText.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.family: xciteMobile.name
        font.bold: true
        font.pixelSize: 10
        font.letterSpacing: 1
    }
    Connections {
        target: xChat
    }

    Controls.TextInput {
        id: sendText
        height: 34
        placeholder: "Type your message."
        text: ""
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.right: parent.right
        anchors.rightMargin: 62
        anchors.bottom: closeXchatModal.top
        anchors.bottomMargin: 25
        color: themecolor
        textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
        font.pixelSize: 14
        mobile: 1

        Timer {
            id: typingTimer
            interval: 6000
            onTriggered: {
                console.log("User stopped writing")
                xChatTypingRemove("%&%& " +username);

            }
        }
        Timer {
                    id: sendTypingTimer
                    interval: 5000
                    onTriggered: {
                    //    console.log("Waiting 5 seconds before sending")
                        sendTyping = true
                    }
                }

        onTextEdited: {
            typingTimer.restart();
            if (sendTyping){
          //      console.log("Sending typing");
                xChatTypingAdd("$#$# " +username);
                sendTypingTimer.start()
            }
            sendTyping = false

        }
    }

    Rectangle {
        id: executeButton
        width: 34
        height: 34
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.bottom: closeXchatModal.top
        anchors.bottomMargin: 25
        color: maincolor
        opacity: 0.25

        MouseArea {
            anchors.fill: parent

            onPressed: {
                click01.play()
                detectInteraction()
                parent.opacity = 0.5
            }

            onCanceled: {
                parent.opacity = 0.5
            }

            onReleased: {
                parent.opacity = 0.5
            }

            onClicked: {

                xchatError = 0
                xChatSend("@ " + username + ",XCITE mobile:" +  sendText.text + " <br>")

                sendText.text = "";
                xChatTypingRemove("%&%& " + username);
            }
        }


        Connections {
            target: xChat
            onXchatSuccess: {
                myXchat.xChatList.positionViewAtIndex(myXchat.xChatList.count - 1, ListView.End)
            }
            onXchatTypingSignal: {
                console.log(msg)
                typing = msg
            }

        }

    }

    Image {
        source: 'qrc:/icons/mobile/debug-icon_01_light.svg'
        height: 24
        width: 24
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: executeButton.verticalCenter
        anchors.horizontalCenter: executeButton.horizontalCenter
    }

    Rectangle {
        width: 34
        height: 34
        anchors.right: executeButton.right
        anchors.top: executeButton.top
        color: "transparent"
        border.color: maincolor
        border.width: 1
        opacity: 0.50
    }

    Label {
        id: closeXchatModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : 70
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"

        Rectangle{
            id: closeButton
            height: 34
            width: doubbleButtonWidth
            radius: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"
        }

        MouseArea {
            anchors.fill: closeButton

            Timer {
                id: timer
                interval: 300
                repeat: false
                running: false

                onTriggered: {
                    sendText.text = ""
                }
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onReleased: {
                if (xchatTracker == 1) {
                    xchatTracker = 0;
                    xchatError = 0
                    timer.start()
                }
            }
        }
    }

    Component.onDestruction: {
        sendText.text = ""
        xchatTracker = 0
        xchatError = 0
    }
}
