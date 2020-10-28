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
    width: parent.width
    height: parent.height
    color: "transparent"

    property alias cardSpacing: allCoins.spacing

    Component {
        id: walletCard

        Rectangle {
            id: currencyRow
            color: "transparent"
            width: allWalletCards.width
            height: appHeight/12
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

                Rectangle {
                    id: selectionIndicator
                    width: parent.width - appWidth*3/24
                    height: parent.height*0.8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: appWidth/12
                    color: maincolor
                    opacity: 0.1
                    visible: false
                }

                Rectangle {
                    width: parent.width - appWidth*3/24
                    height: parent.height*0.8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: appWidth/12
                    color: "transparent"
                    border.width: 0.5
                    border.color: themecolor
                    opacity: 0.1
                }

                Image {
                    id: icon
                    source: getLogo(name)
                    anchors.left: parent.left
                    anchors.leftMargin: appWidth*3/48
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height/2
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: coinName
                    anchors.left: parent.left
                    anchors.leftMargin: appWidth*5/48
                    anchors.verticalCenter: parent.verticalCenter
                    text: fullname
                    font.capitalization: Font.AllUppercase
                    font.pixelSize: appHeight/36
                    font.family: xciteMobile.name
                    font.letterSpacing: 2
                    color: themecolor
                    elide: Text.ElideRight
                }

                Text {
                    property real sumBalance: name === "XBY"? totalXBY : (name === "XFUEL"? totalXFUEL : (name === "XTEST"? totalXFUELTest : (name === "BTC"? totalBTC : (name === "ETH"? totalETH : 0))))
                    property var amountArray: (sumBalance.toLocaleString(Qt.locale("en_US"), "f", 2))
                    id: amountSizeValue
                    anchors.right: amountSizeLabel.left
                    anchors.rightMargin: font.pixelSize
                    anchors.verticalCenter: parent.verticalCenter
                    text:  amountArray
                    font.pixelSize: appHeight/54
                    font.family:  xciteMobile.name
                    color: themecolor
                }

                Text {
                    id: amountSizeLabel
                    anchors.left: parent.left
                    anchors.leftMargin: appWidth*2/6
                    anchors.verticalCenter: parent.verticalCenter
                    text: name
                    font.pixelSize: appHeight/54
                    font.family:  xciteMobile.name
                    color: themecolor
                }

                Text {
                    id: percentChangeLabel
                    anchors.left: parent.right
                    anchors.leftMargin: - appWidth*1.5/6
                    anchors.verticalCenter: coinName.verticalCenter
                    text:"24h: " + (percentage >= 0? "+" + getPercentage(name) + "%" : getPercentage(name) + "%")
                    font.pixelSize: appHeight/54
                    font.family:  xciteMobile.name
                    color: getPercentage(name) < 0 ? "#E55541" : "#4BBE2E"
                    visible: testnet == false
                }

                Label {
                    id: btcLabel
                    anchors.left: parent.right
                    anchors.leftMargin: - appWidth*2/6
                    anchors.verticalCenter: coinName.verticalCenter
                    text: "BTC"
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    color: themecolor
                    visible: testnet == false && userSettings.showBalance === true
                }

                Text {
                    property real sumFiat: name === "XBY"? totalXBYFiat : (name === "XFUEL"? totalXFUELFiat : (name === "BTC"? totalBTCFiat : (name === "ETH"? totalETHFiat : 0)))
                    property real sumBtc: name === "XBY"? sumFiat*btcValueXBY : (name === "XFUEL"? sumFiat*btcValueXFUEL : (name === "BTC"? sumFiat/valueBTC : (name === "ETH"? sumFiat*btcValueETH : 0)))
                    property var amountArray: (sumBtc.toLocaleString(Qt.locale("en_US"), "f", 8))
                    id: totalBtcValue
                    anchors.right: btcLabel.left
                    anchors.rightMargin: font.pixelSize
                    anchors.verticalCenter: parent.verticalCenter
                    text: amountArray
                    font.pixelSize: appHeight/54
                    font.family:  xciteMobile.name
                    color: themecolor
                    visible: testnet == false && userSettings.showBalance === true
                }

                Label {
                    id: dollarSign
                    anchors.right: totalFiatValue.left
                    anchors.rightMargin: font.pixelSize/2
                    anchors.verticalCenter: parent.verticalCenter
                    text: fiatTicker
                    font.pixelSize: appHeight/54
                    font.family:  xciteMobile.name
                    color: themecolor
                    visible: testnet == false && userSettings.showBalance === true
                }

                Text {
                    property real sumFiat: name === "XBY"? totalXBYFiat : (name === "XFUEL"? totalXFUELFiat : (name === "BTC"? totalBTCFiat : (name === "ETH"? totalETHFiat : 0)))
                    property var amountArray: (sumFiat.toLocaleString(Qt.locale("en_US"), "f", 2))
                    id: totalFiatValue
                    anchors.right: parent.right
                    anchors.rightMargin: appWidth*5/48
                    anchors.verticalCenter: parent.verticalCenter
                    text: amountArray
                    font.pixelSize: appHeight/54
                    font.family:  xciteMobile.name
                    color: themecolor
                    visible: testnet == false && userSettings.showBalance === true
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        selectionIndicator.visible = true
                    }

                    onExited: {
                        selectionIndicator.visible = false
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                   onClicked: {
                       /*
                        if (coinTracker == 0 && appsTracker == 0 && addCoinTracker == 0 && transferTracker == 0) {
                            coinIndex = coinID
                            countWallets()
                            coinTracker = 1
                        }*/
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
        contentHeight: (filteredCoins.count * appHeight/12)
        interactive: appsTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0 && transferTracker == 0
        onDraggingChanged: detectInteraction()
    }
}
