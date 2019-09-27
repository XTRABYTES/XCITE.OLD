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
import QtGraphicalEffects 1.0

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

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent

                        onPressAndHold: {
                            if(copy2clipboard == 0 && historyTracker == 1) {
                                txid2Copy = txid
                                copyText2Clipboard(txid)
                                copy2clipboard = 1
                            }
                        }
                    }
                }
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

            DropShadow {
                anchors.fill: textPopup
                source: textPopup
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color: "black"
                opacity: 0.4
                transparentBorder: true
                visible: copy2clipboard == 1 && historyTracker == 1 && txid2Copy === transactionID.text
            }

            Rectangle {
                id: textPopup
                height: 60
                width: parent.width - 56
                color: "#34363D"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                visible: copy2clipboard == 1 && historyTracker == 1 && txid2Copy === transactionID.text

                Label {
                    id: popupClipboardText1
                    text: txid
                    font.family: "Brandon Grotesque"
                    font.pointSize: 14
                    font.bold: true
                    color: "#F2F2F2"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    elide: Text.ElideRight
                }

                Label {
                    id: popupClipboardText2
                    text: "Txid copied!"
                    font.family: "Brandon Grotesque"
                    font.pointSize: 14
                    font.bold: true
                    color: "#F2F2F2"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    elide: Text.ElideRight
                }
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
