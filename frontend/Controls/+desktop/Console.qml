/**
* Filename: Console.qml
*
* XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
* blockchain protocol to host decentralized applications
*
* Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
*
* This file is part of an XTRABYTES Ltd. project.
*
*/

import QtQuick 2.7
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop

Rectangle {
    id: backgroundConsole
    z: 1
    width: appWidth/6 * 5
    height: appHeight
    anchors.right: parent.right
    anchors.top: parent.top
    color: bgcolor
    state: pingTracker == 1? "up" : "down"
    onStateChanged: {
        detectInteraction()
    }

    property int myTracker: pingTracker
    property int totalPings: 0
    property variant replyArray
    property string pingReply
    property string sendTime
    property string replyTime
    property string xdapp: "ping"
    property int popupY: 0
    property string msgAuth: ""
    property int confirmCopy: 0

    onMyTrackerChanged: {
        if (myTracker == 0) {
            timer.start()
        }
        else {
            msgList.positionViewAtEnd()
            requestQueue()
            selectedApp = ""
        }
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: backgroundConsole; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: backgroundConsole; anchors.topMargin: appHeight}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: backgroundConsole; properties: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    Label {
        id: consoleLabel
        text: "Applications - Console"
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        color: themecolor
        font.letterSpacing: 2
        horizontalAlignment: Text.AlignRight
        elide: Text.ElideRight
    }

    Item {
        id: inputArea
        width: (parent.width - (appWidth*3/24))/2
        anchors.bottom: parent.bottom
        anchors.top: consoleLabel.bottom
        anchors.topMargin: appWidth/12
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24

        Controls.TextInput {
            id: appText
            height: appHeight/18
            placeholder: "XDAPP"
            text: xdapp
            anchors.left: parent.left
            anchors.right: appBtn.left
            anchors.rightMargin: height/3
            anchors.top: parent.top
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2.5
            mobile: 1
        }

        Rectangle {
            id: appBtn
            width: appText.height
            height: width
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.verticalCenter: appText.verticalCenter
            color: maincolor
            opacity: 0.5

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                    appBtn.opacity = 1
                }

                onCanceled: {
                    parent.opacity = 1
                }

                onReleased: {
                    appBtn.opacity = 0.5
                }

                onClicked: {
                    xdapp = appText.text
                    xPingTread.append({"message": "new XDAPP set: " + appText.text, "inout": "in", "author": "XCITE", "time": sendTime})
                    msgList.positionViewAtEnd()
                }
            }
        }

        Text {
            id: appBtnLabel
            text: "SET"
            anchors.horizontalCenter: appBtn.horizontalCenter
            anchors.verticalCenter: appBtn.verticalCenter
            font.pixelSize: appBtn.height/2
            font.family: xciteMobile.name
            color: "#F2F2F2"
        }

        Controls.TextInput {
            id: queueText
            height: appHeight/18
            placeholder: "STATIC QUEUE"
            text: queueName
            anchors.left: parent.left
            anchors.right: queueBtn.left
            anchors.rightMargin: height/3
            anchors.top: appBtn.bottom
            anchors.topMargin: height/2
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2.5
            mobile: 1
        }

        Rectangle {
            id: queueBtn
            width: queueText.height
            height: width
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.verticalCenter: queueText.verticalCenter
            color: maincolor
            opacity: 0.5

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                    queueBtn.opacity = 1
                }

                onCanceled: {
                    parent.opacity = 1
                }

                onReleased: {
                    queueBtn.opacity = 0.5
                }

                onClicked: {
                    setQueue(queueText.text)
                }
            }
        }

        Text {
            id: queueBtnLabel
            text: "SET"
            anchors.horizontalCenter: queueBtn.horizontalCenter
            anchors.verticalCenter: queueBtn.verticalCenter
            font.pixelSize: queueBtn.height/2
            font.family: queueBtn.height/2
            color: "#F2F2F2"
        }

        Controls.TextInput {
            id: requestText
            height: appHeight/18
            width: parent.width/3
            placeholder: xdapp != "ping"? "Method" : "PingID"
            text: ""
            anchors.left: parent.left
            anchors.top: queueBtn.bottom
            anchors.topMargin: height/2
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2.5
            mobile: 1
        }

        Controls.TextInput {
            id: pingAmount
            height: requestText.height
            placeholder: xdapp != "ping"? "Payload" : "Amount"
            text: ""
            inputMethodHints: xdapp == "ping"? Qt.ImhDigitsOnly : Qt.ImhNone
            anchors.left: requestText.right
            anchors.leftMargin: height/3
            anchors.right: executeButton.left
            anchors.rightMargin: height/3
            anchors.top: queueBtn.bottom
            anchors.topMargin: height/2
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2.5
            mobile: 1
        }

        Rectangle {
            id: executeButton
            width: requestText.height
            height: width
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.top: queueBtn.bottom
            anchors.topMargin: height/2
            color: maincolor
            opacity: 0.5

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                    parent.opacity = 1
                }

                onCanceled: {
                    parent.opacity = 1
                }

                onReleased: {
                    parent.opacity = 0.5
                }

                onClicked: {
                    sendTime = new Date().toLocaleString(Qt.locale(),"hh:mm:ss .zzz")
                    console.log("sendTime: " + sendTime)
                    if (requestText.text != "") {
                        if (xdapp == "ping") {
                            var pingIdentifier
                            if (pingAmount.text != "") {
                                totalPings = Number.fromLocaleString(Qt.locale("en_US"),pingAmount.text)
                                if (totalPings <= 50) {
                                    xPingTread.append({"message": "UI - ping: " + myUsername + "_" + requestText.text + ", amount: " + pingAmount.text, "inout": "out", "author": myUsername, "time": sendTime})
                                    msgList.positionViewAtEnd()
                                    pingIdentifier = myUsername + "_" + requestText.text + "_" + pingAmount.text
                                    var dataModelParams = {"xdapp":xdapp, "method":"ping","payload":pingIdentifier}
                                    var paramsJson = JSON.stringify(dataModelParams)
                                    dicomRequest(paramsJson)
                                    requestText.text = ""
                                    pingAmount.text = ""
                                }
                                else {
                                    xPingTread.append({"message": "Amount too high, max. 50!!", "inout": "in", "author": "xChatRobot", "time": sendTime})
                                    msgList.positionViewAtEnd()
                                    pingAmount.text = ""
                                }
                            }
                            else {
                                totalPings = 1
                                xPingTread.append({"message": "UI - ping: " + myUsername + "_" + requestText.text + ", amount: 1", "inout": "out", "author": myUsername, "time": sendTime})
                                msgList.positionViewAtEnd()
                                pingIdentifier = myUsername + "_" + requestText.text + "_1"
                                var dataModelParams2 = {"xdapp":xdapp, "method":"ping","payload":pingIdentifier}
                                var paramsJson2 = JSON.stringify(dataModelParams2)
                                dicomRequest(paramsJson2)
                                requestText.text = ""
                                pingAmount.text = ""
                            }
                        }
                        else {
                            xPingTread.append({"message": "UI - " +  xdapp + ": " + requestText.text + " " + pingAmount.text, "inout": "out", "author": myUsername, "time": sendTime})
                            msgList.positionViewAtEnd()
                            var dataModelParams3 = {"xdapp":xdapp, "method":requestText.text,"payload":pingAmount.text}
                            var paramsJson3 = JSON.stringify(dataModelParams3)
                            dicomRequest(paramsJson3)
                            requestText.text = ""
                            pingAmount.text = ""
                        }
                    }
                    else {
                        if (xdapp == "ping") {
                            xPingTread.append({"message": "No ping identifier selected!!", "inout": "in", "author": "xChatRobot", "time": sendTime})
                        }
                        else {
                            xPingTread.append({"message": "No method selected!!", "inout": "in", "author": "xChatRobot", "time": sendTime})
                        }

                        msgList.positionViewAtEnd()
                    }
                }
            }

            Connections {
                target: xChat

                onXchatResponseSignal: {
                    //if (pingTracker == 1) {
                    replyTime = new Date().toLocaleString(Qt.locale(),"hh:mm:ss .zzz")
                    console.log("replyTime: " + replyTime)
                    pingReply = text
                    replyArray = pingReply.split(' ')
                    if (replyArray[0] === "dicom") {
                        xPingTread.append({"message": pingReply, "inout": "in", "author": "staticNet", "time": replyTime})
                        msgList.positionViewAtEnd()
                    }
                    else if (replyArray[0] === "exchange") {
                        xPingTread.append({"message": pingReply, "inout": "in", "author": "staticNet", "time": replyTime})
                        msgList.positionViewAtEnd()
                    }

                    //}
                }
            }
        }

        Image {
            source: 'qrc:/icons/mobile/ping-icon_01_white.svg'
            height: executeButton.height*2/3
            width: 24
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: executeButton.verticalCenter
            anchors.horizontalCenter: executeButton.horizontalCenter
        }

        Rectangle {
            width: height
            height: executeButton.height
            anchors.right: executeButton.right
            anchors.top: queueBtn.bottom
            anchors.topMargin: height/2
            color: "transparent"
            border.color: maincolor
            border.width: 1
            opacity: 0.50
        }
    }

    Item {
        id: outputArea
        width: (parent.width - (appWidth*3/24))/2
        anchors.bottom: parent.bottom
        anchors.top: consoleLabel.bottom
        anchors.topMargin: appWidth/12
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12

        Rectangle {
            id: replyWindow
            width: parent.width
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: appWidth/12
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            clip: true

            Component {
                id: msgLine

                Rectangle {
                    id: msgRow
                    width: parent.width - appHeight/72
                    height: author == "xChatRobot"? 25 : messageText.height
                    color: "transparent"
                    visible: message != ""

                    Rectangle {
                        id: msgBox
                        width: (messageText.implicitWidth + 10) < (0.85 * parent.width)? (messageText.implicitWidth + 10) : (0.85 * parent.width)
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: inout == "in"? undefined : parent.left
                        anchors.leftMargin: inout == "in"? 0 : 2
                        anchors.right: inout == "in"? parent.right : undefined
                        anchors.rightMargin: inout == "in"? 2 : 0
                        color: inout == "in"? "transparent" : maincolor
                        border.width: inout == "in"? 1 : 0
                        border.color: inout == "in"? maincolor : "transparent"
                    }

                    Text {
                        id: messageText
                        text: inout == "in"? (author == "staticNet"? "STATIC-net: " + message : (author == "XCITE"? "XCITE: " + message : message)) : ">>>>" + message
                        anchors.left: msgBox.left
                        anchors.leftMargin: 5
                        anchors.right: msgBox.right
                        anchors.rightMargin: 5
                        anchors.top: parent.top
                        horizontalAlignment: Text.AlignLeft
                        font.family: xciteMobile.name
                        wrapMode: Text.Wrap
                        font.pixelSize: 14
                        textFormat: Text.StyledText
                        color: inout == "in"? (darktheme == false? "#14161B" : maincolor) : "#14161B"

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton

                            onClicked: {
                                popupY = mouseY
                                if (mouse.button == Qt.RightButton && copy2clipboard == 0 && pingTracker == 1 && author !== "xChatRobot") {
                                    copiedConsoleText = messageText.text
                                    msgAuth = author
                                    confirmCopy = 1
                                }
                            }
                        }
                    }

                    Text {
                        id: messageTime
                        text: time
                        anchors.left: inout == "in"? parent.left : msgBox.right
                        anchors.leftMargin: 5
                        anchors.right: inout == "in"? msgBox.left : parent.right
                        anchors.rightMargin: 5
                        anchors.verticalCenter: msgBox.verticalCenter
                        horizontalAlignment: Text.AlignRight
                        font.family: xciteMobile.name
                        wrapMode: Text.Wrap
                        font.pixelSize: 8
                        textFormat: Text.StyledText
                        color: darktheme == false? "#14161B" : maincolor
                        visible: author != "xChatRobot"
                    }

                    Image {
                        id: xChatRobotIcon
                        source: 'qrc:/icons/mobile/robot_bee_01.svg'
                        width: 25
                        height: 25
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: msgBox.left
                        anchors.rightMargin: 5
                        visible: author == "xChatRobot"
                    }
                }
            }

            ListView {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                id: msgList
                model: xPingTread
                delegate: msgLine
                spacing: 5

                ScrollIndicator.vertical: ScrollIndicator {
                    parent: msgList.parent
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    width: appHeight/72
                    opacity: 1

                    contentItem: Rectangle {
                        implicitWidth: parent.width
                        implicitHeight: appWidth/24
                        color: maincolor
                    }
                }

                onDraggingChanged: {
                    detectInteraction()
                }
            }
        }

        DropShadow {
            z: 12
            anchors.fill: textPopup
            source: textPopup
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.4
            transparentBorder: true
            visible: textPopup.visible
        }

        Item {
            id: textPopup
            z: 12
            width: popupClipboard.width
            height: popupClipboardText.height
            anchors.horizontalCenter: replyWindow.horizontalCenter
            anchors.verticalCenter: replyWindow.verticalCenter
            visible: copy2clipboard == 1 && pingTracker == 1

            Rectangle {
                id: popupClipboard
                height: appHeight/27
                width: popupClipboardText.width + appHeight/18
                color: "#42454F"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                id: popupClipboardText
                text: "Text copied!"
                font.family: xciteMobile.name
                font.pointSize: popupClipboard.height/2
                color: "#F2F2F2"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        DropShadow {
            z: 12
            anchors.fill: confirmPopup
            source: confirmPopup
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.4
            transparentBorder: true
            visible: confirmPopup.visible
        }

        Item {
            id: confirmPopup
            z: 12
            width: popupConfirm.width
            height: popupConfirm.height
            anchors.horizontalCenter: replyWindow.horizontalCenter
            anchors.verticalCenter: replyWindow.verticalCenter
            visible: confirmCopy == 1 && pingTracker == 1

            Rectangle {
                id: popupConfirm
                height: popupConfirmText.height + popupConfirmBtn.height + appHeight/72
                width: replyWindow.width*0.9
                color: "#42454F"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Item {
                id: popupConfirmText
                height: appHeight/27
                width: parent.width
                anchors.bottom: popupConfirm.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    id: confirmText
                    width: appWidth/6 * 1.5
                    text: "Copy text: " + copiedConsoleText
                    font.family: xciteMobile.name
                    font.pointSize: parent.height/2
                    color: "#F2F2F2"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    elide: Text.ElideRight
                    leftPadding: parent.height/2
                    rightPadding: parent.height/2
                }
            }

            Item {
                id: popupConfirmBtn
                height: appHeight/27
                width: parent.width
                anchors.bottom: popupConfirm.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                Item {
                    id: yesBtn
                    height: parent.height
                    width: parent.width/2
                    anchors.top: parent.top
                    anchors.left: parent.left

                    Label {
                        text: "Yes"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/2
                        color: "#F2F2F2"
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            if(copy2clipboard == 0 && pingTracker == 1 && msgAuth !== "xChatRobot") {
                                confirmCopy = 0
                                copyText2Clipboard(copiedConsoleText)
                                copy2clipboard = 1
                            }
                        }
                    }
                }

                Item {
                    id: noBtn
                    height: parent.height
                    width: parent.width/2
                    anchors.top: parent.top
                    anchors.right: parent.right

                    Label {
                        text: "No"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/2
                        color: "#F2F2F2"
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            if(copy2clipboard == 0 && pingTracker == 1 && msgAuth !== "xChatRobot") {
                                confirmCopy = 0
                            }
                        }
                    }
                }
            }

            Rectangle {
                height: 1
                width: parent.width - 4
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#F2F2F2"
                opacity: 0.1
            }

            Rectangle {
                height: parent.height/2 - 2
                width: 1
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#F2F2F2"
                opacity: 0.1
            }
        }

        Rectangle {
            id: replyWindowBorder
            height: replyWindow.height + 2
            width: replyWindow.width + 2
            anchors.horizontalCenter: replyWindow.horizontalCenter
            anchors.verticalCenter: replyWindow.verticalCenter
            color: "transparent"
            border.color: themecolor
            border.width: 1
        }

        Timer {
            id: timer
            interval: 300
            repeat: false
            running: false

            onTriggered: {
                pingReply = ""
                requestText.text = ""
                copy2clipboard = 0
                closeAllClipboard = true
            }
        }
    }

    Rectangle {
        id: bottomBar
        height: appWidth/24
        width: parent.width
        anchors.bottom: parent.bottom
        color: darktheme == true? "#14161B" : "#FDFDFD"
    }
}
