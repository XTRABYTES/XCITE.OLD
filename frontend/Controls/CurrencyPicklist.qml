/**
* Filename: CurrencyPicklist.qml
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
    id: completePicklist
    width: 100
    height: totalLines * 35 < 175 ? totalLines * 35 : 175
    radius: 5
    color: "#2A2C31"

    property bool onlyActive: false

    Component.onCompleted: picklistLines()

    Component {
        id: picklistEntry

        Rectangle {
            id: picklistRow
            width: 100
            height: 35
            color: "transparent"

            Rectangle {
                id: clickIndicator
                anchors.fill: parent
                color: "white"
                opacity: 0.25
                visible: false
            }

            Image {
                id: picklistCoinLogo
                source: logo
                height: 20
                width: 20
                anchors.left: parent.left
                anchors.leftMargin: 7
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                id: pickListCoinName
                text: name
                color: "#F2F2F2"
                font.pixelSize: 16
                font.family: xciteMobile.name //"Brandon Grotesque"
                anchors.verticalCenter: picklistCoinLogo.verticalCenter
                anchors.left: picklistCoinLogo.right
                anchors.leftMargin: 7
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    clickIndicator.visible = true
                }

                onCanceled: {
                    clickIndicator.visible = false
                }

                onReleased: {
                    clickIndicator.visible = false
                }

                onClicked: {
                    clickIndicator.visible = false
                    newCoinPicklist = index;
                    newCoinSelect = 1
                    picklistTracker = 0
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                color: "#5F5F5F"
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                visible: index < totalLines ? true : false
            }
        }
    }

    SortFilterProxyModel {
        id: filteredCurrencies
        sourceModel: coinList
        filters: [
            ValueFilter {
                enabled: onlyActive == true
                roleName: "active"
                value: true
            }
        ]
        sorters: [
            RoleSorter { roleName: "favorite"; sortOrder: Qt.DescendingOrder },
            StringSorter { roleName: "name" }
        ]

    }

    ListView {
        anchors.fill: parent
        id: pickList
        model: filteredCurrencies
        delegate: picklistEntry
        interactive: false
    }
}

