/**
 * Filename: XGames.qml
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
import "qrc:/Controls/fun" as Fun

Rectangle {
    id: xgamesModal
    width: appWidth
    height: appHeight
    state: xgamesTracker == 1? "up" : "down"
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    clip: true

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
            PropertyChanges { target: xgamesModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: xgamesModal; anchors.topMargin: xgamesModal.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: xgamesModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    Text {
        id: xgamesModalLabel
        text: "X-GAMES"
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
    Rectangle {
        id: tttButton
        width: parent.width - 66
        height: 60
        anchors.top: xgamesModalLabel.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: maincolor
        border.width: 2
        color: "transparent"

        MouseArea {
            anchors.fill: parent

            onPressed: {
                parent.border.color = themecolor
                tttButtonText.color = themecolor
                click01.play()
                detectInteraction()
            }

            onReleased: {
                parent.border.color = maincolor
                tttButtonText.color = maincolor
            }

            onCanceled: {
                parent.border.color = maincolor
                tttButtonText.color = maincolor
            }

            onClicked: {
                var opponent = ""
                tttSetUsername(myUsername)
                if (tttCurrentGame !== "") {
                    opponent = findOpponent(tttCurrentGame)
                    loadScore("ttt", opponent)
                    tttTracker = 1
                }
                else {
                    for (var i = 0; i < gamesList.count; i ++) {
                        if (gamesList.get(i).game === "ttt" && gamesList.get(i).gameID !== "" && gamesList.get(i).finished === false) {
                            opponent = findOpponent(gamesList.get(i).gameID)
                            if (opponent === "computer") {
                                console.log("found ongoing tic tac toe game against computer")
                                tttCurrentGame = gamesList.get(i).gameID
                            }
                            else {
                                console.log("no ongoing game against computer found")
                            }
                        }
                    }
                    if (tttCurrentGame !== "") {
                        console.log("loading existing tic tac toe game against computer")
                        playGame("ttt", tttCurrentGame)
                    }
                    else {
                        console.log("creating new tic tac toe game against computer")
                        tttcreateGameId(myUsername,"computer")
                    }
                }
                if (opponent === "computer") {
                    for (var e = 0; e < tttButtonList.count; e ++) {
                        tttButtonList.setProperty(e, "online", false)
                    }
                }
            }
        }

        Image {
            id: tttIcon
            source: darktheme === true? 'qrc:/icons/mobile/ttt-icon_ph_white.svg' : 'qrc:/icons/mobile/ttt-icon_ph_black.svg'
            width: 40
            height: 40
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 30
        }

        Text {
            id: tttButtonText
            text: "TIC TAC TOE"
            font.family: "Brandon Grotesque"
            font.pointSize: 16
            color: maincolor
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: tttIcon.right
            anchors.leftMargin: 30
        }
    }

    */
    Fun.TttBoard {
        z: 100
        id: myTtt
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
    }

    Fun.PlayerNotAvailable {
        z: 100
        id: noPlayer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
    }
}
