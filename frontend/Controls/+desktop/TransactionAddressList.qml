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
import QtGraphicalEffects 1.0

Rectangle {
    id: allHistoryCards
    width: parent.width
    height: parent.height
    anchors.top: parent.top
    color: "transparent"
    clip :true

    property string transactionAddresses: ""

    Component {
        id: historyLine

        Rectangle {
            id: historyRow
            color: "transparent"
            width: allHistoryCards.width
            height: appHeight/12
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
                    id: selectionIndicator
                    width: parent.width
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    color: maincolor
                    opacity: 0.3
                    visible: false
                }

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

                MouseArea {
                    anchors.fill: selectionIndicator
                    hoverEnabled: true

                    onEntered: {
                        selectionIndicator.visible = true
                    }

                    onExited: {
                        selectionIndicator.visible = false
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {

                    }
                }

                Label {
                    id: addressHash
                    text: address
                    anchors.left: parent.left
                    anchors.leftMargin: font.pixelSize*2
                    anchors.right: clipBoard1.left
                    anchors.rightMargin: font.pixelSize
                    anchors.top: parent.top
                    anchors.topMargin: font.pixelSize/2
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/4
                    color: darktheme == true? "#F2F2F2" : "#2A2C31"
                    elide: Text.ElideRight
                }

                Image {
                    id: clipBoard1
                    source: darktheme == true? "qrc:/icons/clipboard_icon_light01.png" : "qrc:/icons/clipboard_icon_dark01.png"
                    height: parent.height/5
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: addressHash.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: addressHash.font.pixelSize*2

                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"

                        MouseArea {
                            anchors.fill: parent

                            onPressed: {
                                click01.play()
                                detectInteraction()
                            }

                            onClicked: {
                                if(copy2clipboard == 0) {
                                    selectedList = transactionAddresses
                                    txid2Copy = address
                                    copyText2Clipboard(address)
                                    copy2clipboard = 1
                                    historyAddressClipboard = 1
                                }
                            }
                        }
                    }
                }

                Label {
                    id: amountTicker
                    text: walletList.get(walletIndex).name
                    anchors.right: clipBoard1.right
                    anchors.rightMargin: font.pixelSize*2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: font.pixelSize/2
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/4
                    color: walletList.get(walletIndex).address === address? (transactionAddresses == "input"? "#E55541" : "#4BBE2E") : (darktheme == true? "#F2F2F2" : "#2A2C31")
                }

                Label {
                    property int txAmount: (Number.fromLocaleString(Qt.locale("en_US"),amount) )/ 100000000
                    property int decimals: txAmount == 0? 2 : (txAmount <= 1000 ? 8 : (txAmount <= 1000000 ? 4 : 2))
                    property var amountArray: (txAmount.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountValue1
                    text: "." + amountArray[1]
                    anchors.right: amountTicker.left
                    anchors.rightMargin: font.pixelSize/4
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: font.pixelSize/2
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/4
                    color: walletList.get(walletIndex).address === address? (transactionAddresses == "input"? "#E55541" : "#4BBE2E") : (darktheme == true? "#F2F2F2" : "#2A2C31")
                }

                Label {
                    property int txAmount: (Number.fromLocaleString(Qt.locale("en_US"),amount) )/ 100000000
                    property int decimals: txAmount == 0? 2 : (txAmount <= 1000 ? 8 : (txAmount <= 1000000 ? 4 : 2))
                    property var amountArray: (txAmount.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountValue2
                    text: amountArray[0]
                    anchors.right: amountValue1.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: font.pixelSize/2
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/4
                    color: walletList.get(walletIndex).address === address? (transactionAddresses == "input"? "#E55541" : "#4BBE2E") : (darktheme == true? "#F2F2F2" : "#2A2C31")
                }
            }
        }
    }

    ListView {
        anchors.fill: parent
        id: picklist
        model: transactionAddresses == "input"? inputAddresses : outputAddresses
        delegate: historyLine
        contentHeight: picklist.count * appHeight/12
        onDraggingChanged: detectInteraction()

        ScrollBar.vertical: ScrollBar {
            parent: picklist.parent
            anchors.top: picklist.top
            anchors.right: picklist.right
            anchors.bottom: picklist.bottom
            width: 5
            opacity: 1
            policy: picklist.contentHeight > allHistoryCards.height? ScrollBar.AsNeeded : ScrollBar.AlwaysOff

            contentItem: Rectangle {
                implicitWidth: 5
                implicitHeight: appWidth/24
                color: maincolor
            }
        }
    }
}
