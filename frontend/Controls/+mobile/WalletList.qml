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
    width: appWidth
    height: parent.height - 75

    color: "transparent"

    property alias cardSpacing: allWallets.spacing

    Component {
        id: walletCard

        Rectangle {
            id: currencyRow
            color: "transparent"
            width: appWidth
            height: 156
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true

            Rectangle {
                id: square
                width: parent.width
                height: 156
                radius: 4
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top

                Mobile.CardBody {

                }

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        detectInteraction()
                    }

                    onReleased: {
                    }

                    onPressAndHold: {
                        walletIndex = walletNR
                        walletDetailTracker = 1
                    }
                }

                Image {
                    id: walletFavorite
                    source: favorite == true ? 'qrc:/icons/mobile/favorite-icon_01_color.svg' : (darktheme === true? 'qrc:/icons/mobile/favorite-icon_01_light.svg' : 'qrc:/icons/mobile/favorite-icon_01_dark.svg')
                    width: 18
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: walletName.verticalCenter
                    anchors.verticalCenterOffset: -2
                    anchors.left: parent.left
                    anchors.leftMargin: 28
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
                    width: 30
                    height: 30
                    anchors.verticalCenter: walletFavorite.verticalCenter
                    anchors.horizontalCenter: walletFavorite.horizontalCenter
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
                    anchors.leftMargin: 54
                    anchors.right: amountSizeLabel2.left
                    anchors.rightMargin: 10
                    anchors.verticalCenter: amountSizeLabel.verticalCenter
                    text: label
                    font.pixelSize: 20
                    font.family: xciteMobile.name
                    font.letterSpacing: 2
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                    font.bold: true
                    elide: Text.ElideRight
                }

                Text {
                    id: amountSizeLabel
                    anchors.right: parent.right
                    anchors.rightMargin: 28
                    anchors.top: parent.top
                    anchors.topMargin: 15
                    text: name
                    font.pixelSize: 20
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
                    anchors.bottomMargin: 1
                    text:  "." + amountArray[1]
                    font.pixelSize: 16
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Text {
                    property var totalBalance: balance
                    property int decimals: totalBalance <= 1 ? 8 : (totalBalance <= 1000 ? 4 : 2)
                    property var amountArray: (totalBalance.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountSizeLabel2
                    anchors.right: amountSizeLabel1.left
                    anchors.verticalCenter: walletName.verticalCenter
                    text: amountArray[0]
                    font.pixelSize: 20
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Label {
                    id: unconfirmedTicker
                    text: name
                    anchors.right: amountSizeLabel.right
                    anchors.top: amountSizeLabel.bottom
                    anchors.topMargin: 2
                    font.pixelSize: 12
                    font.family: xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
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
                    font.pixelSize: 12
                    font.family: xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"

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
                    anchors.rightMargin: 7
                    font.pixelSize: 12
                    font.family: xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Label {
                    id: unavailableTicker
                    text: name
                    anchors.right: unconfirmedTicker.right
                    anchors.top: unconfirmedTicker.bottom
                    anchors.topMargin: 2
                    font.pixelSize: 12
                    font.family: xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
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
                    font.pixelSize: 12
                    font.family: xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"

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
                    anchors.rightMargin: 7
                    font.pixelSize: 12
                    font.family: xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Label {
                    id: viewOnlyLabel
                    text: " VIEW ONLY"
                    anchors.left: transfer.left
                    anchors.bottom:  unavailableLabel.bottom
                    anchors.bottomMargin: -5
                    font.pixelSize: 14
                    font.family: xciteMobile.name
                    font.letterSpacing: 2
                    font.bold: true
                    color: "#E55541"
                    visible: viewOnly
                }

                Rectangle {
                    id: transfer
                    height: 34
                    anchors.left: parent.left
                    anchors.leftMargin: 28
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    anchors.right: parent.horizontalCenter
                    anchors.rightMargin: 7
                    color: darktheme == true? "#14161B" : "#F2F2F2"
                    opacity: 0.5

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onReleased: {
                        }

                        onCanceled: {
                        }

                        onClicked: {
                            walletIndex = walletNR
                            switchState = 0
                            transferTracker = 1
                        }
                    }
                }

                Label {
                    text: "TRANSFER"
                    font.family: xciteMobile.name
                    font.pointSize: 14
                    font.bold: true
                    color: darktheme == true? "#F2F2F2" : maincolor
                    anchors.horizontalCenter: transfer.horizontalCenter
                    anchors.verticalCenter: transfer.verticalCenter
                }

                Rectangle {
                    height: 34
                    anchors.left: parent.left
                    anchors.leftMargin: 28
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    anchors.right: parent.horizontalCenter
                    anchors.rightMargin: 7
                    color: "transparent"
                    opacity: 0.5
                    border.color: maincolor
                    border.width: 1
                }

                Rectangle {
                    id: history
                    height: 34
                    anchors.right: parent.right
                    anchors.rightMargin: 28
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 7
                    color: darktheme == true? "#14161B" : "#F2F2F2"
                    opacity: 0.5

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onReleased: {
                        }

                        onCanceled: {
                        }

                        onClicked: {
                            if (coinIndex < 3){
                                historyDetailsCollected = false
                                walletIndex = walletNR
                                transactionPages = 0
                                currentPage = 1
                                historyTracker = 1
                                updateTransactions(name, address, 1)
                            }
                        }
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

                Label {
                    text: "HISTORY"
                    font.family: xciteMobile.name
                    font.pointSize: 14
                    font.bold: true
                    color: coinIndex < 3? (darktheme == true? "#F2F2F2" : maincolor) : "#979797"
                    anchors.horizontalCenter: history.horizontalCenter
                    anchors.verticalCenter: history.verticalCenter
                }

                Rectangle {
                    height: 34
                    anchors.right: parent.right
                    anchors.rightMargin: 28
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 7
                    color: "transparent"
                    opacity: 0.5
                    border.color: coinIndex < 3? maincolor : "#979797"
                    border.width: 1
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
        spacing: 0
        anchors.fill: parent
        contentHeight: (filteredWallets.count  * 140)
        interactive: appsTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0 && transferTracker == 0
        onDraggingChanged: detectInteraction()
    }
}

