/**
* Filename: LeaderBoard.qml
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
    id: leaderBoardModal
    width: appWidth
    height: appHeight
    state: leaderBoardTracker == 1? "up" : "down"
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    visible: leaderBoardModal.anchors.topMargin < leaderBoardModal.height

    onStateChanged: {
        detectInteraction()
        if (leaderBoardTracker === 1) {

        }
    }

    property string gameName: ""

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
            PropertyChanges { target: leaderBoardModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: leaderBoardModal; anchors.topMargin: leaderBoardModal.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: leaderBoardModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    Text {
        id: leaderBoardModalLabel
        text: "LEADERBOARD"
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
        anchors.top: leaderBoardModalLabel.bottom
        anchors.topMargin: 20
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        font.capitalization: Font.AllUppercase
        color: maincolor
    }

    Label {
        id: playerName
        text: "PLAYER"
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.top: gameLabel.bottom
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        font.capitalization: Font.AllUppercase
        color: themecolor
    }

    Label {
        id: drawedGames
        text: "D"
        anchors.horizontalCenter: parent.right
        anchors.horizontalCenterOffset: -43
        anchors.top: gameLabel.bottom
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
        anchors.top: wonGames.bottom
    }

    Rectangle {
        id: scoreBoardArea
        width: parent.width - 56
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: divider.bottom
        color: "transparent"
        clip: true

        Fun.LeaderBoardList {
            id: myLeaderBoardList
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
        }
    }

    Item {
        z: 3
        width: parent.width
        height: myOS === "android"? 215 : 235
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(x, y)
            end: Qt.point(x, y + height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.3; color: darktheme == true? "#14161B" : "#FDFDFD" }
                GradientStop { position: 1.0; color: darktheme == true? "#14161B" : "#FDFDFD" }
            }
        }
    }

    Label {
        id: closeLeaderBoardModal
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
                if (leaderBoardTracker == 1) {
                    leaderBoardTracker = 0
                }
            }
        }
    }
}
