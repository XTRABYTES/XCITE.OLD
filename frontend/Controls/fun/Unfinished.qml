/**
* Filename: Unfinished.qml
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
    anchors.top: parent.top
    color: "transparent"
    clip :true

    property string gameName: ""
    property bool newGame: false

    Component {
        id: gameLine

        Rectangle {
            id: gameRow
            width: parent.width
            height: 35
            color: "transparent"
            clip: true

            Rectangle {
                id: online
                width: 8
                height: 8
                radius: 8
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: opponent.verticalCenter
                color: status === "online" ? "#4BBE2E" : status ==="idle"? "#F7931A" : findOpponent(gameID) === "computer"? "#4BBE2E" : "#E55541"

                property string status: getUserStatus(opponent.text)

                Timer {
                    id: getStatus
                    interval: 5000
                    repeat: true
                    running: tttHubTracker == 1

                    onTriggered: {
                        online.status = getUserStatus(opponent.text)
                    }
                }
            }

            Label {
                id: opponent
                text: findOpponent(gameID)
                font.pixelSize: 16
                font.family: xciteMobile.name
                font.bold: true
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 15
            }

            Label {
                id: gameNr
                text: "#" + findGameNr(gameID)
                font.pixelSize: 12
                font.family: xciteMobile.name
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: opponent.right
                anchors.leftMargin: 15
                anchors.right: parent.right
                anchors.rightMargin: 75
                horizontalAlignment: Text.AlignRight
                elide: Text.ElideRight
            }

            Label {
                id: play
                text: "PLAY"
                font.pixelSize: 16
                font.family: xciteMobile.name
                font.bold: true
                color: maincolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right

                Rectangle {
                    width: parent.width + 10
                    height: parent.height
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            var player = findOpponent(gameID)
                            if (online.status === "online" || online.status === "idle") {
                                console.log("play pushed")
                                playGame(game, gameID);
                                newGame = true
                            }
                            else if (player === "computer" || player === "test1") {
                                console.log("play pushed")
                                playGame(game, gameID);
                                newGame = true
                            }
                            else {
                                playerNotAvailable = 1
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: bottomLine
                width: parent.width
                height: 1
                color: "#C6C6C6"
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    SortFilterProxyModel {
        id: filteredGames
        sourceModel: gamesList
        filters: [
            RegExpFilter {
                roleName: "game"
                pattern: gameName
            },
            ValueFilter {
                roleName: "accepted"
                value: true
            },
            ValueFilter {
                roleName: "finished"
                value: false
            }
        ]
        sorters: [
            RoleSorter {
                roleName: "gameID"
                sortOrder: Qt.AscendingOrder}
        ]
    }

    ListView {
        anchors.fill: parent
        id: games
        model: filteredGames
        delegate: gameLine
        onDraggingChanged: {
            detectInteraction()
        }
    }

    Component.onCompleted: {
        games.positionViewAtBeginning()
    }
}
