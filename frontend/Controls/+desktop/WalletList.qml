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

import "qrc:/Controls" as Controls
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: allWalletCards
    width: parent.width
    height: parent.height
    color: "transparent"

    Component {
        id: walletCard

        Rectangle {
            id: currencyRow
            color: "transparent"
            width: allWalletCards.width
            height: appHeight/6
            anchors.horizontalCenter: parent.horizontalCenter

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
                    opacity: 0.3
                    visible: false
                }

                Rectangle {
                    id: cardBorder
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

                MouseArea {
                    anchors.fill: selectionIndicator
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

                    onReleased: {
                    }

                    onClicked: {
                        console.log(walletName.text + "selected")
                        walletIndex = walletNR
                        if (coinIndex < 3){
                            historyDetailsCollected = false
                            transactionPages = 0
                            currentPage = 1
                            historyTracker = 1
                            updateTransactions(name, address, 1)
                        }
                        walletDetailTracker = 1
                    }

                    Connections {
                        target: explorer

                        onUpdateTransactions: {
                            if (historyDetailsCollected === false) {
                                transactionPages = totalPages;
                                loadTransactions(transactions);
                                historyDetailsCollected = true
                            }
                        }
                    }
                }

                Image {
                    id: walletFavorite
                    source: favorite == true ? 'qrc:/icons/mobile/favorite-icon_01_color.svg' : (darktheme === true? 'qrc:/icons/mobile/favorite-icon_01_light.svg' : 'qrc:/icons/mobile/favorite-icon_01_dark.svg')
                    anchors.left: parent.left
                    anchors.leftMargin: appWidth*3/48
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height/5
                    fillMode: Image.PreserveAspectFit
                    state: favorite == true ? "yes" : "no"

                    states: [
                        State {
                            name: "yes"
                            PropertyChanges { target: walletFavorite; width: 20}
                        },
                        State {
                            name: "no"
                            PropertyChanges { target: walletFavorite; width: 18}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "no"
                            to: "yes"
                            NumberAnimation { target: walletFavorite; properties: "width"; duration: 200; easing.type: Easing.OutBack}
                        },
                        Transition {
                            from: "yes"
                            to: "no"
                            NumberAnimation { target: walletFavorite; properties: "width"; duration: 200; easing.type: Easing.InBack}
                        }
                    ]
                }

                Rectangle {
                    id: favoriteButton
                    anchors.fill: walletFavorite
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            if (viewOnly == false) {
                                if (favorite == true) {
                                    //walletList.setProperty(walletNR, "favorite", false)
                                }
                                else {
                                    resetFavorites(name)
                                    walletList.setProperty(walletNR, "favorite", true)
                                }
                            }
                        }
                    }
                }

                Text {
                    id: walletName
                    anchors.left: parent.left
                    anchors.leftMargin: (appWidth*3/48) + (parent.height*2/5)
                    anchors.verticalCenter: parent.verticalCenter
                    text: label
                    font.capitalization: Font.AllUppercase
                    font.pixelSize: appHeight/36
                    font.family: xciteMobile.name
                    font.letterSpacing: 2
                    color: themecolor
                    elide: Text.ElideRight
                }

                Label {
                    id: viewOnlyLabel
                    text: " VIEW ONLY"
                    anchors.left: walletName.left
                    anchors.top:  walletName.bottom
                    anchors.topMargin: 2
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    font.letterSpacing: 2
                    color: "#E55541"
                    visible: viewOnly
                }

                Text {
                    id: amountSizeLabel
                    anchors.right: cardBorder.right
                    anchors.rightMargin: appHeight/72
                    anchors.top: cardBorder.top
                    anchors.topMargin: appHeight/72
                    text: name
                    font.pixelSize: appHeight/36
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Text {
                    property var totalBalance: balance
                    property int decimals: totalBalance <= 1 ? 8 : (totalBalance <= 1000 ? 4 : 2)
                    property var amountArray: (totalBalance.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountSizeLabel1
                    anchors.right: amountSizeLabel.left
                    anchors.rightMargin: 3
                    anchors.bottom: amountSizeLabel.bottom
                    text:  "." + amountArray[1]
                    font.pixelSize: appHeight/36
                    font.family:  xciteMobile.name
                    color: themecolor
                }

                Text {
                    property var totalBalance: balance
                    property int decimals: totalBalance <= 1 ? 8 : (totalBalance <= 1000 ? 4 : 2)
                    property var amountArray: (totalBalance.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountSizeLabel2
                    anchors.right: amountSizeLabel1.left
                    anchors.bottom: amountSizeLabel.bottom
                    text: amountArray[0]
                    font.pixelSize: appHeight/36
                    font.family:  xciteMobile.name
                    color: themecolor
                }

                Label {
                    id: unconfirmedTicker
                    text: name
                    anchors.right: amountSizeLabel.right
                    anchors.top: amountSizeLabel.bottom
                    anchors.topMargin: appHeight/54
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    color: themecolor
                    opacity: coinIndex < 3? 1 : 0.3
                }

                Label {
                    property int decimals: unconfirmedTx(name, address) === 0? 2 : (unconfirmedTx(name, address) <= 1 ? 8 : (unconfirmedTx(name, address) <= 1000 ? 4 : 2))
                    property string unconfirmedAmount: ((unconfirmedTx(name, address)).toLocaleString(Qt.locale("en_US"), "f", decimals))
                    property int updateTracker1: failedPendingTracker
                    property int updateTracker2: updatePendingTracker
                    property int newBalance: newBalanceTracker
                    id: unconfirmedTotal
                    text: unconfirmedAmount
                    anchors.right: unconfirmedTicker.left
                    anchors.bottom: unconfirmedTicker.bottom
                    anchors.rightMargin: 3
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    color: themecolor
                    opacity: coinIndex < 3? 1 : 0.3

                    onNewBalanceChanged: {
                        var unconfirmedDecimals = unconfirmedTx(name, address) === 0? 2 : (unconfirmedTx(name, address) <= 1 ? 8 : (unconfirmedTx(name, address) <= 1000 ? 4 : 2))
                        unconfirmedTotal.text = ((unconfirmedTx(name, address)).toLocaleString(Qt.locale("en_US"), "f", unconfirmedDecimals))
                    }

                    onUpdateTracker1Changed: {
                        if(updateTracker1 == 1) {
                            for (var e = 0; e < pendingList.count; e ++) {
                                if (pendingList.get(e).coin === name && pendingList.get(e).address === address && failedTX === pendingList.get(e).txid) {
                                    decimals = unconfirmedTx(name, address) === 0? 2 : (unconfirmedTx(name, address) <= 1 ? 8 : (unconfirmedTx(name, address) <= 1000 ? 4 : 2))
                                    unconfirmedTotal.text = ((unconfirmedTx(name, address)).toLocaleString(Qt.locale("en_US"), "f", decimals))
                                }
                            }
                        }
                    }

                    onUpdateTracker2Changed: {
                        if(updateTracker2 == 1) {
                            var i = pendingList.count
                            if (pendingList.get(i-1).coin === name && pendingList.get(i-1).address === address) {
                                decimals = unconfirmedTx(name, address) === 0? 2 : (unconfirmedTx(name, address) <= 1 ? 8 : (unconfirmedTx(name, address) <= 1000 ? 4 : 2))
                                unconfirmedTotal.text = ((unconfirmedTx(name, address)).toLocaleString(Qt.locale("en_US"), "f", decimals))
                            }
                        }
                    }
                }

                Label {
                    id: unconfirmedLabel
                    text: "unconfirmed outgoing TXs:"
                    anchors.right: unconfirmedTotal.left
                    anchors.top: unconfirmedTotal.top
                    anchors.rightMargin: appHeight/54
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    color: themecolor
                    opacity: coinIndex < 3? 1 : 0.3
                }

                Label {
                    id: unavailableTicker
                    text: name
                    anchors.right: unconfirmedTicker.right
                    anchors.top: unconfirmedTicker.bottom
                    anchors.topMargin: appHeight/72
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    color: themecolor
                    opacity: coinIndex < 3? 1 : 0.3
                }

                Label {
                    property int decimals: pendingCoins(name, address) === 0? 2 : (pendingCoins(name, address) <= 1 ? 8 : (pendingCoins(name, address) <= 1000 ? 4 : 2))
                    property string unavailableAmount: (pendingCoins(name, address).toLocaleString(Qt.locale("en_US"), "f", decimals))
                    property int updateTracker1: failedPendingTracker
                    property int updateTracker2: updatePendingTracker
                    property int newBalance: newBalanceTracker
                    id: unavailableTotal
                    text: unavailableAmount
                    anchors.right: unavailableTicker.left
                    anchors.bottom: unavailableTicker.bottom
                    anchors.rightMargin: 3
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    color: themecolor
                    opacity: coinIndex < 3? 1 : 0.3

                    onNewBalanceChanged: {
                        var pendingDecimals = pendingCoins(name, address) === 0? 2 : (pendingCoins(name, address) <= 1 ? 8 : (pendingCoins(name, address) <= 1000 ? 4 : 2))
                        unavailableTotal.text = (pendingCoins(name, address).toLocaleString(Qt.locale("en_US"), "f", pendingDecimals))
                    }

                    onUpdateTracker1Changed: {
                        if(updateTracker1 == 1) {
                            for (var e = 0; e < pendingList.count; e ++) {
                                if (pendingList.get(e).coin === name && pendingList.get(e).address === address && failedTX === pendingList.get(e).txid) {
                                    decimals = pendingCoins(name, address) === 0? 2 : (pendingCoins(name, address) <= 1 ? 8 : (pendingCoins(name, address) <= 1000 ? 4 : 2))
                                    unavailableTotal.text = ((pendingCoins(name, address)).toLocaleString(Qt.locale("en_US"), "f", decimals))
                                }
                            }
                        }
                    }

                    onUpdateTracker2Changed: {
                        if(updateTracker2 == 1) {
                            var i = pendingList.count
                            if (pendingList.get(i-1).coin === name && pendingList.get(i-1).address === address) {
                                decimals = pendingCoins(name, address) === 0? 2 : (pendingCoins(name, address) <= 1 ? 8 : (pendingCoins(name, address) <= 1000 ? 4 : 2))
                                unavailableTotal.text = (pendingCoins(name, address).toLocaleString(Qt.locale("en_US"), "f", decimals))
                            }
                        }
                    }
                }

                Label {
                    id: unavailableLabel
                    text: "unavailable coins:"
                    anchors.right: unavailableTotal.left
                    anchors.top: unavailableTotal.top
                    anchors.rightMargin: appHeight/54
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    color: themecolor
                    opacity: coinIndex < 3? 1 : 0.3
                }
            }
        }
    }

    SortFilterProxyModel {
        id: filteredWallets
        sourceModel: walletList
        filters: [
            RegExpFilter {
                roleName: "name"
                pattern: "^" + getName(coinIndex) + "$"
            },
            ValueFilter {
                roleName: "remove"
                value: false
            }

        ]
        sorters: RoleSorter { roleName: "balance" ; sortOrder: Qt.DescendingOrder }
    }

    ListView {
        id: allWallets
        model: filteredWallets
        delegate: walletCard
        anchors.fill: parent
        onDraggingChanged: detectInteraction()
    }
}
