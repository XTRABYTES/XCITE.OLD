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
    width: 100
    height: parent.height
    color: "transparent"
    clip: true

    property string tagging: ""

    Component {
        id: userNames

        Rectangle {
            id: userRow
            width: 120
            height:{
                if (inviteTracker == 1) {
                    if (username === myUsername && (username == "" || status == "dnd" || status == "offline")) {
                        0
                    }
                    else {
                        35
                    }
                }
                else {
                    if (username != "") {
                        35
                    }
                    else {
                        0
                    }
                }
            }
            color: "transparent"
            clip: true

            Label {
                id: userName
                text: username
                color: "#F2F2F2"
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


