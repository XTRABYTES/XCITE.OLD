/**
 * Filename: WalletDetailList.qml
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
    height: parent.height - 25

    color: "transparent"

    Component {
        id: walletCard

        Rectangle {
            id: currencyRow
            color: "transparent"
            width: Screen.width
            height: 80
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true

            Rectangle {
                id: square
                width: parent.width
                height: 80
                radius: 4
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top

                Controls.CardBody {

                }

                Rectangle {
                    id: clickIndicator
                    anchors.fill: parent
                    color: maincolor
                    opacity: 0.25
                    visible: false

                    Connections {
                        target: allWallets
                        onMovementEnded: {
                            clickIndicator.visible = false
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        clickIndicator.visible = true
                        detectInteraction()
                    }

                    onReleased: {
                        clickIndicator.visible = false
                    }

                    onCanceled: {
                        clickIndicator.visible = false
                    }

                    onClicked: {
                        walletIndex = walletNR
                        screenshotTracker = 1
                    }
                }

                Image {
                    id: coinLogo
                    source: getLogo(name)
                    height: 30
                    width: 30
                    anchors.left: parent.left
                    anchors.leftMargin: 28
                    anchors.top: parent.top
                    anchors.topMargin: 10
                }

                Label {
                    id: coinName
                    anchors.left: coinLogo.right
                    anchors.leftMargin: 7
                    anchors.verticalCenter: coinLogo.verticalCenter
                    text: name
                    font.pixelSize: 20
                    font.family: "Brandon Grotesque"
                    font.letterSpacing: 2
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                    font.bold: true
                }

                Label {
                    id: walletName
                    anchors.right: parent.right
                    anchors.rightMargin: 28
                    anchors.left: coinName.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: coinLogo.verticalCenter
                    text: label
                    font.pixelSize: 20
                    font.family: "Brandon Grotesque"
                    font.letterSpacing: 2
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                    font.bold: true
                    elide: Text.ElideRight
                }

                Label {
                    id: addressLabel
                    anchors.right: parent.right
                    anchors.rightMargin: 28
                    anchors.left: parent.left
                    anchors.leftMargin: 28
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    text: address
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    font.letterSpacing: 2
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                    elide: Text.ElideRight
                }
            }
        }
    }

    SortFilterProxyModel {
        id: filteredWallets
        sourceModel: walletList
        filters: [
            ValueFilter {
                roleName: "remove"
                value: false
            },
            ValueFilter {
                roleName: "viewOnly"
                value: false
            }

        ]
        sorters: [
            StringSorter { roleName: "name" },
            StringSorter { roleName: "label" }
        ]
    }

    ListView {
        id: allWallets
        model: filteredWallets
        delegate: walletCard
        spacing: 0
        anchors.fill: parent
        contentHeight: (filteredWallets.count  * 80)
        onDraggingChanged: detectInteraction()
    }
}
