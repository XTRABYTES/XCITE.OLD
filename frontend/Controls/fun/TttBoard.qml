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

    onStateChanged: {
        if (tttTracker == 1) {
            accepted = isAccepted("ttt", tttCurrentGame)
        }
    }

    property string wonGames: "0"
    property string lostGames: "0"
    property string drawedGames: "0"
    property bool finished: tttFinished
    property string winner: ""
    property bool showResult: false
    property bool accepted: isAccepted("ttt", tttCurrentGame)


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
        z: 11
        id: onlineIndicator
        source: networkAvailable == 1? (xChatConnection == true? "qrc:/icons/mobile/online_blue_icon.svg" : "qrc:/icons/mobile/online_red_icon.svg") : "qrc:/icons/mobile/no_internet_icon.svg"
        anchors.verticalCenter: tttModalLabel.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 28
        width: 20
        fillMode: Image.PreserveAspectFit
    }

    Label {
        z: 11
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
        id: tttHubButton
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
                    var opponent = findOpponent(tttCurrentGame)
                    if (finished == true && opponent === "computer") {
                        tttcreateGameId(myUsername,opponent)
                    }
                    tttHubTracker = 1
                }
            }
        }
    }

    Image {
        id: leaderboardButton
        source: "qrc:/icons/mobile/trophy-icon_01_blue.svg"
        anchors.verticalCenter: tttModalLabel.verticalCenter
        anchors.right: tttHubButton.left
        anchors.rightMargin: 20
        height: 20
        width: 20
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
                    leaderBoardTracker = 1
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
            text: findOpponent(tttCurrentGame)
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            font.pixelSize: 16
            font.family: "Brandon Grotesque"
            font.capitalization: Font.AllUppercase
            color: maincolor
        }
    }

    Label {
        id: gameNr
        text: tttCurrentGame != ""? "#" + findGameNr(tttCurrentGame) : "no game selected"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: opponentBox.bottom
        anchors.topMargin: 5
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        font.italic: true
        color: themecolor
    }

    Rectangle {
        id: board
        width: parent.width - 46
        height: board.width
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: gameNr.bottom
        anchors.topMargin: 10

        Fun.TttGrid {
            id: myTttGrid
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            gamefinished: finished
        }
    }

    Rectangle {
        id: blockBoard
        width: board.width
        height: board.height
        color: "black"
        opacity: 0.5
        anchors.horizontalCenter: board.horizontalCenter
        anchors.verticalCenter: board.verticalCenter
        visible: accepted === false

        MouseArea {
            anchors.fill: parent
        }
    }

    DropShadow {
        anchors.fill: newGameBox
        source: newGameBox
        samples: 9
        radius: 4
        color: darktheme == true? "#000000" : "#727272"
        horizontalOffset:0
        verticalOffset: 0
        spread: 0
        visible: accepted === false
    }

    Rectangle {
        id: newGameBox
        width: newGame.width + 56
        height: 50
        color: darktheme == true? "#2A2C31" : "#F2F2F2"
        anchors.horizontalCenter: blockBoard.horizontalCenter
        anchors.verticalCenter: blockBoard.verticalCenter
        visible: accepted === false

        Item {
            id: newGame
            width: newGameText.width + 30
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                id: newGameText
                text: "SELECT A NEW GAME"
                color: themecolor
                font.pixelSize: 20
                font.family: xciteMobile.name
                anchors.verticalCenter: newGame.verticalCenter
                anchors.horizontalCenter: newGame.horizontalCenter
            }
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
        anchors.horizontalCenter: board.horizontalCenter
        anchors.verticalCenter: board.verticalCenter
        visible: showResult == true

        Item {
            id: notification
            width: notificationText.width + 50
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                id: notificationText
                text: winner === "win"? "YOU WIN!" : (winner === "loose"? "YOU LOSE!" : "IT'S A DRAW!")
                color: themecolor
                font.pixelSize: 20
                font.family: xciteMobile.name
                anchors.verticalCenter: notification.verticalCenter
                anchors.horizontalCenter: notification.horizontalCenter
            }
        }
    }

    Label {
        id: turnLabel
        text: tttCurrentGame != ""? (tttYourTurn === true? "Your turn" : "Opponents turn") : "---"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: board.bottom
        anchors.topMargin: 5
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        font.italic: true
        font.capitalization: Font.SmallCaps
        color: themecolor
        visible: findOpponent(tttCurrentGame) !== "computer"
    }

    Label {
        id: scoreBoardLabel
        text: "SCOREBOARD"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: board.bottom
        anchors.topMargin: 30
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: tttCurrentGame != ""
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
        visible: tttCurrentGame != ""

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
        visible: finished == true && tttquit == false

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
                if (finished == true) {
                    var exists = false
                    for (var i = 0; i < gamesList.count; i ++) {
                        if (gamesList.get(i).game === "ttt") {
                            var opponent = findOpponent(gamesList.get(i).gameID)
                            if (opponent === "computer") {
                                exists = true
                                if (gameList.get(i).finished === true) {
                                    tttcreateGameId(myUsername,opponent)
                                }
                            }
                        }
                    }
                    if (!exists) {
                        tttcreateGameId(myUsername,"computer")
                    }
                    tttHubTracker = 1
                }
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
        visible: finished == false && tttGameStarted == true && tttCurrentGame != ""

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
                    tttCurrentGame = ""
                    accepted = false
                    tttResetScore(0, 0, 0)
                    tttGetScore()
                    finished = true
                    tttquit = true
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
        interval: 3000
        repeat: false
        running: false

        onTriggered: {
            showResult = false
            accepted = false
        }
    }

    Timer {
        id: gameAccepted
        interval: 5000
        repeat: true
        running: tttTracker == 1

        onTriggered: {
            if (tttCurrentGame != "") {
                accepted = isAccepted("ttt", tttCurrentGame)
            }
            else {
                accepted = false
            }
        }
    }

    Connections {
        target: tictactoe

        onGameFinished: {
            if (loadingGame === false) {
                winner = result
                showResult = true
                resultTimer.start()
                finished = true
                tttquit = false
                wonGames = win
                lostGames = loose
                drawedGames = draw
            }
        }

        onScoreBoard: {
            console.log("retrieved score: " + win + ", " + loose + ", " + draw)
            wonGames = win
            lostGames = loose
            drawedGames = draw
        }
    }

    Label {
        id: closetttModal
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
                if (tttTracker == 1) {
                    tttTracker = 0
                }
            }
        }
    }

    Fun.TttHub {
        id: myTttHub
        z:10
        anchors.left: parent.left
        anchors.top: parent.top

        onStateChanged: {
            detectInteraction()
            if (tttHubTracker == 0) {
                if (tttCurrentGame === "") {
                    for (var i = 0; i < gamesList.count; i ++) {
                        if (gamesList.get(i).game === "ttt") {
                            var opponent = findOpponent(gamesList.get(i).gameID)
                            if (opponent === "computer") {
                                tttCurrentGame = gamesList.get(i).gameID
                                tttYourTurn = true
                                playGame("ttt", tttCurrentGame)
                            }
                        }
                    }
                }
                accepted = isAccepted("ttt", tttCurrentGame)
                finished = isFinished("ttt", tttCurrentGame)
            }
            else if (tttHubTracker == 1) {
                newGameSelected = false
                unfinishedNewGame =false
            }
        }

        onNewGameSelectedChanged: {
            if (newGameSelected === true) {
                accepted = isAccepted("ttt", tttCurrentGame)
                finished = isFinished("ttt", tttCurrentGame)
                if (!gameStarted("ttt", tttCurrentGame)){
                    tttGameStarted = false
                    tttquit = false
                }
            }
        }
    }

    Fun.InviteModal {
        id: myInviteModal
        z:10
        anchors.left: parent.left
        anchors.top: parent.top
        gameName: "ttt"
    }

    Fun.LeaderBoard {
        id: myLeaderBoard
        z:10
        anchors.left: parent.left
        anchors.top: parent.top
        gameName: "ttt"
    }

    Component.onCompleted: {
        tttGetScore()
    }
}
