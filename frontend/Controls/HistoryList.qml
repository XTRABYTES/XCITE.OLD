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
    clip: true

    property string searchFilter: ""
    property string selectedCoin: ""
    property string selectedWallet: ""

    Component {
        id: historyLine

        Rectangle {
            id: historyRow
            width: parent.width
            height: 30
            color: "transparent"
            visible: amount !== 0
            clip: true

            property int lineView: 0

            Rectangle {
                id: clickIndicator
                anchors.fill: parent
                color: darktheme == false? "black" : maincolor
                opacity: 0.25
                visible: false

                Connections {
                    target: completeHistory
                    onMovementEnded: clickIndicator.visible = false
                }
            }

            Label {
                id: txDate
                text: date
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                font.family: xciteMobile.name
                font.pixelSize: 14
                color: themecolor
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
                font.family: xciteMobile.name
                font.pixelSize: 14
                color: themecolor
                visible: lineView == 0
            }

            Image {
                id: right1
                source: 'qrc:/icons/right-arrow.svg'
                width: 14
                height: 16
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                visible: lineView == 0

                ColorOverlay {
                    anchors.fill: parent
                    source: parent
                    color: themecolor
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
                anchors.verticalCenter: parent.verticalCenter
                rotation: 180
                visible: lineView == 1

                ColorOverlay {
                    anchors.fill: parent
                    source: parent
                    color: themecolor
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
                id: idPartner

                function compareAddress(){
                    var fromto = ""
                    for(var i = 0; i < addressList.count; i++) {
                        if (addressList.get(i).address === txPartner) {
                            if (addressList.get(i).coin === selectedCoin) {
                                fromto = (contactList.get(addressList.get(i).contact).firstName) + " " + (contactList.get(addressList.get(i).contact).lastName) + " (" + addressList.get(i).label + ")"
                            }
                        }
                    }
                    return fromto
                }

                property string txpartnerName: compareAddress()

                text: (amount > 0 ? "from " : "to ") + (txpartnerName !== "" ? txpartnerName : txPartner)
                anchors.left: left2.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.family: xciteMobile.name
                font.pixelSize: txpartnerName !== "" ? 14 : 11
                color: themecolor
                visible: lineView == 1
            }
            Image {
                id: right2
                source: 'qrc:/icons/right-arrow.svg'
                width: 14
                height: 16
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                visible: lineView == 1

                ColorOverlay {
                    anchors.fill: parent
                    source: parent
                    color: themecolor
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
                anchors.verticalCenter: parent.verticalCenter
                rotation: 180
                visible: lineView == 2

                ColorOverlay {
                    anchors.fill: parent
                    source: parent
                    color: themecolor
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
                font.family: xciteMobile.name
                font.pixelSize: 14
                color: themecolor
                visible: lineView == 2
            }

            MouseArea {
                id: explorerButton
                anchors.left: txPartner.left
                anchors.leftMargin: 10
                anchors.right: txAmount.right
                anchors.rightMargin: 10
                height: txAmount.height

                onPressed: {
                    clickIndicator.visible = true
                }

                onReleased: {
                    clickIndicator.visible = false
                }

                onClicked: {
                    clickIndicator.visible = false
                    if (lineView == 0) {
                        if (selectedCoin == "XBY") {
                            Qt.openUrlExternally("https://xtrabytes.global/explorer/xby?open=%2Fexplorer%2Fxby%2Ftx%2F" + txid)
                        }
                        else if (selectedCoin == "XFUEL") {
                            Qt.openUrlExternally("https://xtrabytes.global/explorer/xfuel?open=%2Fexplorer%2Fxfuel%2Ftx%2F" + txid)
                        }
                    }
                    else if (lineView == 1) {
                        if (selectedCoin == "XBY") {
                            Qt.openUrlExternally("https://xtrabytes.global/explorer/xby?open=%2Faddress%2Fxby%2F" + txpartnerHash)
                        }
                        else if (selectedCoin == "XFUEL") {
                            Qt.openUrlExternally("https://xtrabytes.global/explorer/xfuel?open=%2Faddress%2Fxfuel%2F" + txpartnerHash)
                        }
                    }
                }
            }
        }
    }

    SortFilterProxyModel {
        id: filteredTX
        sourceModel:transactionList
        filters: [
            RegExpFilter {
                roleName: "coinName"
                pattern: selectedCoin
                caseSensitivity: Qt.CaseInsensitive
            },
            RegExpFilter {
                roleName: "walletLabel"
                pattern: selectedWallet
                caseSensitivity: Qt.CaseInsensitive
            },
            AnyOf {
                RegExpFilter {
                    roleName: "reference"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
                RegExpFilter {
                    roleName: "txPartner"
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
                RegExpFilter {
                    roleName: "txid"
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
        contentHeight: parent.height + 125
    }
}
