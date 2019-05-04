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

import "qrc:/Controls" as Controls

Rectangle {
    id: allWalletCards
    width: Screen.width
    height: parent.height - 75
    color: "transparent"

    property alias cardSpacing: allCoins.spacing

    Component {
        id: walletCard

        Rectangle {
            id: currencyRow
            color: "transparent"
            width: Screen.width
            height: 100
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
                width: parent.width
                height: parent.height
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                clip: true

                Controls.CardBody {

                }

                Label {
                    id: testnetLabel
                    text: "TESTNET"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    font.pixelSize: 10
                    font.family: "Brandon Grotesque"
                    color: "#E55541"
                    font.letterSpacing: 2
                    visible: testnet
                }

                Image {
                    id: icon
                    source: getLogoBig(name)
                    anchors.horizontalCenter: parent.left
                    anchors.horizontalCenterOffset: 15 //icon.implicitWidth/6
                    anchors.verticalCenter: parent.verticalCenter
                    height: 70
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: coinName
                    anchors.left: parent.left
                    anchors.leftMargin: 60
                    anchors.top: parent.top
                    anchors.topMargin: 15
                    anchors.right: percentChangeLabel.left
                    anchors.rightMargin: 10
                    text: fullname
                    font.capitalization: Font.AllUppercase
                    font.pixelSize: 24
                    font.family: xciteMobile.name
                    font.letterSpacing: 2
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                    font.bold: true
                    elide: Text.ElideRight
                }

                Text {
                    id: amountSizeLabel
                    anchors.left: amountSizeLabel1.right
                    anchors.leftMargin: 5
                    anchors.bottom: amountSizeLabel2.bottom
                    text: name
                    font.pixelSize: 18
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Text {
                    property real sumBalance: name === "XBY"? totalXBY : (name === "XFUEL"? totalXFUEL : (name === "XTEST"? totalXFUELTest : (name === "BTC"? totalBTC : (name === "ETH"? totalETH : 0))))
                    property int decimals: sumBalance < 10 ? 8 : (sumBalance >= 100000 ? 2 : 4)
                    property var amountArray: (sumBalance.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountSizeLabel1
                    anchors.left: amountSizeLabel2.right
                    anchors.bottom: amountSizeLabel2.bottom
                    anchors.bottomMargin: 1
                    text:  "." + amountArray[1]
                    font.pixelSize: 14
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Text {
                    property real sumBalance: name === "XBY"? totalXBY : (name === "XFUEL"? totalXFUEL : (name === "XTEST"? totalXFUELTest : (name === "BTC"? totalBTC : (name === "ETH"? totalETH : 0))))
                    property int decimals: sumBalance < 10 ? 8 : (sumBalance >= 100000 ? 2 : 4)
                    property var amountArray: (sumBalance.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountSizeLabel2
                    anchors.left: coinName.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    text: amountArray[0]
                    font.pixelSize: 18
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Text {
                    property real sumBalance: name === "XBY"? totalXBY : (name === "XFUEL"? totalXFUEL : (name === "XBY-TEST"? totalXBYTest :(name === "XFUEL-TEST"? totalXFUELTest : (name === "BTC"? totalBTC : (name === "ETH"? totalETH : 0)))))
                    property real sumFiat: name === "XBY"? totalXBYFiat : (name === "XFUEL"? totalXFUELFiat : (name === "BTC"? totalBTCFiat : (name === "ETH"? totalETHFiat : 0)))
                    property var amountArray: (sumFiat.toLocaleString(Qt.locale("en_US"), "f", 2)).split('.')
                    id: totalValueLabel1
                    anchors.right: square.right
                    anchors.rightMargin:28
                    anchors.bottom: totalValueLabel2.bottom
                    anchors.bottomMargin: 1
                    text: "." + amountArray[1]
                    font.pixelSize: 14
                    font.family:  xciteMobile.name
                    color: "#828282"
                    visible: testnet == false
                }

                Text {
                    property real sumBalance: name === "XBY"? totalXBY : (name === "XFUEL"? totalXFUEL : (name === "XBY-TEST"? totalXBYTest :(name === "XFUEL-TEST"? totalXFUELTest : (name === "BTC"? totalBTC : (name === "ETH"? totalETH : 0)))))
                    property real sumFiat: name === "XBY"? totalXBYFiat : (name === "XFUEL"? totalXFUELFiat : (name === "BTC"? totalBTCFiat : (name === "ETH"? totalETHFiat : 0)))
                    property var amountArray: (sumFiat.toLocaleString(Qt.locale("en_US"), "f", 2)).split('.')
                    id: totalValueLabel2
                    anchors.right: totalValueLabel1.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    text:amountArray[0]
                    font.pixelSize: 18
                    font.family:  xciteMobile.name
                    color: "#828282"
                    visible: testnet == false
                }

                Label {
                    id: dollarSign2
                    anchors.right: totalValueLabel2.left
                    anchors.leftMargin: 0
                    anchors.verticalCenter: totalValueLabel2.verticalCenter
                    text: fiatTicker
                    font.pixelSize: 18
                    font.family:  xciteMobile.name
                    color: "#828282"
                    visible: testnet == false
                }

                Text {
                    id: percentChangeLabel
                    anchors.right: square.right
                    anchors.rightMargin: 28
                    anchors.verticalCenter: coinName.verticalCenter
                    text:"24h: " + (percentage >= 0? "+" + getPercentage(name) + "%" : getPercentage(name) + "%")
                    font.pixelSize: 14
                    font.family:  xciteMobile.name
                    color: getPercentage(name) < 0 ? "#E55541" : "#4BBE2E"
                    font.bold: true
                    visible: testnet == false
                }

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                   onClicked: {
                        if (coinTracker == 0 && appsTracker == 0 && addCoinTracker == 0 && transferTracker == 0) {
                            coinIndex = coinID
                            console.log("coinIndex: " + coinIndex)
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
        sorters: [
            RoleSorter { roleName: "testnet" ; sortOrder: Qt.AscendingOrder },
            RoleSorter {roleName: "xby"; sortOrder: Qt.DescendingOrder},
            StringSorter { roleName: "fullname"}
        ]
    }

    ListView {
        id: allCoins
        model: filteredCoins
        delegate: walletCard
        spacing: 0
        anchors.fill: parent
        contentHeight: (filteredCoins.count * 100)
        interactive: appsTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0 && transferTracker == 0
        onDraggingChanged: detectInteraction()
    }
}
