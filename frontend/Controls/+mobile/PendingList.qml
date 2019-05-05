/**
* Filename: HistoryList.qml
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
import SortFilterProxyModel 0.2

import "qrc:/Controls" as Controls

Rectangle {
    width: parent.width
    height: parent.height
    anchors.top: parent.top
    color: "transparent"
    clip :true

    property alias cardSpacing: picklist.spacing
    property string searchCriteria: ""
    property string pendingCoin: walletList.get(walletIndex).name
    property string pendingWallet: walletList.get(walletIndex).address

    Label {
        id: noResultLabel
        text: "No pending transactions."
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.top: parent.top
        anchors.topMargin: 30
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        font.family: xciteMobile.name
        font.pixelSize: 18
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: filteredPending.count == 0
    }

    Component {
        id: pendingLine

        Rectangle {
            id: pendingRow
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            height: 100
            color:"transparent"
            clip: true

            Controls.CardBody {
                id: myCardBody
            }

            Label {
                id: transactionID
                text: txid
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.right: parent.right
                anchors.rightMargin: 28
                anchors.top: parent.top
                anchors.topMargin: 10
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                elide: Text.ElideRight
            }

            Label {
                id: amountTicker
                text: coin
                anchors.right: parent.right
                anchors.rightMargin: 28
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                font.family: xciteMobile.name
                font.pixelSize: 18
                font.bold: true
                color: "#E55541"
            }

            Label {
                property int decimals: amount == 0? 2 : (amount <= 1000 ? 8 : (amount <= 1000000 ? 4 : 2))
                property var amountArray: (amount.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                id: amountValue1
                text: "." + amountArray[1]
                anchors.right: amountTicker.left
                anchors.rightMargin: 3
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 11
                font.family: xciteMobile.name
                font.pixelSize: 14
                font.bold: true
                color: "#E55541"
            }

            Label {
                property int decimals: amount == 0? 2 : (amount <= 1000 ? 8 : (amount <= 1000000 ? 4 : 2))
                property var amountArray: (amount.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                id: amountValue2
                text: "- " + amountArray[0]
                anchors.right: amountValue1.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                font.family: xciteMobile.name
                font.pixelSize: 18
                font.bold: true
                color: "#E55541"
            }
        }
    }

    SortFilterProxyModel {
        id: filteredPending
        sourceModel: pendingList
        filters: [
            RegExpFilter {
                roleName: "address"
                pattern: pendingWallet
            },
            RegExpFilter {
                roleName: "coin"
                pattern: pendingCoin
            },
            AnyOf {
                RegExpFilter {
                    roleName: "txid"
                    pattern: searchCriteria
                }
                RegExpFilter {
                    roleName: "value"
                    pattern: searchCriteria
                }
            }
        ]
    }

    ListView {
        anchors.fill: parent
        id: picklist
        model: filteredPending
        delegate: pendingLine
        spacing: 0
        contentHeight: (filteredPending.count * 100) + 50
        onDraggingChanged: detectInteraction()
    }
}
