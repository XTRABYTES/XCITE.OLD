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
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtMultimedia 5.8
import QtQuick.Window 2.2

import "qrc:/Controls" as Controls

Item {

    Loader {
        id: pageLoader
    }

    // shared vars

    property int pageTracker: view.currentIndex == 0 ? 0 : 1

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
            interactive: (appsTracker == 1 || transferTracker == 1 || addressTracker == 1) ? false : true

            Item {
                id: dashForm

                Label {
                    id: value
                    z: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.top
                    anchors.verticalCenterOffset: 85
                    text: "$" +(totalBalance).toLocaleString(Qt.locale(), "f", 2)
                    font.pixelSize: 40
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                }

                Rectangle {
                    id:scrollAreaDashForm
                    z: 3
                    width: Screen.width
                    height: Screen.height - 200
                    anchors.top: parent.top
                    anchors.topMargin: 154
                    color: "transparent"

                    Controls.WalletList {
                        id: myCurrencyCards

                    }

                }

                DropShadow {
                    z: 3
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
                    z: 4
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
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    mobile: 1
                    addressBook: 1
                }

                Rectangle {
                    id: addressScrollArea
                    z: 3
                    width: Screen.width
                    height: Screen.height - 200
                    anchors.top: parent.top
                    anchors.topMargin: 154
                    color: "transparent"

                    Controls.AddressBook {
                        id: myAddressCards

                    }
                }

                DropShadow {
                    z: 3
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
                    z: 4
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
                    color: "#5E8BFF"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (transferTracker == 0 && addressTracker == 0) {
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
                    color: "#5E8BFF"
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
                visible: transferTracker != 1

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
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 15
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
                        color: "#5E8BFF"
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
                        transferTracker = 1
                    }
                }

            }

            Image {
                id: plus
                z: 6
                anchors.verticalCenter: transfer.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 28
                source: 'qrc:/icons/add_icon_04.svg'
                width: 18
                height: 18
                ColorOverlay {
                    anchors.fill: plus
                    source: plus
                    color: "#5E8BFF"
                }

                Label {
                    id: addCoin
                    text: pageTracker === 0 ? "ADD COIN" : "ADD ADDRESS"
                    font.pixelSize: 13
                    font.family: "Brandon Grotesque"
                    color: "#C7C7C7"
                    anchors.right: parent.left
                    anchors.rightMargin:8
                    anchors.verticalCenter: plus.verticalCenter
                    font.bold: true
                }

                Rectangle {
                    id: addCoinButton
                    anchors.left: addCoin.left
                    anchors.right: plus.right
                    height: plus.height
                    anchors.verticalCenter: plus.verticalCenter
                    color: "transparent"
                }

                MouseArea {
                    anchors.fill: addCoinButton
                    onClicked: {
                        if (pageTracker == 0) {
                            addCoinTracker = 1
                            addCoinModal.coinName1 = currencyList.get(0).name
                            addCoinModal.coinName2= currencyList.get(1).name
                            addCoinModal.coinName3= currencyList.get(2).name
                            addCoinModal.coinName4= currencyList.get(3).name
                            addCoinModal.active1= currencyList.get(0).active
                            addCoinModal.active2= currencyList.get(1).active
                            addCoinModal.active3= currencyList.get(2).active
                            addCoinModal.active4= currencyList.get(3).active
                            addCoinModal.favorite1= currencyList.get(0).favorite
                            addCoinModal.favorite2= currencyList.get(1).favorite
                            addCoinModal.favorite3= currencyList.get(2).favorite
                            addCoinModal.favorite4= currencyList.get(3).favorite
                        }
                        else {
                            addAddressTracker = 1
                        }
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
            visible: transferTracker == 1 || appsTracker == 1 || addressTracker == 1 || addAddressTracker == 1 || addCoinTracker == 1
        }

        Controls.TransferModal{
            id: transferModal
            z: 10
            anchors.horizontalCenter: backgroundHome.horizontalCenter
            anchors.top: backgroundHome.top
            anchors.topMargin: 40
            visible: transferTracker == 1
        }

        Controls.AddressModal{
            id: addressModal
            z: 10
            anchors.horizontalCenter: backgroundHome.horizontalCenter
            anchors.top: backgroundHome.top
            anchors.topMargin: 40
            visible: addressTracker == 1
        }

        Controls.AddAddressModal{
            id: addAddressModal
            z: 10
            anchors.horizontalCenter: backgroundHome.horizontalCenter
            anchors.top: backgroundHome.top
            anchors.topMargin: 40
            visible: addAddressTracker == 1
        }

        Controls.AddCoinModal{
            id: addCoinModal
            z: 10
            anchors.horizontalCenter: backgroundHome.horizontalCenter
            anchors.top: backgroundHome.top
            anchors.topMargin: 40
            visible: addCoinTracker == 1
        }

        Controls.Sidebar{
            z: 100
            anchors.left: parent.left
            anchors.top: parent.top


        }
    }
}
