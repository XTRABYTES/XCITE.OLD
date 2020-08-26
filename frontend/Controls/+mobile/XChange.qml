/**
 * Filename: xchange.qml
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
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

import "qrc:/Controls" as Controls

Rectangle {
    id: xchangeModal
    width: appWidth
    height: appHeight
    state: xchangeTracker == 1? "up" : "down"
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    clip: true

    LinearGradient {
        anchors.fill: parent
        start: Qt.point(0, 0)
        end: Qt.point(0, parent.height)
        opacity: 0.05
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 1.0; color: maincolor }
        }
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: xchangeModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: xchangeModal; anchors.topMargin: xchangeModal.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: xchangeModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    Text {
        id: xchangeModalLabel
        text: "X-CHANGE"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    /**
        SwipeView {
            id: view
            z: 2
            currentIndex: 0
            anchors.fill: parent
            interactive: (appsTracker == 1 && balanceTracker == 1) ? false : true

            Item {
                id: tradingForm

                Rectangle {
                    id:scrollAreaTradignForm
                    z: 3
                    width: xchangeModal.width
                    height: xchangeModal.height - 150
                    anchors.top: parent.top
                    anchors.topMargin: 100
                    color: "transparent"

                }

                DropShadow {
                    z: 3
                    anchors.fill: tradingHeader
                    source: tradingHeader
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color: "black"
                    opacity: 0.5
                    transparentBorder: true
                }

                Rectangle {
                    id: tradingHeader
                    z: 4
                    width: parent.width
                    height: 100
                    color: "#14161B"
                }
            }

            Item {
                id: balanceForm

                Controls.TextInput {
                    id: searchForBalance
                    z: 5
                    height: 34
                    placeholder: "SEARCH COIN"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.top
                    anchors.verticalCenterOffset: 130
                    width: xchangeModal.width - 55
                    color: searchForBalance.text != "" ? "#F2F2F2" : "#727272"
                    font.pixelSize: 14
                    mobile: 1
                    addressBook: 1
                    textBackground: "#2A2C31"
                    onTextChanged: searchCriteria = searchForBalance.text
                }

                Rectangle {
                    id: balanceScrollArea
                    z: 3
                    width: xchangeModal.width
                    height: xchangeModal.height - 150
                    anchors.top: parent.top
                    anchors.topMargin: 100
                    color: "transparent"
                }

                DropShadow {
                    z: 3
                    anchors.fill: balanceHeader
                    source: balanceHeader
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color: "black"
                    opacity: 0.5
                    transparentBorder: true
                }

                Rectangle {
                    id: balanceHeader
                    z: 4
                    width: parent.width
                    height: 100
                    color: "#14161B"
                }
            }
        }

        Rectangle {
            id: xchangeHeader
            z: 6
            width: parent.width
            height: 100
            color: "transparent"

            Image {
                id: apps
                source: '../icons/mobile-menu.svg'
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.verticalCenter: headingLayout.verticalCenter
                width: 22
                height: 17

                ColorOverlay {
                    anchors.fill: apps
                    source: apps
                    color: "#5E8BFE"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (tradingTracker == 0 && balanceTracker == 0) {
                            appsTracker = 1
                        }
                    }
                }
            }

            Image {
                id: notif
                anchors.right: parent.right
                anchors.rightMargin: 30
                anchors.verticalCenter: headingLayout.verticalCenter
                source: '../icons/notification_icon_03.svg'
                width: 30
                height: 30

                ColorOverlay {
                    anchors.fill: notif
                    source: notif
                    color: "#5E8BFE"
                }

                Image{
                    id: notifAlert
                    anchors.left: parent.right
                    anchors.leftMargin: -16
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    source: 'qrc:/icons/notification_red_circle_icon.svg'
                    width: 8
                    height: 8
                }
            }

            RowLayout {
                id: headingLayout
                anchors.top: parent.top
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10
                visible: tradingTracker != 1

                Label {
                    id: trading
                    text: "TRADING"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    color: pageTracker == 0 ? "#5E8BFE": "#757575"

                    Rectangle {
                        id: titleLine
                        width: trading.width
                        height: 2
                        color: "#5E8BFE"
                        anchors.top: trading.bottom
                        anchors.left: trading.left
                        anchors.topMargin: 2
                        visible: pageTracker == 0
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            view.currentIndex = 0
                        }
                    }
                }

                Label {
                    id: balances
                    text: "BALANCES"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: pageTracker == 0 ? "#757575" : "#5E8BFE"
                    font.bold: true

                    Rectangle {
                        id: titleLine2
                        width: balances.width
                        height: 2
                        color: "#5E8BFE"
                        anchors.top: balances.bottom
                        anchors.left: balances.left
                        anchors.topMargin: 2
                        visible: pageTracker == 1
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            view.currentIndex = 1
                        }
                    }
                }
            }

            Label {
                id: favorites
                z: 6
                text: pageTracker == 1 ? "FAVORITES" : "XBY/XFUEL"
                font.pixelSize: 13
                font.family: "Brandon Grotesque"
                color: "#C7C7C7"
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                font.bold: false

                Rectangle {
                    id: favoritesButton
                    anchors.left: favorites.left
                    anchors.right: favorites.right
                    height: favorites.height
                    anchors.verticalCenter: favorites.verticalCenter
                    color: "transparent"
                }

                MouseArea {
                    anchors.fill: favoritesButton
                    onClicked: {
                    }
                }

            }

            Label {
                id: hideZeros
                text: pageTracker == 1 ? "HIDE ZERO BALANCES" : "OPEN ORDERS"
                font.pixelSize: 13
                font.family: "Brandon Grotesque"
                color: "#C7C7C7"
                anchors.right: parent.right
                anchors.rightMargin:28
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                font.bold: false
            }

            Rectangle {
                id: hideZerosButton
                anchors.left: hideZeros.left
                anchors.right: hideZeros.right
                height: hideZeros.height
                anchors.verticalCenter: hideZeros.verticalCenter
                color: "transparent"
            }

            MouseArea {
                anchors.fill: hideZerosButton
                onClicked: {
                }
            }
        }*/

    Image {
        id: underConstruction
        source: darktheme === true? 'qrc:/icons/mobile/construction-icon_01_white.svg' : 'qrc:/icons/mobile/construction-icon_01_black.svg'
        width: 100
        height: 100
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        anchors.horizontalCenter: parent.horizontalCenter
    }
    /**
    Label {
        id: closeXchangeModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : (isIphoneX()? 90 : 70)
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"

        Rectangle{
            id: closeButton
            height: 34
            width: doubbleButtonWidth
            radius: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"
        }

        MouseArea {
            anchors.fill: closeButton

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onReleased: {
                if (xchangeTracker == 1) {
                    xchangeTracker = 0;
                }
            }
        }
    }

        Rectangle {
            color: "black"
            opacity: .75
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            height: parent.height
            width: parent.width
            z: 6
            visible: appsTracker == 1
        }

        Controls.Sidebar{
            z: 100
            anchors.left: parent.left
            anchors.top: parent.top
        }
        */
}
