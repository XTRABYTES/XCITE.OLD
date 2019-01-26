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
import Clipboard 1.0
import QZXing 2.3
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: transactionModal
    width: 325
    state: transferTracker == 1? "up" : "down"
    height: transactionSent == 1 ? 358 : ((transferSwitch.state == "off") ? 488 : 458 )
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: Screen.height
    visible: scanQRTracker == 0

    states: [
        State {
            name: "up"
            PropertyChanges { target: transactionModal; anchors.topMargin: 50}
            PropertyChanges { target: transactionModal; opacity: 1}
            PropertyChanges { target: transferSwitch; state: (switchState == 0 ? "off" : "on")}
        },
        State {
            name: "down"
            PropertyChanges { target: transactionModal; anchors.topMargin: Screen.height}
            PropertyChanges { target: transactionModal; opacity: 0}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: transactionModal; properties: "anchors.topMargin, opacity"; duration: 300; easing.type: Easing.OutCubic}
        }
    ]

    //property string coinName: walletList.get(walletIndex).name
    //property real coinBalance: walletList.get(walletIndex).balance
    //property string coinAddress: walletList.get(walletIndex).address
    //property string coinLabel: walletList.get(walletIndex).label
    property int transactionSent: 0
    property int confirmationSent: 0
    property int invalidAddress: 0
    property int decimals: (coinID.text) == "BTC" ? 8 : 4
    property var inputAmount: Number.fromLocaleString(Qt.locale("en_US"),sendAmount.text)
    property string amountTransfer: "AMOUNT (" + coinID.text + ")"
    property string keyTransfer: "SEND TO (PUBLIC KEY)"
    property string referenceTransfer: "REFERENCE"
    property real amountSend: 0
    property string searchTxText: ""
    property string transactionDate: ""
    property int timestamp: 0
    property string addressName: compareAddress()
    property real currentBalance: getCurrentBalance()
    property int selectedWallet: getWalletNR(coinID.text, walletLabel.text)


    function compareAddress(){
        var fromto = ""
        for(var i = 0; i < addressList.count; i++) {
            if (addressList.get(i).address === keyInput.text) {
                if (addressList.get(i).coin === coinID.text) {
                    fromto = (contactList.get(addressList.get(i).contact).firstName) + " " + (contactList.get(addressList.get(i).contact).lastName) + " (" + (addressList.get(i).label) + ")"
                }
            }
        }
        return fromto
    }

   function checkAddress() {
        invalidAddress = 0
        if (coinID.text == "XBY") {
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
    }

    function getCurrentBalance(){
        var currentBalance = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).address === getAddress (coinID.text, walletLabel.text)) {
                currentBalance = walletList.get(i).balance
            }
        }
        return currentBalance
    }

    Rectangle {
        id: transferTitleBar
        width: parent.width
        height: 50
        anchors.top: parent.top
        anchors.left: parent.left
        color: "transparent"
        visible: transactionSent == 0
                 && addressbookTracker == 0
                 && scanQRTracker == 0

        Text {
            id: transferModalLabel
            text: "TRANSFER"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 27
            font.pixelSize: 18
            font.family: xciteMobile.name
            color: "#F2F2F2"
            font.letterSpacing: 2
        }
    }

    Rectangle {
        id: bodyModal
        width: parent.width
        height: parent.height - 50
        radius: 4
        color: darktheme == false? "#F7F7F7" : "#1B2934"
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter

        Controls.Switch_mobile {
            id: transferSwitch
            anchors.horizontalCenter: bodyModal.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            state: switchState == 0 ? "off" : "on"
            visible: transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
        }

        Text {
            id: receiveText
            text: "RECEIVE"
            anchors.right: transferSwitch.left
            anchors.rightMargin: 7
            anchors.verticalCenter: transferSwitch.verticalCenter
            font.pixelSize: 14
            font.family: xciteMobile.name
            color: transferSwitch.on ? "#757575" : maincolor
            visible: transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
        }
        Text {
            id: sendText
            text: "SEND"
            anchors.left: transferSwitch.right
            anchors.leftMargin: 7
            anchors.verticalCenter: transferSwitch.verticalCenter
            font.pixelSize: 14
            font.family: xciteMobile.name
            color: transferSwitch.on ? maincolor : "#757575"
            visible: transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
        }

        Image {
            id: coinIcon
            source: getLogo(coinID.text)
            width: 25
            height: 25
            anchors.left: sendAmount.left
            anchors.top: transferSwitch.bottom
            anchors.topMargin: 10
            visible: transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && coinListTracker == 0
        }

        Label {
            id: coinID
            text: newCoinSelect == 1 ? coinList.get(newCoinPicklist).name : walletList.get(walletIndex).name
            anchors.left: coinIcon.right
            anchors.leftMargin: 7
            anchors.verticalCenter: coinIcon.verticalCenter
            font.pixelSize: 18
            font.family: xciteMobile.name
            font.bold: true
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            visible: transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && coinListTracker == 0
            onTextChanged: if (keyInput.text != "") {
                               checkAddress()
                           }
        }

        Label {
            id: walletLabel
            text: (newWalletSelect == 0 && coinTracker == 0) ? walletList.get(defaultWallet(coinID.text)).label : walletList.get(walletIndex).label
            anchors.right: picklistArrow2.left
            anchors.rightMargin: 7
            anchors.verticalCenter: coinIcon.verticalCenter
            font.pixelSize: 18
            font.family: xciteMobile.name
            font.bold: true
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            visible: (transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && walletListTracker == 0)
                     || (transferSwitch.state == "off"
                         && walletListTracker == 0)
        }

        Text {
            id: walletBalance
            text: coinID.text
            anchors.right: sendAmount.right
            anchors.top: walletLabel.bottom
            anchors.topMargin: 2
            font.family: xciteMobile.name
            font.pixelSize: 14
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            visible: transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && walletListTracker == 0
        }

        Text {
            property string balance: (walletList.get(selectedWallet).balance).toLocaleString(Qt.locale("en_US"), "f", decimals)
            id: walletBalance1
            text: balance
            anchors.right: walletBalance.left
            anchors.rightMargin: 5
            anchors.bottom: walletBalance.bottom
            font.family: xciteMobile.name
            font.pixelSize: 14
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            visible: transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && walletListTracker == 0
        }

        Image {
            id: picklistArrow1
            source: 'qrc:/icons/dropdown_icon.svg'
            height: 18
            width: 18
            anchors.left: coinListTracker == 0 ? coinID.right : transferPicklist1.right
            anchors.leftMargin: 10
            anchors.verticalCenter: coinID.verticalCenter
            visible: transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && coinListTracker == 0
                     && calculatorTracker == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
            }

            Rectangle{
                id: picklistButton1
                height: 20
                width: 20
                radius: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
            }

            MouseArea {
                anchors.fill: picklistButton1

                onPressed: { click01.play() }

                onClicked: {
                    coinListLines(true)
                    coinListTracker = 1
                }
            }
        }

        DropShadow {
            id: shadowTransferPicklist1
            z:11
            anchors.fill: transferPicklist1
            source: transferPicklist1
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.3
            transparentBorder: true
            visible: coinListTracker == 1
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
        }

        Rectangle {
            id: transferPicklist1
            z: 11
            width: 100
            height: ((totalLines + 1) * 35)-10
            radius: 4
            color: "#2A2C31"
            anchors.top: coinIcon.top
            anchors.topMargin: -5
            anchors.left: coinIcon.left
            visible: coinListTracker == 1
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0

            Controls.CoinPicklist {
                id: myCoinPicklist
                onlyActive: true
            }
        }

        Rectangle {
            id: picklistClose1
            z: 11
            width: 100
            height: 25
            radius: 4
            color: "#2A2C31"
            anchors.bottom: transferPicklist1.bottom
            anchors.horizontalCenter: transferPicklist1.horizontalCenter
            visible: coinListTracker == 1
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0

            Image {
                id: picklistCloseArrow1
                source: 'qrc:/icons/dropdown-arrow.svg'
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                rotation: 180
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    coinListTracker = 0
                }
            }
        }

        Image {
            id: picklistArrow2
            source: 'qrc:/icons/dropdown_icon.svg'
            height: 18
            width: 18
            anchors.right: sendAmount.right
            anchors.verticalCenter: walletLabel.verticalCenter
            visible: transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && walletListTracker == 0
                     && calculatorTracker == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
            }

            Rectangle{
                id: picklistButton2
                height: 20
                width: 20
                radius: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
            }

            MouseArea {
                anchors.fill: picklistButton2

                onPressed: { click01.play() }

                onClicked: {
                    coinWalletLines(coinID.text)
                    walletListTracker = 1
                }
            }
        }

        DropShadow {
            id: shadowTransferPicklist2
            z:11
            anchors.fill: transferPicklist2
            source: transferPicklist2
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.3
            transparentBorder: true
            visible: walletListTracker == 1
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
        }

        Rectangle {
            id: transferPicklist2
            z: 11
            width: 100
            height: ((totalCoinWallets + 1) * 35)-10
            radius: 4
            color: "#2A2C31"
            anchors.top: coinIcon.top
            anchors.topMargin: -5
            anchors.right: picklistArrow2.right
            visible: walletListTracker == 1
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0

            Controls.WalletPicklist {
                id: myWalletPicklist
                coin: coinID.text
            }
        }

        Rectangle {
            id: picklistClose2
            z: 11
            width: 100
            height: 25
            radius: 4
            color: "#2A2C31"
            anchors.bottom: transferPicklist2.bottom
            anchors.horizontalCenter: transferPicklist2.horizontalCenter
            visible: walletListTracker == 1
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0

            Image {
                id: picklistCloseArrow2
                source: 'qrc:/icons/dropdown-arrow.svg'
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                rotation: 180
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    walletListTracker = 0
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
            color: "#FFFFFF"
            visible: transferSwitch.on == false
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
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
            visible: transferSwitch.on == false
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
        }

        Text {
            id: pubKey
            text: "PUBLIC KEY"
            anchors.top: qrBorder.bottom
            anchors.topMargin: 25
            anchors.horizontalCenter: parent.horizontalCenter
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            font.family: xciteMobile.name
            font.bold: true
            font.pixelSize: 14
            font.letterSpacing: 1
            visible: transferSwitch.on == false
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
        }

        Text {
            id: publicKey
            text: walletList.get(selectedWallet).address
            anchors.top: pubKey.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: pubKey.horizontalCenter
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            font.family: xciteMobile.name
            font.pixelSize: 12
            visible: transferSwitch.on == false
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
        }

        Image {
            id: copyIcon
            source: 'qrc:/icons/paste_icon.svg'
            width: 13
            height: 13
            anchors.left: pubKey.right
            anchors.leftMargin: 15
            anchors.verticalCenter: pubKey.verticalCenter
            visible: transferSwitch.on == false
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
            }

            Rectangle {
                id: copyButton
                anchors.fill: parent
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: "transparent"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        clipboard.setDataText(publicKey.text)
                        console.log("public key: " + clipboard.dataText + " copied to clipboard")
                    }
                }
            }
        }

        // Send state

        Mobile.AmountInput {
            id: sendAmount
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: walletBalance.bottom
            anchors.topMargin: 20
            placeholder: amountTransfer
            color: sendAmount.text !== "" ? "#F2F2F2" : "#727272"
            textBackground: darktheme == false? "#484A4D" : "#0B0B09"
            font.pixelSize: 14
            validator: DoubleValidator {bottom: 0; top: ((walletList.get(selectedWallet).balance))}
            visible: transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
            mobile: 1
        }

        Text {
            id: calculated
            text: calculatedAmount
            anchors.left: sendAmount.left
            anchors.top: sendAmount.bottom
            anchors.topMargin: 3
            visible: false
            onTextChanged: {
                sendAmount.text = calculated.text
            }
        }

        Label {
            text: "Insufficient funds"
            color: "#FD2E2E"
            anchors.left: sendAmount.left
            anchors.leftMargin: 5
            anchors.top: sendAmount.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: xciteMobile.name
            visible: transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && inputAmount > (walletList.get(selectedWallet).balance)
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
            textBackground: darktheme == false? "#484A4D" : "#0B0B09"
            font.pixelSize: 14
            visible: transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
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
            text: "Invalid address format!"
            color: "#FD2E2E"
            anchors.left: keyInput.left
            anchors.leftMargin: 5
            anchors.top: keyInput.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: xciteMobile.name
            visible: transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
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
            border.color: darktheme == false? "#42454F" : "#0ED8D2"
            border.width: 2
            color: "transparent"
            visible: transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0

            MouseArea {
                anchors.fill: scanQrButton

                onPressed: {
                    click01.play()
                }

                onReleased: {
                    scanQrButton.color = "transparent"
                    scanQRTracker = 1
                    scanning = "scanning..."
                }
            }

            Text {
                id: qrButtonText
                text: "SCAN QR"
                font.family: xciteMobile.name
                font.pointSize: 14
                color: darktheme == false? "#0ED8D2" : "#F2F2F2"
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
            border.color: darktheme == false? "#42454F" : "#0ED8D2"
            border.width: 2
            color: "transparent"
            anchors.top: keyInput.bottom
            anchors.topMargin: 20
            anchors.right: keyInput.right
            visible: transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0

            MouseArea {
                anchors.fill: addressBookButton

                onPressed: {
                    click01.play()
                }

                onReleased: {
                    addressBookButton.color = "transparent"
                    addressbookTracker = 1
                    currentAddress = getAddress(coinID.text, walletLabel.text)
                }
            }

            Text {
                id: addressButtonText
                text: "ADDRESS BOOK"
                font.family: xciteMobile.name
                font.pointSize: 14
                font.bold: true
                color: darktheme == false? "#0ED8D2" : "#F2F2F2"
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
            textBackground: darktheme == false? "#484A4D" : "#0B0B09"
            font.pixelSize: 14
            visible: transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
            mobile: 1
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
                    && inputAmount <= (walletList.get(selectedWallet).balance)) ? maincolor : (darktheme == false? "#727272" : "#14161B")
            anchors.bottom: bodyModal.bottom
            anchors.bottomMargin: 20
            anchors.left: referenceInput.left
            visible: transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0

            MouseArea {
                anchors.fill: sendButton

                onPressed: { click01.play() }

                onReleased: {
                    if (invalidAddress == 0
                            && keyInput.text !== ""
                            && sendAmount.text !== ""
                            && inputAmount !== 0
                            && inputAmount <= (walletList.get(selectedWallet).balance)
                            && calculatorTracker == 0) {
                        transactionSent = 1
                        coinListTracker = 0
                        walletListTracker = 0
                    }
                }
            }

            Text {
                text: "SEND"
                font.family: xciteMobile.name
                font.pointSize: 14
                font.bold: true
                color: (invalidAddress == 0
                        && keyInput.text !== ""
                        && sendAmount.text !== ""
                        && inputAmount !== 0
                        && inputAmount <= (walletList.get(selectedWallet).balance)) ? "#F2F2F2" : (darktheme == false? "#979797" : "#3F3F3F")
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
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 25
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: xciteMobile.name
                font.pixelSize: 16
                font.weight: Font.Normal
                color: "#F2F2F2"
            }

            Text {
                id: sendingLabel
                text: "SENDING:"
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: confirmationText.bottom
                anchors.topMargin: 30
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
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
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
            }

            Text {
                property string transferAmount: inputAmount.toLocaleString(Qt.locale("en_US"), "f", decimals)
                property var amountArray: transferAmount.split('.')
                id: confirmationAmount1
                text: "." + amountArray[1]
                anchors.bottom: confirmationAmount.bottom
                anchors.bottomMargin: 2
                anchors.right: confirmationAmount.left
                anchors.rightMargin: 7
                font.family: xciteMobile.name
                font.pixelSize: 12
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
            }

            Text {
                property string transferAmount: inputAmount.toLocaleString(Qt.locale("en_US"), "f", decimals)
                property var amountArray: transferAmount.split('.')
                id: confirmationAmount2
                text: amountArray[0]
                anchors.top: confirmationAmount.top
                anchors.left: amount.left
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
            }

            Text {
                id: to
                text: "TO:"
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: sendingLabel.bottom
                anchors.topMargin: 15
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
            }

            Text {
                id: confirmationAddress
                text: addressName != ""? addressName : keyInput.text
                anchors.bottom: to.bottom
                anchors.bottomMargin: 2
                anchors.right: parent.right
                anchors.rightMargin: 25
                font.family: xciteMobile.name
                font.pixelSize: addressName != ""? 16 : 10
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
            }

            Text {
                id: confirmationAddressName
                text: "(" + keyInput.text + ")"
                anchors.top: confirmationAddress.bottom
                anchors.topMargin: 5
                anchors.right: parent.right
                anchors.rightMargin: 25
                font.family: xciteMobile.name
                font.pixelSize: 10
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                visible: addressName != ""
            }

            Text {
                id: reference
                text: "REF.:"
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: confirmationAddressName.bottom
                anchors.topMargin: 5
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                visible: referenceInput.text !== ""
            }

            Text {
                id: referenceText
                text: referenceInput.text
                anchors.bottom: reference.bottom
                anchors.right: parent.right
                anchors.rightMargin: 25
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                visible: referenceInput.text !== ""
            }

            Text {
                id: feeLabel
                text: "TRANSACTION FEE:"
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: reference.bottom
                anchors.topMargin: 15
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
            }

            Item {
                id:feeAmount
                implicitWidth: confirmationFeeAmount.implicitWidth + confirmationFeeAmount1.implicitWidth + confirmationFeeAmount2.implicitWidth + 7
                implicitHeight: confirmationAmount.implicitHeight
                anchors.bottom: feeLabel.bottom
                anchors.right: parent.right
                anchors.rightMargin: 25
            }

            Text {
                id: confirmationFeeAmount
                text: coinID.text
                anchors.top: feeAmount.top
                anchors.right: feeAmount.right
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
            }

            Text {
                id: confirmationFeeAmount1
                text: ".0000"
                anchors.bottom: confirmationFeeAmount.bottom
                anchors.bottomMargin: 2
                anchors.right: confirmationFeeAmount.left
                anchors.rightMargin: 7
                font.family: xciteMobile.name
                font.pixelSize: 12
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
            }

            Text {
                id: confirmationFeeAmount2
                text: "1"
                anchors.top: confirmationFeeAmount.top
                anchors.left: feeAmount.left
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
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

                    onPressed: { click01.play() }

                    onReleased: {
                        confirmationSent = 1
                        // whatever function needed to execute payment
                    }
                }

                Text {
                    text: "CONFIRM"
                    font.family: xciteMobile.name
                    font.pointSize: 14
                    color: "#F2F2F2"
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
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

                    onPressed: { click01.play() }

                    onReleased: {
                        transactionSent = 0
                    }
                }

                Text {
                    text: "CANCEL"
                    font.family: xciteMobile.name
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
                source: 'qrc:/icons/icon-success.svg'
                width: 120
                height: 120
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -15

                ColorOverlay {
                    anchors.fill: parent
                    source: confirmedIcon
                    color: maincolor
                }
            }

            Label {
                id: confirmedIconLabel
                text: "Transaction sent!"
                anchors.top: confirmedIcon.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: confirmedIcon.horizontalCenter
                color: maincolor
                font.pixelSize: 14
                font.family: xciteMobile.name
                font.bold: true
                visible: transactionSent == 1
                         && confirmationSent == 1
            }

            Rectangle {
                id: closeConfirm
                width: (parent.width - 45) / 2
                height: 33
                radius: 5
                color: maincolor
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: closeConfirm

                    onPressed: { click01.play() }

                    onReleased: {
                        transactionDate = new Date().toLocaleDateString(Qt.locale(),"dd MMM yy")
                        timestamp = Number.fromLocaleString(new Date().toLocaleDateString(Qt.locale(),"yyMMdd") + new Date().toLocaleTimeString(Qt.locale(),"HHmmsszzz"))
                        transactionList.append ({"coinName": coinID.text, "walletLabel": walletLabel.text, "date": transactionDate, "amount": Number.fromLocaleString(Qt.locale("en_US"), ("-"+sendAmount.text)), "txPartner": keyInput.text, "reference": referenceText.text, "txid": txID, "txNR": timestamp })
                        txID = txID + 1
                        sendAmount.text = ""
                        keyInput.text = ""
                        referenceInput.text = ""
                        selectedAddress = ""
                        confirmationSent = 0
                        transactionSent = 0
                        invalidAddress = 0
                        transactionDate = ""
                        timestamp = 0
                        // update wallet balance
                    }
                }

                Text {
                    text: "OK"
                    font.family: xciteMobile.name
                    font.pointSize: 14
                    font.bold: true
                    color: "#F2F2F2"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // Addressbook

        Rectangle {
            id: addressbookTitleBar
            z: -1
            width: parent.width
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: bodyModal.top
            anchors.bottomMargin: darktheme == false? -8 : 0
            color: "transparent"
            visible: transferSwitch.on == true
                     && transactionSent == 0
                     && (addressbookTracker == 1)
        }

        Label {
            id: addressbookTitle
            text: "ADDRESSBOOK"
            anchors.horizontalCenter: bodyModal.horizontalCenter
            anchors.verticalCenter: addressbookTitleBar.top
            anchors.verticalCenterOffset: 27
            font.pixelSize: 20
            font.family: xciteMobile.name
            font.bold: true
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            visible: transferSwitch.on == true
                     && transactionSent == 0
                     && ( addressbookTracker == 1)
        }

        Rectangle {
            id: addressPicklistArea
            width: parent.width
            radius: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: bodyModal.top
            anchors.topMargin: 50
            anchors.bottom: bodyModal.bottom
            anchors.bottomMargin: 63
            color: "transparent"
            visible: transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 1

            Mobile.AddressPicklist {
                id: myAddressPicklist
                selectedWallet: (coinID.text === "XBY" ? 0 : 1)
            }
        }

        Image {
            id: addressbookCoinLogo
            source: coinIcon.source
            height: 25
            width: 25
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 25
            anchors.left: parent.left
            anchors.leftMargin: 30
            visible: transferSwitch.on == true
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
            font.family: xciteMobile.name
            font.bold: true
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            visible: transferSwitch.on == true
                     && transactionSent == 0
                     && addressbookTracker == 1
        }

        Rectangle {
            id: cancelAddressButton
            width: (bodyModal.width - 40) / 2
            height: 33
            radius: 5
            color: "transparent"
            border.color: maincolor
            border.width: 2
            anchors.bottom: bodyModal.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: bodyModal.horizontalCenter
            visible: transferSwitch.on == true
                     && transactionSent == 0
                     && (addressbookTracker == 1)

            MouseArea {
                anchors.fill: cancelAddressButton

                onPressed: {
                   click01.play()
                }

                onReleased: {
                    cancelAddressButton.color = "transparent"
                    addressbookTracker = 0
                    currentAddress = ""
                }
            }

            Text {
                text: "BACK"
                font.family: xciteMobile.name
                font.pointSize: 14
                font.bold: true
                color: darktheme == false? "#0ED8D2" : "#F2F2F2"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    // Crypto converter

    Mobile.CryptoCalculator {
        id: calculator
        toCurrency: coinID.text
        visible: calculatorTracker == 1 && transferTracker == 1
    }

    Label {
        id: closeTransferModal
        z: 10
        text: "CLOSE"
        anchors.top: bodyModal.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: bodyModal.horizontalCenter
        font.pixelSize: 14
        font.family: xciteMobile.name
        color: "#F2F2F2"
        visible: transferTracker == 1
                 && transactionSent == 0
                 && confirmationSent == 0
                 && calculatorTracker == 0
                 && scanQRTracker == 0
                 && addressbookTracker == 0

        Rectangle{
            id: closeButton
            height: 34
            width: doubbleButtonWidth
            radius: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"
         }

        MouseArea {
            anchors.fill: closeButton

            Timer {
                id: timer
                interval: 300
                repeat: false
                running: false

                onTriggered: {
                    addressbookTracker = 0
                    coinListTracker = 0
                    walletListTracker = 0
                    walletIndex = 0
                    addressIndex = 0
                    switchState = 0
                    transactionSent =0
                    confirmationSent = 0
                    newCoinSelect = 0
                    newCoinPicklist = 0
                    newWalletPicklist = 0
                    newWalletSelect = 0
                    selectedAddress = ""
                    sendAmount.text = ""
                    keyInput.text = sendAddress.text
                    referenceInput.text = ""
                    invalidAddress = 0
                    calculatorTracker = 0
                    calculatedAmount = ""
                    scanQRTracker = 0
                    scanning = "scanning..."
                }
            }

            onPressed: {
                closeTransferModal.anchors.topMargin = 12
                click01.play()
            }

            onReleased: {
                closeTransferModal.anchors.topMargin = 10
                transferTracker = 0;
                timer.start()
            }
        }
    }
}

