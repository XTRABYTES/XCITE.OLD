/**
 * Filename: TransferModal.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

import QtQuick.Controls 2.3
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QZXing 2.3

import "qrc:/Controls" as Controls

Rectangle {
    id: transactionModal
    width: 325
    height: transactionSent == 0? 480 : 230
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 50

    property string coinName: currencyList.get(currencyIndex).name
    property url coinLogo: currencyList.get(currencyIndex).logo
    property real coinBalance: currencyList.get(currencyIndex).balance
    property string coinAddress: currencyList.get(currencyIndex).address
    property string coinLabel: currencyList.get(currencyIndex).label
    property int modalState: 0
    property int scanQRCodeTracker: 0
    property int addressBookTracker: 0
    property int transactionSent: 0
    property int confirmationSent: 0
    property int switchState: 0
    property int errorAmount: 0
    property string amountTransfer: "AMOUNT (" + coinName + ")"
    property string keyTransfer: "SEND TO (PUBLIC KEY)"
    property string referenceTransfer: "REFERENCE"
    property real amountSend: 0

    Rectangle {
        id: transferTitleBar
        width: parent.width/2
        height: 50
        radius: 4
        anchors.top: parent.top
        anchors.left: parent.left
        color: modalState == 0 ? "#42454F" : "#34363D"
        visible: transactionSent == 0

        Text {
            id: transferModalLabel
            text: "TRANSFER"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -3
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            color: modalState == 0 ? "#F2F2F2" : "#5F5F5F"
            font.letterSpacing: 2
            MouseArea {
                height: parent.height
                width: parent.width
                onClicked: {
                    modalState = 0
                    transferSwitch.state = "off"
                }
            }
        }
    }

    Rectangle {
        id: historyTitleBar
        width: parent.width/2
        height: 50
        radius: 4
        anchors.top: parent.top
        anchors.right: parent.right
        color: modalState == 1 ? "#42454F" : "#34363D"
        visible: transactionSent == 0

        Text {
            id: historyModalLabel
            text: "HISTORY"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -3
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            color: modalState == 1 ? "#F2F2F2" : "#5F5F5F"
            font.letterSpacing: 2
            MouseArea {
                height: parent.height
                width: parent.width
                onClicked: {
                    modalState = 1
                    transferSwitch.state = "off"
                }
            }
        }
    }

    Rectangle {
        id:bodyModal
        width: parent.width
        height: parent.height - 50
        radius: 4
        color: "#42454F"
        anchors.top: parent.top
        anchors.topMargin: 46
        anchors.horizontalCenter: parent.horizontalCenter

        Controls.Switch_mobile {
            id: transferSwitch
            anchors.horizontalCenter: bodyModal.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            state: switchState == 0 ? "off" : "on"
            visible: transactionSent == 0
        }

        Text {
            id: receiveText
            text: modalState == 0 ? "RECEIVE" : "WALLET"
            anchors.right: transferSwitch.left
            anchors.rightMargin: 7
            anchors.verticalCenter: transferSwitch.verticalCenter
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            font.weight: Font.Medium
            color: transferSwitch.on ? "#5F5F5F" : "#5E8BFE"
            visible: transactionSent == 0
        }
        Text {
            id: sendText
            text: modalState == 0 ?  "SEND" : "COIN"
            anchors.left: transferSwitch.right
            anchors.leftMargin: 7
            anchors.verticalCenter: transferSwitch.verticalCenter
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            font.weight: Font.Medium
            color: transferSwitch.on ? "#5E8BFE" : "#5F5F5F"
            visible: transactionSent == 0
        }

        Image {
            id: coinIcon
            source: newCoinSelect == 1 ? currencyList.get(newCoinPicklist).logo : currencyList.get(currencyIndex).logo
            width: 25
            height: 25
            anchors.left: sendAmount.left
            anchors.top: transferSwitch.bottom
            anchors.topMargin: 10
            visible: transactionSent == 0
        }

        Label {
            id: coinID
            text: newCoinSelect == 1 ? currencyList.get(newCoinPicklist).name : currencyList.get(currencyIndex).name
            anchors.left: coinIcon.right
            anchors.leftMargin: 10
            anchors.verticalCenter: coinIcon.verticalCenter
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: "#F2F2F2"
            visible: transactionSent == 0
        }

        Label {
            id: walletLabel
            text: newCoinSelect == 1 ? currencyList.get(newCoinPicklist).label : currencyList.get(currencyIndex).label
            anchors.right: sendAmount.right
            anchors.verticalCenter: coinIcon.verticalCenter
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: "#F2F2F2"
            visible: transactionSent == 0
        }

        Text {
            id: walletBalance
            text: newCoinSelect == 1 ? (currencyList.get(newCoinPicklist).balance).toLocaleString(Qt.locale(), "f", 4) : (currencyList.get(currencyIndex).balance).toLocaleString(Qt.locale(), "f", 4)
            anchors.right: sendAmount.right
            anchors.top: walletLabel.bottom
            anchors.topMargin: 7
            font.pixelSize: 13
            color: "#828282"
            visible: transactionSent == 0
        }

        Image {
            id: picklistArrow
            source: 'qrc:/icons/dropdown_icon.svg'
            height: 20
            width: 20
            anchors.left: transferPicklist.right
            anchors.leftMargin: 10
            anchors.verticalCenter: coinID.verticalCenter
            visible: transactionSent == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: "#F2F2F2"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (picklistTracker == 0) {
                        picklistTracker = 1
                    }
                    else {
                        picklistTracker = 0
                    }
                }
            }
        }

        Rectangle {
            id: transferPicklist
            z: 11
            width: 100
            height: totalLines * 35
            color: "#2A2C31"
            anchors.top: coinIcon.top
            anchors.topMargin: -5
            anchors.left: coinIcon.left
            visible: picklistTracker == 1 && transactionSent == 0

            Controls.CurrencyPicklist {
                id: myCoinPicklist
            }
        }

        // Receive state

        Rectangle {
            id: qrBorder
            radius: 8
            width: 210
            height: 210
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: walletBalance.bottom
            anchors.topMargin: 20
            color: "#F2F2F2"
            visible: modalState == 0 && transferSwitch.on == false && transactionSent == 0
        }

        Item {
            id: qrPlaceholder
            width: 180
            height: 180
            anchors.horizontalCenter: qrBorder.horizontalCenter
            anchors.verticalCenter: qrBorder.verticalCenter
            Image {
                anchors.fill: parent
                source: "image://QZXing/encode/" + publicKey.text
                cache: false
            }
            visible: modalState == 0 && transferSwitch.on == false && transactionSent == 0
        }

        Text {
            id: pubKey
            text: "PUBLIC KEY"
            anchors.top: qrBorder.bottom
            anchors.topMargin: 25
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: true
            font.pixelSize: 13
            font.letterSpacing: 1
            visible: modalState == 0 && transferSwitch.on == false && transactionSent == 0
        }

        Text {
            id: publicKey
            text: newCoinSelect == 1 ? currencyList.get(newCoinPicklist).address :currencyList.get(currencyIndex).address
            anchors.top: pubKey.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: pubKey.horizontalCenter
            color: "white"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 11
            visible: modalState == 0 && transferSwitch.on == false && transactionSent == 0
        }

        Image {
            id: pasteIcon
            source: 'qrc:/icons/paste_icon.svg'
            width: 13
            height: 13
            anchors.left: publicKey.right
            anchors.leftMargin: 5
            anchors.verticalCenter: publicKey.verticalCenter
            visible: modalState == 0 && transferSwitch.on == false && transactionSent == 0
        }

        // Send state

        Controls.TextInput {
            id: sendAmount
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: walletBalance.bottom
            anchors.topMargin: 20
            placeholder: amountTransfer
            color: "#727272"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0
        }

        Controls.TextInput {
            id: keyInput
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: sendAmount.bottom
            anchors.topMargin: 15
            placeholder: keyTransfer
            color: "#727272"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0
        }
        Rectangle {
            id: scanQrButton
            width: (keyInput.width - 5) / 2
            height: 33
            anchors.top: keyInput.bottom
            anchors.topMargin: 15
            anchors.left: keyInput.left
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0
            MouseArea {
                anchors.fill: scanQrButton
                onClicked: {
                    scanQRCodeTracker = 1
                }
            }
            Text {
                text: "SCAN QR"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#5E8BFF"
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: addressBookButton
            width: (keyInput.width - 5) / 2
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: keyInput.bottom
            anchors.topMargin: 15
            anchors.right: keyInput.right
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0
            MouseArea {
                anchors.fill: addressBookButton

                onClicked: {
                    addressBookTracker = 1
                }
            }
            Text {
                text: "ADDRESS BOOK"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Controls.TextInput {
            id: referenceInput
            height: 34
            // radius: 8
            placeholder: referenceTransfer
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: scanQrButton.bottom
            anchors.topMargin: 15
            color: "#727272"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0
        }
        Rectangle {
            id: sendButton
            width: keyInput.width
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: referenceInput.bottom
            anchors.topMargin: 35
            anchors.left: referenceInput.left
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0
            MouseArea {
                anchors.fill: sendButton

                onClicked: {
                    // error handeling (not a number, insufficient funds, negative amount, incorrect address)
                    transactionSent = 1
                }
            }
            Text {
                text: "SEND"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // Confirm state

        Rectangle {
            id: sendConfirmation
            width: parent.width
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            visible: transactionSent == 1 && confirmationSent == 0
            Text {
                id: confirmationText
                text: "You are about to send:"
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Brandon Grotesque"
                font.pixelSize: 16
                font.weight: Font.Normal
                color: "#F2F2F2"
            }
            Text {
                id: confirmationAmount
                text: newCoinSelect == 1 ? sendAmount.text + " " + currencyList.get(newCoinPicklist).name : sendAmount.text + " " + currencyList.get(currencyIndex).name
                anchors.top: confirmationText.bottom
                anchors.topMargin: 7
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Brandon Grotesque"
                font.pixelSize: 16
                font.weight: Font.Medium
                color: "#F2F2F2"
            }
            Text {
                id: to
                text: "to"
                anchors.top: confirmationAmount.bottom
                anchors.topMargin: 7
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Brandon Grotesque"
                font.pixelSize: 16
                font.weight: Font.Normal
                color: "#F2F2F2"
            }
            Text {
                id: confirmationAddress
                text: keyInput.text
                anchors.top: to.bottom
                anchors.topMargin: 7
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Brandon Grotesque"
                font.pixelSize: 13
                font.weight: Font.Normal
                color: "#F2F2F2"
            }
            Rectangle {
                id: confirmationSendButton
                width: (sendConfirmation.width - 45) / 2
                height: 33
                anchors.top: confirmationAddress.bottom
                anchors.topMargin: 15
                anchors.left: sendConfirmation.left
                anchors.leftMargin: 20
                radius: 8
                border.color: "#5E8BFF"
                border.width: 2
                color: "transparent"
                MouseArea {
                    anchors.fill: confirmationSendButton
                    onClicked: {
                        confirmationSent = 1
                        // whatever function needed to execute payment
                    }
                }
                Text {
                    text: "CONFIRM"
                    font.family: "Brandon Grotesque"
                    font.pointSize: 14
                    color: "#5E8BFF"
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Rectangle {
                id: cancelSendButton
                width: (sendConfirmation.width - 45) / 2
                height: 33
                radius: 8
                border.color: "#5E8BFF"
                border.width: 2
                color: "transparent"
                anchors.top: confirmationAddress.bottom
                anchors.topMargin: 15
                anchors.right: sendConfirmation.right
                anchors.rightMargin: 20
                MouseArea {
                    anchors.fill: cancelSendButton

                    onClicked: {
                        transactionSent = 0
                    }
                }
                Text {
                    text: "CANCEL"
                    font.family: "Brandon Grotesque"
                    font.pointSize: 14
                    font.bold: true
                    color: "#5E8BFF"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // Transfer sent state

        Rectangle {
            id: transferConfirmed
            width: parent.width
            height: parent.height
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            visible: transactionSent == 1 && confirmationSent == 1
            Image {
                id: confirmedIcon
                source: 'qrc:/icons/rocket.svg'
                width: 50
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -15
                ColorOverlay {
                    anchors.fill: parent
                    source: confirmedIcon
                    color: "#5E8BFF"
                }
            }
            Rectangle {
                id: closeConfirm
                width: (parent.width - 45) / 2
                height: 33
                radius: 8
                border.color: "#5E8BFF"
                border.width: 2
                color: "transparent"
                anchors.top: confirmedIcon.bottom
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    anchors.fill: closeConfirm

                    onClicked: {
                        sendAmount.text = ""
                        keyInput.text = ""
                        referenceInput.text = ""
                        confirmationSent = 0
                        transactionSent = 0
                    }
                }
                Text {
                    text: "OK"
                    font.family: "Brandon Grotesque"
                    font.pointSize: 14
                    font.bold: true
                    color: "#5E8BFF"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // History coin state

        Rectangle {
            id: historyScrollArea
            width: parent.width
            height: 250
            anchors.top : parent.top
            anchors.topMargin: 150
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            visible: modalState == 1 && transferSwitch.state == "off"

            Controls.HistoryList {
                id: myHistoryList
            }
        }
    }
    Label {
        id: closeTransferModal
        z: 10
        text: "CLOSE"
        anchors.top: bodyModal.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: bodyModal.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: "#F2F2F2"
        visible: transferTracker == 1 && confirmationSent == 0

        MouseArea {
            anchors.fill: closeTransferModal

            onClicked: {
                if (transferTracker == 1) {
                    transferTracker = 0;
                    modalState = 0
                    currencyIndex = 0
                    transferSwitch.state = "off"
                    transactionSent =0
                    confirmationSent = 0
                    newCoinSelect = 0
                    newCoinPicklist = 0
                    sendAmount.text = ""
                    keyInput.text = ""
                    referenceInput.text = ""
                }

            }
        }
    }
}

