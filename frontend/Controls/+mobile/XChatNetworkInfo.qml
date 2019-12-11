/**
* Filename: XChatNetworkInfo.qml
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
import SortFilterProxyModel 0.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.11
import QtQuick.Window 2.2

import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: xchatNetworkModal
    width: appWidth
    height: appHeight
    state: xchatNetworkTracker == 1? "up" : "down"
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
            PropertyChanges { target: xchatNetworkModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: xchatNetworkModal; anchors.topMargin: xchatNetworkModal.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: xchatNetworkModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    Text {
        id: xchatNetworkModalLabel
        text: "X-CHAT NETWORK INFO"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Label {
        id: notConnectedLabel
        text: "Not connected to the X-CHAT network"
        font.family: xciteMobile.name
        font.pointSize: 16
        color: "#E55541"
        font.italic: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: xchatNetworkModalLabel.bottom
        anchors.topMargin: 15
        visible: xChatConnection !== true
    }

    Rectangle {
        id: pingButton
        width: (networkInfoArea.width - 56) / 2
        height: 34
        anchors.top: xchatNetworkModalLabel.bottom
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: maincolor
        border.width: 1
        opacity: pingingXChat == true? 0.5 : 1
        color: "transparent"
        visible: xChatConnection === true

        MouseArea {
            anchors.fill: pingButton

            onPressed: {
                click01.play()
                parent.border.color = themecolor
                detectInteraction()
            }

            onCanceled: {
                parent.border.color = maincolor
            }

            onReleased: {
                parent.border.color = maincolor
            }

            onClicked: {
                if (xChatConnection && !pingingXChat) {
                    pingTimeRemain = -1
                    pingingXChat = true
                    checkingXchat = true
                    resetServerUpdateStatus();
                    pingXChatServers();
                    updateServerStatus();
                }
                if (!xChatConnection) {
                    resetServerUpdateStatus();
                    updateServerStatus();
                }
            }
        }

        Text {
            id: pingButtonText
            text: (!pingingXChat)? "PING NOW" : "PINGING"
            font.family: xciteMobile.name
            font.pointSize: 14
            color: darktheme == true? "#F2F2F2" : maincolor
            opacity: pingingXChat == true? 0.25 : 1
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Item {
        id: timeUntilPing
        height: timeUntilPingText.height
        width: timeUntilPingText.width + 35
        opacity: pingingXChat == true? 0.25 : 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: pingButton.bottom
        anchors.bottomMargin: 10
        visible: xChatConnection === true

        Label {
            id: timeUntilPingText
            text: "time until next ping:"
            font.family: xciteMobile.name
            font.pointSize: 12
            color: darktheme == true? "#F2F2F2" : maincolor
            font.italic: true
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: timeUntilPingTime
            text: pingTimeRemain > 0? pingTimeRemain + " s" : ""
            font.family: xciteMobile.name
            font.pointSize: 12
            color: darktheme == true? "#F2F2F2" : maincolor
            font.italic: true
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: networkInfoArea
        width: parent.width
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: timeUntilPing.bottom
        anchors.topMargin: 10
        anchors.bottom: closeXchatNetworkModal.top
        anchors.bottomMargin: 20
        clip: true

        Mobile.XChatServerList {
            id: myServerList
        }
    }

    Label {
        id: closeXchatNetworkModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : (myOS === "ios"? (isIphoneX()? 70 : 50) : 70)
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
                }
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onReleased: {
                if (xchatNetworkTracker == 1) {
                    xchatNetworkTracker = 0
                    timer.start()
                }
            }
        }
    }
}
