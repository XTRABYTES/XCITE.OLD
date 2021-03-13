/**
* Filename: TttHub.qml
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
    id: tttHubModal
    width: appWidth
    height: appHeight
    state: tttHubTracker == 1? "up" : "down"
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    visible: tttHubModal.anchors.topMargin < tttHubModal.height

    property bool newGameSelected: false
    property bool myInvites: false
    property alias unfinishedNewGame: myUnfinished.newGame

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
            PropertyChanges { target: tttHubModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: tttHubModal; anchors.topMargin: height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: tttHubModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    Text {
        id: tttHubModalLabel
        text: "TIC TAC TOE HUB"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Label {
        id: taggingLabel
        text: "Accepted games"
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.bold: true
        font.capitalization: Font.SmallCaps
        color: themecolor
        anchors.top: tttHubModalLabel.bottom
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 28
    }

    Rectangle {
        id: unfinishedGamesArea
        width: parent.width - 56
        height: 150
        anchors.top: taggingLabel.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        clip: true

        Fun.Unfinished {
            id: myUnfinished
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            gameName: "ttt"

            onNewGameChanged: {
                if(newGame === true) {
                    newGameSelected = true
                }
            }
        }
    }

    Label {
        id: invitations
        text: "Invitations"
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.bold: true
        font.capitalization: Font.SmallCaps
        color: themecolor
        anchors.top: unfinishedGamesArea.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 28
    }

    Label {
        id: invitationLabel
        text: "Received"
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.bold: myInvites === false? true: false
        color: myInvites === false? maincolor : "#C6C6C6"
        anchors.top: invitations.bottom
        anchors.left: parent.left
        anchors.leftMargin: 28

        Rectangle {
            width: parent.width
            height: parent.height + 10
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if(myInvites === true) {
                        myInvites = false
                    }
                }
            }
        }
    }

    Label {
        id: myInvitationLabel
        text: "Send"
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.bold: myInvites === true? true: false
        color: myInvites === true? maincolor : "#C6C6C6"
        anchors.top: invitations.bottom
        anchors.right: parent.right
        anchors.rightMargin: 28

        Rectangle {
            width: parent.width
            height: parent.height + 10
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if(myInvites === false) {
                        myInvites = true
                    }
                }
            }
        }
    }


    Rectangle {
        id: invitationsArea
        width: parent.width - 56
        height: 150
        anchors.top: invitationLabel.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        clip: true

        Fun.Invitations {
            id: myInvitations
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            gameName: "ttt"
            place: myInvites ===false? 2 : 1
        }
    }

    Rectangle {
        id: inviteButton
        width: parent.width - 56
        height: 34
        anchors.top: invitationsArea.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: maincolor
        border.width: 1
        color: "transparent"

        MouseArea {
            anchors.fill: parent

            onPressed: {
                parent.border.color = themecolor
                inviteButtonText.color = themecolor
                click01.play()
                detectInteraction()
            }

            onReleased: {
                parent.border.color = maincolor
                inviteButtonText.color = maincolor
            }

            onCanceled: {
                parent.border.color = maincolor
                inviteButtonText.color = maincolor
            }

            onClicked: {
                inviteTracker = 1
                inviteGame = "ttt"
            }
        }

        Text {
            id: inviteButtonText
            text: "INVITE PLAYER"
            font.family: "Brandon Grotesque"
            font.pointSize: 16
            color: maincolor
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Label {
        id: closetttHubModal
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

                }
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onReleased: {
                if (tttHubTracker == 1) {
                    tttHubTracker = 0
                }
            }
        }
    }
}
