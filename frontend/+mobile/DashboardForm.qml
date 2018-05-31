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

import "./Controls" as Controls
import "./Theme" 1.0

Item {
    Column {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 15

        Controls.Header {
            text: qsTr("My Wallet")
            showBack: false
        }

        Controls.Balance {
        }

        Item {
            height: 10
            width: 1
        }

        //FIX. find good dynamic sizing values
        Item {
            anchors.left: parent.left
            anchors.right: parent.right
            height: 350
            Controls.TransactionTables {
                anchors.topMargin: -40
            }
        }

        Item {
            anchors.left: parent.left
            anchors.right: parent.right
            height: 39

            RowLayout {
                anchors.fill: parent
                spacing: 10
                Controls.ButtonIconText {
                    backgroundColor: Theme.primaryHighlight
                    textColor: "#2D3043"
                    border.width: 0
                    radius: 0
                    label.font.letterSpacing: 0.92
                    label.font.family: Theme.fontCondensed
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: qsTr("SEND XBY")
                    iconFile: '/icons/mobile-send.svg'
                    marginLeftValue: -10
                    size: 20
                    // set 1 to alert this normally used desktop control that it is using mobile parameters
                    mobile: 1
                    onButtonClicked: {
                        mainRoot.push("SendCoins.qml")
                    }
                }

                Controls.ButtonIconText {
                    backgroundColor: Theme.primaryHighlight
                    textColor: "#2D3043"
                    marginLeftValue: -10
                    border.width: 0
                    radius: 0
                    label.font.letterSpacing: 0.92
                    label.font.family: Theme.fontCondensed
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: qsTr("RECEIVE XBY")
                    iconFile: '/icons/mobile-receive.svg'
                    size: 20
                    // set 1 to alert this normally used desktop control that it is using mobile parameters
                    mobile: 1
                    onButtonClicked: {
                        mainRoot.push("ReceiveCoins.qml")
                    }
                }
            }
        }
    }
}
