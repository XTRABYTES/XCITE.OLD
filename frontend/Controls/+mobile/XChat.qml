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
    clip: true
    onStateChanged: {
        detectInteraction()
        if(xchatTracker === 1) {
            myXchat.xChatList.positionViewAtEnd()
        }
    }


    property string xChatMessage: ""
    property var msg : ""
    property int cursorPos: 0
    property bool isTag: false
    property int beginTag: 0
    property int endTag: 0
    property bool startTagging: false
    property string beforeTag: ""
    property string afterTag: ""

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
                    xchatNetworkTracker = 1
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
        id: xChatDND
        source: "qrc:/icons/mobile/dnd-icon_01.svg"
        anchors.verticalCenter: xchatModalLabel.verticalCenter
        anchors.left: connectingLabel.right
        anchors.leftMargin: 20
        height: 20
        fillMode: Image.PreserveAspectFit
        visible: userSettings.xChatDND === true
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
        anchors.bottom: newMessagesBar.visible? newMessagesBar.top : sendText.top
        anchors.bottomMargin: newMessagesBar.visible? 0 : 10
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        clip: true

        Mobile.XChatList {
            id: myXchat
            focus: false
            onTaggingChanged: {
                if (myXchat.tagging !== "") {
                    var pos = sendText.cursorPosition
                    var tag = myXchat.tagging + " "
                    if (cursorPos == 0 || msg.charAt(cursorPos - 1) == " ") {
                        sendText.text = sendText.insert(pos, tag)
                    }
                    else {
                        sendText.text = sendText.insert(pos, (" " + tag))
                    }
                    myXchat.tagging = ""
                }
            }
        }
    }

    Label {
        id: typingLabel
        text: typing
        anchors.top: sendText.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.family: xciteMobile.name
        font.bold: true
        font.pixelSize: 10
        font.letterSpacing: 1
    }

    DropShadow {
        anchors.fill: newMessagesBar
        source: newMessagesBar
        samples: 9
        radius: 4
        color: darktheme == true? "#000000" : "#727272"
        horizontalOffset:0
        verticalOffset: 0
        spread: 0
        visible: newMessagesBar.visible
    }

    Rectangle {
        id: newMessagesBar
        width: Screen.width
        height: 20
        color: darktheme == false ? "#34363D" : "#2A2C31"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: sendText.top
        anchors.bottomMargin: 5
        visible: xChatScrolling && newMessages

        Label {
            id: newMessagesLabel
            text: "New messages available"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 28
            color: "#F2F2F2"
            font.family: xciteMobile.name
            font.pixelSize: 16
        }

        Image {
            id: newMessagesArrow
            source: 'qrc:/icons/mobile/dropdown-icon_01_light.svg'
            height: 14
            width: 14
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 28
        }

        Rectangle {
            height: 20
            width: 20
            color: "transparent"
            anchors.horizontalCenter: newMessagesArrow.horizontalCenter
            anchors.verticalCenter: newMessagesArrow.verticalCenter

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    myXchat.xChatList.positionViewAtEnd()
                    newMessages = false
                }
            }
        }
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
        deleteBtn: 0

        Timer {
            id: typingTimer
            interval: 6000
            onTriggered: {
                xChatTyping(myUsername,"removeFromTyping",status);
                if (userSettings.xChatDND === false) {
                    status="online"
                    checkIfIdle.restart();
                }
            }
        }

        Timer {
            id: sendTypingTimer
            interval: 5000
            onTriggered: {
                sendTyping = true
            }
        }

        onTextChanged:  {
            msg = sendText.text
            cursorPos = sendText.cursorPosition
            isTag = msg.charAt(cursorPos - 1) === "@" && (cursorPos === 1 || msg.charAt(cursorPos - 2) === " ")

            if (isTag) {
                beginTag = cursorPos
                endTag = cursorPos
                startTagging = true
                tagListTracker = 1
            }

            if (startTagging) {
                endTag = cursorPos
                if (msg.charAt(endTag - (endTag - beginTag) - 1) === "@") {
                    tagFilter = sendText.getText(beginTag, endTag)
                }
                else {
                    startTagging = false
                    tagListTracker = 0
                    tagFilter = ""
                    beginTag = 0
                    endTag = 0
                }
            }
        }

        onTextEdited: {
            typingTimer.restart();
            if (sendTyping){
                if (userSettings.xChatDND === false) {
                    status="online"
                }
                xChatTyping(myUsername,"addToTyping",status);
                sendTypingTimer.start()
                sendXchatConnection.restart();
                checkIfIdle.restart();
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
                if (xChatMessage.length != 0 && xChatMessage.length < 251 && xChatConnection) {
                    xchatError = 0
                    if (UserSettings.xChatDND === false) {
                        status="online"
                    }
                    xChatSend(myUsername,"mobile",status,sendText.text)
                    sendText.text = "";
                    xChatTyping(myUsername,"removeFromTyping",status);
                    checkIfIdle.restart();
                    myXchat.tagging = ""
                }
                if (xChatMessage.length >= 251) {
                    xChatTread.append({"author" : "xChatRobot", "device" : "", "date" : "", "message" : "The limit for text messages is 250 characters.", "ID" : xChatID})
                    xChatID = xChatID + 1
                    sendText.text = ""
                    myXchat.xChatList.positionViewAtEnd()

                }
                if (!xChatConnection) {
                    xChatTread.append({"author" : "xChatRobot", "device" : "", "date" : "", "message" : "You're currently not connected to X-CHAT. Try again later", "ID" : xChatID})
                    xChatID = xChatID + 1
                    myXchat.xChatList.positionViewAtEnd()
                }
            }
        }

        Connections {
            target: xChat

            onXchatSuccess: {
                if(myXchat.xChatOrderedList.get(myXchat.xChatOrderedList.count - 1).author === myUsername) {
                    myXchat.xChatList.positionViewAtEnd()
                }
                else if(!xChatScrolling) {
                    myXchat.xChatList.positionViewAtEnd()
                }
                else {
                    newMessages = true
                }
            }

            onXchatTypingSignal: {
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
                    isTag = false
                    startTagging = false
                    tagListTracker = 0
                    tagFilter = ""
                    beginTag = 0
                    endTag = 0
                    beforeTag = ""
                    afterTag = ""
                    myXchatTaglist.userTag = ""
                    myXchatUsers.usertag = ""
                    myXchat.tagging = ""
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

    DropShadow {
        anchors.fill: userTagArea
        source: userTagArea
        samples: 9
        radius: 4
        color: darktheme == true? "#000000" : "#727272"
        horizontalOffset:0
        verticalOffset: 0
        spread: 0
        visible: tagListTracker == 1 && xChatFilterResults > 0
    }

    Rectangle {
        id: userTagArea
        width: Screen.width - 56
        height: myXchatTaglist.height + 25
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: sendText.top
        anchors.bottomMargin: 15
        color: darktheme == false ? "#34363D" : "#2A2C31"
        visible: tagListTracker == 1 && xChatFilterResults > 0

        Label {
            id: tagListLabel
            text: "Users"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            font.bold: true
            color: "#F2F2F2"
        }

        Image {
            id: closeTagList
            source: 'qrc:/icons/mobile/close-icon_01_white.svg'
            height: 9
            fillMode: Image.PreserveAspectFit
            anchors.top: parent.top
            anchors.topMargin: 8
            anchors.right: parent.right
            anchors.rightMargin: 8
        }

        Rectangle {
            id: closeTagListButton
            width: 25
            height: 25
            anchors.horizontalCenter: closeTagList.horizontalCenter
            anchors.verticalCenter: closeTagList.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    tagListTracker = 0
                    tagFilter = ""
                }
            }
        }
    }

    Mobile.XChatTagList {
        id: myXchatTaglist
        z: 10
        width: Screen.width - 56
        anchors.bottom: userTagArea.bottom
        anchors.horizontalCenter:parent.horizontalCenter
        visible: tagListTracker == 1 && xChatFilterResults > 0


        onUserTagChanged: {
            if (myXchatTaglist.userTag !== "" && startTagging == true) {
                var pos = beginTag
                var tag = myXchatTaglist.userTag
                tagListTracker = 0
                tagFilter = ""
                startTagging = false
                beforeTag = sendText.getText(0, beginTag)
                afterTag = sendText.getText(endTag, msg.length)
                sendText.text = beforeTag + " " + afterTag
                sendText.text = sendText.insert(pos, tag)
                myXchatTaglist.userTag = ""
                beforeTag = ""
                afterTag = ""
                beginTag = 0
                endTag = 0
            }
        }
    }

    Mobile.XChatNetworkInfo {
        id: myXchatNetwork
        z: 10
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Mobile.XChatUsers {
        id: myXchatUsers
        z: 10
        anchors.left: parent.left
        anchors.top: parent.top

        onUsertagChanged: {
            if (myXchatUsers.usertag !== "") {
                var pos = sendText.cursorPosition
                var tag = myXchatUsers.usertag + " "
                if (cursorPos == 0 || msg.charAt(cursorPos - 1) == " ") {
                    sendText.text = sendText.insert(pos, tag)
                }
                else {
                    sendText.text = sendText.insert(pos,(" " + tag))
                }
                myXchatUsers.usertag = ""
            }
        }
    }

    Mobile.XChatSettings {
        id: myXchatSettings
        z: 10
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Mobile.XChatDndNotification {
        id: myDndNotification
        z: 11
        anchors.left: parent.left
        anchors.top: parent.top
        visible: dndTracker == 1
    }

    Mobile.NetworkError {
        z:100
        id: myNetworkError
    }

    Component.onDestruction: {
        sendText.text = ""
        xchatTracker = 0
        xchatError = 0
        isTag = false
        startTagging = false
        tagListTracker = 0
        tagFilter = ""
        beginTag = 0
        endTag = 0
        beforeTag = ""
        afterTag = ""
        myXchatTaglist.userTag = ""
        myXchatUsers.usertag = ""
        myXchat.tagging = ""
    }
}

