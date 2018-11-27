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
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtMultimedia 5.8
import QtQuick.Window 2.2
import SortFilterProxyModel 0.2



Rectangle {
    width: parent.width
    height: parent.height
    color: "transparent"

    property string searchFilter: ""
    property int selectedWallet: 0
    property string txcoinName: currencyList.get(selectedWallet).name

    Component {
        id: historyLine

        Rectangle {
            id: historyRow
            width: parent.width
            height: 30
            color: "transparent"
            visible: amount !== 0

            property int lineView: 0

            Label {
                id: txDate
                text: date
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Brandon Grotesque"
                font.pixelSize: 14
                color: "#F2F2F2"
                visible: lineView == 0
            }

            Image {
                id: inOut
                source: 'qrc:/icons/left-arrow2.svg'
                width: 20
                height: 14
                anchors.left: parent.left
                anchors.leftMargin: 75
                anchors.verticalCenter: parent.verticalCenter
                rotation: amount > 0 ? 180 : 0
                visible: lineView == 0

                ColorOverlay {
                    anchors.fill: parent
                    source: parent
                    color: amount > 0 ? "#5DFC36" : "#FD2E2E"
                }
            }

            Label {
                id: txAmount
                property string amountTX: amount.toLocaleString(Qt.locale("en_US"), "f", 4)
                text: amount > 0 ? "+" + amountTX : amountTX
                anchors.right: parent.right
                anchors.rightMargin: 45
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Brandon Grotesque"
                font.pixelSize: 14
                color: "#F2F2F2"
                visible: lineView == 0
            }

            Image {
                id: right1
                source: 'qrc:/icons/right-arrow.svg'
                width: 14
                height: 16
                anchors.right: parent.right
                anchors.rightMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                visible: lineView == 0

                ColorOverlay {
                    anchors.fill: parent
                    source: parent
                    color: "#F2F2F2"
                }

                Rectangle {
                    id: button1
                    height: 16
                    width: 16
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                }

                MouseArea {
                    id: right1Button
                    anchors.fill: button1

                    onClicked: {
                        lineView = 1
                    }
                }
            }
            Image {
                id: left2
                source: 'qrc:/icons/right-arrow.svg'
                width: 14
                height: 16
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                rotation: 180
                visible: lineView == 1

                ColorOverlay {
                    anchors.fill: parent
                    source: parent
                    color: "#F2F2F2"
                }

                Rectangle{
                    id: button2
                    height: 16
                    width: 16
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                }

                MouseArea {
                    id: left2Button
                    anchors.fill: button2

                    onClicked: {
                        lineView = 0
                    }
                }
            }

            Label {
                id: txPartner

                function compareAddress(){
                    var fromto = ""
                    for(var i = 0; i < addressList.count; i++) {
                        if (addressList.get(i).address === txpartnerHash) {
                            if (addressList.get(i).coin === txcoinName) {
                                fromto = (addressList.get(i).name)
                            }
                        }
                    }
                    return fromto
                }

                property string txpartnerName: compareAddress()

                text: (amount > 0 ? "from " : "to ") + (txpartnerName !== "" ? txpartnerName : txpartnerHash)
                anchors.left: left2.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Brandon Grotesque"
                font.pixelSize: txpartnerName !== "" ? 14 : 11
                color: "#F2F2F2"
                visible: lineView == 1
            }
            Image {
                id: right2
                source: 'qrc:/icons/right-arrow.svg'
                width: 14
                height: 16
                anchors.right: parent.right
                anchors.rightMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                visible: lineView == 1

                ColorOverlay {
                    anchors.fill: parent
                    source: parent
                    color: "#F2F2F2"
                }

                Rectangle{
                    id: button3
                    height: 16
                    width: 16
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                }

                MouseArea {
                    id: right2Button
                    anchors.fill: button3

                    onClicked: {
                        lineView = 2
                    }
                }
            }
            Image {
                id: left3
                source: 'qrc:/icons/right-arrow.svg'
                width: 14
                height: 16
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                rotation: 180
                visible: lineView == 2

                ColorOverlay {
                    anchors.fill: parent
                    source: parent
                    color: "#F2F2F2"
                }

                Rectangle{
                    id: button4
                    height: 16
                    width: 16
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                }

                MouseArea {
                    id: left3Button
                    anchors.fill: button4

                    onClicked: {
                        lineView = 1
                    }
                }
            }

            Label {
                id: txReference
                text: "ref: " + (reference === "" ? "N/A" : reference)
                anchors.left: left3.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Brandon Grotesque"
                font.pixelSize: 14
                color: "#F2F2F2"
                visible: lineView == 2
            }

            MouseArea {
                id: explorerButton
                anchors.left: txPartner.left
                anchors.leftMargin: 10
                anchors.right: txAmount.right
                anchors.rightMargin: 10
                height: txAmount.height

                onClicked: {
                    if (selectedWallet == 0) {
                        Qt.openUrlExternally("https://xtrabytes.global/explorer/xby?open=%2Fexplorer%2Fxby%2Ftx%2F" + txid)
                    }
                    else if (selectedWallet == 1) {
                        Qt.openUrlExternally("https://xtrabytes.global/explorer/xfuel?open=%2Fexplorer%2Fxfuel%2Ftx%2F" + txid)
                    }
                    else if (selectedWallet == 2) {
                        Qt.openUrlExternally("https://blockexplorer.com/tx/" + txid)
                    }
                    else if (selectedWallet == 3) {
                        Qt.openUrlExternally("https://etherscan.io/tx/" + txid)
                    }
                }
            }
        }
    }



    SortFilterProxyModel {
        id: filteredTX
        sourceModel:(selectedWallet == 0 ? xbyTXHistory :
                                           (selectedWallet == 1 ? xfuelTXHistory :
                                                                  (selectedWallet == 2 ? btcTXHistory : ethTXHistory)))
        filters: [
            AnyOf {
                RegExpFilter {
                    roleName: "reference"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
                RegExpFilter {
                    roleName: "txpartnerHash"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
                RegExpFilter {
                    roleName: "txid"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
                RegExpFilter {
                    roleName: "amount"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
                RegExpFilter {
                    roleName: "date"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
            }
        ]
        sorters: [
            RoleSorter { roleName: "txNR" ; sortOrder: Qt.DescendingOrder }
        ]
    }

    ListView {
        anchors.fill: parent
        id: completeHistory
        model: filteredTX
        delegate: historyLine
    }
}
