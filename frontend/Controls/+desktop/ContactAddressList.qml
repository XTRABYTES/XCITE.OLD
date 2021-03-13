/**
 * Filename: ContactAddressList.qml
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
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: allAddressCards
    width: parent.width
    height: parent.height
    anchors.top: parent.top
    color: "transparent"

    property int favoriteNR: 0

    Component {
        id: addressCard

        Rectangle {
            id: addressRow
            width: allAddressCards.width
            height: appHeight/9
            color: "transparent"
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
                    width: parent.width - 5
                    height: parent.height*0.8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    color: maincolor
                    opacity: 0.3
                    visible: false
                }

                Rectangle {
                    id: cardBorder
                    width: parent.width - 5
                    height: parent.height*0.8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    color: "transparent"
                    border.width: 0.5
                    border.color: themecolor
                    opacity: 0.1
                }

                Rectangle {
                    width: parent.width
                    height: parent.height*0.8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    color: "transparent"

                    Image {
                        id: addressCoinLogo
                        source: logo
                        height: parent.height*2/3
                        fillMode: Image.PreserveAspectFit
                        anchors.left: parent.left
                        anchors.leftMargin: appWidth/48
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.topMargin: 10
                    }

                    Label {
                        id: addressCoinName
                        text: coin + " - " + label
                        color: themecolor
                        font.pixelSize: parent.height/3
                        font.family: xciteMobile.name
                        font.letterSpacing: 2
                        anchors.top: parent.top
                        anchors.topMargin: parent.height/6
                        anchors.left: addressCoinLogo.right
                        anchors.right: transferBtnArea.left
                        leftPadding: parent.height/3
                        rightPadding: parent.height/3
                        elide: Text.ElideRight
                    }

                    Text {
                        id: addressHash
                        text: address
                        color: themecolor
                        font.pixelSize: parent.height/4
                        font.family: xciteMobile.name
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: parent.height/6
                        anchors.left: addressCoinName.left
                        anchors.right: transferBtnArea.left
                        leftPadding: parent.height/3
                        rightPadding: parent.height/3
                        elide: Text.ElideRight
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        enabled: editContactTracker == 0 && editName == 0

                        onEntered: {
                            selectionIndicator.visible = true
                        }

                        onExited: {
                            selectionIndicator.visible = false
                        }

                        onPressed: {
                            detectInteraction()
                            click01.play()
                        }

                        onClicked: {
                            addressIndex = uniqueNR
                            addressTracker = 1
                        }
                    }

                    Item {
                        id: transferBtnArea
                        height: parent.height
                        width: appWidth/6 * 0.5
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.rightMargin: appHeight/72

                        Rectangle {
                            id: transfer
                            height: parent.height/2*0.6
                            width: parent.width
                            radius: height/2
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "transparent"
                            border.color: themecolor
                            border.width: 1
                            opacity: (coin == "XBY" || coin == "XFUEL" || coin == "XTEST")? 1 : 0.3

                            Rectangle {
                                id: selectTransfer
                                anchors.fill: parent
                                radius: height/2
                                color: maincolor
                                opacity: 0.3
                                visible: false
                            }

                            Label {
                                text: "TRANSFER"
                                font.family: xciteMobile.name
                                font.pointSize: transfer.height/2
                                color: themecolor
                                anchors.horizontalCenter: transfer.horizontalCenter
                                anchors.verticalCenter: transfer.verticalCenter
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                enabled: coin == "XBY" || coin == "XFUEL" || coin == "XTEST"

                                onEntered: {
                                    selectTransfer.visible = true
                                }

                                onExited: {
                                    selectTransfer.visible = false
                                }

                                onPressed: {
                                    click01.play()
                                    detectInteraction()
                                }

                                onClicked: {
                                    selectedCoin = coin
                                    selectedAddress = address
                                    coinIndex = getCoinID(selectedCoin)
                                    addressIndex = uniqueNR
                                    walletIndex = -1
                                    transferTracker = 1
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
        id: allAddresses
        anchors.fill: parent
        model: filteredAddress
        delegate: addressCard
        onDraggingChanged: detectInteraction()
        contentHeight: filteredAddress.count * appHeight/9

        ScrollBar.vertical: ScrollBar {
            parent: allAddresses.parent
            anchors.top: allAddresses.top
            anchors.right: allAddresses.right
            anchors.bottom: allAddresses.bottom
            width: 5
            opacity: 1
            policy: allAddresses.contentHeight > allAddressCards.height? ScrollBar.AsNeeded : ScrollBar.AlwaysOff

            contentItem: Rectangle {
                implicitWidth: 5
                implicitHeight: appWidth/24
                color: maincolor
            }
        }
    }
}
