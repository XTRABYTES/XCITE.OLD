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

import "qrc:/Controls" as Controls

Rectangle {
    id: allAddressCards
    width: Screen.width
    height: parent.height - 75
    color: "transparent"

    property alias cardSpacing: allAddresses.spacing
    property int favoriteNR: 0

    Component {
        id: addressCard

        Rectangle {
            id: addressRow
            width: Screen.width
            height: 140
            color: "transparent"
            anchors.horizontalCenter: Screen.horizontalCenter
            state: "big"
            clip: true

            Rectangle {
                id: cardBackground
                width: parent.width
                height: 140
                color: "transparent"
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                Controls.CardBody {

                }

                Image {
                    id: addressCoinLogo
                    source: logo
                    height: 30
                    width: 30
                    anchors.left: cardBackground.left
                    anchors.leftMargin: 28
                    anchors.top: cardBackground.top
                    anchors.topMargin: 10
                }

                Label {
                    id: addressCoinName
                    text: coin
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                    font.pixelSize: 20
                    font.family: "Brandon Grotesque"
                    font.letterSpacing: 2
                    font.bold: true
                    anchors.verticalCenter: addressCoinLogo.verticalCenter
                    anchors.left: addressCoinLogo.right
                    anchors.leftMargin: 7
                }

                Label {
                    id: addressName
                    text: label
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                    font.pixelSize: 20
                    font.family: "Brandon Grotesque"
                    font.letterSpacing: 2
                    font.bold: true
                    font.capitalization: Font.SmallCaps
                    anchors.bottom: addressCoinName.bottom
                    anchors.right: cardBackground.right
                    anchors.rightMargin: 28
                    anchors.left: addressCoinName.right
                    anchors.leftMargin: 30
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideRight
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
                    source: favorite == 1 ? 'qrc:/icons/mobile/favorite-icon_01_color.svg' : (darktheme === true? 'qrc:/icons/mobile/favorite-icon_01_light.svg' : 'qrc:/icons/mobile/favorite-icon_01_dark.svg')
                    width: 18
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: addressHash.verticalCenter
                    anchors.verticalCenterOffset: -2
                    anchors.horizontalCenter: addressCoinLogo.horizontalCenter
                    state: favorite == 1 ? "yes" : "no"

                    states: [
                        State {
                            name: "yes"
                            PropertyChanges { target: addressFavorite; width: 20}
                        },
                        State {
                            name: "no"
                            PropertyChanges { target: addressFavorite; width: 18}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "no"
                            to: "yes"
                            NumberAnimation { target: addressFavorite; properties: "width"; duration: 200; easing.type: Easing.OutBack}
                        },
                        Transition {
                            from: "yes"
                            to: "no"
                            NumberAnimation { target: addressFavorite; properties: "width"; duration: 200; easing.type: Easing.InBack}
                        }
                    ]
                }

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        detectInteraction()
                    }

                    onPressAndHold: {
                        addressIndex = uniqueNR
                        addressTracker = 1
                    }
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
                            selectedAddress = addressHash.text
                            selectedCoin = coin
                            walletIndex = defaultWallet(coin)
                            addressIndex = uniqueNR
                            switchState = 1
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
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    anchors.left: parent.left
                    anchors.leftMargin: 28
                    anchors.right: parent.horizontalCenter
                    anchors.rightMargin: 7
                    color: "transparent"
                    border.color: maincolor
                    border.width: 1
                    opacity: 0.5
                }

                Rectangle {
                    id: details
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
                            addressIndex = uniqueNR
                            addressQRTracker = 1
                        }
                    }
                }

                Label {
                    text: "QR CODE"
                    font.family: xciteMobile.name
                    font.pointSize: 14
                    font.bold: true
                    color: darktheme == true? "#F2F2F2" : maincolor
                    anchors.horizontalCenter: details.horizontalCenter
                    anchors.verticalCenter: details.verticalCenter
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
                    border.color: maincolor
                    border.width: 1
                    opacity: 0.5
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
        contentHeight: (filteredAddress.count * 85)
        interactive: appsTracker == 0 && addAddressTracker == 0 && addressTracker == 0 && transferTracker == 0
        onDraggingChanged: detectInteraction()
    }
}
