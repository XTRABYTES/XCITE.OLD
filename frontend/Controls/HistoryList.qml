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
    id: allHistoryLines
    width: parent.width
    height: parent.height
    color: "transparent"

    property int selectedWallet: 1

    Component {
        id: historyLine

        Rectangle {
            id: historyRow
            width: parent.width
            height: 30
            color: "transparent"

            SwipeView {
                id: lineView
                currentIndex: 0
                anchors.fill: parent

                Item {
                    id: part1
                    visible: lineView.currentIndex == 0

                    Label {
                        id: txDate
                        text: date
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: "Brandon Grotesque"
                        font.pixelSize: 14
                        color: "#F2F2F2"
                    }

                    Image {
                        id: inOut
                        source: amount > 0 ? 'qrc:/icons/right-arrow2.svg' : 'qrc:/icons/left-arrow2.svg'
                        width: 20
                        height: 14
                        anchors.left: parent.left
                        anchors.leftMargin: 75
                        anchors.verticalCenter: parent.verticalCenter

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: amount > 0 ? "green" : "red"
                        }
                    }

                    Label {
                        id: txAmount
                        property string amountTX: amount.toLocaleString(Qt.locale(), "f", 4)
                        text: amount > 0 ? "+" + amountTX : amountTX
                        anchors.right: parent.right
                        anchors.rightMargin: 45
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: "Brandon Grotesque"
                        font.pixelSize: 14
                        color: "#F2F2F2"
                    }

                    Image {
                        id: right1
                        source: 'qrc:/icons/side-arrow-right.svg'
                        width: 20
                        height: 20
                        anchors.right: parent.right
                        anchors.rightMargin: 15
                        anchors.verticalCenter: parent.verticalCenter

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: "#F2F2F2"
                        }

                        MouseArea {
                            id: right1Button
                            anchors.fill: parent

                            onClicked: {
                                lineView.currentIndex = 1
                            }
                        }
                    }
                }

                Item {
                    id: part2
                    visible: lineView.currentIndex == 1

                    Image {
                        id: left2
                        source: 'qrc:/icons/side-arrow-left.svg'
                        width: 20
                        height: 20
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        anchors.verticalCenter: parent.verticalCenter

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: "#F2F2F2"
                        }

                        MouseArea {
                            id: left2Button
                            anchors.fill: parent

                            onClicked: {
                                lineView.currentIndex = 0
                            }
                        }
                    }

                    Label {
                        id: txPartner
                        function compareAddress(){
                            var fromto = ""
                            for(var i = 0; i < addressList.count; i++) {
                                if (addressList.get(i).address === txpartnerHash) {
                                    fromto = addressList.get(i).name
                                }
                            }
                            return fromto
                        }
                        property string partner: compareAddress()
                        text: (amount > 0 ? "from " : "to ") + (partner !== "" ? partner : txpartnerHash)
                        anchors.left: left2.right
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: "Brandon Grotesque"
                        font.pixelSize: partner != "" ? 14 : 11
                        color: "#F2F2F2"
                    }
                    Image {
                        id: right2
                        source: 'qrc:/icons/side-arrow-right.svg'
                        width: 20
                        height: 20
                        anchors.right: parent.right
                        anchors.rightMargin: 15
                        anchors.verticalCenter: parent.verticalCenter

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: "#F2F2F2"
                        }

                        MouseArea {
                            id: right2Button
                            anchors.fill: parent

                            onClicked: {
                                lineView.currentIndex = 2
                            }
                        }
                    }
                }

                Item {
                    id: part3
                    visible: lineView.currentIndex == 2

                    Image {
                        id: left3
                        source: 'qrc:/icons/side-arrow-left.svg'
                        width: 20
                        height: 20
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        anchors.verticalCenter: parent.verticalCenter

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: "#F2F2F2"
                        }

                        MouseArea {
                            id: left3Button
                            anchors.fill: parent

                            onClicked: {
                                lineView.currentIndex = 1
                            }
                        }
                    }

                    Label {
                        id: txReference
                        text: "ref: " + reference
                        anchors.left: left3.right
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: "Brandon Grotesque"
                        font.pixelSize: 14
                        color: "#F2F2F2"
                    }
                }
            }
        }
    }

    ListView {
        anchors.fill: parent
        id: completeHistory
        model: {
            if (selectedWallet == 1) {
                xbyTXHistory
            }
            if (selectedWallet == 2) {
                xfuelTXHistory
            }
            if (selectedWallet == 3) {
                btcTXHistory
            }
            if (selectedWallet == 4) {
                ethTXHistory
            }
        }

        delegate: historyLine
    }
}
