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

Rectangle {
    id: allWalletCards
    width: Screen.width
    height: parent.height - 75

    color: "transparent"

    property alias cardSpacing: allWallets.spacing

    Component {
        id: walletCard

        Rectangle {
            id: currencyRow
            color: "transparent"
            width: Screen.width
            height: 140
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true

            Rectangle {
                id: square
                width: parent.width
                height: 140
                radius: 4
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top

                Controls.CardBody {

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
                    property int decimals: balance <= 1 ? 8 : (balance <= 1000 ? 4 : 2)
                    property var amountArray: (balance.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
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
                    property int decimals: balance <= 1 ? 8 : (balance <= 1000 ? 4 : 2)
                    property var amountArray: (balance.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountSizeLabel2
                    anchors.right: amountSizeLabel1.left
                    anchors.verticalCenter: walletName.verticalCenter
                    text: amountArray[0]
                    font.pixelSize: 20
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Label {
                    id: pendingTicker
                    text: name
                    anchors.right: amountSizeLabel.right
                    anchors.top: amountSizeLabel.bottom
                    anchors.topMargin: 2
                    font.pixelSize: 12
                    font.family: xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Label {
                    property int decimals: pendingCoins(name, address) === 0? 2 : (pendingCoins(name, address) <= 1 ? 8 : (pendingCoins(name, address) <= 1000 ? 4 : 2))
                    property string pendingAmount: ((pendingCoins(name, address)).toLocaleString(Qt.locale("en_US"), "f", decimals))
                    id: pendingTotal
                    text: pendingAmount
                    anchors.right: pendingTicker.left
                    anchors.bottom: pendingTicker.bottom
                    anchors.rightMargin: 3
                    font.pixelSize: 12
                    font.family: xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Label {
                    id: pendingLabel
                    text: "Pending:"
                    anchors.right: pendingTotal.left
                    anchors.top: pendingTotal.top
                    anchors.rightMargin: 7
                    font.pixelSize: 12
                    font.family: xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Label {
                    id: viewOnlyLabel
                    text: " VIEW ONLY"
                    anchors.left: transfer.left
                    anchors.bottom:  pendingLabel.bottom
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
                                walletIndex = walletNR
                                transactionPages = 0
                                currentPage = 1
                                updateTransactions(name, address, 1)
                            }
                        }
                    }

                    Connections {
                        target: explorer

                        onUpdateTransactions: {
                            if (historyTracker === 0) {
                                transactionPages = totalPages;
                                loadTransactions(transactions);
                                historyTracker = 1
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

