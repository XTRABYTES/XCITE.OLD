/**
* Filename: DashboardForm.qml
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

Item {

    Loader {
        id: pageLoader
    }

    // shared vars

    property int pageTracker: view.currentIndex == 0 ? 0 : 1
    property var balanceArray: ((totalBalance).toLocaleString(Qt.locale("en_US"), "f", 2)).split('.')
    property string searchCriteria:""

    Component.onCompleted: {

        sumBalance()
    }

    Rectangle {
        id: backgroundHome
        z: 1
        width: Screen.width
        height: Screen.height
        color: "#34363d"

        SwipeView {
            id: view
            z: 2
            currentIndex: 0
            anchors.fill: parent
            interactive: (appsTracker == 1 || transferTracker == 1 || addressTracker == 1 || addAddressTracker == 1 || addCoinTracker == 1) ? false : true

            Item {
                id: dashForm

                Label {
                    id: valueTicker
                    z: 5
                    anchors.right: value1.left
                    anchors.bottom: value1.bottom
                    anchors.bottomMargin: 5
                    text: "$"
                    font.pixelSize: 24
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                }

                Label {
                    id: value1
                    z: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -((value2.implicitWidth - valueTicker.implicitWidth) / 2)
                    anchors.verticalCenter: parent.top
                    anchors.verticalCenterOffset: 85
                    text: balanceArray[0]
                    font.pixelSize: 40
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                }

                Label {
                    id: value2
                    z: 5
                    anchors.left: value1.right
                    anchors.bottom: value1.bottom
                    anchors.bottomMargin: 4
                    text: "." + balanceArray[1]
                    font.pixelSize: 24
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                }

                Rectangle {
                    id:scrollAreaDashForm
                    z: 3
                    width: Screen.width
                    height: Screen.height - 200
                    anchors.top: parent.top
                    anchors.topMargin: 150
                    color: "transparent"

                    Controls.WalletList {
                        id: myCurrencyCards
                    }

                }

                Controls.AddCoinModal{
                    z: 3
                    id: addCoinModal
                    visible: addCoinTracker == 1
                }

                DropShadow {
                    z: 4
                    anchors.fill: homeHeader
                    source: homeHeader
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color:"#2A2C31"
                    transparentBorder: true
                }

                Rectangle {
                    id: homeHeader
                    z: 4.1
                    width: parent.width
                    height: 150
                    color: "#2a2c31"
                }
            }

            Item {
                id: addressBookForm

                Controls.TextInput {
                    id: searchForAddress
                    z: 5
                    height: 34
                    placeholder: "SEARCH ADDRESS BOOK"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.top
                    anchors.verticalCenterOffset: 85
                    width: Screen.width - 55
                    color: searchForAddress.text != "" ? "#F2F2F2" : "#727272"
                    font.pixelSize: 14
                    mobile: 1
                    addressBook: 1
                    onTextChanged: searchCriteria = searchForAddress.text
                }

                Rectangle {
                    id: addressScrollArea
                    z: 3
                    width: Screen.width
                    height: Screen.height - 200
                    anchors.top: parent.top
                    anchors.topMargin: 150
                    color: "transparent"

                    Controls.AddressBook {
                        id: myAddressCards
                        searchFilter: searchCriteria
                    }
                }

                DropShadow {
                    z: 4
                    anchors.fill: homeHeader2
                    source: homeHeader2
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color:"#2A2C31"
                    transparentBorder: true
                }

                Rectangle {
                    id: homeHeader2
                    z: 4.1
                    width: parent.width
                    height: 150
                    color: "#2a2c31"
                }
            }
        }

        Rectangle {
            id: homeHeader3
            z: 6
            width: parent.width
            height: 150
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
                        if (transferTracker == 0 && addressTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0) {
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
                visible: transferTracker == 0 && addAddressTracker == 0 && addressTracker == 0

                Label {
                    id: overview
                    text: "OVERVIEW"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    color: pageTracker == 0 ? "#5E8BFE": "#757575"

                    Rectangle {
                        id: titleLine
                        width: overview.width
                        height: 2
                        color: "#5E8BFE"
                        anchors.top: overview.bottom
                        anchors.left: overview.left
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
                    id: add5
                    text: "ADDRESS BOOK"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: pageTracker == 0 ? "#757575" : "#5E8BFE"
                    font.bold: true

                    Rectangle {
                        id: titleLine2
                        width: add5.width
                        height: 2
                        color: "#5E8BFE"
                        anchors.top: add5.bottom
                        anchors.left: add5.left
                        anchors.topMargin: 2
                        visible: pageTracker == 1
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            if (addCoinTracker == 0)
                            view.currentIndex = 1
                        }
                    }
                }
            }

            Label {
                id: transfer
                z: 6
                text: "TRANSFER"
                font.pixelSize: 13
                font.family: "Brandon Grotesque"
                color: "#C7C7C7"
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.verticalCenter: plus.verticalCenter
                font.bold: true

                Image {
                    id: transfer2
                    anchors.verticalCenter: transfer.verticalCenter
                    anchors.left: parent.right
                    anchors.leftMargin: 8
                    source: 'qrc:/icons/transfer_icon_02.svg'
                    width: 18
                    height: 18
                    ColorOverlay {
                        anchors.fill: transfer2
                        source: transfer2
                        color: "#5E8BFE"
                    }
                }

                Rectangle {
                    id: transferButton
                    anchors.left: transfer.left
                    anchors.right: transfer2.right
                    height: transfer2.height
                    anchors.verticalCenter: transfer2.verticalCenter
                    color: "transparent"
                }

                MouseArea {
                    anchors.fill: transferButton
                    onClicked: {
                        if (addressTracker ==0   && transferTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0) {
                            transferTracker = 1
                        }
                    }
                }

            }

            Image {
                id: plus
                z: 6
                anchors.bottom: homeHeader3.bottom
                anchors.bottomMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 28
                source: 'qrc:/icons/add_icon_04.svg'
                width: 18
                height: 18
                visible: pageTracker == 1

                ColorOverlay {
                    anchors.fill: plus
                    source: plus
                    color: "#5E8BFE"
                }

                Label {
                    id: addAddress
                    text: "ADD ADDRESS"
                    font.pixelSize: 13
                    font.family: "Brandon Grotesque"
                    color: "#C7C7C7"
                    anchors.right: parent.left
                    anchors.rightMargin:8
                    anchors.verticalCenter: plus.verticalCenter
                    font.bold: true
                }

                Rectangle {
                    id: addAddressButton
                    anchors.left: addAddress.left
                    anchors.right: plus.right
                    height: plus.height
                    anchors.verticalCenter: plus.verticalCenter
                    color: "transparent"

                    MouseArea {
                        anchors.fill: addAddressButton
                        onClicked: {
                            addAddressTracker = 1
                        }
                    }
                }
            }

            Label {
                z: 6
                id: addCoin
                text: "MANAGE COINS"
                font.pixelSize: 13
                font.family: "Brandon Grotesque"
                color: "#C7C7C7"
                anchors.right: parent.right
                anchors.rightMargin: 28
                anchors.verticalCenter: plus.verticalCenter
                font.bold: true
                visible: pageTracker == 0

                /**Image {
                    id: coinsArrow
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.left
                    anchors.rightMargin:8
                    source: 'qrc:/icons/left-arrow.svg'
                    width: 10
                    height: 18
                    rotation: addCoinTracker == 0 ? 0 : 180

                    ColorOverlay {
                        anchors.fill: coinsArrow
                        source: coinsArrow
                        color: "#5E8BFE"
                    }
                }*/

                Rectangle {
                    id: addCoinButton
                    anchors.right: addCoin.right
                    anchors.left: addCoin.left
                    height: 18
                    anchors.verticalCenter: addCoin.verticalCenter
                    color: "transparent"

                    Timer {
                        id: timer
                        interval: 300
                        repeat: false
                        running: false

                        onTriggered: addCoinTracker = 0
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (addCoinTracker == 1) {
                                addCoinModal.sidebarState = "closed"
                                timer.start()
                            }
                            else {
                                addCoinTracker = 1
                                addCoinModal.sidebarState = "open"
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            id: darkOverlay
            color: "black"
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            height: parent.height
            width: parent.width
            z: 6
            state: (transferTracker == 1 || appsTracker == 1 || addressTracker == 1 || addAddressTracker == 1) ? "dark" : "clear"

            states: [
                State {
                    name: "dark"
                    PropertyChanges { target: darkOverlay; opacity: 0.9}
                },
                State {
                    name: "clear"
                    PropertyChanges { target: darkOverlay; opacity: 0}
                }
            ]

            transitions: [
                Transition {
                    from: "*"
                    to: "*"
                    NumberAnimation { target: darkOverlay; property: "opacity"; duration: 200}
                }
            ]
        }

        Controls.TransferModal{
            id: transferModal
            z: 10
            anchors.horizontalCenter: backgroundHome.horizontalCenter
            anchors.top: backgroundHome.top
            anchors.topMargin: 40
        }

        Controls.AddressModal{
            id: addressModal
            z: 10
            anchors.horizontalCenter: backgroundHome.horizontalCenter
            anchors.top: backgroundHome.top
            anchors.topMargin: 40
        }

        Controls.AddAddressModal{
            id: addAddressModal
            z: 10
            anchors.horizontalCenter: backgroundHome.horizontalCenter
            anchors.top: backgroundHome.top
            anchors.topMargin: 40
        }

        Controls.Sidebar{
            z: 100
            anchors.left: parent.left
            anchors.top: parent.top
        }
    }
}
