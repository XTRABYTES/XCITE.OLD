/**
 * Filename: XPING.qml
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

import "qrc:/Controls" as Controls

Rectangle {
    id: pingModal
    width: appWidth
    height: appHeight
    state: pingTracker == 1? "up" : "down"
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    onStateChanged: detectInteraction()

    property int myTracker: pingTracker
    property int totalPings: 0
    property variant replyArray
    property string pingReply
    property string sendTime
    property string replyTime
    property string xdapp: "ping"
    property int popupY: 0

    onMyTrackerChanged: {
        if (myTracker == 0) {
            timer.start()
        }
        else {
            msgList.positionViewAtEnd()
            requestQueue()
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
            PropertyChanges { target: pingModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: pingModal; anchors.topMargin: pingModal.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: pingModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    Text {
        id: pingModalLabel
        text: "DICOM CONSOLE"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Rectangle {
        id: pingBtn
        width: (replyWindow.width - 20) / 5
        height: 30
        anchors.left: replyWindow.left
        anchors.top: pingModalLabel.bottom
        anchors.topMargin: 20
        color: xdapp == "ping"? maincolor : "transparent"
        border.width: 1
        border.color: xdapp == "ping"? "transparent" : maincolor

        Text {
            id: pingBtnLabel
            text: "PING"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 10
            font.family: "Brandon Grotesque"
            color: xdapp == "ping"? "#2A2C31": (darktheme == true? "#F2F2F2" : "#2A2C31")
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                xdapp = "ping"
            }
        }
    }

    Rectangle {
        id: xfuelBtn
        width: (replyWindow.width - 20) / 5
        height: 30
        anchors.left: pingBtn.right
        anchors.leftMargin: 5
        anchors.top: pingModalLabel.bottom
        anchors.topMargin: 20
        color: xdapp == "xfuel"? maincolor : "transparent"
        border.width: 1
        border.color: xdapp == "xfuel"? "transparent" : maincolor

        Text {
            id: xfuelBtnLabel
            text: "XFUEL"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 10
            font.family: "Brandon Grotesque"
            color: xdapp == "xfuel"? "#2A2C31": (darktheme == true? "#F2F2F2" : "#2A2C31")
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                xdapp = "xfuel"
            }
        }
    }

    Rectangle {
        id: xbyBtn
        width: (replyWindow.width - 20) / 5
        height: 30
        anchors.left: xfuelBtn.right
        anchors.leftMargin: 5
        anchors.top: pingModalLabel.bottom
        anchors.topMargin: 20
        color: xdapp == "xtrabytes"? maincolor : "transparent"
        border.width: 1
        border.color: xdapp == "xtrabytes"? "transparent" : maincolor

        Text {
            id: xbyBtnLabel
            text: "XBY"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 10
            font.family: "Brandon Grotesque"
            color: xdapp == "xtrabytes"? "#2A2C31": (darktheme == true? "#F2F2F2" : "#2A2C31")
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                xdapp = "xtrabytes"
            }
        }
    }

    Rectangle {
        id: testBtn
        width: (replyWindow.width - 20) / 5
        height: 30
        anchors.left: xbyBtn.right
        anchors.leftMargin: 5
        anchors.top: pingModalLabel.bottom
        anchors.topMargin: 20
        color: xdapp == "testnet"? maincolor : "transparent"
        border.width: 1
        border.color: xdapp == "testnet"? "transparent" : maincolor

        Text {
            id: testBtnLabel
            text: "TESTNET"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 10
            font.family: "Brandon Grotesque"
            color: xdapp == "testnet"? "#2A2C31": (darktheme == true? "#F2F2F2" : "#2A2C31")
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                xdapp = "testnet"
            }
        }
    }

    Rectangle {
        id: explorerBtn
        width: (replyWindow.width - 20) / 5
        height: 30
        anchors.left: testBtn.right
        anchors.leftMargin: 5
        anchors.top: pingModalLabel.bottom
        anchors.topMargin: 20
        color: xdapp == "explorer"? maincolor : "transparent"
        border.width: 1
        border.color: xdapp == "explorer"? "transparent" : maincolor

        Text {
            id: explorerBtnLabel
            text: "EXPLORER"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 10
            font.family: "Brandon Grotesque"
            color: xdapp == "explorer"? "#2A2C31": (darktheme == true? "#F2F2F2" : "#2A2C31")
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                xdapp = "explorer"
            }
        }
    }

    Controls.TextInput {
        id: queueText
        height: 34
        placeholder: "STATIC QUEUE"
        text: queueName
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.right: queueBtn.left
        anchors.rightMargin: 10
        anchors.top: xbyBtn.bottom
        anchors.topMargin: 15
        color: themecolor
        textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
        font.pixelSize: 14
        mobile: 1
    }

    Rectangle {
        id: queueBtn
        width: 50
        height: 33
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.verticalCenter: queueText.verticalCenter
        color: maincolor


        Text {
            id: queueBtnLabel
            text: "SET"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 10
            font.family: "Brandon Grotesque"
            color: "#F2F2F2"
        }

        MouseArea {
            anchors.fill: parent

            onPressed: {
                queueBtn.opacity = 0.5
            }

            onReleased: {
                queueBtn.opacity = 1
            }

            onClicked: {
                setQueue(queueText.text)
            }
        }
    }

    Rectangle {
        id: replyWindow
        width: parent.width - 58
        anchors.top: queueText.bottom
        anchors.topMargin: 20
        anchors.bottom: requestText.top
        anchors.bottomMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        clip: true

        Component {
            id: msgLine

            Rectangle {
                id: msgRow
                width: parent.width
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
                    text: inout == "in"? (author == "staticNet"? "STATIC-net: " + message : message) : ">>>>" + message
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

                        onPressAndHold: {
                            popupY = mouseY
                            if(copy2clipboard == 0 && pingTracker == 1 && author !== "xChatRobot") {
                                copiedConsoleText = messageText.text
                                copyText2Clipboard(copiedConsoleText)
                                copy2clipboard = 1
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
                        visible: copy2clipboard == 1 && pingTracker == 1 && copiedConsoleText == messageText.text
                    }

                    Item {
                        id: textPopup
                        z: 12
                        y: popupY - popupClipboard.height/2
                        width: popupClipboard.width
                        height: popupClipboardText.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: copy2clipboard == 1 && pingTracker == 1 && copiedConsoleText == messageText.text

                        Rectangle {
                            id: popupClipboard
                            height: popupClipboardText.height + 4
                            width: popupClipboardText.width + 20
                            color: "#42454F"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Label {
                            id: popupClipboardText
                            text: "Text copied!"
                            font.family: "Brandon Grotesque"
                            font.pointSize: 14
                            font.bold: true
                            color: "#F2F2F2"
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
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
            anchors.fill: parent
            id: msgList
            model: xPingTread
            delegate: msgLine
            spacing: 5
            onDraggingChanged: {
                detectInteraction()
            }
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

    Controls.TextInput {
        id: requestText
        height: 34
        placeholder: xdapp != "ping"? "Method" : "PingID"
        text: ""
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.right: parent.right
        anchors.rightMargin: 182
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : (isIphoneX()? 90 : 70)
        color: themecolor
        textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
        font.pixelSize: 14
        mobile: 1
    }

    Controls.TextInput {
        id: pingAmount
        height: 34
        width: 100
        placeholder: xdapp != "ping"? "Payload" : "Amount"
        text: ""
        inputMethodHints: xdapp == "ping"? Qt.ImhDigitsOnly : Qt.ImhNone
        anchors.right: parent.right
        anchors.rightMargin: 72
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : (isIphoneX()? 90 : 70)
        color: themecolor
        textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
        font.pixelSize: 14
        mobile: 1
    }

    Rectangle {
        id: executeButton
        width: 34
        height: 34
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : (isIphoneX()? 90 : 70)
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
                //}
            }
        }
    }

    Image {
        source: 'qrc:/icons/mobile/ping-icon_01_white.svg'
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
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : (isIphoneX()? 90 : 70)
        color: "transparent"
        border.color: maincolor
        border.width: 1
        opacity: 0.50
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

    Component.onDestruction: {
        pingReply = ""
        pingAmount.text = ""
        pingTracker = 0
        copy2clipboard = 0
    }
}
