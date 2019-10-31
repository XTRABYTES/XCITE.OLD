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

    property string xChatMessage: ""

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

    Image {
        id: onlineIndicator
        source: networkAvailable == 1? (xChatConnection == true? "qrc:/icons/mobile/online_blue_icon.svg" : "qrc:/icons/mobile/online_red_icon.svg") : "qrc:/icons/mobile/no_internet_icon.svg"
        anchors.verticalCenter: xchatModalLabel.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 28
        width: 20
        fillMode: Image.PreserveAspectFit

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 30
            height: 30
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    checkingXchat = true
                    console.log("Manually reconnect X-CHAT")
                    checkXChatSignal();
                }
            }
        }
    }

    Label {
        id: connectingLabel
        text: "connecting"
        anchors.horizontalCenter: onlineIndicator.horizontalCenter
        anchors.top: onlineIndicator.bottom
        anchors.topMargin: 5
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.pixelSize: 8
        font.family: "Brandon Grotesque"
        visible: xChatConnecting == true
    }

    Image {
        id: xChatUsersButton
        source: "qrc:/icons/mobile/users-icon_01.svg"
        anchors.verticalCenter: xchatModalLabel.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 28
        height: 20
        fillMode: Image.PreserveAspectFit

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 30
            height: 30
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("X-CHAT users")
                    xchatUserTracker = 1
                }
            }
        }
    }

    Image {
        id: xChatSettingsButton
        source: "qrc:/icons/mobile/settings-icon_01.svg"
        anchors.verticalCenter: xchatModalLabel.verticalCenter
        anchors.right: xChatUsersButton.left
        anchors.rightMargin: 20
        height: 20
        width: 20

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 30
            height: 30
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    console.log("X-CHAT settings")
                    xchatSettingsTracker = 1
                }
            }
        }
    }

    Rectangle {
        id: msgWindow
        width: Screen.width - 56
        anchors.top: xchatModalLabel.bottom
        anchors.topMargin: 20
        anchors.bottom: typingLabel.top
        anchors.bottomMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        clip: true

        Mobile.XChatList {
            id: myXchat
            focus: false
            onTaggingChanged: {
               if (sendText.text == "") {

                   sendText.text = myXchat.tag + " "
               }
               else {
                   sendText.text = sendText.text + " " + myXchat.tag + " "
               }
            }
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

        onTextChanged:  {
            sendEnabled = text.length > 0 ? true : false
        }

        onTextEdited: {
            typingTimer.restart();
            if (sendTyping){
                xChatTypingAdd("$#$# " +username);
                sendTypingTimer.start()
                sendXchatConnection.restart();

            }
            sendTyping = false
        }
    }

    Rectangle {
        id: executeButton
        width: 26
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.verticalCenter: sendText.verticalCenter
        color: "transparent"

        MouseArea {
            anchors.fill: parent
            //enabled: sendEnabled

            onPressed: {
                click01.play()
                detectInteraction()
                parent.opacity = 0.5
                sendEnabled = false;
            }

            onCanceled: {
                parent.opacity = 0.5
            }

            onReleased: {
                parent.opacity = 0.5
            }

            onClicked: {
                xChatMessage = sendText.text
                if (xChatMessage.length != 0 && xChatMessage.length < 251) {
                    xchatError = 0
                    xChatSend("@ " + username + ",mobile:" +  sendText.text)
                    sendText.text = "";
                    xChatTypingRemove("%&%& " + username);
                    myXchat.tag = ""
                }
                if (xChatMessage.length >= 251) {
                    xChatTread.append({"author" : "xChatRobot", "device" : "", "date" : "", "message" : "The limit for text messages is 250 characters.", "ID" : xChatID})
                    xChatID = xChatID + 1
                    sendText.text = ""
                }
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
        source: 'qrc:/icons/mobile/send_rotated_03.svg'
        width: executeButton.width
        height: executeButton.height
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: executeButton.verticalCenter
        anchors.right: executeButton.right
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
                    myXchat.tag = ""
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

    Mobile.XChatSettings {
        z: 10
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Mobile.XChatUsers {
        z: 10
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Component.onDestruction: {
        sendText.text = ""
        myXchat.tag = ""
        xchatTracker = 0
        xchatError = 0
    }
}

