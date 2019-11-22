/**
 * Filename: TttBoard.qml
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
    id: tttModal
    width: Screen.width
    state: tttTracker == 1? "up" : "down"
    height: Screen.height
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    clip: true

    property string wonGames: "0"
    property string lostGames: "0"
    property string drawedGames: "0"
    property bool finished: tttFinished
    property string winner: ""
    property bool showResult: false

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
            PropertyChanges { target: tttModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: tttModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: tttModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    Label {
        id: tttModalLabel
        text: "TIC TAC TOE"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Image {
        id: onlineIndicator
        source: networkAvailable == 1? (xChatConnection == true? "qrc:/icons/mobile/online_blue_icon.svg" : "qrc:/icons/mobile/online_red_icon.svg") : "qrc:/icons/mobile/no_internet_icon.svg"
        anchors.verticalCenter: tttModalLabel.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 28
        width: 20
        fillMode: Image.PreserveAspectFit
    }

    Label {
        id: connectingLabel
        text: "connecting"
        anchors.horizontalCenter: onlineIndicator.horizontalCenter
        anchors.top: onlineIndicator.bottom
        anchors.topMargin: 5
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.pixelSize: 8
        font.family: "Brandon Grotesque"
        visible: xChatConnecting == true
    }

    Image {
        id: xChatUsersButton
        source: "qrc:/icons/mobile/users-icon_01.svg"
        anchors.verticalCenter: tttModalLabel.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 28
        height: 20
        fillMode: Image.PreserveAspectFit

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 30
            height: 30
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    tttPlayerTracker = 1
                }
            }
        }
    }

    Item {
        id:opponentBox
        width: opponentLabel.width + opponentName.width + 10
        height: opponentLabel.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: tttModalLabel.bottom
        anchors.topMargin: 20

        Label {
            id: opponentLabel
            text: "PLAYING AGAINGST :"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            font.pixelSize: 16
            font.family: "Brandon Grotesque"
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
        }

        Label {
            id: opponentName
            text: tttCurrentGame == "computer"? "computer" : findOpponent(tttCurrentGame)
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            font.pixelSize: 16
            font.family: "Brandon Grotesque"
            font.capitalization: Font.AllUppercase
            color: maincolor
        }
    }


    Rectangle {
        id: board
        width: parent.width - 46
        height: board.width
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: opponentBox.bottom
        anchors.topMargin: 10

        Fun.TttGrid {
            id: myTttGrid
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    DropShadow {
        anchors.fill: notificationBox
        source: notificationBox
        samples: 9
        radius: 4
        color: darktheme == true? "#000000" : "#727272"
        horizontalOffset:0
        verticalOffset: 0
        spread: 0
        visible: showResult == true
    }

    Rectangle {
        id: notificationBox
        width: notification.width + 56
        height: 50
        color: darktheme == true? "#2A2C31" : "#F2F2F2"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        visible: showResult == true

        Item {
            id: notification
            width: notificationText.width + 50
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                id: notificationText
                text: winner === "win"? "YOU WIN!" : (winner === "loose"? "YOU LOOSE!" : "IT'S A DRAW!")
                color: "#F2F2F2"
                font.pixelSize: 20
                font.family: xciteMobile.name
                anchors.verticalCenter: notification.verticalCenter
                anchors.horizontalCenter: notification.horizontalCenter
            }
        }
    }

    Label {
        id: scoreBoardLabel
        text: "SCOREBOARD"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: board.bottom
        anchors.topMargin: 20
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: tttCurrentGame == "computer"
    }

    Rectangle {
        id: scoreBoard
        width: parent.width - 56
        height: 34
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: scoreBoardLabel.bottom
        anchors.topMargin: 10
        border.width: 1
        border.color: maincolor
        visible: tttCurrentGame == "computer"

        Item {
            id: wonBox
            height: parent.height
            width: parent.width / 3
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left

            Label {
                id: wonLabel
                text: "WIN"
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }

            Label {
                id: wonScore
                text: wonGames
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                color: maincolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: wonLabel.right
                anchors.leftMargin: 10
            }
        }

        Item {
            id: lostBox
            height: parent.height
            width: parent.width / 3
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                id: lostLabel
                text: "LOSE"
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }

            Label {
                id: lostScore
                text: lostGames
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                color: maincolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: lostLabel.right
                anchors.leftMargin: 10
            }
        }

        Item {
            id: drawBox
            height: parent.height
            width: parent.width / 3
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right

            Label {
                id: drawLabel
                text: "DRAW"
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }

            Label {
                id: drawScore
                text: drawedGames
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                color: maincolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: drawLabel.right
                anchors.leftMargin: 10
            }
        }
    }

    Rectangle {
        id: newGameButton
        width: (parent.width - 66) / 2
        height: 34
        anchors.top: scoreBoard.bottom
        anchors.topMargin: 25
        anchors.left: scoreBoard.left
        border.color: maincolor
        border.width: 2
        color: "transparent"
        visible: finished == true

        MouseArea {
            anchors.fill: parent

            onPressed: {
                parent.border.color = themecolor
                newGameButtonText.color = themecolor
                click01.play()
                detectInteraction()
            }

            onReleased: {
                parent.border.color = maincolor
                newGameButtonText.color = maincolor
            }

            onCanceled: {
                parent.border.color = maincolor
                newGameButtonText.color = maincolor
            }

            onClicked: {
                tttNewGame()
                tttGameStarted = false
                finished = false
                showResult = false
            }
        }

        Text {
            id: newGameButtonText
            text: "NEW GAME"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            color: maincolor
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: quitGameButton
        width: (parent.width - 66) / 2
        height: 34
        anchors.top: scoreBoard.bottom
        anchors.topMargin: 25
        anchors.right: scoreBoard.right
        border.color: maincolor
        border.width: 2
        color: "transparent"
        visible: finished == false && tttGameStarted == true

        MouseArea {
            anchors.fill: parent

            onPressed: {
                parent.border.color = themecolor
                quitGameButtonText.color = themecolor
                click01.play()
                detectInteraction()
            }

            onReleased: {
                parent.border.color = maincolor
                quitGameButtonText.color = maincolor
            }

            onCanceled: {
                parent.border.color = maincolor
                quitGameButtonText.color = maincolor
            }

            onClicked: {
                if (tttGameStarted){
                    tttQuitGame()
                    tttGameStarted = false
                }
                else {
                    tttTracker = 0
                }
            }
        }

        Text {
            id: quitGameButtonText
            text: "STOP PLAYING"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            color: maincolor
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Timer {
        id: resultTimer
        interval: 5000
        repeat: false
        running: false

        onTriggered: {
            showResult = false
        }
    }

    Connections {
        target: tictactoe

        onGameFinished: {
            for (var i = 0; i < tttButtonList.count; i ++) {
                winner = result
                showResult = true
                resultTimer.start()
                finished = true
                wonGames = win
                lostGames = loose
                drawedGames = draw
                if(result === "win") {
                    updateScore(tttCurrentGame, findOpponent(tttCurrentGame), 1, 0, 0)
                }
                else if (result === "loose") {
                    updateScore(tttCurrentGame, findOpponent(tttCurrentGame), 0, 1, 0)
                }
                else if (result === "draw") {
                    updateScore(tttCurrentGame, findOpponent(tttCurrentGame), 0, 0, 1)
                }
            }
        }

        onPlayersChoice: {
            console.log("player's choice: " + btn1)
            for (var i = 0; i < tttButtonList.count; i ++) {
                if (tttButtonList.get(i).number === btn1) {
                    tttButtonList.setProperty(i, "player", myUsername)
                    tttButtonList.setProperty(i, "played", true)
                }
            }
        }

        onOpponentsChoice: {
            console.log("player's choice: " + btn1)
            var opponent = findOpponent(tttCurrentGame)
            for (var i = 0; i < tttButtonList.count; i ++) {
                if (tttButtonList.get(i).number === btn1) {
                    tttButtonList.setProperty(i, "player", opponent)
                    tttButtonList.setProperty(i, "played", true)
                }
            }
        }

        onComputersChoice: {
            console.log("computer's choice: " + btn2)
            for (var i = 0; i < tttButtonList.count; i ++) {
                if (tttButtonList.get(i).number === btn2) {
                    tttButtonList.setProperty(i, "player", "pc")
                    tttButtonList.setProperty(i, "played", true)
                    if (tttCurrentGame === "computer") {
                        checkIfMoveExists("ttt", "computer", "computer", btn2, moveID)
                        confirmMove("computer", "ttt", "computer", btn2, moveID)
                    }
                }
            }
        }

        onBlockButton: {
        }

        onClearBoard: {
            for (var i = 0; i < tttButtonList.count; i ++) {
                tttButtonList.setProperty(i, "played", false)
                tttButtonList.setProperty(i, "player", "")
                tttButtonList.setProperty(i, "confirmed", false)
            }
            if (tttCurrentGame === "computer") {
                for (var i = 0; i < movesList.count; i ++) {
                    if (movesList.get(i).game === "ttt" && movesList.get(i).gameID === "computer") {
                        movesList.remove(i)
                    }
                }
            }
        }

        onScoreBoard: {
            wonGames = win
            lostGames = loose
            drawedGames = draw
        }

        onNewGameID: {
            var gameIDArray = gameID.split(':')
            var opponent = gameIDArray[1]
            gamesList.append({"game": "ttt", "gameID": gameID, "invited": false, "accepted": false, "finished": false})
            sendGameInvite(myUsername, opponent, "ttt", gameID)
            inviteSent("ttt", gameID)
        }

        onNewMoveID: {
            console.log("new moveID received: " + moveID)
            checkIfMoveExists("ttt", "computer", myUsername, move, moveID)
            tttButtonClicked(move)
            confirmMove(myUsername, "ttt", "computer", btn1, moveID)
        }

        onYourTurn: {
            tttYourTurn = turn
        }
    }

    Component.onCompleted: {
        tttGetScore()
    }
}
