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

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent

                        onPressAndHold: {
                            if(copy2clipboard == 0 && transactionDetailTracker == 1) {
                                address2Copy = address
                                copyText2Clipboard(address)
                                copy2clipboard = 1
                            }
                        }
                    }
                }
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
                color: walletList.get(walletIndex).address === address? (transactionAddresses == "input"? "#E55541" : "#4BBE2E") : (darktheme == true? "#F2F2F2" : "#2A2C31")
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
                color: walletList.get(walletIndex).address === address? (transactionAddresses == "input"? "#E55541" : "#4BBE2E") : (darktheme == true? "#F2F2F2" : "#2A2C31")
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
                color: walletList.get(walletIndex).address === address? (transactionAddresses == "input"? "#E55541" : "#4BBE2E") : (darktheme == true? "#F2F2F2" : "#2A2C31")
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
                visible: copy2clipboard == 1 && transactionDetailTracker == 1 && address2Copy === addressHash.text
            }

            Rectangle {
                id: textPopup
                height: 50
                width: popupClipboardText.width + 20
                color: "#34363D"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                visible: copy2clipboard == 1 && transactionDetailTracker == 1 && address2Copy === addressHash.text

                Label {
                    id: popupClipboardText
                    text: address + "<br>Address copied!"
                    font.family: "Brandon Grotesque"
                    font.pointSize: 14
                    font.bold: true
                    color: "#F2F2F2"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
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

