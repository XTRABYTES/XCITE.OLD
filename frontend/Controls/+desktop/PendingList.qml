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
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: allPendingCards
    width: parent.width
    height: parent.height
    anchors.top: parent.top
    color: "transparent"

    property string pendingCoin: walletList.get(walletIndex).name
    property string pendingWallet: walletList.get(walletIndex).address

    Label {
        id: noResultLabel
        text: "No pending transactions."
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: xciteMobile.name
        font.pixelSize: appHeight/45
        color: themecolor
        visible: filteredPending.count == 0
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
        visible: copy2clipboard == 1
    }

    Rectangle {
        id: textPopup
        height: popupClipboardText1.font.pixelSize*3.5
        width: parent.width*0.9
        color: "#34363D"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: copy2clipboard == 1

        Label {
            id: popupClipboardText1
            width: parent.width
            text: txid2Copy
            font.family: xciteMobile.name
            font.pointSize: appHeight/45
            color: "#F2F2F2"
            horizontalAlignment: Text.AlignHCenter
            leftPadding: font.pixelSize
            rightPadding: font.pixelSize
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: font.pixelSize/2
            elide: Text.ElideRight
        }

        Label {
            id: popupClipboardText2
            text: "Txid copied!"
            font.family: xciteMobile.name
            font.pointSize: appHeight/45
            color: "#F2F2F2"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: font.pixelSize/2
        }
    }

    Component {
        id: pendingLine

        Rectangle {
            id: pendingRow
            color: "transparent"
            width: allPendingCards.width
            height: appHeight/12
            anchors.horizontalCenter: parent.horizontalCenter

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

            Label {
                id: transactionID
                text: txid
                anchors.left: parent.left
                anchors.leftMargin: font.pixelSize
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
                height: parent.height/3
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: transactionID.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: height

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
                anchors.rightMargin: font.pixelSize
                anchors.bottom: parent.bottom
                anchors.bottomMargin: font.pixelSize/2
                font.family: xciteMobile.name
                font.pixelSize: parent.height/4
                color: "#E55541"
            }

            Label {
                property int decimals: amount == 0? 2 : (amount <= 1000 ? 8 : (amount <= 1000000 ? 4 : 2))
                property var amountArray: (amount.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                id: amountValue1
                text: "." + amountArray[1]
                anchors.right: amountTicker.left
                anchors.rightMargin: font.pixelSize/4
                anchors.bottom: parent.bottom
                anchors.bottomMargin: font.pixelSize/2
                font.family: xciteMobile.name
                font.pixelSize: parent.height/4
                color: "#E55541"
            }

            Label {
                property int decimals: amount == 0? 2 : (amount <= 1000 ? 8 : (amount <= 1000000 ? 4 : 2))
                property var amountArray: (amount.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                id: amountValue2
                text: "- " + amountArray[0]
                anchors.right: amountValue1.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: font.pixelSize/2
                font.family: xciteMobile.name
                font.pixelSize: parent.height/4
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
            RegExpFilter {
                roleName: "value"
                pattern: "false"
            }
        ]
    }

    ListView {
        anchors.fill: parent
        id: picklist
        model: filteredPending
        delegate: pendingLine
        onDraggingChanged: detectInteraction()
        contentHeight: filteredPending.count * appHeight/12
        interactive: walletListTracker == 0

        ScrollBar.vertical: ScrollBar {
            parent: picklist.parent
            anchors.top: picklist.top
            anchors.right: picklist.right
            anchors.bottom: picklist.bottom
            width: 5
            opacity: 1
            policy: picklist.contentHeight > allPendingCards.height? ScrollBar.AsNeeded : ScrollBar.AlwaysOff

            contentItem: Rectangle {
                implicitWidth: 5
                implicitHeight: appWidth/24
                color: maincolor
            }
        }
    }
}
