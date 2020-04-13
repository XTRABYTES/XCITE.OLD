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

    onMyTrackerChanged: {
        if (myTracker == 0) {
            timer.start()
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
        width: parent.width - 56
        anchors.top: pingModalLabel.bottom
        anchors.topMargin: 30
        anchors.bottom: requestText.top
        anchors.bottomMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        border.color: themecolor
        border.width: 1

        Flickable {
            id: scrollArea
            height: parent.height
            width: parent.width
            contentHeight: replyText.height
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            boundsBehavior: Flickable.DragOverBounds
            clip: true

            ScrollBar.vertical: ScrollBar {
                parent: scrollArea.parent
                anchors.top: scrollArea.top
                anchors.left: scrollArea.right
                anchors.bottom: scrollArea.bottom
                policy: ScrollBar.AsNeeded
                width: 5
            }

            Text {
                id: replyText
                y: scrollArea.y + scrollArea.height - replyText.implicitHeight
                width: parent.width
                text: ""
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                padding: 7
                wrapMode: Text.Wrap
                //anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: darktheme == true? maincolor : "#14161B"
                font.pixelSize: 14
                font.family: xciteMobile.name

                onTextChanged: {
                    y = scrollArea.y + scrollArea.height - replyText.implicitHeight
                }
            }
        }
    }

    Controls.TextInput {
        id: requestText
        height: 34
        placeholder: "PING IDENTIFIER"
        text: ""
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.right: parent.right
        anchors.rightMargin: 147
        anchors.bottom: closePingModal.top
        anchors.bottomMargin: 25
        color: themecolor
        textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
        font.pixelSize: 14
        mobile: 1
    }

    Controls.TextInput {
        id: pingAmount
        height: 34
        width: 75
        placeholder: "AMOUNT"
        text: ""
        inputMethodHints: Qt.ImhDigitsOnly
        anchors.right: parent.right
        anchors.rightMargin: 62
        anchors.bottom: closePingModal.top
        anchors.bottomMargin: 25
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
        anchors.bottom: closePingModal.top
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
                totalPings = Number.fromLocaleString(Qt.locale("en_US"),pingAmount.text)
                if (totalPings < 50) {
                    replyText.text = replyText.text + "<br>" + "ping ID: " + requestText.text + ", amount: " + pingAmount.text
                    for (var a = 0; i < totalPings; i ++) {
                        var b = pingSNR + a
                        var pingIdentifier = requestText.text + "_" + b
                        requestPing(pingIdentifier)
                    }
                    pingSNR = pingSNR + totalPings
                    requestText.text = ""
                    pingAmount.text = ""
                }
                else {
                    replyText.text = replyText.text + "<br>" + "Amount too high, max. 50"
                    pingAmount.text = ""
                }
            }
        }

        Connections {
            target: static_int
            // code to detect incoming replies for the pings
            // execute: replyText.text = replyText.text + "<br>" + pingReply
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
        anchors.top: executeButton.top
        color: "transparent"
        border.color: maincolor
        border.width: 1
        opacity: 0.50
    }

    Label {
        id: closePingModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : (isIphoneX()? 90 : 70)
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
                    replyText.text = ""
                    requestText.text = ""
                    closeAllClipboard = true
                }
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onReleased: {
                if (pingTracker == 1) {
                    pingTracker = 0;
                }
            }
        }
    }

    Component.onDestruction: {
        replyText.text = ""
        replyText.text = ""
        pingTracker = 0
    }
}
