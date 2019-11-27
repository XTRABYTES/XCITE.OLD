/**
* Filename: XChatUserslist.qml
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


Rectangle {
    width: inviteTracker == 0? 120 : parent.width
    height: parent.height
    color: "transparent"
    clip: true

    property string tagging: ""
    property string gameName: ""
    property string win: ""
    property string lost: ""
    property string drawed: ""

    Component {
        id: userNames

        Rectangle {
            id: userRow
            width: inviteTracker == 0? 120 : parent.width
            height: inviteTracker == 1?((username === myUsername || username == "" || status == "dnd" || status == "offline")? 0 : 35):(username != ""? 35 : 0)
            color: "transparent"
            clip: true

            Timer {
                id: leaderboardTimer
                interval: 10000
                repeat: true
                running: inviteTracker == 1

                onTriggered: {
                    win = getScore(username, gameName, "lost")
                    lost = getScore(username, gameName, "win")
                    drawed = getScore(username, gameName, "draw")
                }
            }

            Label {
                id: userName
                text: username
                color: inviteTracker ==0? "#F2F2F2": themecolor
                font.pixelSize: 14
                font.family: xciteMobile.name
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.right: status == "dnd"? dndArea.left : parent.right
                anchors.rightMargin: status == "dnd"? 5 : 10
                elide: Text.ElideRight
            }

            Rectangle {
                id: dndArea
                height: 10
                width: 10
                color: "transparent"
                anchors.right: parent.right
                anchors.rightMargin: 15
                anchors.verticalCenter: userName.verticalCenter
                visible: status === "dnd"
            }

            Image {
                id: dndIcon
                source: 'qrc:/icons/mobile/dnd-icon_01.svg'
                height: 10
                width: 10
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: userName.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 15
                visible: dndArea.visible == true
            }

            Rectangle {
                id: onlineIndicator
                height: 8
                width: 8
                radius: 8
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: userName.verticalCenter
                color: status == "online"? "#4BBE2E" : (status == "idle"? "#F7931A" : "#E55541")
                visible: status !== "dnd"
            }

            Label {
                id: drawedGames
                text: inviteTracker == 1 ? drawed : ""
                font.pixelSize: 12
                font.family: xciteMobile.name
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.right
                anchors.horizontalCenterOffset: -15
                visible: inviteTracker == 1
            }

            Label {
                id: lostGames
                text: inviteTracker == 1 ? lost : ""
                font.pixelSize: 12
                font.family: xciteMobile.name
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.right
                anchors.horizontalCenterOffset: -55
                visible: inviteTracker == 1
            }

            Label {
                id: wonGames
                text: inviteTracker == 1 ? win : ""
                font.pixelSize: 12
                font.family: xciteMobile.name
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.right
                anchors.horizontalCenterOffset: -95
                visible: inviteTracker == 1
            }

            Rectangle {
                id: divider
                width: parent.width
                height: 1
                color: "#C6C6C6"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                visible: inviteTracker == 1
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        if (xchatTracker == 1) {
                            if(status !== "dnd" && username !== myUsername) {
                                tagging = ""
                                tagging = "@" + username + " "
                            }
                            else if (status === "dnd") {
                                dndNotification(username)
                            }
                        }
                        if (inviteTracker == 1) {
                            if(status !== "dnd" && username !== myUsername) {
                                if (status === "online" || status === "idle") {
                                    invitedPlayer = username
                                }
                                else {
                                    playerNotAvailable = 1
                                }
                            }
                            else if (status === "dnd") {
                                playerNotAvailable = 1
                            }
                        }
                    }
                }
            }
        }
    }

    SortFilterProxyModel {
        id: filteredUsers
        sourceModel: xChatUsers

        sorters: [
            StringSorter {
                roleName: "noCapitals";
                sortOrder: Qt.AscendingOrder;
            }
        ]
    }

    ListView {
        anchors.fill: parent
        id: userList
        model: filteredUsers
        delegate: userNames
        onDraggingChanged: detectInteraction()
    }
}


