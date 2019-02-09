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
    width: Screen.width
    state: transferTracker == 1? "up" : "down"
    height: Screen.height
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: Screen.height
    visible: scanQRTracker == 0

    states: [
        State {
            name: "up"
            PropertyChanges { target: transactionModal; anchors.topMargin: 0}
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

    property int transactionSend: 0
    property int confirmationSend: 0
    property int failedSend: 0
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

    Text {
        id: transferModalLabel
        text: "TRANSFER"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 18
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        visible: addressbookTracker == 0
    }

    Flickable {
        id: scrollArea
        width: parent.width
        contentHeight: (transactionSend == 0 && confirmationSend == 0)? transferScrollArea.height + 125 : scrollArea.height + 125
        anchors.left: parent.left
        anchors.top: transferModalLabel.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: (transactionSend == 0 && confirmationSend == 0)? 10 : 0
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        Rectangle {
            id: transferScrollArea
            width: parent.width
            anchors.top: parent.top
            anchors.bottom: publicKey.bottom
            color: "transparent"
        }

        Controls.Switch_mobile {
            id: transferSwitch
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 30
            state: switchState == 0 ? "off" : "on"
            visible: transactionSend == 0
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
            visible: transactionSend == 0
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
            visible: transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
        }

        Image {
            id: coinIcon
            source: getLogo(coinID.text)
            width: 30
            height: 30
            anchors.left: sendAmount.left
            anchors.top: transferSwitch.bottom
            anchors.topMargin: 20
            visible: transactionSend == 0
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
            font.pixelSize: 24
            font.family: xciteMobile.name
            font.bold: true
            font.letterSpacing: 2
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: transactionSend == 0
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
            anchors.verticalCenterOffset: 2
            font.pixelSize: 20
            font.family: xciteMobile.name
            font.bold: true
            font.letterSpacing: 2
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: (transactionSend == 0
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
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: transactionSend == 0
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
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && walletListTracker == 0
        }

        Image {
            id: picklistArrow1
            source: 'qrc:/icons/dropdown_icon.svg'
            height: 20
            width: 20
            anchors.left: coinListTracker == 0 ? coinID.right : transferPicklist1.right
            anchors.leftMargin: 10
            anchors.verticalCenter: coinID.verticalCenter
            visible: transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && coinListTracker == 0
                     && calculatorTracker == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
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
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
        }

        Rectangle {
            id: transferPicklist1
            z: 11
            width: 100
            height: ((totalLines + 1) * 35)-10
            color: "#2A2C31"
            anchors.top: coinIcon.top
            anchors.topMargin: -5
            anchors.left: coinIcon.left
            visible: coinListTracker == 1
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
            clip: true

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
            color: "#2A2C31"
            anchors.bottom: transferPicklist1.bottom
            anchors.horizontalCenter: transferPicklist1.horizontalCenter
            visible: coinListTracker == 1
                     && transactionSend == 0
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
            height: 20
            width: 20
            anchors.right: sendAmount.right
            anchors.verticalCenter: walletLabel.verticalCenter
            visible: transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && walletListTracker == 0
                     && calculatorTracker == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
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
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
        }

        Rectangle {
            id: transferPicklist2
            z: 11
            width: 100
            height: ((totalCoinWallets + 1) * 35)-10
            color: "#2A2C31"
            anchors.top: coinIcon.top
            anchors.topMargin: -5
            anchors.right: picklistArrow2.right
            visible: walletListTracker == 1
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
            clip: true

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
            color: "#2A2C31"
            anchors.bottom: transferPicklist2.bottom
            anchors.horizontalCenter: transferPicklist2.horizontalCenter
            visible: walletListTracker == 1
                     && transactionSend == 0
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
                     && transactionSend == 0
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
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
        }

        Text {
            id: pubKey
            text: "PUBLIC KEY"
            anchors.top: qrBorder.bottom
            anchors.topMargin: 25
            anchors.horizontalCenter: parent.horizontalCenter
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            font.family: xciteMobile.name
            font.bold: true
            font.pixelSize: 14
            font.letterSpacing: 1
            visible: transferSwitch.on == false
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
        }

        Text {
            id: publicKey
            text: walletList.get(selectedWallet).address
            anchors.top: pubKey.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: pubKey.horizontalCenter
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            font.family: xciteMobile.name
            font.pixelSize: 12
            visible: transferSwitch.on == false
                     && transactionSend == 0
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
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
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
                        click01.play()
                        clipboard.setText(publicKey.text)
                        console.log("public key: " + clipboard.text + " copied to clipboard")
                    }
                }
            }
        }

        // Send state

        Mobile.AmountInput {
            id: sendAmount
            height: 34
            anchors.right: parent.right
            anchors.rightMargin: 28
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: walletBalance.bottom
            anchors.topMargin: 20
            placeholder: amountTransfer
            color: sendAmount.text !== "" ? (darktheme == false? "#2A2C31" : "#F2F2F2") : "#727272"
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            validator: DoubleValidator {bottom: 0; top: ((walletList.get(selectedWallet).balance))}
            visible: transferSwitch.on == true
                     && transactionSend == 0
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
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && inputAmount > (walletList.get(selectedWallet).balance)
        }

        Controls.TextInput {
            id: keyInput
            text: sendAddress.text
            height: 34
            width: sendAmount.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: sendAmount.bottom
            anchors.topMargin: 15
            placeholder: keyTransfer
            color: keyInput.text != "" ? (darktheme == false? "#2A2C31" : "#F2F2F2") : "#727272"
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            visible: transferSwitch.on == true
                     && transactionSend == 0
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
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && keyInput.text != ""
                     && invalidAddress == 1
        }

        Rectangle {
            id: scanQrButton
            width: (sendAmount.width - 14) / 2
            height: 34
            anchors.top: keyInput.bottom
            anchors.topMargin: 20
            anchors.left: keyInput.left
            border.color: maincolor
            border.width: 1
            color: "transparent"
            visible: transferSwitch.on == true
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0

            MouseArea {
                anchors.fill: scanQrButton

                onPressed: {
                    click01.play()
                    parent.border.color = themecolor
                }

                onCanceled: {
                    parent.border.color = maincolor
                }

                onReleased: {
                    parent.border.color = maincolor
                }

                onClicked: {
                    scanQRTracker = 1
                    scanning = "scanning..."
                }
            }

            Text {
                id: qrButtonText
                text: "SCAN QR"
                font.family: xciteMobile.name
                font.pointSize: 14
                color: darktheme == true? "#F2F2F2" : maincolor
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Rectangle {
            id: addressBookButton
            width: (sendAmount.width - 14) / 2
            height: 34
            border.color: maincolor
            border.width: 1
            color: "transparent"
            anchors.top: keyInput.bottom
            anchors.topMargin: 20
            anchors.right: keyInput.right
            visible: transferSwitch.on == true
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0

            MouseArea {
                anchors.fill: addressBookButton

                onPressed: {
                    click01.play()
                    parent.border.color = themecolor
                }

                onCanceled: {
                    parent.border.color = maincolor
                }

                onReleased: {
                    parent.border.color = maincolor
                }

                onClicked: {
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
                color: darktheme == true? "#F2F2F2" : maincolor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Controls.TextInput {
            id: referenceInput
            height: 34
            width: keyInput.width
            placeholder: referenceTransfer
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: scanQrButton.bottom
            anchors.topMargin: 20
            color: referenceInput.text != "" ? (darktheme == false? "#2A2C31" : "#F2F2F2") : "#727272"
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            visible: transferSwitch.on == true
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
            mobile: 1
        }

        Rectangle {
            id: sendButton
            width: keyInput.width
            height: 34
            color: (invalidAddress == 0
                    && keyInput.text !== ""
                    && sendAmount.text !== ""
                    && inputAmount !== 0
                    && inputAmount <= (walletList.get(selectedWallet).balance)) ? maincolor : "#727272"
            opacity: darktheme == true? 0.25 : 0.5
            anchors.top: referenceInput.bottom
            anchors.topMargin: 30
            anchors.left: referenceInput.left
            visible: transferSwitch.on == true
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0

            MouseArea {
                anchors.fill: sendButton

                onPressed: {
                    click01.play()
                }

                onCanceled: {
                }

                onReleased: {
                }

                onClicked: {
                    if (invalidAddress == 0
                            && keyInput.text !== ""
                            && sendAmount.text !== ""
                            && inputAmount !== 0
                            && inputAmount <= (walletList.get(selectedWallet).balance)
                            && calculatorTracker == 0) {
                        transactionSend = 1
                        coinListTracker = 0
                        walletListTracker = 0
                    }
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
                    && inputAmount <= (walletList.get(selectedWallet).balance)) ? (darktheme == false? "#F2F2F2" : maincolor) : "#979797"
            anchors.horizontalCenter: sendButton.horizontalCenter
            anchors.verticalCenter: sendButton.verticalCenter
            visible: sendButton.visible
        }

        Rectangle {
            width: keyInput.width
            height: 34
            color: "transparent"
            border.color: (invalidAddress == 0
                           && keyInput.text !== ""
                           && sendAmount.text !== ""
                           && inputAmount !== 0
                           && inputAmount <= (walletList.get(selectedWallet).balance)) ? maincolor : "#979797"
            border.width: 1
            opacity: darktheme == true? 0.5 : 0.75
            anchors.horizontalCenter: sendButton.horizontalCenter
            anchors.verticalCenter: sendButton.verticalCenter
            visible: sendButton.visible
        }

        // Transfer confirm state

        Rectangle {
            id: sendConfirmation
            width: parent.width
            height: sendingLabel.height + to.height + confirmationAddressName.height + reference.height + feeLabel.height + cancelSendButton.height + 70
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -125
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        Text {
            id: sendingLabel
            text: "SENDING:"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: sendConfirmation.top
            font.family: xciteMobile.name
            font.pixelSize: 16
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        Item {
            id:amount
            implicitWidth: confirmationAmount.implicitWidth + confirmationAmount1.implicitWidth + confirmationAmount2.implicitWidth + 7
            implicitHeight: confirmationAmount.implicitHeight
            anchors.bottom: sendingLabel.bottom
            anchors.right: parent.right
            anchors.rightMargin: 28
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        Text {
            id: confirmationAmount
            text: coinID.text
            anchors.top: amount.top
            anchors.right: amount.right
            font.family: xciteMobile.name
            font.pixelSize: 16
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
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
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
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
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        Text {
            id: to
            text: "TO:"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: sendingLabel.bottom
            anchors.topMargin: 15
            font.family: xciteMobile.name
            font.pixelSize: 16
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        Text {
            id: confirmationAddress
            text: addressName != ""? addressName : keyInput.text
            anchors.bottom: to.bottom
            anchors.bottomMargin: 2
            anchors.right: parent.right
            anchors.rightMargin: 28
            font.family: xciteMobile.name
            font.pixelSize: addressName != ""? 16 : 10
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
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
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: addressName != ""
                     && transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        Text {
            id: reference
            text: "REF.:"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: confirmationAddressName.bottom
            anchors.topMargin: 5
            font.family: xciteMobile.name
            font.pixelSize: 16
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: referenceInput.text !== ""
                     && transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        Text {
            id: referenceText
            text: referenceInput.text
            anchors.bottom: reference.bottom
            anchors.right: parent.right
            anchors.rightMargin: 28
            font.family: xciteMobile.name
            font.pixelSize: 16
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: referenceInput.text !== ""
                     && transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        Text {
            id: feeLabel
            text: "TRANSACTION FEE:"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: reference.bottom
            anchors.topMargin: 15
            font.family: xciteMobile.name
            font.pixelSize: 16
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        Item {
            id:feeAmount
            implicitWidth: confirmationFeeAmount.implicitWidth + confirmationFeeAmount1.implicitWidth + confirmationFeeAmount2.implicitWidth + 7
            implicitHeight: confirmationAmount.implicitHeight
            anchors.bottom: feeLabel.bottom
            anchors.right: parent.right
            anchors.rightMargin: 28
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        Text {
            id: confirmationFeeAmount
            text: coinID.text
            anchors.top: feeAmount.top
            anchors.right: feeAmount.right
            font.family: xciteMobile.name
            font.pixelSize: 16
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
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
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        Text {
            id: confirmationFeeAmount2
            text: "1"
            anchors.top: confirmationFeeAmount.top
            anchors.left: feeAmount.left
            font.family: xciteMobile.name
            font.pixelSize: 16
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        Rectangle {
            id: confirmationSendButton
            width: (Screen.width - 66) / 2
            height: 34
            anchors.top: feeLabel.bottom
            anchors.topMargin: 30
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 5
            color: "#4BBE2E"
            opacity: darktheme == true? 0.25 : 0.5
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0

            MouseArea {
                anchors.fill: confirmationSendButton

                onPressed: {
                    click01.play()
                }

                onCanceled: {
                }

                onReleased: {
                }

                onClicked: {
                    if (userSettings.pinlock === true){
                        pincodeTracker = 1
                    }
                    else {
                        // whatever function needed to execute payment
                        requestSend = 1
                    }
                }
            }
            /**
            Connections {
                target: sendCoins
                ontransferSucceededChanged: {
                    confirmationSend == 1
                    // function to add TX info to Transaction History List
                }

                onTransferFailedChanged: {
                    if(networkError == 0){
                    failedSend = 1
                    }
                }

                onNetworkError: {
                    networkError = 1
                }
            }
            */
        }

        Text {
            text: "CONFIRM"
            font.family: xciteMobile.name
            font.pointSize: 14
            color: "#4BBE2E"
            opacity: darktheme == true? 0.5 : 0.75
            font.bold: true
            anchors.horizontalCenter: confirmationSendButton.horizontalCenter
            anchors.verticalCenter: confirmationSendButton.verticalCenter
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        Rectangle {
            width: (Screen.width - 66) / 2
            height: 34
            anchors.horizontalCenter: confirmationSendButton.horizontalCenter
            anchors.verticalCenter: confirmationSendButton.verticalCenter
            color: "transparent"
            border.color: "#4BBE2E"
            border.width: 1
            opacity: darktheme == true? 0.5 : 0.75
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        Rectangle {
            id: cancelSendButton
            width: (Screen.width - 66) / 2
            height: 34
            color: "#E55541"
            opacity: darktheme == true? 0.25 : 0.5
            anchors.top: feeLabel.bottom
            anchors.topMargin: 30
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 5
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0

            MouseArea {
                anchors.fill: cancelSendButton

                onPressed: {
                    click01.play()
                }

                onCanceled: {
                }

                onReleased: {
                }

                onClicked: {
                    transactionSend = 0
                }
            }
        }

        Text {
            text: "CANCEL"
            font.family: xciteMobile.name
            font.pointSize: 14
            font.bold: true
            color: "#E55541"
            opacity: darktheme == true? 0.5 : 0.75
            anchors.horizontalCenter: cancelSendButton.horizontalCenter
            anchors.verticalCenter: cancelSendButton.verticalCenter
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        Rectangle {
            width: (Screen.width - 66) / 2
            height: 34
            color: "transparent"
            border.color: "#E55541"
            border.width: 1
            opacity: darktheme == true? 0.5 : 0.75
            anchors.horizontalCenter: cancelSendButton.horizontalCenter
            anchors.verticalCenter: cancelSendButton.verticalCenter
            visible: transactionSend == 1
                     && confirmationSend == 0
                     &&requestSend == 0
        }

        // Wait for feedback

        AnimatedImage {
            id: waitingDots
            source: 'qrc:/gifs/loading_02.gif'
            width: 128
            height: 128
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -125
            playing: requestSend == 1
            visible: requestSend == 1

            // Just to get past this stage

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    confirmationSend = 1
                    requestSend = 0
                }
            }
        }

        Label {
            id: waitingText
            text: "Waiting for confirmation ..."
            anchors.bottom: waitingDots.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.bold: true
            visible: requestSend == 1
        }

        // Transfer failed state

        Rectangle {
            id: transferFailed
            width: parent.width
            height: failedIcon.height + failedIconLabel.height + closeFail.height + 60
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -125
            visible: transactionSend == 1
                     && failedSend == 1
        }

        Image {
            id: failedIcon
            source: 'qrc:/icons/icon-delete-mobile.svg'
            width: 120
            height: 120
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: transferFailed.top
            visible: transactionSend == 1
                     && failedSend == 1

            ColorOverlay {
                anchors.fill: parent
                source: confirmedIcon
                color: maincolor
            }
        }

        Label {
            id: failedIconLabel
            text: "Transaction failed!"
            anchors.top: confirmedIcon.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: failedIcon.horizontalCenter
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.bold: true
            visible: transactionSend == 1
                     && failedSend == 1
        }

        Rectangle {
            id: closeFail
            width: doubbleButtonWidth / 2
            height: 34
            color: maincolor
            opacity: darktheme == true? 0.25 : 0.5
            anchors.top: failedIconLabel.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: transactionSend == 1
                     && failedSend == 1

            MouseArea {
                anchors.fill: closeFail

                onPressed: {
                    click01.play()
                }

                onCanceled: {
                }

                onReleased: {
                }

                onClicked: {
                    sendAmount.text = ""
                    keyInput.text = ""
                    referenceInput.text = ""
                    selectedAddress = ""
                    failedSend = 0
                    transactionSend = 0
                    invalidAddress = 0
                    transactionDate = ""
                    timestamp = 0
                }
            }
        }

        Text {
            text: "OK"
            font.family: xciteMobile.name
            font.pointSize: 14
            font.bold: true
            color: darktheme == true? "#F2F2F2" : maincolor
            opacity: darktheme == true? 0.5 : 0.75
            anchors.horizontalCenter: closeFail.horizontalCenter
            anchors.verticalCenter: closeFail.verticalCenter
            visible: transactionSend == 1
                     && failedSend == 1
        }

        Rectangle {
            width: doubbleButtonWidth / 2
            height: 34
            color: "transparent"
            border.color: maincolor
            border.width: 1
            opacity: darktheme == true? 0.5 : 0.75
            anchors.horizontalCenter: closeFail.horizontalCenter
            anchors.verticalCenter: closeFail.verticalCenter
            visible: transactionSend == 1
                     && failedSend == 1
        }

        // Transfer sent state

        Rectangle {
            id: transferConfirmed
            width: parent.width
            height: confirmedIcon.height + confirmedIconLabel.height + closeConfirm.height + 60
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -125
            visible: transactionSend == 1
                     && confirmationSend == 1
        }

        Image {
            id: confirmedIcon
            source: 'qrc:/icons/icon-success.svg'
            width: 120
            height: 120
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: transferConfirmed.top
            visible: transactionSend == 1
                     && confirmationSend == 1

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
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.bold: true
            visible: transactionSend == 1
                     && confirmationSend == 1
        }

        Rectangle {
            id: closeConfirm
            width: doubbleButtonWidth / 2
            height: 34
            color: maincolor
            opacity: darktheme == true? 0.25 : 0.5
            anchors.top: confirmedIconLabel.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: transactionSend == 1
                     && confirmationSend == 1

            MouseArea {
                anchors.fill: closeConfirm

                onPressed: {
                    click01.play()
                }

                onCanceled: {
                }

                onReleased: {
                }

                onClicked: {
                    // provisional TX info
                    transactionDate = new Date().toLocaleDateString(Qt.locale(),"dd MMM yy")
                    timestamp = Number.fromLocaleString(new Date().toLocaleDateString(Qt.locale(),"yyMMdd") + new Date().toLocaleTimeString(Qt.locale(),"HHmmsszzz"))
                    transactionList.append ({"coinName": coinID.text, "walletLabel": walletLabel.text, "date": transactionDate, "amount": Number.fromLocaleString(Qt.locale("en_US"), ("-"+sendAmount.text)), "txPartner": keyInput.text, "reference": referenceText.text, "txid": txID, "txNR": timestamp })
                    txID = txID + 1

                    sendAmount.text = ""
                    keyInput.text = ""
                    referenceInput.text = ""
                    selectedAddress = ""
                    confirmationSend = 0
                    transactionSend = 0
                    invalidAddress = 0
                    transactionDate = ""
                    timestamp = 0
                    // update wallet balance
                }
            }
        }

        Text {
            text: "OK"
            font.family: xciteMobile.name
            font.pointSize: 14
            font.bold: true
            color: darktheme == true? "#F2F2F2" : maincolor
            opacity: darktheme == true? 0.5 : 0.75
            anchors.horizontalCenter: closeConfirm.horizontalCenter
            anchors.verticalCenter: closeConfirm.verticalCenter
            visible: transactionSend == 1
                     && confirmationSend == 1
        }

        Rectangle {
            width: doubbleButtonWidth / 2
            height: 34
            color: "transparent"
            border.color: maincolor
            border.width: 1
            opacity: darktheme == true? 0.5 : 0.75
            anchors.horizontalCenter: closeConfirm.horizontalCenter
            anchors.verticalCenter: closeConfirm.verticalCenter
            visible: transactionSend == 1
                     && confirmationSend == 1
        }
    }

    // Addressbook

    Label {
        id: addressbookTitle
        text: "ADDRESSBOOK"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.letterSpacing: 2
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: transferSwitch.on == true
                 && transactionSend == 0
                 && ( addressbookTracker == 1)
    }

    Image {
        id: addressbookCoinLogo
        source: coinIcon.source
        height: 25
        width: 25
        anchors.top: addressbookTitle.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 30
        visible: transferSwitch.on == true
                 && transactionSend == 0
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
                 && transactionSend == 0
                 && addressbookTracker == 1
    }

    Rectangle {
        id: addressPicklistArea
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: addressbookCoinLogo.bottom
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        color: "transparent"
        visible: transferSwitch.on == true
                 && transactionSend == 0
                 && addressbookTracker == 1
        clip: true

        Mobile.AddressPicklist {
            id: myAddressPicklist
            selectedWallet: (coinID.text === "XBY" ? 0 : 1)
        }
    }

    Item {
        width: Screen.width
        height: 125
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        visible: transferSwitch.on == true
                 && transactionSend == 0
                 && addressbookTracker == 1

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(x, y)
            end: Qt.point(x, y + height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.5; color: darktheme == true? "#14161B" : "#FDFDFD" }
                GradientStop { position: 1.0; color: darktheme == true? "#14161B" : "#FDFDFD" }
            }
        }
    }

    Rectangle {
        id: cancelAddressButton
        width: doubbleButtonWidth / 2
        height: 33
        color: "transparent"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        visible: transferSwitch.on == true
                 && transactionSend == 0
                 && (addressbookTracker == 1)

        MouseArea {
            anchors.fill: cancelAddressButton

            onPressed: {
                click01.play()
            }

            onCanceled: {
            }

            onReleased: {
            }

            onClicked: {
                addressbookTracker = 0
                currentAddress = ""
            }
        }
    }

    Text {
        text: "BACK"
        font.family: xciteMobile.name
        font.pointSize: 14
        font.bold: true
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        anchors.horizontalCenter: cancelAddressButton.horizontalCenter
        anchors.verticalCenter: cancelAddressButton.verticalCenter
        visible: cancelAddressButton.visible
    }

    // Crypto converter

    Mobile.CryptoCalculator {
        id: calculator
        toCurrency: coinID.text
        visible: calculatorTracker == 1 && transferTracker == 1
    }

    // Network error

    Rectangle {
        id: serverError
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.top
        width: Screen.width
        height: 100
        state: networkError == 0? "up" : "down"
        color: "black"
        opacity: 0.9


        states: [
            State {
                name: "up"
                PropertyChanges { target: serverError; anchors.bottomMargin: 0}
            },
            State {
                name: "down"
                PropertyChanges { target: serverError; anchors.bottomMargin: -100}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: serverError; property: "anchors.bottomMargin"; duration: 300; easing.type: Easing.OutCubic}
            }
        ]

        Label {
            id: serverErrorText
            text: "A network error occured, please try again later."
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "#FD2E2E"
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Rectangle {
            id: okButton
            width: (doubbleButtonWidth - 10) / 2
            height: 33
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            radius: 5
            color: "#1B2934"
            opacity: 0.5

            LinearGradient {
                anchors.fill: parent
                source: parent
                start: Qt.point(x, y)
                end: Qt.point(x, parent.height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: "#0ED8D2" }
                }
            }


            MouseArea {
                anchors.fill: parent

                onReleased: {
                    networkError = 0
                    transactionSend = 0
                }
            }
        }

        Text {
            id: okButtonText
            text: "OK"
            font.family: xciteMobile.name
            font.pointSize: 14
            color: "#F2F2F2"
            font.bold: true
            anchors.horizontalCenter: okButton.horizontalCenter
            anchors.verticalCenter: okButton.verticalCenter
        }

        Rectangle {
            width: (doubbleButtonWidth - 10) / 2
            height: 33
            anchors.horizontalCenter: okButton.horizontalCenter
            anchors.bottom: okButton.bottom
            radius: 5
            color: "transparent"
            opacity: 0.5
            border.width: 1
            border.color: "#0ED8D2"
        }

        Rectangle {
            width: parent.width
            height: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            color: "black"
        }
    }

    // Bottom bar

    Item {
        z: 3
        width: Screen.width
        height: 125
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        visible: transferTracker == 1
                 && transactionSend == 0
                 && confirmationSend == 0
                 && calculatorTracker == 0
                 && scanQRTracker == 0
                 && addressbookTracker == 0

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(x, y)
            end: Qt.point(x, y + height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.5; color: darktheme == true? "#14161B" : "#FDFDFD" }
                GradientStop { position: 1.0; color: darktheme == true? "#14161B" : "#FDFDFD" }
            }
        }
    }

    Label {
        id: closeTransferModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: transferTracker == 1
                 && transactionSend == 0
                 && confirmationSend == 0
                 && calculatorTracker == 0
                 && scanQRTracker == 0
                 && addressbookTracker == 0

        Rectangle{
            id: closeButton
            height: 34
            width: closeTransferModal.width
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
                    transactionSend =0
                    confirmationSend = 0
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
                    networkError = 0
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

    Controls.Pincode {
        id: myPincode
        z: 10

        coin: coinID.text
        walletHash: getAddress(coinID.text, walletLabel.text)
        amount: inputAmount
        partnerHash: keyInput.text
    }
}

