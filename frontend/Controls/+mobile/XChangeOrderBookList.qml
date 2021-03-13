/**
* Filename: XChangeOrdeBookList.qml
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
    id: orderBooklist
    width: parent.width
    height: parent.height
    color: bgcolor
    clip: true

    property string exchange: ""
    property string coin: ""
    property string orderType: ""
    property real volume: 0



    Component {
        id: orderlistEntry

        Rectangle {
            id: listRow
            width: parent.width
            anchors.left: orderType == "buy"? undefined : parent.left
            anchors.right: orderType == "buy"? parent.right : undefined
            height: 25
            color: "transparent"

            Rectangle {
                id: accVolumeIndicator
                height: parent.height - 1
                width: parent.width/volume * accVolume
                color: orderType == "buy"? "#4BBE2E" : "#E55541"
                opacity: 0.2
                anchors.top: parent.top
                anchors.left: orderType == "buy"? undefined : parent.left
                anchors.right: orderType == "buy"? parent.right : undefined
            }

            Rectangle {
                id: volumeIndicator
                height: parent.height - 1
                width: parent.width/volume * quantity
                color: orderType == "buy"? "#4BBE2E" : "#E55541"
                opacity: accVolume != "0"? 0.15 : 0.35
                anchors.top: parent.top
                anchors.left: orderType == "buy"? undefined : parent.left
                anchors.right: orderType == "buy"? parent.right : undefined
            }

            Rectangle {
                anchors.fill: volumeIndicator
                color: "transparent"
                border.color: orderType == "buy"? "#4BBE2E" : "#E55541"
                border.width: 1
            }

            Label {
                id: orderPrice
                text: price.toLocaleString(Qt.locale("en_US"), "f", 8)
                color: themecolor
                font.pixelSize: 13
                font.family: xciteMobile.name
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: orderType == "buy"? 28 : 5
            }

            Label {
                id: orderVolume
                text: quantity.toLocaleString(Qt.locale("en_US"), "f", 4) + " " + coin
                color: themecolor
                font.pixelSize: 13
                font.family: xciteMobile.name
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: orderType == "sell"? 28 : 5
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
        id: sortedOrders
        sourceModel: orderList
        filters:[
            ValueFilter {
                roleName: "side"
                value: orderType
            }
        ]
        sorters: [
            RoleSorter {
                roleName: "price"
                sortOrder: orderType == "buy"? Qt.DescendingOrder : Qt.AscendingOrder
            }
        ]
    }

    ListView {
        id: sortedOrderList
        anchors.fill: parent
        model: sortedOrders
        delegate: orderlistEntry
        onDraggingChanged: detectInteraction()

        ScrollBar.vertical: ScrollBar {
            parent: sortedOrderList.parent
            anchors.top: sortedOrderList.top
            anchors.right: orderType === "buy"? undefined : sortedOrderList.right
            anchors.left: orderType === "buy"? sortedOrderList.left : undefined
            anchors.bottom: sortedOrderList.bottom
            width: 5
            opacity: 1
            policy: ScrollBar.AlwaysOn
        }
    }
}


