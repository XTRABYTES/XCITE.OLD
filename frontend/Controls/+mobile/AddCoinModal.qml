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

import "qrc:/Controls" as Controls

Rectangle {
    id: addCoinModal
    width: parent.width
    height: parent.height - 150
    color: "transparent"
    anchors.top: parent.top
    anchors.topMargin: 150
    anchors.right: parent.right

    property alias sidebarState: addCoinSidebar.state

    Rectangle {
        id: addCoinSidebar
        height: parent.height
        width: 0
        color: "#34363D"
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
                            anchors.verticalCenter: icon.verticalCenter
                            text: name
                            font.pixelSize: 18
                            font.family: "Brandon Grotesque"
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
                            visible: active == 0
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
                                for(var i = 0; i < currencyList.count; i++) {
                                    if (currencyList.get(i).name === name) {
                                        if (active == 0) {
                                            currencyList.setProperty(i, "active", 1)
                                            for (var e = 0; e < addressList.count; e++) {
                                                if (addressList.get(e).address === address) {
                                                    addressList.setProperty(e, "active", true)
                                                }
                                            }
                                        }
                                        else {
                                            currencyList.setProperty(i, "active", 0)
                                            for (var e = 0; e < addressList.count; e++) {
                                                if (addressList.get(e).address === address) {
                                                    addressList.setProperty(e, "active", false)
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            onClicked: {
                                compareCoin()
                                filterActiveCoin.visible = active == 0
                                sumBalance()
                            }
                        }
                    }
            }

            ListView {
                anchors.fill: parent
                id: allWallets
                model: currencyList
                delegate: walletCard
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



