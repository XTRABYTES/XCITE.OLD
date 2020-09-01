/**
* Filename: XChangeRecentTradeList.qml
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
    id: recentTradelist
    width: parent.width
    height: parent.height
    color: bgcolor
    clip: true

    property alias list: sortedTrades.sourceModel
    property string exchange: ""
    property string coin: ""

    Component {
        id: tradelistEntry

        Rectangle {
            id: listRow
            width: parent.width
            height: 25
            color: "transparent"

            Label {
                id: tradeDate
                text: date
                color: themecolor
                font.pixelSize: 8
                font.family: xciteMobile.name
                anchors.bottom: parent.verticalCenter
                anchors.bottomMargin: -1
                anchors.left: parent.left
                anchors.leftMargin: 28
            }

            Label {
                id: tradeTime
                text: time + " UTC"
                color: themecolor
                font.pixelSize: 8
                font.family: xciteMobile.name
                anchors.top: parent.verticalCenter
                anchors.topMargin: -1
                anchors.left: parent.left
                anchors.leftMargin: 28
            }

            Label {
                id: buySell
                text: side
                color: text.toLowerCase() == "buy"? "#4BBE2E" : "#E55541"
                font.pixelSize: 13
                font.family: xciteMobile.name
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: tradeDate.left
                anchors.leftMargin: 65
            }

            Label {
                id: tradePrice
                text: price
                color: themecolor
                font.pixelSize: 10
                font.family: xciteMobile.name
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: tradeDate.left
                anchors.leftMargin: 100
            }

            Label {
                id: tradeVol
                text: quantity + " " + coin
                color: themecolor
                font.pixelSize: 10
                font.family: xciteMobile.name
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 28
            }

            Rectangle {
                width: parent.width
                height: 1
                color: "#757575"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
            }
        }
    }

    SortFilterProxyModel {
        id: sortedTrades
        sorters: [
            RoleSorter {roleName: "date" ; sortOrder: Qt.DescendingOrder},
            RoleSorter {roleName: "time"; sortOrder: Qt.DescendingOrder}
        ]
    }

    ListView {
        id: sortedTradesList
        anchors.fill: parent
        model: sortedTrades
        delegate: tradelistEntry
        onDraggingChanged: detectInteraction()

        ScrollBar.vertical: ScrollBar {
            parent: sortedTradesList.parent
            anchors.top: sortedTradesList.top
            anchors.right: sortedTradesList.right
            anchors.bottom: sortedTradesList.bottom
            width: 5
            opacity: 1
            policy: ScrollBar.AlwaysOn
        }
    }
}

