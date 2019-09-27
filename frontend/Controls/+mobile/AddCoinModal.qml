/**
 * Filename: AddCoinModal.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

import QtQuick.Controls 2.3
import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import SortFilterProxyModel 0.2

import "qrc:/Controls" as Controls

Rectangle {
    id: addCoinModal
    width: parent.width
    height: parent.height - 180
    color: "transparent"
    anchors.top: parent.top
    anchors.topMargin: 180
    anchors.right: parent.right

    property alias sidebarState: addCoinSidebar.state

    Rectangle {
        id: addCoinSidebar
        height: parent.height
        width: 0
        color: darktheme == false ? "#34363D" : "#2A2C31"
        anchors.top: parent.top
        anchors.right: parent.right
        state: "closed"

        states: [
            State {
                name: "closed"
                PropertyChanges { target: addCoinSidebar; width: 0}
                PropertyChanges { target: clickArea; opacity: 0}
            },
            State {
                name: "open"
                PropertyChanges { target: addCoinSidebar; width: 150}
                PropertyChanges { target: clickArea; opacity: 0.5}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: addCoinSidebar; property: "width"; duration: 300; easing.type: Easing.OutCubic}
                NumberAnimation { target: clickArea; property: "opacity"; duration: 300}
            }
        ]

        Component {
            id: walletCard

            Rectangle {
                id: currencyRow
                color: "transparent"
                width: Screen.width
                height: 50

                Image {
                    id: icon
                    source: logo
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    anchors.verticalCenter: parent.verticalCenter
                    width: 25
                    height: 25
                }

                Text {
                    id: coinName
                    anchors.left: icon.right
                    anchors.leftMargin: 7
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    elide: Text.ElideRight
                    anchors.verticalCenter: icon.verticalCenter
                    text: name
                    font.pixelSize: 18
                    font.family: xciteMobile.name
                    color: "#E5E5E5"
                    font.bold: true
                }

                Rectangle {
                    id: filterActiveCoin
                    height: parent.height
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    color: "black"
                    opacity: .25
                    visible: active == false
                }

                Rectangle {
                    id: divider1
                    height: 1
                    width: parent.width
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    color: "#2a2c31"
                    opacity: 0.5
                }

                Rectangle {
                    id: divider2
                    height: 1
                    width: parent.width
                    anchors.bottom: divider1.top
                    anchors.left: parent.left
                    color: "#979797"
                }

                MouseArea {
                    anchors.fill: parent

                    function compareCoin() {
                        for(var i = 0; i < coinList.count; i++) {
                            if (coinList.get(i).name === name) {
                                if (active == false) {
                                    coinList.setProperty(i, "active", true)
                                    for (var e = 0; e < addressList.count; e++) {
                                        if (addressList.get(e).coin === name) {
                                            addressList.setProperty(e, "active", true)
                                        }
                                    }
                                    for (var y = 0; y < walletList.count; y++) {
                                        if (walletList.get(y).name === name) {
                                            walletList.setProperty(y, "active", true)
                                        }
                                    }
                                    if (name == "XFUEL") {
                                       userSettings.xfuel = true
                                    }
                                    if (name == "XBY") {
                                       userSettings.xby = true
                                    }
                                    if (name == "XTEST") {
                                       userSettings.xtest = true
                                    }
                                    if (name == "BTC") {
                                       userSettings.btc = true
                                    }
                                    if (name == "ETH") {
                                       userSettings.eth = true
                                    }

                                }
                                else {
                                    coinList.setProperty(i, "active", false)
                                    for (var a = 0; a < addressList.count; a++) {
                                        if (addressList.get(a).coin === name) {
                                            addressList.setProperty(a, "active", false)
                                        }
                                    }
                                    for (var o = 0; o < walletList.count; o++) {
                                        if (walletList.get(o).name === name) {
                                            walletList.setProperty(o, "active", false)
                                        }
                                    }
                                    if (name == "XFUEL") {
                                       userSettings.xfuel = false
                                    }
                                    if (name == "XBY") {
                                       userSettings.xby = false
                                    }
                                    if (name == "XTEST") {
                                       userSettings.xtest = false
                                    }
                                    if (name == "BTC") {
                                       userSettings.btc = false
                                    }
                                    if (name == "ETH") {
                                       userSettings.eth = false
                                    }
                                }
                            }
                        }
                    }

                    onClicked: {
                        click01.play()
                        detectInteraction()
                        compareCoin()
                        sumBalance()
                    }
                }
            }
        }

        SortFilterProxyModel {
            id: filteredCurrencies
            sourceModel: coinList
            sorters: [
                RoleSorter {roleName: "testnet" ; sortOrder: Qt.AscendingOrder},
                RoleSorter {roleName: "xby"; sortOrder: Qt.DescendingOrder},
                StringSorter {roleName: "name"}
            ]
        }

        ListView {
            anchors.fill: parent
            id: allWallets
            model: filteredCurrencies
            delegate: walletCard

            ScrollBar.vertical: ScrollBar {
                parent: allWallets.parent
                anchors.top: allWallets.top
                anchors.right: allWallets.right
                anchors.bottom: allWallets.bottom
                width: 5
                opacity: 1
                policy: ScrollBar.AlwaysOn
                visible: (coinList.count * 50) > (parent.height)
            }
        }

        Rectangle {
            id: clickArea
            width: Screen.width - parent.width
            height: parent.height
            anchors.top: parent.top
            anchors.right: parent.left
            color: "black"
            opacity: 0.25

            Timer {
                id: timer
                interval: 300
                repeat: false
                running: false

                onTriggered: addCoinTracker = 0
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    addCoinSidebar.state = "closed"
                    timer.start()
                }
            }
        }
    }
}



