/**
* Filename: WalletPicklist.qml
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
    height: (totalCoinWallets * 35 < 175)? totalCoinWallets * 35 : 175
    radius: 5
    color: "#2A2C31"

    property string coin: ""

    Component.onCompleted: coinWalletLines(coin)

    Component {
        id: picklistEntry

        Rectangle {
            id: picklistRow
            width: 100
            height: 35
            color: "transparent"
            clip: true

            Rectangle {
                id: clickIndicator
                anchors.fill: parent
                color: "white"
                opacity: 0.25
                visible: false
            }

            Label {
                id: pickListWalletLabel
                text: label
                color: "#F2F2F2"
                font.pixelSize: 16
                font.family: xciteMobile.name
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 10
                horizontalAlignment: Text.AlignRight
                elide: Text.ElideRight
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    clickIndicator.visible = true
                    detectInteraction()
                }

                onCanceled: {
                    clickIndicator.visible = false
                }

                onReleased: {
                    clickIndicator.visible = false
                }

                onClicked: {
                    clickIndicator.visible = false
                    walletIndex = walletNR;
                    newWalletSelect = 1
                    walletListTracker = 0
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                color: "#5F5F5F"
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                visible: index < totalCoinWallets ? true : false
            }
        }
    }

    SortFilterProxyModel {
        id: filteredWallets
        sourceModel: walletList
        filters: [
            ValueFilter {
                roleName: "remove"
                value: false
            },
            RegExpFilter {
                roleName: "name"
                pattern: "^" + coin + "$"
            }

        ]
        sorters: [
            RoleSorter { roleName: "favorite"; sortOrder: Qt.DescendingOrder },
            StringSorter { roleName: "label" }
        ]

    }

    ListView {
        anchors.fill: parent
        id: pickList
        model: filteredWallets
        delegate: picklistEntry
        interactive: (totalCoinWallets * 35) > 175
        onDraggingChanged: detectInteraction()

        ScrollBar.vertical: ScrollBar {
            parent: pickList.parent
            anchors.top: pickList.top
            anchors.right: pickList.right
            anchors.bottom: pickList.bottom
            width: 5
            opacity: 1
            policy: ScrollBar.AlwaysOn
            visible: (totalCoinWallets * 35) > 175
        }
    }
}

