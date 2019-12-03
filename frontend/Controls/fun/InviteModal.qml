/**
* Filename: InviteModal.qml
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
import "qrc:/Controls/fun" as Fun

Rectangle {
    id: inviteModal
    width: appWidth
    height: appHeight
    state: inviteTracker == 1? "up" : "down"
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    visible: inviteModal.anchors.topMargin < inviteModal.height

    onStateChanged: {
        detectInteraction()
        if (inviteTracker === 1) {
            invitedPlayer = ""
        }
    }

    property string gameName: ""
    property int inviteSend: 0

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
            PropertyChanges { target: inviteModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: inviteModal; anchors.topMargin: inviteModal.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: inviteModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    Text {
        id: inviteModalLabel
        text: "INVITE A PLAYER"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Label {
        id: gameLabel
        text: getGameName(gameName)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: inviteModalLabel.bottom
        anchors.topMargin: 20
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        font.capitalization: Font.AllUppercase
        color: maincolor
    }

    Label {
        id: onlinePLayers
        text: "Online players"
        font.pixelSize: 16
        font.family: xciteMobile.name
        font.bold: true
        color: themecolor
        anchors.top: gameLabel.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 28
    }

    Label {
        id: drawedGames
        text: "D"
        anchors.horizontalCenter: parent.right
        anchors.horizontalCenterOffset: -43
        anchors.top: gameLabel.bottom
        anchors.topMargin: 10
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        font.capitalization: Font.AllUppercase
        color: themecolor
    }

    Label {
        id: lostGames
        text: "L"
        anchors.horizontalCenter: parent.right
        anchors.horizontalCenterOffset: -83
        anchors.top: gameLabel.bottom
        anchors.topMargin: 10
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        font.capitalization: Font.AllUppercase
        color: themecolor
    }

    Label {
        id: wonGames
        text: "W"
        anchors.horizontalCenter: parent.right
        anchors.horizontalCenterOffset: -123
        anchors.top: gameLabel.bottom
        anchors.topMargin: 10
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        font.capitalization: Font.AllUppercase
        color: themecolor
    }

    Rectangle {
        id: divider
        width: parent.width -56
        height: 1
        color: themecolor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: onlinePLayers.bottom
    }

    Rectangle {
        id: userPicklistArea
        width: parent.width - 56
        height: 200
        color: "transparent"
        anchors.top: divider.bottom
        anchors.left: parent.left
        anchors.leftMargin: 28

        Mobile.XChatUsersList {
            id: myXchatUsers
            anchors.top: parent.top
            anchors.left: parent.left
            gameName: gameName
        }
    }

    Rectangle {
        id: inviteButton
        width: parent.width - 56
        height: 34
        anchors.top: userPicklistArea.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: invitedPlayer !== ""? maincolor : "#727272"
        border.width: 1
        color: "transparent"
        opacity: invitedPlayer !== ""? 1 : 0.5

        MouseArea {
            anchors.fill: parent

            onPressed: {
                if (invitedPlayer !== "" || getUserStatus(invitedPlayer) === "offline" || getUserStatus(invitedPlayer) === "dnd") {
                    parent.border.color = themecolor
                    inviteButton.border.color = invitedPlayer !== ""? themecolor : "#727272"
                    click01.play()
                    detectInteraction()
                }
            }

            onReleased: {
                if (invitedPlayer !== "" || getUserStatus(invitedPlayer) === "online" || getUserStatus(invitedPlayer) === "idle") {
                    parent.border.color = maincolor
                    inviteButton.border.color = invitedPlayer !== ""? maincolor : "#727272"
                }
            }

            onCanceled: {
                if (invitedPlayer !== "" || getUserStatus(invitedPlayer) === "online" || getUserStatus(invitedPlayer) === "idle") {
                    parent.border.color = maincolor
                    inviteButton.border.color = invitedPlayer !== ""? maincolor : "#727272"
                }
            }

            onClicked: {
                if (invitedPlayer !== "" || getUserStatus(invitedPlayer) === "online" || getUserStatus(invitedPlayer) === "idle") {
                    if (xChatConnection) {
                        if (gameName === "ttt") {
                            inviteSend = 1
                            console.log("request new game ID for tic tac toe")
                            tttcreateGameId(myUsername, invitedPlayer);
                            invitedPlayer = ""
                        }
                    }
                    else {
                        networkError = 1
                    }
                }
                if (getUserStatus(invitedPlayer) === "offline" || getUserStatus(invitedPlayer) === "dnd") {
                    playerNotAvailable = 1
                }
            }
        }

        Text {
            id: inviteButtonText
            text: "INVITE <font color='#0ED8D2'>" + invitedPlayer + "</font>"
            font.family: "Brandon Grotesque"
            font.pointSize: 16
            color: invitedPlayer !== ""? themecolor : "#727272"
            font.bold: true
            font.capitalization: Font.AllUppercase
            font.letterSpacing: 2
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Label {
        id: closeInviteModal
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

                }
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onReleased: {
                if (inviteTracker == 1) {
                    inviteTracker = 0
                }
            }
        }
    }

    Rectangle {
        z: 10
        width: parent.width
        height: parent.height
        color: "black"
        opacity: 0.5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        visible: inviteSend == 1
    }

    DropShadow {
        z: 10
        anchors.fill: notificationBox
        source: notificationBox
        samples: 9
        radius: 4
        color: darktheme == true? "#000000" : "#727272"
        horizontalOffset:0
        verticalOffset: 0
        spread: 0
        visible: inviteSend == 1
    }

    Rectangle {
        z: 10
        id: notificationBox
        width: notification.width + 56
        height: 50
        color: darktheme == true? "#2A2C31" : "#F2F2F2"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        visible: inviteSend == 1

        Item {
            id: notification
            width: notificationText.width + 15
            height: notificationText.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                id: notificationText
                text: "Invitation sent"
                color: themecolor
                font.pixelSize: 16
                font.family: xciteMobile.name
                anchors.verticalCenter: notification.verticalCenter
                anchors.horizontalCenter: notification.horizontalCenter
            }
        }
    }

    Timer {
        id: sendTimer
        interval: 2000
        repeat: false
        running: inviteSend == 1

        onTriggered: {
            inviteSend = 0
            invitedPlayer = ""
        }
    }
}
