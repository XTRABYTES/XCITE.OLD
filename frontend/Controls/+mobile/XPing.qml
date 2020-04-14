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

    onMyTrackerChanged: {
        if (myTracker == 0) {
            timer.start()
        }
        else {
            msgList.positionViewAtEnd()
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
        text: "PING CONSOLE"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Rectangle {
        id: replyWindow
        width: parent.width - 58
        anchors.top: pingModalLabel.bottom
        anchors.topMargin: 30
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
        placeholder: "PING ID"
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
        placeholder: "Amount"
        text: ""
        inputMethodHints: Qt.ImhDigitsOnly
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
                    var pingIdentifier
                    if (pingAmount.text != "") {
                        totalPings = Number.fromLocaleString(Qt.locale("en_US"),pingAmount.text)
                        if (totalPings <= 50) {
                            xPingTread.append({"message": "ping ID: " + myUsername + "_" + requestText.text + ", amount: " + pingAmount.text, "inout": "out", "author": myUsername, "time": sendTime})
                            msgList.positionViewAtEnd()
                            for (var a = 0; a < totalPings; a ++) {
                                var b = pingSNR + a
                                pingIdentifier = myUsername + "_" + requestText.text + "_" + b
                                pingRequest(pingIdentifier)
                            }
                            pingSNR = pingSNR + totalPings
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
                        xPingTread.append({"message": "ping ID: " + myUsername + "_" + requestText.text + ", amount: " + pingAmount.text, "inout": "out", "author": myUsername, "time": sendTime})
                        msgList.positionViewAtEnd()
                        var c = pingSNR + totalPings
                        pingIdentifier = myUsername + "_" + requestText.text + "_" + c
                        pingRequest(pingIdentifier)
                        pingSNR = pingSNR + totalPings
                        requestText.text = ""
                        pingAmount.text = ""
                    }
                }
                else {
                    xPingTread.append({"message": "No ping identifier selected!!", "inout": "in", "author": "xChatRobot", "time": sendTime})
                    msgList.positionViewAtEnd()
                }
            }
        }

        Connections {
            target: xChat

            onXchatResponseSignal: {
                if (pingTracker == 1) {
                    replyTime = new Date().toLocaleString(Qt.locale(),"hh:mm:ss .zzz")
                    console.log("replyTime: " + replyTime)
                    pingReply = text
                    replyArray = pingReply.split(' ')
                    if (replyArray[0] === "SPING") {
                        xPingTread.append({"message": pingReply, "inout": "in", "author": "staticNet", "time": replyTime})
                        msgList.positionViewAtEnd()
                    }
                }
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
            replyText.text = ""
            requestText.text = ""
            closeAllClipboard = true
        }
    }

    Component.onDestruction: {
        replyText.text = ""
        pingAmount.text = ""
        pingTracker = 0
    }
}
