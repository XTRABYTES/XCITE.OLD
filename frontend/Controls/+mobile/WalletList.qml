/**
 * Filename: WalletList.qml
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
import QtQuick.Window 2.2
import SortFilterProxyModel 0.2
import QtGraphicalEffects 1.0

Rectangle {
    id: allWalletCards
    width: Screen.width
    height: parent.height
    color: "transparent"

    Component {
        id: walletCard

        Rectangle {
            id: currencyRow
            color: "transparent"
            width: Screen.width
            height: {
                if (active == 0) {
                    0
                }
                else {
                    if (unconfirmedCoins != 0) {
                        98
                    }
                    else {
                        88
                    }
                }
            }
            visible: active == 1

            DropShadow {
                anchors.fill: square
                source: square
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color:"#2A2C31"
                transparentBorder: true
            }

            Rectangle {
                id: square
                width: parent.width - 55
                height: unconfirmedCoins != 0 ? 88: 78
                //radius: 4
                color: "#42454F"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 10
                visible: active == 1



                Image {
                    id: icon
                    source: logo
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    anchors.top: parent.top
                    anchors.topMargin: 14
                    width: 25
                    height: 25
                    visible: active == 1
                }

                Text {
                    id: coinName
                    anchors.left: icon.right
                    anchors.leftMargin: 7
                    anchors.verticalCenter: icon.verticalCenter
                    text: name
                    font.pixelSize: 18
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: active == 1
                }

                Text {
                    id: amountSizeLabel
                    anchors.right: parent.right
                    anchors.rightMargin: 14
                    anchors.verticalCenter: coinName.verticalCenter
                    text: name
                    font.pixelSize: 18
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: active == 1
                }

                Text {
                    property int decimals: name == "BTC" ? 8 : (balance >= 100000 ? 2 : 4)
                    property var amountArray: (balance.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountSizeLabel1
                    anchors.right: amountSizeLabel.left
                    anchors.rightMargin: 5
                    anchors.bottom: amountSizeLabel.bottom
                    anchors.bottomMargin: 1
                    text: "." + amountArray[1]
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: active == 1
                }

                Text {
                    property int decimals: name == "BTC" ? 8 : (balance >= 100000 ? 2 : 4)
                    property var amountArray: (balance.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountSizeLabel2
                    anchors.right: amountSizeLabel1.left
                    anchors.verticalCenter: coinName.verticalCenter
                    text: amountArray[0]
                    font.pixelSize: 18
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: active == 1
                }

                Text {
                    property var amountArray: (fiatValue.toLocaleString(Qt.locale("en_US"), "f", 2)).split('.')
                    id: totalValueLabel1
                    anchors.right: square.right
                    anchors.rightMargin:14
                    anchors.bottom: totalValueLabel2.bottom
                    text: "." + amountArray[1]
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    color: "#828282"
                    font.bold: true
                    visible: active == 1
                }

                Text {
                    property var amountArray: (fiatValue.toLocaleString(Qt.locale("en_US"), "f", 2)).split('.')
                    id: totalValueLabel2
                    anchors.right: totalValueLabel1.left
                    anchors.verticalCenter: price2.verticalCenter
                    text: amountArray[0]
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    color: "#828282"
                    font.bold: true
                    visible: active == 1
                }

                Label {
                    id: dollarSign2
                    anchors.right: totalValueLabel2.left
                    anchors.leftMargin: 0
                    anchors.verticalCenter: totalValueLabel1.verticalCenter
                    text: "$"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    color: "#828282"
                    font.bold: true
                    visible: active == 1
                }

                Text {
                    id: percentChangeLabel
                    anchors.left: price2.right
                    anchors.leftMargin: 5
                    anchors.bottom: price2.bottom
                    text: percentage >= 0? "+" + percentage + "%" : percentage + "%"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: percentage <= 0 ? "#E55541" : "#4BBE2E"
                    font.bold: true
                    visible: active == 1
                }

                Text {
                    property var amountArray: (coinValue.toLocaleString(Qt.locale("en_US"), "f", 4)).split('.')
                    id: price1
                    anchors.left: dollarSign1.right
                    anchors.top: icon.bottom
                    anchors.topMargin: 8
                    text: amountArray[0]
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    color: "#828282"
                    font.bold: true
                    visible: active == 1
                }

                Text {
                    property var amountArray: (coinValue.toLocaleString(Qt.locale("en_US"), "f", 4)).split('.')
                    id: price2
                    anchors.left: price1.right
                    anchors.bottom: price1.bottom
                    text: "." + amountArray[1]
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    color: "#828282"
                    font.bold: true
                    visible: active == 1
                }

                Label {
                    id: dollarSign1
                    anchors.left: icon.left
                    anchors.verticalCenter: price2.verticalCenter
                    text: "$"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    color: "#828282"
                    font.bold: true
                    visible: active == 1
                }

                Text {
                    id: unconfirmed
                    anchors.horizontalCenter: square.horizontalCenter
                    anchors.top: percentChangeLabel.bottom
                    anchors.topMargin: 4
                    text: "Unconfirmed " + unconfirmedCoins.toLocaleString(Qt.locale("en_US"), "f", 4) + " " + name
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: "#F2F2F2"
                    font.weight: Font.Light
                    font.italic: true
                    visible: unconfirmedCoins != 0 && active == 1
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (appsTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0 && transferTracker == 0) {
                            transferTracker = 1
                            currencyIndex = walletNR
                        }
                    }
                }
            }
        }
    }

    SortFilterProxyModel {
        id: filteredCoins
        sourceModel: currencyList
        sorters: RoleSorter { roleName: "fiatValue" ; sortOrder: Qt.DescendingOrder }
    }

    ListView {
        anchors.fill: parent
        id: allWallets
        model: filteredCoins
        delegate: walletCard
        contentHeight: (totalWallets * 98)
        interactive: appsTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0 && transferTracker == 0
   }
}

