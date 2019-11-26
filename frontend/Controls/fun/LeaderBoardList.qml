/**
* Filename: LeaderBoardList.qml
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

    Component {
        id: scoreLine

        Rectangle {
            id: scoreRow
            width: parent.width
            height: 35
            color: "transparent"
            clip: true

            Label {
                id: opponent
                text: player
                font.pixelSize: 16
                font.family: xciteMobile.name
                font.bold: true
                color: maincolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: wonGames.left
                anchors.rightMargin: 15
                horizontalAlignment: Text.AlignLeft
                elide: Text.ElideRight
            }

            Label {
                id: drawedGames
                text: draw
                font.pixelSize: 12
                font.family: xciteMobile.name
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.right
                anchors.horizontalCenterOffset: -15
            }

            Label {
                id: lostGames
                text: win
                font.pixelSize: 12
                font.family: xciteMobile.name
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                  anchors.horizontalCenter: parent.right
                anchors.horizontalCenterOffset: -55
            }

            Label {
                id: wonGames
                text: lost
                font.pixelSize: 12
                font.family: xciteMobile.name
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.right
                anchors.horizontalCenterOffset: -95
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
        id: filteredScores
        sourceModel: scoreList
        filters: [
            RegExpFilter {
                roleName: "game"
                pattern: gameName
            }
        ]
        sorters: [
            RoleSorter {
                roleName: "win"
                sortOrder: Qt.AsscendingOrder},
            RoleSorter {
                roleName: "lost"
                sortOrder: Qt.DecendingOrder},
            RoleSorter {
                roleName: "draw"
                sortOrder: Qt.DescendingOrder}
        ]
    }

    ListView {
        anchors.fill: parent
        id: scores
        model: filteredScores
        delegate: scoreLine
        onDraggingChanged: {
            detectInteraction()
        }
    }

    Component.onCompleted: {
        games.positionViewAtBeginning()
    }
}
