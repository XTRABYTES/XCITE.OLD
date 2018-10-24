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
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QZXing 2.3

import "qrc:/Controls" as Controls

Rectangle {
    id: transactionModal
    width: 325
    height: transactionSent == 1 ? 350 : ((transferSwitch.state == "off") ? 480 : 450 )
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
    property int transactionSent: 0
    property int confirmationSent: 0
    property int switchState: 0
    property int invalidAddress: 0
    property var inputAmount: Number.fromLocaleString(Qt.locale(),sendAmount.text)
    property string amountTransfer: "AMOUNT (" + coinName + ")"
    property string keyTransfer: "SEND TO (PUBLIC KEY)"
    property string referenceTransfer: "REFERENCE"
    property real amountSend: 0
    property string searchTxText: ""

    Rectangle {
        id: transferTitleBar
        width: parent.width/2
        height: 50
        radius: 4
        anchors.top: parent.top
        anchors.left: parent.left
        color: modalState == 0 ? "#42454F" : "#34363D"
        visible: transactionSent == 0 && addressbookTracker == 0

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
        }

        MouseArea {
            height: transferTitleBar.height
            width: parent.width
            onClicked: {
                modalState = 0
                transferSwitch.state = "off"
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
        visible: transactionSent == 0 && addressbookTracker == 0

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
        }

        MouseArea {
            height: historyTitleBar.height
            width: parent.width
            onClicked: {
                modalState = 1
                transferSwitch.state = "off"
            }
        }
    }

    Rectangle {
        id: bodyModal
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
            visible: transactionSent == 0 && addressbookTracker == 0
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
            visible: transactionSent == 0 && addressbookTracker == 0
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
            visible: transactionSent == 0 && addressbookTracker == 0
        }

        Image {
            id: coinIcon
            source: newCoinSelect == 1 ? currencyList.get(newCoinPicklist).logo : currencyList.get(currencyIndex).logo
            width: 25
            height: 25
            anchors.left: sendAmount.left
            anchors.top: transferSwitch.bottom
            anchors.topMargin: 10
            visible: transactionSent == 0 && addressbookTracker == 0
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
            visible: transactionSent == 0 && addressbookTracker == 0
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
            visible: transactionSent == 0 && addressbookTracker == 0
        }

        Text {
            id: walletBalance
            text: (newCoinSelect == 1 ? (currencyList.get(newCoinPicklist).balance).toLocaleString(Qt.locale(), "f", 4) : (currencyList.get(currencyIndex).balance).toLocaleString(Qt.locale(), "f", 4)) + " " + coinID.text
            anchors.right: sendAmount.right
            anchors.top: walletLabel.bottom
            anchors.topMargin: 1
            font.pixelSize: 13
            color: "#828282"
            visible: transactionSent == 0 && addressbookTracker == 0
        }

        Image {
            id: picklistArrow
            source: 'qrc:/icons/dropdown_icon.svg'
            height: 20
            width: 20
            anchors.left: picklistTracker == 0 ? coinID.right : transferPicklist.right
            anchors.leftMargin: 10
            anchors.verticalCenter: coinID.verticalCenter
            visible: transactionSent == 0 && addressbookTracker == 0 && picklistTracker == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: "#F2F2F2"
            }

            Rectangle{
                id: picklistButton
                height: 20
                width: 20
                radius: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
            }

            MouseArea {
                anchors.fill: picklistButton
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
            visible: picklistTracker == 1 && transactionSent == 0 && addressbookTracker == 0

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
            visible: modalState == 0 && transferSwitch.on == false && transactionSent == 0 && addressbookTracker == 0
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
            visible: modalState == 0 && transferSwitch.on == false && transactionSent == 0 && addressbookTracker == 0
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
            font.pixelSize: 14
            font.letterSpacing: 1
            visible: modalState == 0 && transferSwitch.on == false && transactionSent == 0 && addressbookTracker == 0
        }

        Text {
            id: publicKey
            text: newCoinSelect == 1 ? currencyList.get(newCoinPicklist).address : currencyList.get(currencyIndex).address
            anchors.top: pubKey.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: pubKey.horizontalCenter
            color: "white"
            font.family: "Brandon Grotesque"
            font.weight: Font.Light
            font.pixelSize: 12
            visible: modalState == 0 && transferSwitch.on == false && transactionSent == 0 && addressbookTracker == 0
        }

        Image {
            id: pasteIcon
            source: 'qrc:/icons/paste_icon.svg'
            width: 13
            height: 13
            anchors.left: publicKey.right
            anchors.leftMargin: 5
            anchors.verticalCenter: publicKey.verticalCenter
            visible: modalState == 0 && transferSwitch.on == false && transactionSent == 0 && addressbookTracker == 0
        }

        // Send state

        Controls.TextInput {
            id: sendAmount
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: walletBalance.bottom
            anchors.topMargin: 20
            placeholder: amountTransfer
            color: sendAmount.text != "" ? "#F2F2F2" : "#727272"
            font.pixelSize: 14
            validator: DoubleValidator {bottom: 0; top: (newCoinSelect == 1 ? (currencyList.get(newCoinPicklist).balance) : (currencyList.get(currencyIndex).balance))}
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0 && addressbookTracker == 0
            mobile: 1
        }

        Label {
            text: "*insufficient funds"
            color: "#FD2E2E"
            anchors.left: sendAmount.left
            anchors.leftMargin: 5
            anchors.top: sendAmount.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.weight: Font.Normal
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && inputAmount > (newCoinSelect == 1 ? (currencyList.get(newCoinPicklist).balance) : (currencyList.get(currencyIndex).balance))
        }

        Controls.TextInput {
            id: keyInput
            text: sendAddress.text
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: sendAmount.bottom
            anchors.topMargin: 15
            placeholder: keyTransfer
            color: keyInput.text != "" ? "#F2F2F2" : "#727272"
            font.pixelSize: 14
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0 && addressbookTracker == 0
            mobile: 1
            onTextChanged: {
                if (keyInput.length === 34
                        && sendAmount.text !== "") {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
        }

        Text {
            id: sendAddress
            text: selectedAddress
            anchors.left: keyInput.left
            anchors.top: keyInput.bottom
            anchors.topMargin: 3
            visible: false
            onTextChanged: {
                keyInput.text = sendAddress.text
            }
        }

        Label {
            id: addressWarning
            text: "Invalid address!"
            color: "#FD2E2E"
            anchors.left: keyInput.left
            anchors.leftMargin: 5
            anchors.top: keyInput.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.weight: Font.Normal
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0 && addressbookTracker == 0 && invalidAddress == 1
        }

        Rectangle {
            id: scanQrButton
            width: (keyInput.width - 10) / 2
            height: 33
            anchors.top: keyInput.bottom
            anchors.topMargin: 20
            anchors.left: keyInput.left
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0 && addressbookTracker == 0

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
            width: (keyInput.width - 10) / 2
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: keyInput.bottom
            anchors.topMargin: 20
            anchors.right: keyInput.right
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0 && addressbookTracker == 0

            MouseArea {
                anchors.fill: addressBookButton

                onClicked: {
                    addressbookTracker = 1
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
            placeholder: referenceTransfer
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: scanQrButton.bottom
            anchors.topMargin: 20
            color: referenceInput.text != "" ? "#F2F2F2" : "#727272"
            font.pixelSize: 14
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0 && addressbookTracker == 0
            mobile: 1
        }

        Rectangle {
            id: sendButton
            width: keyInput.width
            height: 33
            radius: 8
            border.color: (keyInput.text !== ""
                           && keyInput.length === 34
                           && sendAmount.text !== ""
                           && inputAmount !== 0
                           && inputAmount <= (newCoinSelect == 1 ? (currencyList.get(newCoinPicklist).balance) : (currencyList.get(currencyIndex).balance))) ? "#5E8BFF" : "#727272"
            border.width: 2
            color: "transparent"
            anchors.bottom: bodyModal.bottom
            anchors.bottomMargin: 20
            anchors.left: referenceInput.left
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0

            MouseArea {
                anchors.fill: sendButton

                onClicked: {
                    if (keyInput.text !== ""
                            && keyInput.length === 34
                            && sendAmount.text !== ""
                            && inputAmount !== 0
                            && inputAmount <= (newCoinSelect == 1 ? (currencyList.get(newCoinPicklist).balance) : (currencyList.get(currencyIndex).balance))) {
                        transactionSent = 1
                        picklistTracker = 0
                    }
                }
            }

            Text {
                text: "SEND"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: (keyInput.text !== ""
                        && keyInput.length === 34
                        && sendAmount.text !== ""
                        && inputAmount !== 0
                        && inputAmount <= (newCoinSelect == 1 ? (currencyList.get(newCoinPicklist).balance) : (currencyList.get(currencyIndex).balance))) ? "#5E8BFF" : "#727272"
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
                anchors.topMargin: 60
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

            Text {
                id: reference
                text: "for"
                anchors.top: confirmationAddress.bottom
                anchors.topMargin: 7
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Brandon Grotesque"
                font.pixelSize: 16
                font.weight: Font.Normal
                color: "#F2F2F2"
            }
            Text {
                id: referenceText
                text: referenceInput.text != "" ? referenceInput.text : "no reference"
                anchors.top: reference.bottom
                anchors.topMargin: 7
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Brandon Grotesque"
                font.pixelSize: 13
                font.weight: referenceInput.text != "" ? Font.Normal : Font.Light
                font.italic: referenceInput.text == ""
                color: "#F2F2F2"
            }

            Rectangle {
                id: confirmationSendButton
                width: (sendConfirmation.width - 45) / 2
                height: 33
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
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
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
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
                width: 120
                height: 120
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
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: closeConfirm

                    onClicked: {
                        sendAmount.text = ""
                        keyInput.text = ""
                        referenceInput.text = ""
                        selectedAddress = ""
                        confirmationSent = 0
                        transactionSent = 0
                        invalidAddress = 0
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

        // Addressbook state

        Rectangle {
            id: addressPicklistArea
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressbookTitleBar.bottom
            anchors.topMargin: 10
            anchors.bottom: bodyModal.bottom
            anchors.bottomMargin: 63
            color: "transparent"
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0 && addressbookTracker == 1

            Controls.AddressPicklist {
                id: myAddressPicklist
                selectedWallet: (coinID.text === "XBY" ? 0:
                                                         (coinID.text === "XFUEL" ? 1:
                                                                                    (coinID.text === "BTC" ? 2 : 3)))
            }
        }

        Rectangle {
            id: addressbookTitleBar
            width: parent.width
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: bodyModal.top
            radius: 4
            color: "#34363D"
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0 && addressbookTracker == 1
        }

        Rectangle {
            id: addressbookSpacerBar
            width: parent.width
            height: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressbookTitleBar.bottom
            anchors.topMargin: -4
            color: "#42454F"
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0 && addressbookTracker == 1
        }

        Label {
            id: addressbookTitle
            text: "ADDRESSBOOK"
            anchors.horizontalCenter: bodyModal.horizontalCenter
            anchors.verticalCenter: addressbookTitleBar.verticalCenter
            anchors.verticalCenterOffset: -2
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: "#F2F2F2"
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0 && addressbookTracker == 1
        }

        Rectangle {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressPicklistArea.bottom
            anchors.bottom: bodyModal.bottom
            radius: 4
            color: "#42454F"
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0 && addressbookTracker == 1
        }


        Rectangle {
            id: cancelAddressButton
            width: (bodyModal.width - 40) / 2
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: addressPicklistArea.bottom
            anchors.topMargin: 15
            anchors.horizontalCenter: bodyModal.horizontalCenter
            visible: modalState == 0 && transferSwitch.on == true && transactionSent == 0 && addressbookTracker == 1

            MouseArea {
                anchors.fill: cancelAddressButton

                onClicked: {
                    addressbookTracker = 0
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

        // History coin state

        Rectangle {
            id: historyScrollArea
            width: parent.width
            height: 230
            anchors.top: searchTx.bottom
            anchors.topMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            visible: modalState == 1 && transferSwitch.state == "off"

            Controls.HistoryList {
                id: myHistoryList
                searchFilter: searchTxText
                selectedWallet: newCoinSelect == 1 ?    (currencyList.get(newCoinPicklist).name === "XBY" ? 0:
                                                                                                            (currencyList.get(newCoinPicklist).name === "XFUEL" ? 1:
                                                                                                                                                                  (currencyList.get(newCoinPicklist).name === "BTC" ? 2 : 3))) : currencyIndex
            }
        }

        Rectangle {
            width: parent.width
            height: 49
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: walletBalance.bottom
            anchors.topMargin: 15
            color: "#42454F"
            visible: (modalState == 1 && transferSwitch.state == "off")
        }

        Rectangle {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: historyScrollArea.bottom
            anchors.bottom: bodyModal.bottom
            radius: 4
            color: "#42454F"
            visible: (modalState == 1 && transferSwitch.state == "off")
        }

        Controls.TextInput {
            id: searchTx
            height: 34
            placeholder: "SEARCH TRANSACTIONS"
            //anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: walletBalance.bottom
            anchors.topMargin: 15
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: 15
            width: Screen.width - 55
            color: searchTx.text != "" ? "#F2F2F2" : "#727272"
            font.pixelSize: 14
            mobile: 1
            addressBook: 1
            visible: modalState == 1 && transferSwitch.state == "off"
        }

        Image {
            id: resetInput
            source: 'qrc:/icons/CloseIcon.svg'
            height: 12
            width: 12
            anchors.right: searchTx.right
            anchors.rightMargin: 11
            anchors.verticalCenter: searchTx.verticalCenter
            visible: modalState == 1 && transferSwitch.state == "off"

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: "#F2F2F2"
            }

            MouseArea {
                anchors.fill : parent
                onClicked: {
                    searchTx.text = ""
                }
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

        Rectangle{
            id: closeButton
            anchors.fill: parent
            color: "transparent"
        }

        MouseArea {
            anchors.fill: closeButton

            onClicked: {
                transferTracker = 0;
                addressbookTracker = 0;
                picklistTracker = 0;
                modalState = 0
                currencyIndex = 0
                transferSwitch.state = "off"
                transactionSent =0
                confirmationSent = 0
                newCoinSelect = 0
                newCoinPicklist = 0
                selectedAddress = ""
                sendAmount.text = ""
                keyInput.text = ""
                referenceInput.text = ""
                invalidAddress = 0
            }
        }
    }
}

