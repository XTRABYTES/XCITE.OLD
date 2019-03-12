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
    color: "transparent"
    clip :true

    Component {
        id: historyLine

        Rectangle {
            id: historyRow
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            height: 100
            color:"transparent"
            clip: true

            Controls.CardBody {
                id: myCardBody
            }

            Rectangle {
                id: clickIndicator
                anchors.fill: parent
                color: maincolor
                opacity: 0.25
                visible: false

                Connections {
                    target: picklist
                    onMovementEnded: {
                        clickIndicator.visible = false
                    }
                }
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    clickIndicator.visible = true
                    detectInteraction()
                }

                onReleased: {
                    clickIndicator.visible = false
                }

                onClicked: {
                    clickIndicator.visible = false
                }
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

            Rectangle {
                id: confirmationIndicator
                height: 5
                width: 5
                radius: 5
                anchors.left: transactionID.left
                anchors.verticalCenter: amountTicker.verticalCenter
                color: confirmations < 4? "#E555412" : (confirmations < 6? "#FF8400" : "#4BBE2E")
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
                color: direction == false? "#E55541" : "#4BBE2E"
            }

            Label {
                property real amount: (Number.fromLocaleString(Qt.locale("en_US"),value) )/ 100000000
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
                color: direction == false? "#E55541" : "#4BBE2E"
            }

            Label {
                property real amount: (Number.fromLocaleString(Qt.locale("en_US"),value))/ 100000000
                property int decimals: amount == 0? 2 : (amount <= 1000 ? 8 : (amount <= 1000000 ? 4 : 2))
                property var amountArray: (amount.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                id: amountValue2
                text: direction == false? ("- " + amountArray[0]) : ("+ " + amountArray[0])
                anchors.right: amountValue1.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                font.family: xciteMobile.name
                font.pixelSize: 18
                font.bold: true
                color: direction == false? "#E55541" : "#4BBE2E"
            }
        }
    }

    ListView {
        anchors.fill: parent
        id: picklist
        model: historyList
        delegate: historyLine
        contentHeight: (historyList.count * 100) + 50
        onDraggingChanged: detectInteraction()
    }
}
