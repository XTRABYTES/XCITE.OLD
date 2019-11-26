/**
* Filename: Invitations.qml
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
    property int place: 0
    property string player: ""
    property int rounds: 0
    property int turn: 0

    Component {
        id: gameLine

        Rectangle {
            id: gameRow
            width: parent.width
            height: findInviter(gameID, place) === myUsername? 35 : 0
            color: "transparent"
            clip: true

            Rectangle {
                id: online
                width: 8
                height: 8
                radius: 8
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: opponent.verticalCenter
                color:  status === "online" ? "#4BBE2E" : status ==="idle"? "#F7931A" : "#E55541"

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
                anchors.right: findInviter(gameID, 2) === myUsername? accept.left : resend.left
                anchors.rightMargin: findInviter(gameID, 2) === myUsername? 35 : 75
                horizontalAlignment: Text.AlignRight
                elide: Text.ElideRight
            }

            Image {
                id: accept
                source: 'qrc:/icons/mobile/accept-icon_01.svg'
                width: 20
                height: 20
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: decline.left
                anchors.rightMargin: 20
                visible: findInviter(gameID, 2) === myUsername

                Rectangle {
                    width: 30
                    height: 30
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            player = findOpponent(gameID)
                            if (online.status === "online" || online.status === "idle") {
                                acceptGameInvite(myUsername, gameName, gameID, "true")
                            }
                            else {
                                playerNotAvailable = 1
                            }
                        }
                    }
                }
            }

            Image {
                id: decline
                source: 'qrc:/icons/mobile/decline-icon_01.svg'
                width: 20
                height: 20
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                visible: findInviter(gameID, 2) === myUsername

                Rectangle {
                    width: 30
                    height: 30
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            player = findOpponent(gameID)
                            if (online.status === "online" || online.status === "idle") {
                                acceptGameInvite(myUsername, gameName, gameID, "false")
                            }
                            else {
                                playerNotAvailable = 1
                            }
                        }
                    }
                }
            }

            Image {
                id: resend
                source: darktheme == true? 'qrc:/icons/mobile/conversion-icon_01_light.svg' : 'qrc:/icons/mobile/conversion-icon_01_dark.svg'
                width: 20
                height: 20
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                visible: findInviter(gameID, 1) === myUsername

                Rectangle {
                    width: 30
                    height: 30
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            player = findOpponent(gameID)
                            if (online.status === "online" || online.status === "idle") {
                                turn = 0
                                rounds = 60
                                resendTimer.start()
                                sendGameInvite(myUsername, player, gameName, gameID)
                            }
                            else {
                                playerNotAvailable = 1
                            }
                        }
                    }
                }
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
                value: false
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
