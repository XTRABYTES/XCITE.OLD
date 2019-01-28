/**
 * Filename: CoinList.qml
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

    property alias cardSpacing: allCoins.spacing

    Component {
        id: walletCard

        Rectangle {
            id: currencyRow
            color: "transparent"
            width: Screen.width
            height: 85
            anchors.horizontalCenter: parent.horizontalCenter

            Timer {
                id: timer
                interval: 300
                repeat: false
                running: false

                onTriggered:{
                    walletTracker = 1
                }
            }

            Rectangle {
                id: square
                width: parent.width - 55
                height: 75
                radius: 4
                color: darktheme == false? "#F2F2F2" : "#1B2934"
                border.width: 1
                border.color: darktheme == false? "#42454F" : "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top

                DropShadow {
                    id: iconShadow
                    anchors.fill: icon
                    source: icon
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color:"black"
                    opacity: 0.3
                    transparentBorder: true
                }

                Image {
                    id: icon
                    source: getLogo(coinName.text)
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    width: 25
                    height: 25
                }

                Text {
                    id: coinName
                    anchors.left: icon.right
                    anchors.leftMargin: 7
                    anchors.verticalCenter: icon.verticalCenter
                    text: name
                    font.pixelSize: 18
                    font.family: xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                    font.bold: true
                }

                Text {
                    id: amountSizeLabel
                    anchors.right: parent.right
                    anchors.rightMargin: 14
                    anchors.verticalCenter: coinName.verticalCenter
                    text: name
                    font.pixelSize: 18
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Text {
                    property real sumBalance: (sumCoinTotal(coinName.text))
                    property int decimals: name == "BTC" ? 8 : (sumBalance >= 100000 ? 2 : 4)
                    property var amountArray: (sumBalance.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountSizeLabel1
                    anchors.right: amountSizeLabel.left
                    anchors.rightMargin: 5
                    anchors.bottom: amountSizeLabel.bottom
                    anchors.bottomMargin: 1
                    text:  "." + amountArray[1]
                    font.pixelSize: 14
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Text {
                    property real sumBalance: (sumCoinTotal(coinName.text))
                    property int decimals: name == "BTC" ? 8 : (sumBalance >= 100000 ? 2 : 4)
                    property var amountArray: (sumBalance.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountSizeLabel2
                    anchors.right: amountSizeLabel1.left
                    anchors.verticalCenter: coinName.verticalCenter
                    text: amountArray[0]
                    font.pixelSize: 18
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Text {
                    property real sumBalance: (sumCoinTotal(coinName.text))
                    property var amountArray: ((coinConversion(name, sumBalance)).toLocaleString(Qt.locale("en_US"), "f", 2)).split('.')
                    id: totalValueLabel1
                    anchors.right: square.right
                    anchors.rightMargin:14
                    anchors.bottom: totalValueLabel2.bottom
                    anchors.bottomMargin: 1
                    text: "." + amountArray[1]
                    font.pixelSize: 11
                    font.family:  xciteMobile.name
                    color: "#828282"
                }

                Text {
                    property real sumBalance: (sumCoinTotal(coinName.text))
                    property var amountArray: ((coinConversion(name, sumBalance)).toLocaleString(Qt.locale("en_US"), "f", 2)).split('.')
                    id: totalValueLabel2
                    anchors.right: totalValueLabel1.left
                    anchors.verticalCenter: price1.verticalCenter
                    text:amountArray[0]
                    font.pixelSize: 14
                    font.family:  xciteMobile.name
                    color: "#828282"
                }

                Label {
                    id: dollarSign2
                    anchors.right: totalValueLabel2.left
                    anchors.leftMargin: 0
                    anchors.verticalCenter: totalValueLabel2.verticalCenter
                    text: "$"
                    font.pixelSize: 14
                    font.family:  xciteMobile.name
                    color: "#828282"
                }

                Text {
                    id: percentChangeLabel
                    anchors.left: price2.right
                    anchors.leftMargin: 5
                    anchors.bottom: price1.bottom
                    text:(percentage >= 0? "+" + getPercentage(coinName.text) + "%" : getPercentage(coinName.text) + "%")
                    font.pixelSize: 14
                    font.family:  xciteMobile.name
                    color: getPercentage(coinName.text) <= 0 ? "#E55541" : "#4BBE2E"
                    font.bold: true
                }

                Text {
                    property var amountArray: ((getValue(coinName.text) * valueBTC).toLocaleString(Qt.locale("en_US"), "f", 4)).split('.')
                    id: price1
                    anchors.left: dollarSign1.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    text:amountArray[0]
                    font.pixelSize: 14
                    font.family:  xciteMobile.name
                    color: "#828282"
                }

                Text {
                    property var amountArray: ((getValue(coinName.text) * valueBTC).toLocaleString(Qt.locale("en_US"), "f", 4)).split('.')
                    id: price2
                    anchors.left: price1.right
                    anchors.bottom: price1.bottom
                    anchors.bottomMargin: 1
                    text: "." + amountArray[1]
                    font.pixelSize: 11
                    font.family: xciteMobile.name
                    color: "#828282"
                }

                Label {
                    id: dollarSign1
                    anchors.left: icon.left
                    anchors.verticalCenter: price1.verticalCenter
                    text: "$"
                    font.pixelSize: 14
                    font.family:  xciteMobile.name
                    color: "#828282"
                }

                MouseArea {
                    anchors.fill: parent

                   onClicked: {
                        if (coinTracker == 0 && appsTracker == 0 && addCoinTracker == 0 && transferTracker == 0) {
                            coinIndex = coinID
                            countWallets()
                            coinTracker = 1
                        }
                    }

                }
            }

        }
    }

    SortFilterProxyModel {
        id: filteredCoins
        sourceModel: coinList
        filters: [
            ValueFilter {
                roleName: "active"
                value: true
            }
        ]
        sorters: RoleSorter { roleName: "name" ; sortOrder: Qt.DescendingOrder }
    }

    ListView {
        id: allCoins
        model: filteredCoins
        delegate: walletCard
        spacing: 0
        anchors.fill: parent
        contentHeight: (filteredCoins.count * 85) + 75
        interactive: appsTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0 && transferTracker == 0
    }
}
