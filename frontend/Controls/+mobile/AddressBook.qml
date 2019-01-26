/**
 * Filename: AddressBook.qml
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
import QtGraphicalEffects 1.0
import SortFilterProxyModel 0.2
import QtQuick.Window 2.2
import QtMultimedia 5.8

Rectangle {
    id: allAddressCards
    width: Screen.width
    height: parent.height
    color: "transparent"

    property alias cardSpacing: allAddresses.spacing
    property int favoriteNR: 0

    Component {
        id: addressCard

        Rectangle {
            id: addressRow
            width: Screen.width
            height: 135
            color: "transparent"
            anchors.horizontalCenter: Screen.horizontalCenter

            Rectangle {
                id: cardBackground
                width: parent.width - 55
                height: 125
                radius: 4
                color: darktheme == false? "#F2F2F2" : "#1B2934"
                border.width: 1
                border.color: darktheme == false? "#42454F" : "transparent"
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                Image {
                    id: addressCoinLogo
                    source: logo
                    height: 22
                    width: 22
                    anchors.left: cardBackground.left
                    anchors.leftMargin: 14
                    anchors.top: cardBackground.top
                    anchors.topMargin: 10
                }

                Label {
                    id: addressCoinName
                    text: coin
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                    font.pixelSize: 16
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    anchors.verticalCenter: addressCoinLogo.verticalCenter
                    anchors.left: addressCoinLogo.right
                    anchors.leftMargin: 7
                }

                Label {
                    id: addressName
                    text: label
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                    font.pixelSize: 16
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    anchors.verticalCenter: addressCoinLogo.verticalCenter
                    anchors.right: cardBackground.right
                    anchors.rightMargin: 14
                }

                Text {
                    id: addressHash
                    text: address
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                    font.pixelSize: 13
                    font.family: "Brandon Grotesque"
                    font.weight: Font.Light
                    anchors.bottom: transfer.top
                    anchors.bottomMargin: 15
                    anchors.left: addressCoinName.left
                    anchors.right: addressName.right
                    elide: Text.ElideRight
                }

                Image {
                    id: addressFavorite
                    source: 'qrc:/icons/icon-favorite.svg'
                    width: 18
                    height: 18
                    anchors.verticalCenter: addressHash.verticalCenter
                    anchors.verticalCenterOffset: -2
                    anchors.horizontalCenter: addressCoinLogo.horizontalCenter


                    ColorOverlay {
                        id: favoriteColor
                        anchors.fill: parent
                        source: parent
                        color: favorite == 1 ? "#FDBC40" : "#2A2C31"
                    }
                    state: favorite == 1 ? "yes" : "no"

                    states: [
                        State {
                            name: "yes"
                            PropertyChanges { target: favoriteColor; color: "#FDBC40"}
                            PropertyChanges { target: addressFavorite; width: 20}
                            PropertyChanges { target: addressFavorite; height: 20}
                        },
                        State {
                            name: "no"
                            PropertyChanges { target: favoriteColor; opacity: "#2A2C31"}
                            PropertyChanges { target: addressFavorite; width: 18}
                            PropertyChanges { target: addressFavorite; height: 18}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "no"
                            to: "yes"
                            PropertyAnimation { target: favoriteColor; property: "color"; duration: 200; easing.type: Easing.InOutCubic}
                            NumberAnimation { target: addressFavorite; properties: "width, height"; duration: 200; easing.type: Easing.OutBack}
                        },
                        Transition {
                            from: "yes"
                            to: "no"
                            PropertyAnimation { target: favoriteColor; property: "color"; duration: 200; easing.type: Easing.InOutCubic}
                            NumberAnimation { target: addressFavorite; properties: "width, height"; duration: 200; easing.type: Easing.InBack}
                        }
                    ]
                }

                MouseArea {
                    anchors.fill: parent

                   onPressed: {
                        click01.play()
                    }

                    onPressAndHold: {
                        addressIndex = uniqueNR
                        addressTracker = 1
                    }
                }

                Rectangle {
                    id: favoriteButton
                    width: 28
                    height: 28
                    anchors.verticalCenter: addressFavorite.verticalCenter
                    anchors.horizontalCenter: addressFavorite.horizontalCenter
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (appsTracker == 0 && addAddressTracker == 0 && addressTracker == 0 && transferTracker == 0) {
                                if (favorite == 1) {
                                    addressList.setProperty(uniqueNR, "favorite", 0)
                                }
                                else {
                                    addressList.setProperty(uniqueNR, "favorite", 1)
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    id: transfer
                    height: 34
                    width: (parent.width - 38) / 2
                    radius: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 14
                    anchors.left: addressCoinLogo.left
                    color: "transparent"
                    border.color: darktheme == false? "#42454F" : "#0ED8D2"
                    border.width: 2

                    Label {
                        text: "TRANSFER"
                        font.family: xciteMobile.name
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
                            click01.play()
                        }

                        onReleased: {
                            transfer.color = "transparent"
                        }

                        onCanceled: {
                            transfer.color = "transparent"
                        }

                        onClicked: {
                            selectedAddress = addressHash.text
                            walletIndex = defaultWallet(coin)
                            addressIndex = uniqueNR
                            switchState = 1
                            transferTracker = 1
                        }
                    }
                }

                Rectangle {
                    id: details
                    height: 34
                    width: (parent.width - 38) / 2
                    radius: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 14
                    anchors.right: addressName.right
                    color: "transparent"
                    border.color: darktheme == false? "#42454F" : "#0ED8D2"
                    border.width: 2

                    Label {
                        text: "QR CODE"
                        font.family: xciteMobile.name
                        font.pointSize: 14
                        font.bold: true
                        color: darktheme == false? "#0ED8D2" : "#F2F2F2"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            details.color = maincolor
                        }

                        onReleased: {
                            details.color = "transparent"
                        }

                        onCanceled: {
                            details.color = "transparent"
                        }

                        onClicked: {
                            addressIndex = uniqueNR
                            addressQRTracker = 1
                        }
                    }
                }
            }
        }
    }

    SortFilterProxyModel {
        id: filteredAddress
        sourceModel: addressList
        filters: [
            ValueFilter {
                roleName: "contact"
                value: contactIndex
            },

            ValueFilter {
                    roleName: "active"
                    value: true
            },
            ValueFilter {
                roleName: "remove"
                value: false
            }
        ]
        sorters: [
            RoleSorter { roleName: "favorite"; sortOrder: Qt.DescendingOrder },
            StringSorter { roleName: "coin" },
            StringSorter { roleName: "label" }
        ]
    }

    ListView {
        anchors.fill: parent
        id: allAddresses
        model: filteredAddress
        delegate: addressCard
        spacing: 0
        contentHeight: (filteredAddress.count * 85) + 75
        interactive: appsTracker == 0 && addAddressTracker == 0 && addressTracker == 0 && transferTracker == 0
    }
}
