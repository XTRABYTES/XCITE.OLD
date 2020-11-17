/**
 * Filename: WalletListSmall.qml
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

    property int walletCount: filteredWallets.count
    property bool onlyView: false
    property bool onlyViewActive: false
    property string coinFilter: ""
    property int availableWallets: filteredWallets.count

    Component {
        id: walletCard

        Rectangle {
            id: currencyRow
            color: "transparent"
            width: allWalletCards.width
            height: appHeight/15
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: square
                width: parent.width
                height: parent.height
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                clip: true

                property int decimals: balance == 0? 2 : (balance <= 1000? 8 : (balance <= 1000000? 4 : 2))

                Rectangle {
                    id: selectionIndicator
                    width: parent.width
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    color: maincolor
                    opacity: 0.3
                    visible: false
                }

                Rectangle {
                    id: cardBorder
                    width: parent.width*0.95
                    height: 1
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: themecolor
                    border.width: 1
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
                        walletListTracker = 0
                    }
                }

                Image {
                    id: coinLogo
                    source: getLogo(name)
                    height: square.height/2
                    fillMode: Image.PreserveAspectFit
                    anchors.left: parent.left
                    anchors.leftMargin: height/2
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    id: coinName
                    anchors.left: coinLogo.right
                    anchors.leftMargin: coinLogo.height/2
                    anchors.verticalCenter: parent.verticalCenter
                    text: name
                    font.capitalization: Font.AllUppercase
                    font.pixelSize: square.height/3
                    font.family: xciteMobile.name
                    font.letterSpacing: 2
                    color: themecolor
                }

                Text {
                    id: walletName
                    anchors.left: coinName.right
                    anchors.leftMargin: font.pixelSize
                    anchors.right: parent.right
                    anchors.rightMargin: font.pixelSize*2
                    anchors.verticalCenter: parent.verticalCenter
                    text: label
                    font.capitalization: Font.AllUppercase
                    font.pixelSize: square.height/3
                    font.family: xciteMobile.name
                    color: themecolor
                    elide: Text.ElideRight
                }

                Text {
                    id: walletBalance
                    anchors.right: parent.right
                    anchors.rightMargin: walletName.anchors.rightMargin
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: font.pixelSize/2
                    text: balance.toLocaleString(Qt.locale("en_US"), "f", decimals)
                    font.pixelSize: square.height/4
                    font.family: xciteMobile.name
                    color: themecolor
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
                pattern: "^" + coinFilter + "$"
            },
            ValueFilter {
                roleName: "remove"
                value: false
            },
            ValueFilter {
                roleName: "viewOnly"
                value: onlyView
                enabled: onlyViewActive
            }

        ]
        sorters: [
            RoleSorter { roleName: "balance" ; sortOrder: Qt.DescendingOrder },
            RoleSorter { roleName: "label" ; sortOrder: Qt.AscendingOrder }
        ]
    }

    ListView {
        id: allWallets
        model: filteredWallets
        delegate: walletCard
        anchors.fill: parent
        onDraggingChanged: detectInteraction()
    }
}
