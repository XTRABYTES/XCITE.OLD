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

    property alias cardSpacing: allWallets.spacing

    Component {
        id: walletCard

        Rectangle {
            id: currencyRow
            color: "transparent"
            width: Screen.width
            height: 135
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: square
                width: parent.width - 55
                height: 125
                radius: 4
                color: "transparent"
                border.width: 2
                border.color: darktheme == false? "#42454F" : "#0ED8D2"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        cardShadow.verticalOffset = 0
                    }

                    onReleased: {
                        cardShadow.verticalOffset = 4
                    }


                    onPressAndHold: {
                        cardShadow.verticalOffset = 4
                        // edit wallet info
                    }
                }

                Image {
                    id: walletFavorite
                    source: 'qrc:/icons/icon-favorite.svg'
                    width: 18
                    height: 18
                    anchors.verticalCenter: walletName.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 14

                    ColorOverlay {
                        id: favoriteColor
                        anchors.fill: parent
                        source: parent
                        color: favorite == true ? "#FDBC40" : "#2A2C31"
                    }
                    state: favorite == true ? "yes" : "no"

                    states: [
                        State {
                            name: "yes"
                            PropertyChanges { target: favoriteColor; color: "#FDBC40"}
                            PropertyChanges { target: walletFavorite; width: 20}
                            PropertyChanges { target: walletFavorite; height: 20}
                        },
                        State {
                            name: "no"
                            PropertyChanges { target: favoriteColor; opacity: "#2A2C31"}
                            PropertyChanges { target: walletFavorite; width: 18}
                            PropertyChanges { target: walletFavorite; height: 18}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "no"
                            to: "yes"
                            PropertyAnimation { target: favoriteColor; property: "color"; duration: 200; easing.type: Easing.InOutCubic}
                            NumberAnimation { target: walletFavorite; properties: "width, height"; duration: 200; easing.type: Easing.OutBack}
                        },
                        Transition {
                            from: "yes"
                            to: "no"
                            PropertyAnimation { target: favoriteColor; property: "color"; duration: 200; easing.type: Easing.InOutCubic}
                            NumberAnimation { target: walletFavorite; properties: "width, height"; duration: 200; easing.type: Easing.InBack}
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
                        onClicked: {
                            if (favorite == true) {
                                walletList.setProperty(walletNR, "favorite", false)
                            }
                            else {
                                resetFavorites(name)
                                walletList.setProperty(walletNR, "favorite", true)
                            }
                        }
                    }
                }

                Text {
                    id: walletName
                    anchors.left: parent.left
                    anchors.leftMargin: 40
                    anchors.verticalCenter: amountSizeLabel.verticalCenter
                    text: label
                    font.pixelSize: 18
                    font.family: xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                    font.bold: true
                }

                Text {
                    id: amountSizeLabel
                    anchors.right: parent.right
                    anchors.rightMargin: 14
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    text: name
                    font.pixelSize: 18
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
                    font.pixelSize: 14
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
                    font.pixelSize: 18
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
                    property int decimals: unconfirmedCoins <= 1 ? 8 : (unconfirmedCoins <= 1000 ? 4 : 2)
                    property var unconfirmedArray: (unconfirmedCoins.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: unconfirmedTotal1
                    text: "." + unconfirmedArray[1]
                    anchors.right: unconfirmedTicker.left
                    anchors.bottom: unconfirmedTicker.bottom
                    anchors.rightMargin: 3
                    font.pixelSize: 12
                    font.family: xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Label {
                    property int decimals: unconfirmedCoins <= 1 ? 8 : (unconfirmedCoins <= 1000 ? 4 : 2)
                    property var unconfirmedArray: (unconfirmedCoins.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: unconfirmedTotal2
                    text: unconfirmedArray[0]
                    anchors.right: unconfirmedTotal1.left
                    anchors.top: unconfirmedTotal1.top
                    font.pixelSize: 12
                    font.family: xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Label {
                    id: unconfirmedLabel
                    text: "Unconfirmed:"
                    anchors.right: parent.right
                    anchors.top: unconfirmedTotal2.top
                    anchors.rightMargin: 135
                    font.pixelSize: 12
                    font.family: xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Rectangle {
                    id: transfer
                    height: 34
                    width: (parent.width - 38) / 2
                    radius: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 14
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    color: "transparent"
                    border.color: darktheme == false? "#42454F" : "#0ED8D2"
                    border.width: 2

                    Label {
                        text: "TRANSFER"
                        font.family: xciteMobile.name //"Brandon Grotesque"
                        font.pointSize: 14
                        font.bold: true
                        color: darktheme == false? "#0ED8D2" : "#F2F2F2"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            transfer.color = maincolor
                        }

                        onReleased: {
                            transfer.color = "transparent"
                        }

                        onCanceled: {
                            transfer.color = "transparent"
                        }

                        onClicked: {
                            walletIndex = walletNR
                            switchState = 0
                            transferTracker = 1
                        }
                    }
                }

                Rectangle {
                    id: history
                    height: 34
                    width: (parent.width - 38) / 2
                    radius: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 14
                    anchors.right: parent.right
                    anchors.rightMargin: 14
                    color: "transparent"
                    border.color: darktheme == false? "#42454F" : "#0ED8D2"
                    border.width: 2

                    Label {
                        text: "HISTORY"
                        font.family: xciteMobile.name //"Brandon Grotesque"
                        font.pointSize: 14
                        font.bold: true
                        color: darktheme == false? "#0ED8D2" : "#F2F2F2"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            history.color = maincolor
                        }

                        onReleased: {
                            history.color = "transparent"
                        }

                        onCanceled: {
                            history.color = "transparent"
                        }

                        onClicked: {
                            walletIndex = walletNR
                            historyTracker = 1
                        }
                    }
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
                pattern: getName(coinIndex)
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
        contentHeight: (filteredWallets.count  * 135) + 75
        interactive: appsTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0 && transferTracker == 0
    }
}

