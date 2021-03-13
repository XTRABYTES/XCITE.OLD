/**
* Filename: TttGrid.qml
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

import "qrc:/Controls" as Controls

Rectangle {
    width: parent.width
    height: parent.height
    color: "transparent"
    clip :true

    property bool newMove: false
    property bool gamefinished: false
    property int rounds: 60

    Component {
        id: buttonSquare

        Item {
            width: grid.cellWidth
            height: grid.cellHeight

            Image {
                id: playedImage
                source: played == false? '': (player == myUsername? 'qrc:/icons/XFUEL_logo_big.svg' : player != ""? 'qrc:/icons/XBY_logo_big.svg' : '')
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 10
                height: parent.height * 0.75
                width: parent.width * 0.75
                opacity: online == false? 1 : (confirmed == true? 1 : 0.5)
                fillMode: Image.PreserveAspectFit
                visible: played
            }

            Image {
                id: resend
                source: 'qrc:/icons/mobile/conversion-icon_01_light.svg'
                width: 40
                height: 40
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                visible: played && !confirmed && !gamefinished
            }

            Timer {
                id: resendTimer
                interval: 40
                repeat: rounds > 0
                running: false

                onTriggered: {
                    rounds = rounds -1
                    turn = turn + 6
                    resend.rotation = turn
                }
            }

            Rectangle {
                width: parent.width - 5
                height: parent.height - 5
                color: "transparent"
                border.width: 2
                border.color: maincolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent
                    enabled: gamefinished == true? false : (online == false? (played == false? true : false) : (played == false? (tttYourTurn == false?  false : true) : (confirmed == false? true : false)))

                    onClicked: {
                        if (tttYourTurn === true) {
                            tttYourTurn = false
                        }
                        console.log("clicked button nr: " + number)
                        tttGameStarted = true
                        newMove = true
                        if (online == false) {
                            console.log("requesting new moveID")
                            tttGetMoveID(number)
                        }
                        else {
                            if (tttCurrentGame !== "" && gameError === 0) {
                                var opponent = findOpponent(tttCurrentGame)
                                var status = getUserStatus(opponent)
                                if (status === "online" || status === "idle") {
                                    resend.rotation = 0
                                    if (played && !confirmed) {
                                        turn = 0
                                        rounds = 60
                                        resendTimer.start()
                                    }
                                    var lastMove = findLastMove("ttt", tttCurrentGame);
                                    var lastMoveID = findLastMoveID("ttt", tttCurrentGame)
                                    if(lastMove !== "") {
                                        console.log("confirm previous move")
                                        confirmGameSend(myUsername, "ttt", tttCurrentGame, lastMove, lastMoveID);
                                    }
                                    console.log("send new move to the network")
                                    sendGameToQueue(myUsername, "ttt", tttCurrentGame, number);
                                }
                                else {
                                    playerNotAvailable = 1
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    GridView {
        id: grid
        anchors.fill: parent
        cellWidth: parent.width/3; cellHeight: parent.width/3
        boundsBehavior: Flickable.StopAtBounds

        model: tttButtonList
        delegate: buttonSquare
    }
}
