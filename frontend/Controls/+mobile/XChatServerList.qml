/**
* Filename: XChatServerList.qml
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

Rectangle {
    width: parent.width
    height: parent.height
    color: "transparent"
    clip: true

    Component {
        id: xChatServerInfo

        Rectangle {
            id: serverRow
            width: parent.width
            height: 35
            color: "transparent"
            clip: true

            Label {
                id: serverName
                text: name
                color: darktheme == true? "#F2F2F2" : "14161B"
                font.pixelSize: 14
                font.family: xciteMobile.name
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.right: name == selectedXChatServer? connectIndicator.left : (serverStatus == "down"? nodeDownLabel.left : pingTime.left)
                anchors.rightMargin: 10
                elide: Text.ElideRight
            }

            DropShadow {
                anchors.fill: connectIndicator
                source: connectIndicator
                samples: 9
                radius: 4
                color: darktheme == true? "#000000" : "#727272"
                horizontalOffset:0
                verticalOffset: 0
                spread: 0
                visible: name == selectedXChatServer && xChatConnection == true
            }

            Image {
                id: connectIndicator
                source: darktheme == true? 'qrc:/icons/mobile/connected-icon_01_white.svg' : 'qrc:/icons/mobile/connected-icon_01_black.svg'
                height: 20
                fillMode: Image.PreserveAspectFit
                anchors.right: serverStatus == "down"? nodeDownLabel.left : pingTime.left
                anchors.rightMargin: 15
                anchors.verticalCenter: serverName.verticalCenter
                visible: name == selectedXChatServer && xChatConnection == true
            }

            DropShadow {
                anchors.fill: onlineIndicator
                source: onlineIndicator
                samples: 9
                radius: 4
                color: darktheme == true? "#000000" : "#727272"
                horizontalOffset:0
                verticalOffset: 0
                spread: 0
                visible: serverStatus != "down"
            }

            Rectangle {
                id: onlineIndicator
                height: 14
                width: 14
                radius: 14
                anchors.right: parent.right
                anchors.rightMargin: 28
                anchors.verticalCenter: serverName.verticalCenter
                color: pingTime.msPing < 100? "#4BBE2E" : ((pingTime.msPing >= 100 && pingTime.msPing < 500)? "#F2C94C" :"#F7D57E")
                visible: serverStatus != "down"
            }

            Label {
                property string pingStr: responseTime
                property int msPing: Math.round(Number.fromLocaleString(pingStr) / 1000000)

                id: pingTime
                text: "(" + msPing + " ms)"
                color: darktheme == true? "#F2F2F2" : "14161B"
                font.pixelSize: 14
                font.family: xciteMobile.name
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: onlineIndicator.left
                anchors.rightMargin: 15
                visible: serverStatus != "down"
            }

            Image {
                id: nodeDownIcon
                source: 'qrc:/icons/mobile/not_available-icon_01.svg'
                height: 20
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 25
                visible: serverStatus == "down"
            }

            Label {
                id: nodeDownLabel
                text: "node not available"
                color: darktheme == true? "#F2F2F2" : "14161B"
                font.pixelSize: 14
                font.family: xciteMobile.name
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: nodeDownIcon.left
                anchors.rightMargin: 12
                visible: serverStatus == "down"
            }
        }
    }

    SortFilterProxyModel {
        id: filteredServers
        sourceModel: xChatServers

        sorters: [
            StringSorter {
                roleName: "name";
                sortOrder: Qt.AscendingOrder;
                caseSensitivity: Qt.CaseInsensitive
            }
        ]
    }

    ListView {
        anchors.fill: parent
        id: serverList
        model: filteredServers
        delegate: xChatServerInfo
        onDraggingChanged: detectInteraction()
    }
}
