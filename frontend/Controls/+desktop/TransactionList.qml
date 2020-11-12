/**
 * Filename: TransactionList.qml
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
import QtQuick.Window 2.2
import SortFilterProxyModel 0.2
import QtGraphicalEffects 1.0

import "qrc:/Controls" as Controls

Rectangle {
    id: allWalletCards
    width: parent.width
    height: parent.height
    color: "transparent"

    property int deleteTx: 0
    property int selectedTX: 0

    Component {
        id: walletCard

        Rectangle {
            id: currencyRow
            color: "transparent"
            width: allWalletCards.width
            height: appHeight/15
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: square
                width: parent.width
                height: parent.height
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                clip: true

                Rectangle {
                    id: cardBorder
                    width: parent.width*0.95
                    height: 1
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: themecolor
                    border.width: 1
                    opacity: 0.1
                }

                Text {
                    id: receiverName
                    anchors.left: parent.left
                    anchors.leftMargin: font.pixelSize
                    anchors.top: parent.top
                    anchors.topMargin: font.pixelSize/2
                    text: receiver
                    font.pixelSize: square.height/4
                    font.family: xciteMobile.name
                    color: themecolor
                }

                Text {
                    id: amountValue
                    anchors.right: amountTicker.left
                    anchors.rightMargin: font.pixelSize/2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: font.pixelSize/2
                    text: amount
                    font.pixelSize: square.height/4
                    font.family: xciteMobile.name
                    color: themecolor
                }

                Text {
                    id: amountTicker
                    anchors.right: deleteButton.left
                    anchors.rightMargin: deleteButton.height/2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: font.pixelSize/2
                    text: walletList.get(walletIndex).name
                    font.pixelSize: square.height/4
                    font.family: xciteMobile.name
                    color: themecolor
                }

                Rectangle {
                    id: deleteButton
                    height: parent.height/2
                    width: height
                    radius: height/2
                    color: "transparent"
                    border.color: themecolor
                    border.width: 1
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: height/2

                    Rectangle {
                        id: selectDelete
                        anchors.fill: parent
                        radius: height/2
                        color: maincolor
                        opacity: 0.3
                        visible: false
                    }

                    Item {
                        width: parent.width*0.6
                        height: width
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        rotation: 45

                        Rectangle {
                            width: parent.width
                            height: 1
                            color: themecolor
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Rectangle {
                            height: parent.height
                            width: 1
                            color: themecolor
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        enabled: deleteTx == 0

                        onEntered: {
                            selectDelete.visible = true
                        }

                        onExited: {
                            selectDelete.visible = false
                        }

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            selectDelete.visible = false
                            selectedTX = index
                            deleteTx = 1
                        }
                    }
                }

                Rectangle {
                    id: replyPopUp
                    height: parent.height*0.9
                    width: askDelete.implicitWidth + askDelete.font.pixelSize*4
                    color: "#f2f2f2"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: deleteTx == 1 && selectedTX == index

                    Item {
                        id: questionArea
                        height: parent.height/2
                        width: parent.width
                        anchors.top: parent.top
                    Label {
                        id: askDelete
                        text: "Delete this transaction?"
                        font.family: xciteMobile.name
                        font.pixelSize: height/2
                        color: "#2a2c31"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Rectangle {
                        width: parent.width
                        height:0.5
                        color: "#2a2c31"
                        opacity: 0.1
                        anchors.bottom: parent.bottom
                    }
                    }
                    Item {
                        id: buttonArea
                        height: parent.height/2
                        width: parent.width
                        anchors.bottom: parent.bottom

                        Rectangle {
                            height: parent.height
                            width: parent.width/2
                            color: "transparent"
                            anchors.top: parent.top
                            anchors.left: parent.left

                            Rectangle {
                                id: yesSelect
                                anchors.fill: parent
                                color: maincolor
                                opacity: 0.3
                                visible: false
                            }

                            Label {
                                text: "YES"
                                color: "#2a2c31"
                                font.family: xciteMobile.name
                                font.pixelSize: parent.height/2
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true

                                onEntered: {
                                    yesSelect.visible = true
                                }

                                onExited: {
                                    yesSelect.visible = false
                                }

                                onPressed: {
                                    click01.play()
                                    detectInteraction()
                                }

                                onClicked: {
                                    advancedTXList.remove(selectedTX, 1)
                                    deleteTx = 0
                                }
                            }
                        }

                        Rectangle {
                            height: parent.height
                            width: parent.width/2
                            color: "transparent"
                            anchors.top: parent.top
                            anchors.right: parent.right

                            Rectangle {
                                id: noSelect
                                anchors.fill: parent
                                color: maincolor
                                opacity: 0.3
                                visible: false
                            }

                            Label {
                                text: "NO"
                                color: "#2a2c31"
                                font.family: xciteMobile.name
                                font.pixelSize: parent.height/2
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true

                                onEntered: {
                                    noSelect.visible = true
                                }

                                onExited: {
                                    noSelect.visible = false
                                }

                                onPressed: {
                                    click01.play()
                                    detectInteraction()
                                }

                                onClicked: {
                                    deleteTx = 0
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    ListView {
        id: allTransactions
        model: advancedTXList
        delegate: walletCard
        anchors.fill: parent
        onDraggingChanged: detectInteraction()
    }
}
