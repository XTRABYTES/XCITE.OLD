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
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: allWalletCards
    width: parent.width - appWidth/12
    height: parent.height

    color: "transparent"

    Component {
        id: walletCard

        Item {
            width: grid.cellWidth
            height: grid.cellHeight

            Rectangle {
                id: currencyRow
                color: "transparent"
                width: allWalletCards.width
                height: appHeight/12
                anchors.horizontalCenter: parent.horizontalCenter
            }

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
                    width: parent.width - appWidth/24 - 5
                    height: parent.height*0.8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: appWidth/24
                    color: maincolor
                    opacity: 0.3
                    visible: false
                }

                Rectangle {
                    width: parent.width - appWidth/24 - 5
                    height: parent.height*0.8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: appWidth/24
                    color: "transparent"
                    border.width: 0.5
                    border.color: themecolor
                    opacity: 0.1
                }

                Rectangle {
                    width: parent.width - appWidth/12
                    height: parent.height*0.8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: appWidth/24
                    color: "transparent"

                    Image {
                        id: icon
                        source: getLogo(name)
                        anchors.left: parent.left
                        anchors.leftMargin: appWidth/48
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height*2/3
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: coinName
                        text: name
                        anchors.left: icon.right
                        anchors.leftMargin: appWidth/96
                        anchors.top: parent.top
                        anchors.topMargin: parent.height/6
                        font.pixelSize: parent.height/3
                        font.family: xciteMobile.name
                        font.bold: true
                        color: themecolor
                    }

                    Label {
                        id: walletName
                        anchors.right: parent.right
                        anchors.rightMargin: appWidth/96
                        anchors.left: coinName.right
                        anchors.leftMargin: appWidth/96
                        anchors.top: parent.top
                        anchors.topMargin: parent.height/6
                        text: label
                        font.pixelSize: parent.height/3
                        font.family: xciteMobile.name
                        font.bold: true
                        color: themecolor
                        elide: Text.ElideRight
                    }

                    Label {
                        id: addressLabel
                        text: address
                        anchors.right: parent.right
                        anchors.rightMargin: appWidth/96
                        anchors.left: coinName.left
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: parent.height/6
                        font.pixelSize: parent.height/3 *0.8
                        font.family: xciteMobile.name
                        color: themecolor
                        elide: Text.ElideRight
                    }
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

                    onClicked: {
                        walletIndex = walletNR
                        screenshotTracker = 1
                    }
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

    GridView {
        id: grid
        width: parent.width
        height: parent.height
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        cellWidth: parent.width/2
        cellHeight: appHeight/9

        model: filteredWallets
        delegate: walletCard
        contentHeight: filteredWallets.count * appHeight/9

        ScrollBar.vertical: ScrollBar {
            parent: grid.parent
            anchors.top: grid.top
            anchors.right: grid.right
            anchors.bottom: grid.bottom
            width: 5
            opacity: 1
            policy: grid.contentHeight > allWalletCards.height? ScrollBar.AsNeeded : ScrollBar.AlwaysOff

            contentItem: Rectangle {
                implicitWidth: 5
                implicitHeight: appWidth/24
                color: maincolor
            }
        }
    }
}
