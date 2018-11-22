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
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: transactionModal
    width: 325
    state: transferTracker == 1? "up" : "down"
    height: transactionSent == 1 ? 350 : ((transferSwitch.state == "off") ? 480 : 450 )
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    states: [
        State {
            name: "up"
            PropertyChanges { target: transactionModal; anchors.topMargin: 50}
            //PropertyChanges { target: transactionModal; visible: true}
        },
        State {
            name: "down"
            PropertyChanges { target: transactionModal; anchors.topMargin: Screen.height}
            //PropertyChanges { target: transactionModal; visible: false}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: transactionModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.OutCubic}
            //PropertyAnimation { target: transactionModal; property: "visible"; duration: 300}
        }
    ]

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
    property int decimals: (coinID.text) == "BTC" ? 8 : 4
    property var inputAmount: Number.fromLocaleString(Qt.locale("en_US"),sendAmount.text)
    property string amountTransfer: "AMOUNT (" + coinName + ")"
    property string keyTransfer: "SEND TO (PUBLIC KEY)"
    property string referenceTransfer: "REFERENCE"
    property real amountSend: 0
    property string searchTxText: ""
    property string transactionDate: ""
    property string addressName: compareAddress()


    function compareAddress(){
        var fromto = ""
        for(var i = 0; i < addressList.count; i++) {
            if (addressList.get(i).address === keyInput.text) {
                if (addressList.get(i).coin === coinID.text) {
                    fromto = (addressList.get(i).name)
                }
            }
        }
        return fromto
    }

   function checkAddress() {
        invalidAddress = 0
        if (coinID.text == "XBY" || coinID.text == "BTC") {
            if (keyInput.length === 34
                    && keyInput.text !== ""
                    && keyInput.text.substring(0,1) == "B"
                    && keyInput.acceptableInput == true) {
                invalidAddress = 0
            }
            else {
                invalidAddress = 1
            }
        }
        else if (coinID.text == "XFUEL") {
            if (keyInput.length === 34
                    && keyInput.text !== ""
                    && keyInput.text.substring(0,1) == "F"
                    && keyInput.acceptableInput == true) {
                invalidAddress = 0
            }
            else {
                invalidAddress = 1
            }
        }
        else {
            invalidAddress = 0
        }
    }

    function getCurrentBalance(){
        var currentBalance = 0
        for(var i = 0; i < currencyList.count; i++) {
            if (currencyList.get(i).name === coinID.text) {
                currentBalance = currencyList.get(i).balance
            }
        }
        return currentBalance
    }

    Rectangle {
        id: transferTitleBar
        width: parent.width/2
        height: 50
        //radius: 4
        anchors.top: parent.top
        anchors.left: parent.left
        color: modalState == 0 ? "#42454F" : "#34363D"
        visible: transactionSent == 0
                 && addressbookTracker == 0

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
        //radius: 4
        anchors.top: parent.top
        anchors.right: parent.right
        color: modalState == 1 ? "#42454F" : "#34363D"
        visible: transactionSent == 0
                 && addressbookTracker == 0

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
        //radius: 4
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
                     && addressbookTracker == 0
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
                     && addressbookTracker == 0
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
                     && addressbookTracker == 0
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
            anchors.leftMargin: 7
            anchors.verticalCenter: coinIcon.verticalCenter
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: "#F2F2F2"
            visible: transactionSent == 0
                     && addressbookTracker == 0
            onTextChanged: if (keyInput.text != "") {
                               checkAddress()
                           }
        }

        Label {
            id: walletLabel
            text: newCoinSelect == 1 ? currencyList.get(newCoinPicklist).label : currencyList.get(currencyIndex).label
            anchors.right: sendAmount.right
            anchors.verticalCenter: coinIcon.verticalCenter
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: "#F2F2F2"
            visible: transactionSent == 0
                     && addressbookTracker == 0
        }

        Text {
            id: walletBalance
            text: coinID.text
            anchors.right: sendAmount.right
            anchors.top: walletLabel.bottom
            anchors.topMargin: 1
            font.pixelSize: 14
            color: "#828282"
            visible: transactionSent == 0
                     && addressbookTracker == 0
        }

        Text {
            property string balance: (newCoinSelect == 1 ? (currencyList.get(newCoinPicklist).balance).toLocaleString(Qt.locale("en_US"), "f", decimals) : (currencyList.get(currencyIndex).balance).toLocaleString(Qt.locale("en_US"), "f", decimals))
            property var balanceArray: balance.split('.')
            id: walletBalance1
            text: "." + balanceArray[1]
            anchors.right: walletBalance.left
            anchors.rightMargin: 5
            anchors.bottom: walletBalance.bottom
            font.pixelSize: 11
            color: "#828282"
            visible: transactionSent == 0
                     && addressbookTracker == 0
        }

        Text {
            property string balance: (newCoinSelect == 1 ? (currencyList.get(newCoinPicklist).balance).toLocaleString(Qt.locale("en_US"), "f", decimals) : (currencyList.get(currencyIndex).balance).toLocaleString(Qt.locale("en_US"), "f", decimals))
            property var balanceArray: balance.split('.')
            id: walletBalance2
            text: balanceArray[0]
            anchors.right: walletBalance1.left
            anchors.top: walletLabel.bottom
            anchors.topMargin: 1
            font.pixelSize: 14
            color: "#828282"
            visible: transactionSent == 0
                     && addressbookTracker == 0
        }

        Image {
            id: picklistArrow
            source: 'qrc:/icons/dropdown_icon.svg'
            height: 18
            width: 18
            anchors.left: picklistTracker == 0 ? coinID.right : transferPicklist.right
            anchors.leftMargin: 10
            anchors.verticalCenter: coinID.verticalCenter
            visible: transactionSent == 0
                     && addressbookTracker == 0
                     && picklistTracker == 0

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
                    picklistLinesActive()
                    picklistTracker = 1
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
            visible: picklistTracker == 1
                     && transactionSent == 0
                     && addressbookTracker == 0

            Controls.CurrencyPicklist {
                id: myCoinPicklist
                onlyActive: true
            }
        }

        Rectangle {
            id: picklistClose
            z: 11
            width: 100
            height: 25
            color: "#2A2C31"
            anchors.top: transferPicklist.bottom
            anchors.horizontalCenter: transferPicklist.horizontalCenter
            visible: picklistTracker == 1
                     && transactionSent == 0
                     && addressbookTracker == 0

            Image {
                id: picklistCloseArrow
                source: 'qrc:/icons/dropdown-arrow.svg'
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                rotation: 180
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    picklistTracker = 0
                }
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
            visible: modalState == 0
                     && transferSwitch.on == false
                     && transactionSent == 0
                     && addressbookTracker == 0
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
            visible: modalState == 0
                     && transferSwitch.on == false
                     && transactionSent == 0
                     && addressbookTracker == 0
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
            visible: modalState == 0
                     && transferSwitch.on == false
                     && transactionSent == 0
                     && addressbookTracker == 0
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
            visible: modalState == 0
                     && transferSwitch.on == false
                     && transactionSent == 0
                     && addressbookTracker == 0
        }

        Image {
            id: pasteIcon
            source: 'qrc:/icons/paste_icon.svg'
            width: 13
            height: 13
            anchors.left: pubKey.right
            anchors.leftMargin: 15
            anchors.verticalCenter: pubKey.verticalCenter
            visible: modalState == 0
                     && transferSwitch.on == false
                     && transactionSent == 0
                     && addressbookTracker == 0
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
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            validator: DoubleValidator {bottom: 0; top: (newCoinSelect == 1 ? (currencyList.get(newCoinPicklist).balance) : (currencyList.get(currencyIndex).balance))}
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0
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
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0
            mobile: 1
            validator: RegExpValidator { regExp: /[0-9A-Za-z]+/ }
            onTextChanged: checkAddress()
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
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && keyInput.text != ""
                     && invalidAddress == 1
        }

        Rectangle {
            id: scanQrButton
            width: (doubbleButtonWidth - 10) / 2
            height: 33
            anchors.top: keyInput.bottom
            anchors.topMargin: 20
            anchors.left: keyInput.left
            radius: 5
            border.color: "#5E8BFE"
            border.width: 2
            color: "transparent"
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0

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
                color: "#5E8BFE"
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Rectangle {
            id: addressBookButton
            width: (doubbleButtonWidth - 10) / 2
            height: 33
            radius: 5
            border.color: "#5E8BFE"
            border.width: 2
            color: "transparent"
            anchors.top: keyInput.bottom
            anchors.topMargin: 20
            anchors.right: keyInput.right
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0

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
                color: "#5E8BFE"
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
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0
            mobile: 1
        }

        DropShadow {
            anchors.fill: sendButton
            source: sendButton
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color:"#2A2C31"
            transparentBorder: true
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0
        }

        Rectangle {
            id: sendButton
            width: keyInput.width
            height: 33
            radius: 5
            color: (invalidAddress == 0
                    && keyInput.text !== ""
                    && sendAmount.text !== ""
                    && inputAmount !== 0
                    && inputAmount <= (newCoinSelect == 1 ? (currencyList.get(newCoinPicklist).balance) : (currencyList.get(currencyIndex).balance))) ? "#5E8BFE" : "#727272"
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
                    if (invalidAddress == 0
                            && keyInput.text !== ""
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
                color: "#F2F2F2"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // Transfer confirm state

        Rectangle {
            id: sendConfirmation
            width: parent.width
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            visible: transactionSent == 1
                     && confirmationSent == 0

            Text {
                id: confirmationText
                text: "CONFIRM TRANSACTION"
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Brandon Grotesque"
                font.pixelSize: 16
                font.weight: Font.Normal
                color: "#5E8BFE"
            }

            Text {
                id: sendingLabel
                text: "SENDING:"
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: confirmationText.bottom
                anchors.topMargin: 40
                font.family: "Brandon Grotesque"
                font.pixelSize: 16
                font.weight: Font.Normal
                color: "#F2F2F2"
            }

            Item {
                id:amount
                implicitWidth: confirmationAmount.implicitWidth + confirmationAmount1.implicitWidth + confirmationAmount2.implicitWidth + 7
                implicitHeight: confirmationAmount.implicitHeight
                anchors.bottom: sendingLabel.bottom
                anchors.right: parent.right
                anchors.rightMargin: 25
            }

            Text {
                id: confirmationAmount
                text: coinID.text
                anchors.top: amount.top
                anchors.right: amount.right
                font.family: "Brandon Grotesque"
                font.pixelSize: 16
                font.weight: Font.Medium
                color: "#F2F2F2"
            }

            Text {
                property string transferAmount: inputAmount.toLocaleString(Qt.locale("en_US"), "f", decimals)
                property var amountArray: transferAmount.split('.')
                id: confirmationAmount1
                text: "." + amountArray[1]
                anchors.bottom: confirmationAmount.bottom
                anchors.bottomMargin: 1
                anchors.right: confirmationAmount.left
                anchors.rightMargin: 7
                font.family: "Brandon Grotesque"
                font.pixelSize: 12
                font.weight: Font.Medium
                color: "#F2F2F2"
            }

            Text {
                property string transferAmount: inputAmount.toLocaleString(Qt.locale("en_US"), "f", decimals)
                property var amountArray: transferAmount.split('.')
                id: confirmationAmount2
                text: amountArray[0]
                anchors.top: confirmationAmount.top
                anchors.left: amount.left
                font.family: "Brandon Grotesque"
                font.pixelSize: 16
                font.weight: Font.Medium
                color: "#F2F2F2"
            }

            Text {
                id: to
                text: "TO:"
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: sendingLabel.bottom
                anchors.topMargin: 15
                font.family: "Brandon Grotesque"
                font.pixelSize: 16
                font.weight: Font.Normal
                color: "#F2F2F2"
            }

            Text {
                id: confirmationAddress
                text: keyInput.text
                anchors.bottom: to.bottom
                anchors.bottomMargin: 2
                anchors.right: parent.right
                anchors.rightMargin: 25
                font.family: "Brandon Grotesque"
                font.pixelSize: 12
                font.weight: Font.Normal
                color: "#F2F2F2"
            }

            Text {
                id: confirmationAddressName
                text: "(" + addressName + ")"
                anchors.top: confirmationAddress.bottom
                anchors.topMargin: 5
                anchors.right: parent.right
                anchors.rightMargin: 25
                font.family: "Brandon Grotesque"
                font.pixelSize: 16
                font.weight: Font.Normal
                color: "#F2F2F2"
                visible: addressName != ""
            }

            Text {
                id: reference
                text: "REF.:"
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: confirmationAddressName.bottom
                anchors.topMargin: 15
                font.family: "Brandon Grotesque"
                font.pixelSize: 16
                font.weight: Font.Normal
                color: "#F2F2F2"
                visible: referenceInput.text !== ""
            }

            Text {
                id: referenceText
                text: referenceInput.text
                anchors.bottom: reference.bottom
                anchors.right: parent.right
                anchors.rightMargin: 25
                font.family: "Brandon Grotesque"
                font.pixelSize: 16
                font.weight: Font.Normal
                color: "#F2F2F2"
                visible: referenceInput.text !== ""
            }

            DropShadow {
                anchors.fill: confirmationSendButton
                source: confirmationSendButton
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color:"#2A2C31"
                transparentBorder: true
            }

            Rectangle {
                id: confirmationSendButton
                width: (doubbleButtonWidth - 10) / 2
                height: 33
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 5
                radius: 5
                color: "#4BBE2E"

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
                    color: "#F2F2F2"
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            DropShadow {
                anchors.fill: cancelSendButton
                source: cancelSendButton
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color:"#2A2C31"
                transparentBorder: true
            }

            Rectangle {
                id: cancelSendButton
                width: (doubbleButtonWidth - 10) / 2
                height: 33
                radius: 5
                color: "#E55541"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 5

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
                    color: "#F2F2F2"
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
            visible: transactionSent == 1
                     && confirmationSent == 1

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
                    color: "#5E8BFE"
                }
            }

            Label {
                id: confirmedIconLabel
                text: "Transaction sent!"
                anchors.top: confirmedIcon.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: confirmedIcon.horizontalCenter
                color: "#5E8BFE"
                font.pixelSize: 14
                font.family: "Brandon Grotesque"
                font.bold: true
                visible: transactionSent == 1
                         && confirmationSent == 1
            }

            DropShadow {
                anchors.fill: closeConfirm
                source: closeConfirm
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color:"#2A2C31"
                transparentBorder: true
            }

            Rectangle {
                id: closeConfirm
                width: (parent.width - 45) / 2
                height: 33
                radius: 5
                color: "#5E8BFE"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: closeConfirm

                    onClicked: {
                        transactionDate = new Date().toLocaleDateString(Qt.locale(),"MM/dd")
                        if (coinID.text == "XBY"){
                            xbyTXHistory.append ({"date": transactionDate, "amount": Number.fromLocaleString(Qt.locale("en_US"), ("-"+sendAmount.text)), "txid": "", "txpartnerHash": keyInput.text, "reference": referenceText.text, "txNR": xbyTXID});
                            xbyTXID = xbyTXID + 1;
                            currencyList.setProperty(0, "balance", (getCurrentBalance() - Number.fromLocaleString(Qt.locale("en_US"), sendAmount.text)));
                            currencyList.setProperty(0, "fiatValue", ((currencyList.get(0).balance) * (currencyList.get(0).coinValue)));
                            totalBalance = sumBalance()
                        }
                        if (coinID.text == "XFUEL"){
                            xfuelTXHistory.append ({"date": transactionDate, "amount": Number.fromLocaleString(Qt.locale("en_US"), ("-"+sendAmount.text)), "txid": "", "txpartnerHash": keyInput.text, "reference": referenceText.text, "txNR": xfuelTXID});
                            xfuelTXID = xfuelTXID + 1;
                            currencyList.setProperty(1, "balance", (getCurrentBalance() - Number.fromLocaleString(Qt.locale("en_US"), sendAmount.text)));
                            currencyList.setProperty(1, "fiatValue", ((currencyList.get(1).balance) * (currencyList.get(1).coinValue)));
                            totalBalance = sumBalance()
                        }
                        if (coinID.text == "BTC"){
                            btcTXHistory.append ({"date": transactionDate, "amount": Number.fromLocaleString(Qt.locale("en_US"), ("-"+sendAmount.text)), "txid": "", "txpartnerHash": keyInput.text, "reference": referenceText.text, "txNR": btcTXID});
                            btcTXID = btcTXID + 1;
                            currencyList.setProperty(2, "balance", (getCurrentBalance() - Number.fromLocaleString(Qt.locale("en_US"), sendAmount.text)));
                            currencyList.setProperty(2, "fiatValue", ((currencyList.get(2).balance) * (currencyList.get(2).coinValue)));
                            totalBalance = sumBalance()
                        }
                        if (coinID.text == "ETH"){
                            ethTXHistory.append ({"date": transactionDate, "amount": Number.fromLocaleString(Qt.locale("en_US"), ("-"+sendAmount.text)), "txid": "", "txpartnerHash": keyInput.text, "reference": referenceText.text, "txNR": ethTXID});
                            ethTXID = ethTXID + 1;
                            currencyList.setProperty(3, "balance", (getCurrentBalance() - Number.fromLocaleString(Qt.locale("en_US"), sendAmount.text)));
                            currencyList.setProperty(3, "fiatValue", ((currencyList.get(3).balance) * (currencyList.get(3).coinValue)));
                            totalBalance = sumBalance()
                        }
                        sendAmount.text = ""
                        keyInput.text = ""
                        referenceInput.text = ""
                        selectedAddress = ""
                        confirmationSent = 0
                        transactionSent = 0
                        invalidAddress = 0
                        transactionDate = ""
                    }
                }

                Text {
                    text: "OK"
                    font.family: "Brandon Grotesque"
                    font.pointSize: 14
                    font.bold: true
                    color: "#F2F2F2"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // Addressbook state

        Rectangle {
            id: addressbookTitleBar
            width: parent.width
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: bodyModal.top
            anchors.bottomMargin: -4
            radius: 4
            color: "#34363D"
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 1
        }

        Rectangle {
            id: addressPicklistArea
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: bodyModal.top
            anchors.topMargin: 50
            anchors.bottom: bodyModal.bottom
            anchors.bottomMargin: 63
            color: "transparent"
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 1

            Mobile.AddressPicklist {
                id: myAddressPicklist
                selectedWallet: (coinID.text === "XBY" ? 0:
                                                         (coinID.text === "XFUEL" ? 1:
                                                                                    (coinID.text === "BTC" ? 2 : 3)))
            }
        }

        Rectangle {
            id: addressbookSpacerBar
            width: parent.width
            height: 50
            //radius: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: bodyModal.top
            color: "#42454F"
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 1
        }

        Image {
            id: addressbookCoinLogo
            source: coinIcon.source
            height: 25
            width: 25
            anchors.verticalCenter: addressbookSpacerBar.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 30
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 1
        }

        Label {
            id: addressbookCoinID
            text: coinID.text
            anchors.left: addressbookCoinLogo.right
            anchors.leftMargin: 7
            anchors.verticalCenter: addressbookCoinLogo.verticalCenter
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: "#F2F2F2"
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 1
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
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 1
        }

        Rectangle {
            width: parent.width
            height: 63
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: bodyModal.bottom
            //radius: 4
            color: "#42454F"
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 1
        }

        DropShadow {
            anchors.fill: cancelAddressButton
            source: cancelAddressButton
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color:"#2A2C31"
            transparentBorder: true
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 1
        }

        Rectangle {
            id: cancelAddressButton
            width: (bodyModal.width - 40) / 2
            height: 33
            radius: 5
            color: "#5E8BFE"
            anchors.bottom: bodyModal.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: bodyModal.horizontalCenter
            visible: modalState == 0
                     && transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 1

            MouseArea {
                anchors.fill: cancelAddressButton

                onClicked: {
                    addressbookTracker = 0
                }
            }

            Text {
                text: "BACK"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#F2F2F2"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // History wallet state

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
                searchFilter: searchTx.text
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
            visible: modalState == 1
                     && transferSwitch.state == "off"
        }

        Rectangle {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: historyScrollArea.bottom
            anchors.bottom: bodyModal.bottom
            //radius: 4
            color: "#42454F"
            visible: modalState == 1
                     && transferSwitch.state == "off"
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
            visible: modalState == 1
                     && transferSwitch.state == "off"
        }

        // History coin state

        Label {
            id: coinhistorySoon
            text: "Coming SOON"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: modalState == 1
                     && transferSwitch.state == "on"
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
        visible: transferTracker == 1
                 && confirmationSent == 0

        Rectangle{
            id: closeButton
            height: 30
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
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

