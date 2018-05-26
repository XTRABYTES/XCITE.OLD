/**
 * Filename: SideMenu.qml
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
import "../Theme" 1.0

Rectangle {
    property string selectedView
    property string selectedModule

    Connections {
        target: dashboard
        onSelectView: {
            var parts = path.split('.')

            selectedModule = parts[0]
            selectedView = path
        }
    }

    color: Theme.panelBackground

    Version {
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: undefined
        anchors.horizontalCenter: parent.horizontalCenter
    }

    /**
      * XCite/Board Menu
      */
    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: moduleMenuHeight + 6
        spacing: 0
        visible: selectedModule == 'xCite'

        SideMenuButton {
            name: "xCite.home"
            imageSource: "../icons/menu-home.svg"
            labelText: qsTr("HOME")
            size: 32
        }

        SideMenuButton {
            name: "xCite.sendCoins"
            imageSource: "../icons/menu-sendcoins.svg"
            labelText: qsTr("SEND")
            imageOffsetX: -6
            size: 25
        }

        SideMenuButton {
            name: "xCite.receiveCoins"
            imageSource: "../icons/menu-receivecoins.svg"
            labelText: qsTr("RECEIVE")
            imageOffsetX: 5
            size: 25
        }

        SideMenuButton {
            name: "xCite.history"
            imageSource: "../icons/menu-history.svg"
            labelText: qsTr("HISTORY")
            size: 28
        }

        SideMenuButton {
            name: "xCite.nodes"
            imageSource: "../icons/share.svg"
            labelText: qsTr("NODES")
            size: 30
        }
    }

    /**
      * XChange menu
      */
    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: moduleMenuHeight + 7
        spacing: 0
        visible: selectedModule == 'xChange'
        SideMenuButton {
            name: "xChange.home"
            imageSource: "../icons/menu-home.svg"
            labelText: qsTr("HOME")
            size: 32
        }

        SideMenuButton {
            name: "xChange.openOrders"
            imageSource: "../icons/icon-open-orders.svg"
            labelText: qsTr("OPEN\nORDERS")

            size: 25
        }

        SideMenuButton {
            name: "xChange.orderHistory"
            imageSource: "../icons/icon-order-history.svg"
            labelText: qsTr("ORDER\nHISTORY")

            size: 25
        }

        SideMenuButton {
            name: "xChange.marketTrades"
            imageSource: "../icons/icon-market-trades.svg"
            labelText: qsTr("MARKET\nTRADES")
            size: 25
        }

        SideMenuButton {
            name: "xChange.orderBooks"
            imageSource: "../icons/menu-history.svg"
            labelText: qsTr("ORDER\nBOOKS")
            size: 30
        }
    }

    /**
      * Chat Menu
      */
    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: moduleMenuHeight + 7
        spacing: 0
        visible: selectedModule == 'xChat'

        SideMenuButton {
            name: "xChat.home"
            imageSource: "../icons/menu-home.svg"
            labelText: qsTr("HOME")
            size: 32
        }
    }

    /**
      * Vault Menu
      */
    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: moduleMenuHeight + 7
        spacing: 0
        visible: selectedModule == 'xVault'

        SideMenuButton {
            name: "xVault.home"
            imageSource: "../icons/menu-home.svg"
            labelText: qsTr("HOME")
            size: 32
        }
    }

    Item {
        visible: xcite.height <= 600
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 76

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            SideMenuButtonSmall {
                text: qsTr("SETTINGS")
                isActive: (selectedView === "xCite.settings")

                Layout.fillWidth: true
                Layout.fillHeight: true

                onButtonClicked: {
                    selectView("xCite.settings")
                }
            }

            SideMenuButtonSmall {
                text: xcite.isNetworkActive ? qsTr("ONLINE") : qsTr("OFFLINE")
                isLit: xcite.isNetworkActive
                Layout.fillWidth: true
                Layout.fillHeight: true

                onButtonClicked: toggleNetwork()
            }
        }
    }

    ColumnLayout {
        visible: xcite.height > 600
        width: parent.width
        Layout.fillHeight: true
        Layout.minimumHeight: 200
        Layout.preferredHeight: 200
        anchors.bottomMargin: 32.5
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        spacing: 10

        SideMenuButton {
            name: "xCite.settings"
            imageSource: "../icons/menu-settings.svg"
            labelText: qsTr("SETTINGS")
            size: 32
        }

        ButtonIcon {
            id: wifiButton
            imageSource: "../icons/wifi.svg"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            isSelected: xcite.isNetworkActive
            labelText: xcite.isNetworkActive ? qsTr("ONLINE") : qsTr("OFFLINE")
            onButtonClicked: toggleNetwork()
        }
    }

    function toggleNetwork() {
        if (xcite.isNetworkActive) {
            xcite.isNetworkActive = false
            return
        }

        modalAlert({
                       title: qsTr("TESTNET OFFLINE"),
                       bodyText: qsTr("The testnet is currently unavailable.\nStay tuned for Testnet 4, coming soon!"),
                       buttonText: qsTr("OK")
                   })

        /*
        confirmationModal({
                              title: qsTr("CONNECT?"),
                              bodyText: qsTr("Please ensure your Testnet wallet is running with RPC enabled at http://127.0.0.1:2222"),
                              confirmText: qsTr("LET'S DO THIS!"),
                              cancelText: qsTr("CANCEL")
                          }, function () {
                              xcite.isNetworkActive = !xcite.isNetworkActive
                              pollWallet(true)
                              network.listAccounts()
                          })
        */
    }
}
