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

Rectangle {
    id: allAddressCards
    width: Screen.width
    height: parent.height
    color: "transparent"

    property string searchFilter: ""
    property int favoriteNR: 0

    Component {
        id: addressCard

        Rectangle {
            id: addressRow
            width: Screen.width
            height: 85
            color: "transparent"
            anchors.horizontalCenter: Screen.horizontalCenter

            DropShadow {
                anchors.fill: cardBackground
                source: cardBackground
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color:"#2A2C31"
                transparentBorder: true
            }

            Rectangle {
                id: cardBackground
                width: parent.width - 55
                height: 75
                radius: 4
                color: "#42454F"
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                Image {
                    id: addressCoinLogo
                    source: logo
                    height: 22
                    width: 22
                    anchors.right: cardBackground.right
                    anchors.rightMargin: 14
                    anchors.top: cardBackground.top
                    anchors.topMargin: 10
                }

                Label {
                    id: addressCoinName
                    text: coin
                    color: "#F2F2F2"
                    font.pixelSize: 16
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    anchors.verticalCenter: addressCoinLogo.verticalCenter
                    anchors.right: addressCoinLogo.left
                    anchors.rightMargin: 7
                }

                Label {
                    id: addressName
                    text: name
                    color: "#F2F2F2"
                    font.pixelSize: 16
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    anchors.verticalCenter: addressCoinLogo.verticalCenter
                    anchors.left: cardBackground.left
                    anchors.leftMargin: 14
                }

                Text {
                    id: addressHash
                    text: address
                    color: "#F2F2F2"
                    font.pixelSize: 13
                    font.family: "Brandon Grotesque"
                    font.weight: Font.Light
                    anchors.bottom: cardBackground.bottom
                    anchors.bottomMargin: 10
                    anchors.left: addressName.left
                    anchors.leftMargin: 21
                    anchors.right: addressCoinLogo.right
                    elide: Text.ElideRight
                }

                Image {
                    id: addressFavorite
                    source: 'qrc:/icons/icon-favorite.svg'
                    width: 18
                    height: 18
                    anchors.verticalCenter: addressHash.verticalCenter
                    anchors.verticalCenterOffset: -2
                    anchors.right: addressHash.left
                    anchors.rightMargin: 7

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: favorite == 1 ? "#FDBC40" : "#2A2C31"
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (appsTracker == 0 && addAddressTracker == 0 && addressTracker == 0 && transferTracker == 0) {
                            addressTracker = 1
                            addressIndex = uniqueNR
                            //selectedAddress = ""
                            if (coin === currencyList.get(0).name) {
                                currencyIndex = 0
                            }
                            if (coin === currencyList.get(1).name) {
                                currencyIndex = 1
                            }
                            if (coin === currencyList.get(2).name) {
                                currencyIndex = 2
                            }
                            if (coin === currencyList.get(3).name) {
                                currencyIndex = 3
                            }
                        }
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
            }
        }
    }

    SortFilterProxyModel {
        id: filteredAddress
        sourceModel: addressList
        filters: [
            ValueFilter {
                    roleName: "active"
                    value: true
            },
            AnyOf {
                RegExpFilter {
                    roleName: "name"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
                RegExpFilter {
                    roleName: "address"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
                RegExpFilter {
                    roleName: "coin"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
            }
        ]
        sorters: [
            RoleSorter { roleName: "favorite"; sortOrder: Qt.DescendingOrder },
            StringSorter { roleName: "name" },
            StringSorter { roleName: "coin" },
            StringSorter { roleName: "address" }
        ]
    }

    ListView {
        anchors.fill: parent
        id: allAddresses
        model: filteredAddress
        delegate: addressCard
        contentHeight: (totalAddresses * 80)
        interactive: appsTracker == 0 && addAddressTracker == 0 && addressTracker == 0 && transferTracker == 0
    }
}
