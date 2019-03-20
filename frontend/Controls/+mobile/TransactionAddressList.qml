/**
* Filename: TransactionAddressList.qml
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
    property string transactionAddresses: "input"

    Component {
        id: addressLine

        Rectangle {
            id: addressRow
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            height: 80
            color:"transparent"
            clip: true

            Controls.CardBody {
                id: myCardBody
            }

            Label {
                id: addressHash
                text: address
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
                text: walletList.get(walletIndex).name
                anchors.right: parent.right
                anchors.rightMargin: 28
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                font.family: xciteMobile.name
                font.pixelSize: 18
                font.bold: true
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Label {
                property real txAmount: (Number.fromLocaleString(Qt.locale("en_US"),amount) )/ 100000000
                property int decimals: txAmount == 0? 2 : (txAmount <= 1000 ? 8 : (txAmount <= 1000000 ? 4 : 2))
                property var amountArray: (txAmount.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                id: amountValue1
                text: "." + amountArray[1]
                anchors.right: amountTicker.left
                anchors.rightMargin: 3
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 11
                font.family: xciteMobile.name
                font.pixelSize: 14
                font.bold: true
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Label {
                property real txAmount: (Number.fromLocaleString(Qt.locale("en_US"),amount))/ 100000000
                property int decimals: txAmount == 0? 2 : (txAmount <= 1000 ? 8 : (txAmount <= 1000000 ? 4 : 2))
                property var amountArray: (txAmount.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                id: amountValue2
                text: amountArray[0]
                anchors.right: amountValue1.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                font.family: xciteMobile.name
                font.pixelSize: 18
                font.bold: true
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }
        }
    }

    ListView {
        anchors.fill: parent
        id: picklist
        model: transactionAddresses == "input"? inputAddresses : outputAddresses
        delegate: addressLine
        spacing: 0
        contentHeight: transactionAddresses == "input"? ((inputAddresses.count * 80) + 50) : ((outputAddresses.count * 80) + 50)
        onDraggingChanged: detectInteraction()
    }
}

