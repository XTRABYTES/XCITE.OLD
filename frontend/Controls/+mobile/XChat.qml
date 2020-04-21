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
    width: appWidth
    height: appHeight
    state: xchatTracker == 1? "up" : "down"
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
    property int myTracker: xchatTracker
    property int charCount: 0

    onMyTrackerChanged: {
        if (myTracker == 0) {
            xchatError = 0
            timer.start()
        }
    }

    function sendChat() {
        xChatMessage = sendText.text
        var trimedMsg = xChatMessage.trim()
        if (trimedMsg !== 0 && xChatMessage.length < 251 && xChatConnection) {
            if (imageAdded == true && xChatMessage.length > 100) {
                xChatTread.append({"author" : "xChatRobot", "device" : "", "date" : "", "message" : "The limit for text messages with images is 100 characters.", "ID" : xChatID})
                xChatID = xChatID + 1
                myXchat.xChatList.positionViewAtEnd()
            }
            else {
                xchatError = 0
                if (UserSettings.xChatDND === false) {
                    status="online"
                }
                var device = "mobile"
                if (Qt.platform.os !== "android" && Qt.platform.os !== "ios") {
                    device = "desktop"
                }

                xChatSend(myUsername,device,status,sendText.text, xchatLink, xchatImage, xchatQuote)
                xchatQuote = ""
                quoteAdded = false
                xchatLink = ""
                myXchatLink.urlText = ""
                linkAdded = false
                xchatImage = ""
                imageAdded = false
                myXchatImage.urlText = ""
                myXchatImage.imageSource = 'qrc:/icons/mobile/image-icon_01_grey.svg'
                sendText.text = "";
                xChatTyping(myUsername,"removeFromTyping",status);
                checkIfIdle.restart();
                myXchat.tagging = ""
                isTag = false
                startTagging = false
                tagListTracker = 0
                tagFilter = ""
                beginTag = 0
                endTag = 0
            }
        }
        if (xChatMessage.length >= 251) {
            xChatTread.append({"author" : "xChatRobot", "device" : "", "date" : "", "message" : "The limit for text messages is 250 characters.", "ID" : xChatID})
            xChatID = xChatID + 1
            myXchat.xChatList.positionViewAtEnd()

        }
        if (!xChatConnection) {
            xChatTread.append({"author" : "xChatRobot", "device" : "", "date" : "", "message" : "You're currently not connected to X-CHAT. Try again later", "ID" : xChatID})
            xChatID = xChatID + 1
            myXchat.xChatList.positionViewAtEnd()
        }
    }

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
            PropertyChanges { target: xchatModal; anchors.topMargin: xchatModal.height}
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
        id: underConstruction
        source: darktheme === true? 'qrc:/icons/mobile/construction-icon_01_white.svg' : 'qrc:/icons/mobile/construction-icon_01_black.svg'
        width: 100
        height: 100
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        anchors.horizontalCenter: parent.horizontalCenter
    }
    /**
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

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

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
        anchors.verticalCenter: onlineIndicator.verticalCenter
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

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

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

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    xchatSettingsTracker = 1
                }
            }
        }
    }

    Rectangle {
        id: msgWindow
        width: parent.width - 56
        anchors.top: xchatModalLabel.bottom
        anchors.topMargin: 5
        anchors.bottom: newMessagesBar.visible? newMessagesBar.top : sendText.top
        anchors.bottomMargin: newMessagesBar.visible? 0 : 15
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        clip: true

        Mobile.XChatList {
            id: myXchat
            focus: false
            onTaggingChanged: {
                if (myXchat.tagging !== "") {
                    var pos = sendText.cursorPosition
                    var tag = myXchat.tagging.trim()
                    if (pos === 0 || msg.charAt(pos - 1) === " ") {
                        tag = tag + " "
                    }
                    else {
                        tag = " " + tag + " "
                    }
                    console.log("XChat1 - pos." + pos + "., tag." + tag + ".")
                    sendText.text = sendText.text.substring(0, pos) + tag + sendText.text.substring(pos)
                    myXchat.tagging = ""
                }
            }
        }
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
        width: parent.width
        height: 20
        color: "#6C6C6C"
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
            typingTimer.restart();
            if (sendTyping){
                if (userSettings.xChatDND === false) {
                    status="online"
                }
                xChatTyping(myUsername,"addToTyping",status);
                sendTyping = false
                sendTypingTimer.start()
                sendXchatConnection.restart();
                checkIfIdle.restart();
            }
            // check for tag
            msg = sendText.text
            charCount = msg.length
            cursorPos = sendText.cursorPosition

            if (isTag == false) {
                if (msg.charAt(cursorPos - 1) === "@" && (cursorPos === 1 || msg.charAt(cursorPos - 2) === " ")) {
                    isTag = true
                    startTagging = true
                    beginTag = cursorPos
                    endTag = cursorPos
                    tagListTracker = 1
                    tagFilter = beginTag !== endTag? sendText.getText(beginTag, endTag): ""
                }
            }

            else {
                if (msg.charAt(cursorPos - 1) === " " || cursorPos === 0) {
                    isTag = false
                    startTagging = false
                    tagListTracker = 0
                    tagFilter = ""
                    beginTag = 0
                    endTag = 0
                }
                else {
                    endTag = cursorPos
                    tagFilter = sendText.getText(beginTag, endTag)
                    console.log("tagfilter: " + tagFilter)
                }
            }
        }

        Keys.onEnterPressed: sendChat()
        Keys.onReturnPressed: sendChat()
    }

    Image {
        id: sendIcon
        source: 'qrc:/icons/mobile/send_rotated_03.svg'
        width: 25
        height: 25
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: executeButton.verticalCenter
        anchors.right: executeButton.right
    }

    Rectangle {
        id: executeButton
        width: 30
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.verticalCenter: sendText.verticalCenter
        color: "transparent"

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
                sendChat()
            }
        }

        Connections {
            target: xChat

            onXchatTypingSignal: {
                typing = msg
            }

            onXchatSuccess: {
                autoScrollThread.sendMessage({"author": author, "date": date, "time": time, "device": device, "msg": message, "link": link, "image": image, "quote": quote, "msgID": msgID, "me": myUsername.trim(), "tagMe": userSettings.tagMe, "tagEveryone": userSettings.tagEveryone, "dnd": userSettings.xChatDND})
            }
        }
    }

    Label {
        id: maxWords
        text: imageAdded == true? "/100" : "/250"
        anchors.bottom: sendIcon.top
        anchors.bottomMargin: 4
        anchors.right: sendText.right
        anchors.rightMargin: 5
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.family: xciteMobile.name
        font.pixelSize: 8
    }

    Label {
        id: charLength
        text: charCount.toString()
        anchors.bottom: sendIcon.top
        anchors.bottomMargin: 4
        anchors.right: maxWords.left
        color: (imageAdded === true && charCount > 100)? "#E55541": charCount > 250? "#E55541" : darktheme == true? "#F2F2F2" : "#2A2C31"
        font.family: xciteMobile.name
        font.pixelSize: 8
    }

    Image {
        id: msgQuote
        source: quoteAdded === false? "qrc:/icons/mobile/quote-icon_01_grey.svg" : "qrc:/icons/mobile/quote-icon_01_blue.svg"
        width: 20
        height: 20
        fillMode: Image.PreserveAspectFit
        anchors.right: msgLink.left
        anchors.rightMargin: 20
        anchors.top: sendText.bottom
        anchors.topMargin: 10

        Rectangle {
            id: msgQuoteBtn
            width: 30
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                enabled: quoteAdded === true

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (xChatQuoteTracker == 0) {
                        xChatQuoteTracker = 1
                    }
                }
            }
        }
    }

    Image {
        id: msgLink
        source: linkAdded === false? "qrc:/icons/mobile/link-icon_01_grey.svg" : "qrc:/icons/mobile/link-icon_01_blue.svg"
        width: 20
        height: 20
        fillMode: Image.PreserveAspectFit
        anchors.right: msgImage.left
        anchors.rightMargin: 20
        anchors.top: sendText.bottom
        anchors.topMargin: 10

        Rectangle {
            id: msgLinkBtn
            width: 30
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (xChatLinkTracker == 0) {
                        xChatLinkTracker = 1
                    }
                }
            }
        }
    }

    Image {
        id: msgImage
        source: imageAdded === false? "qrc:/icons/mobile/image-icon_01_grey.svg" : "qrc:/icons/mobile/image-icon_01_blue.svg"
        width: 20
        height: 20
        fillMode: Image.PreserveAspectFit
        anchors.right: sendText.right
        anchors.rightMargin: 5
        anchors.top: sendText.bottom
        anchors.topMargin: 10

        Rectangle {
            id: msgImageBtn
            width: 30
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (xChatImageTracker == 0) {
                        xChatImageTracker = 1
                    }
                }
            }
        }
    }

    Label {
        id: typingLabel
        text: typing
        anchors.top: msgImage.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.family: xciteMobile.name
        font.bold: true
        font.pixelSize: 10
        font.letterSpacing: 1
    }

    Label {
        id: closeXchatModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : (isIphoneX()? 90 : 70)
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: false

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
            visible: false

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
                    myXchatTaglist.userTag = ""
                    myXchatUsers.usertag = ""
                    myXchat.tagging = ""
                    myXchatLink.urlText = ""
                    myXchatImage.urlText = ""
                    xchatLink = ""
                    xchatImage = ""
                    xchatQuote = ""
                    linkAdded = false
                    imageAdded = false
                    quoteAdded = false
                }
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onReleased: {
                if (xchatTracker == 1) {
                    xchatTracker = 0;
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
        width: parent.width - 56
        height: myXchatTaglist.height + 25
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: sendText.top
        anchors.bottomMargin: 15
        color: "#6C6C6C"
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

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    tagListTracker = 0
                    tagFilter = ""
                }
            }
        }
    }

    WorkerScript {
        id: autoScrollThread
        source:'qrc:/Controls/+mobile/addMessage.js'

        onMessage: {
            for (var b = 0; b < xChatUsers.count; b ++) {
                if (xChatUsers.get(b).username === messageObject.author) {
                    if (messageObject.msg !== "") {
                        if(!xChatScrolling) {
                            autoScrollTimer.start()
                        }
                    }
                }
            }
        }
    }

    Mobile.XChatTagList {
        id: myXchatTaglist
        z: 10
        width: parent.width - 56
        anchors.bottom: userTagArea.bottom
        anchors.horizontalCenter:parent.horizontalCenter
        visible: tagListTracker == 1 && xChatFilterResults > 0


        onUserTagChanged: {
            if (myXchatTaglist.userTag !== "" && startTagging == true) {
                console.log("tag received: " + userTag)
                var pos = beginTag
                var tag = myXchatTaglist.userTag.trim() + " "
                console.log("XChat2 - pos." + pos + "., tag." + tag + ".")
                sendText.text = sendText.text.substring(0, pos) + tag + sendText.text.substring(pos)
                tagListTracker = 0
                tagFilter = ""
                startTagging = false
                myXchatTaglist.userTag = ""
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
                var tag = myXchatUsers.usertag.trim()
                if (pos === 0 || msg.charAt(pos - 1) === " ") {
                    tag = tag + " "
                }
                else {
                    tag = " " + tag + " "
                }
                console.log("XChat3 - pos." + pos + "., tag." + tag + ".")
                sendText.text = sendText.text.substring(0, pos) + tag + sendText.text.substring(pos)
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

    Mobile.XChatQuote {
        id: myXchatQuote
        z: 10
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Mobile.XChatLink {
        id: myXchatLink
        z: 10
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Mobile.XChatImage {
        id: myXchatImage
        z: 10
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Mobile.XChatLargeImage {
        id: myXchatLargeImage
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

    Timer {
        id: autoScrollTimer
        interval: 100
        repeat: false
        running: false

        onTriggered: {
            myXchat.xChatList.positionViewAtEnd()
        }
    }

    */
    Component.onDestruction: {
        //sendText.text = ""
        xchatTracker = 0
        xchatError = 0
        isTag = false
        startTagging = false
        tagListTracker = 0
        tagFilter = ""
        beginTag = 0
        endTag = 0
        myXchatTaglist.userTag = ""
        myXchatUsers.usertag = ""
        myXchat.tagging = ""
    }
}
