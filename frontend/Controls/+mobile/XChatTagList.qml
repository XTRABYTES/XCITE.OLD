/**
* Filename: XChatTagList.qml
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
    height: filteredUsers.count < 5? filteredUsers.count * 30 : 150
    color: "transparent"
    clip: true

    property string userTag: ""

    Component {
        id: userNames

        Rectangle {
            id: userRow
            width: parent.width
            height: (username != "" && status != "dnd")? 30 : 0
            color: "transparent"
            clip: true

            Rectangle {
                id: divider
                width: parent.width - 20
                height: 1
                color: "#F2F2F2"
                opacity: 0.15
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                id: userName
                text: username
                color: "#F2F2F2"
                font.pixelSize: 14
                font.family: xciteMobile.name
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 15
            }

            Rectangle {
                id: onlineIndicator
                height: 8
                width: 8
                radius: 8
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: userName.verticalCenter
                color: status == "online"? "#4BBE2E" : (status == "idle"? "#F7931A" : "#E55541")
                visible: getUserStatus(username) !== "dnd"
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        userTag = ""
                        userTag = username
                    }
                }
            }
        }
    }

    SortFilterProxyModel {
        id: filteredUsers
        sourceModel: xChatUsers

        filters: [
            RegExpFilter {
                roleName: "username"
                pattern: tagFilter && !myUsername
                caseSensitivity: Qt.CaseInsensitive
            },
            RegExpFilter {
                roleName: "status"
                pattern: "online" || "idle" || "offline"
                caseSensitivity: Qt.CaseInsensitive
            }
        ]

        sorters: [
            StringSorter {roleName: "username" ; sortOrder: Qt.AscendingOrder}
        ]
    }

    ListView {
        anchors.fill: parent
        id: userList
        model: filteredUsers
        delegate: userNames
        onDraggingChanged: detectInteraction()
        property var userCount: filteredUsers.count

        onUserCountChanged:  {
            xChatFilterResults = userCount
        }
    }
}
