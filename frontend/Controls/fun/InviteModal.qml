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
    width: Screen.width
    state: inviteTracker == 1? "up" : "down"
    height: Screen.height
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    visible: inviteModal.anchors.topMargin < Screen.height

    onStateChanged: {
        detectInteraction()
        if (inviteTracker === 1) {

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
            PropertyChanges { target: inviteModal; anchors.topMargin: Screen.height}
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
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.bold: true
        color: themecolor
        anchors.top: gameLabel.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 28
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
        width: 120
        height: 200
        color: "transparent"
        anchors.top: divider.bottom
        anchors.left: parent.left
        anchors.leftMargin: 28

        Mobile.XChatUsersList {
            id: myXchatUsers
            anchors.top: parent.top
            anchors.left: parent.left
        }
    }

    Label {
        id: selectedLabel
        text: "Selected player:"
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        color: themecolor
        anchors.horizontalCenter: parent.right
        anchors.horizontalCenterOffset: -(((parent.width - 176)/2)+28)
        anchors.bottom: userPicklistArea.verticalCenter
    }

    Label {
        id: selectedPlayer
        text: invitedPlayer
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        font.capitalization: Font.AllUppercase
        color: maincolor
        anchors.horizontalCenter: parent.right
        anchors.horizontalCenterOffset: -(((parent.width - 176)/2)+28)
        anchors.top: selectedLabel.bottom
    }

    Rectangle {
        id: inviteButton
        width: parent.width - 56
        height: 34
        anchors.top: userPicklistArea.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: invitedPlayer !== ""? maincolor : "#727272"
        border.width: 2
        color: "transparent"
        opacity: invitedPlayer !== ""? 1 : 0.5

        MouseArea {
            anchors.fill: parent

            onPressed: {
                if (invitedPlayer !== "") {
                    parent.border.color = themecolor
                    inviteButtonText.color = themecolor
                    click01.play()
                    detectInteraction()
                }
            }

            onReleased: {
                if (invitedPlayer !== "") {
                    parent.border.color = maincolor
                    inviteButtonText.color = maincolor
                }
            }

            onCanceled: {
                if (invitedPlayer !== "") {
                    parent.border.color = maincolor
                    inviteButtonText.color = maincolor
                }
            }

            onClicked: {
                if (invitedPlayer !== "") {
                    if (xChatConnection) {
                        if (gameName === "ttt") {
                            inviteSend = 1
                            console.log("request new game ID for tic tac toe")
                            tttcreateGameId(myUsername, invitedPlayer)
                        }
                    }
                    else {
                        networkError = 1
                    }
                }
            }
        }

        Text {
            id: inviteButtonText
            text: "INVITE " + invitedPlayer
            font.family: "Brandon Grotesque"
            font.pointSize: 16
            color: invitedPlayer !== ""? maincolor : "#727272"
            font.bold: true
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
            height: notificationIcon.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                id: notificationText
                text: "Invitation sent"
                color: "#F2F2F2"
                font.pixelSize: 12
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
