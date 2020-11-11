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
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: transactionModal
    width: appWidth
    height: appHeight
    state: transferTracker == 1? "up" : "down"
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: transactionModal.height
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
            PropertyChanges { target: transactionModal; anchors.topMargin: transactionModal.height}
            PropertyChanges { target: transactionModal; opacity: 0}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: transactionModal; properties: "anchors.topMargin, opacity"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    onStateChanged: {
        if (transferTracker == 0) {
            closeTimer.start()
        }
    }

    property int transactionSend: 0
    property int confirmationSend: 0
    property int failedSend: 0
    property int invalidAddress: 0
    property int decimals: (coinID.text) == "BTC" ? 8 : 4
    property var inputAmount: Number.fromLocaleString(Qt.locale("en_US"),replaceComma)
    property string amountTransfer: "AMOUNT (" + coinID.text + ")"
    property string keyTransfer: "SEND TO (ADDRESS)"
    property string referenceTransfer: "REFERENCE"
    property int txFee: 1
    property string rawTX: ""
    property string receivedReceiver: ""
    property string receivedSender: ""
    property string receivedAmount: ""
    property string receivedLabel: ""
    property string receivedTxID: ""
    property string usedCoins: ""
    property string txId: ""
    property real totalAmount: 0
    property string network: coinID.text
    property real amountSend: 0
    property string transferReply: ""
    property var replyArray
    property string searchTxText: ""
    property string transactionDate: ""
    property int timestamp: 0
    property string addressName: compareAddress()
    property real currentBalance: getCurrentBalance()
    property int selectedWallet: getWalletNR(coinID.text, walletLabel.text)
    property string searchCriteria: ""
    property int copyImage2clipboard: 0
    //property int screenShot: 0
    property int badNetwork: 0
    property bool selectNetwork: false
    property string txFailError:""

    property var commaArray
    property int detectComma
    property string replaceComma
    property var transferArray
    property int precision: 0

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
                    && (keyInput.text.substring(0,1) == "B")
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
        else if (coinID.text == "XTEST") {
            if (keyInput.length === 34
                    && keyInput.text !== ""
                    && keyInput.text.substring(0,1) == "G"
                    && keyInput.acceptableInput == true) {
                invalidAddress = 0
            }
            else {
                invalidAddress = 1
            }
        }
        else if (coinID.text == "BTC") {
            if (keyInput.length > 25
                    && keyInput.length < 36
                    &&(keyInput.text.substring(0,1) == "1" || keyInput.text.substring(0,1) == "3" || keyInput.text.substring(0,3) == "bc1")
                    && keyInput.acceptableInput == true) {
                invalidAddress = 0
            }
            else {
                invalidAddress = 1
            }
        }
        else if (coinID.text == "ETH") {
            if (keyInput.length == 42
                    && keyInput.text.substring(0,2) == "0x"
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
        font.pixelSize: 20
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        visible: addressbookTracker == 0 && viewForScreenshot == 0
    }

    Label {
        id: testnetLabel
        text: "TESTNET"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 40
        font.pixelSize: 18
        font.family: "Brandon Grotesque"
        color: "#E55541"
        font.letterSpacing: 2
        visible: coinID.text == "XTEST"
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
                     && viewForScreenshot == 0
            onStateChanged: detectInteraction()
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
                     && viewForScreenshot == 0
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
                     && viewForScreenshot == 0
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
            text: coinTracker == 1? (newCoinSelect == 1 ? coinList.get(newCoinPicklist).name : walletList.get(walletIndex).name) : (newCoinSelect == 1 ? coinList.get(newCoinPicklist).name : selectedCoin)
            anchors.left: coinIcon.right
            anchors.leftMargin: 7
            anchors.verticalCenter: coinIcon.verticalCenter
            font.pixelSize: (coinID.text).length <= 6? 24 : 18
            font.family: xciteMobile.name
            font.bold: true
            font.letterSpacing: 2
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && coinListTracker == 0
            onTextChanged: {
                network = coinID.text == "XBY"? "xtrabytes" : (coinID.text == "XFUEL"? "xfuel" : (coinID.text == "XTEST"? "testnet" : "nothing"))
                if (keyInput.text != "") {
                    checkAddress()
                }
            }
        }

        Label {
            id: walletLabel
            text: coinTracker == 1? (newCoinSelect == 0? walletList.get(walletIndex).label : (newWalletSelect == 1? walletList.get(walletIndex).label : walletList.get(defaultWallet(coinID.text)).label)) : (newWalletSelect == 1 ? walletList.get(walletIndex).label : walletList.get(defaultWallet(coinID.text)).label)
            anchors.right: picklistArrow2.left
            anchors.rightMargin: 7
            anchors.left: picklistArrow1.right
            anchors.leftMargin: 15
            anchors.verticalCenter: coinIcon.verticalCenter
            font.pixelSize: (walletLabel.text).length <= 6? 24 : 18
            font.family: xciteMobile.name
            font.bold: true
            font.capitalization: Font.SmallCaps
            horizontalAlignment: TextInput.AlignRight
            elide: Text.ElideRight
            font.letterSpacing: 2
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: (transactionSend == 0
                      && addressbookTracker == 0
                      && scanQRTracker == 0
                      && calculatorTracker == 0
                      && walletListTracker == 0
                      && publicKey.text != "")
                     || (transferSwitch.state === "off"
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
                     && publicKey.text != ""
                     && viewForScreenshot == 0
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
                     && publicKey.text != ""
                     && viewForScreenshot == 0
        }

        Image {
            id: picklistArrow1
            source: darktheme == true? 'qrc:/icons/mobile/dropdown-icon_01_light.svg' : 'qrc:/icons/mobile/dropdown-icon_01_dark.svg'
            height: 20
            width: 20
            anchors.left: coinListTracker == 0 ? coinID.right : transferPicklist1.right
            anchors.leftMargin: 10
            anchors.verticalCenter: coinIcon.verticalCenter
            visible: transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && coinListTracker == 0
                     && calculatorTracker == 0
                     && viewForScreenshot == 0

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

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

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
                     && viewForScreenshot == 0
        }

        Rectangle {
            id: transferPicklist1
            z: 11
            width: 100
            height: (totalLines * 35) < 175? ((totalLines * 35) + 25) : 200
            color: "#2A2C31"
            anchors.top: coinIcon.top
            anchors.topMargin: -5
            anchors.left: coinIcon.left
            visible: coinListTracker == 1
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && viewForScreenshot == 0
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
                     && viewForScreenshot == 0

            Image {
                id: picklistCloseArrow1
                height: 12
                fillMode: Image.PreserveAspectFit
                source: 'qrc:/icons/mobile/close_picklist-icon_01.svg'
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    detectInteraction()
                }

                onClicked: {
                    coinListTracker = 0
                }
            }
        }

        Image {
            id: picklistArrow2
            source: darktheme == true? 'qrc:/icons/mobile/dropdown-icon_01_light.svg' : 'qrc:/icons/mobile/dropdown-icon_01_dark.svg'
            height: 20
            width: 20
            anchors.right: sendAmount.right
            anchors.verticalCenter: coinIcon.verticalCenter
            visible: transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && walletListTracker == 0
                     && calculatorTracker == 0
                     && publicKey.text != ""
                     && viewForScreenshot == 0

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

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

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
                     && publicKey.text != ""
                     && viewForScreenshot == 0
        }

        Rectangle {
            id: transferPicklist2
            z: 11
            width: 100
            height: ((totalCoinWallets * 35) < 175) ? ((totalCoinWallets * 35) + 25) : 200
            color: "#2A2C31"
            anchors.top: coinIcon.top
            anchors.topMargin: -5
            anchors.right: picklistArrow2.right
            visible: walletListTracker == 1
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && publicKey.text != ""
                     && viewForScreenshot == 0
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
                     && publicKey.text != ""
                     && viewForScreenshot == 0

            Image {
                id: picklistCloseArrow2
                height: 12
                fillMode: Image.PreserveAspectFit
                source: 'qrc:/icons/mobile/close_picklist-icon_01.svg'
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    detectInteraction()
                }

                onClicked: {
                    walletListTracker = 0
                }
            }
        }

        Label {
            id:noWalletLabel
            text: "NO WALLETS"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: walletBalance.bottom
            anchors.topMargin: 40
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            font.letterSpacing: 2
            visible: transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && publicKey.text == ""
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
                     && publicKey.text != ""

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
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {

                }

                onClicked: {
                    if (viewForScreenshot == 0) {
                        viewForScreenshot = 1
                    }

                    else if (viewForScreenshot == 1) {
                        viewForScreenshot = 0
                    }
                }
            }
        }

        Text {
            id: pubKey
            text: "ADDRESS"
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
                     && publicKey.text != ""
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
                     && publicKey.text != ""

            Rectangle {
                width: parent.width
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: "transparent"

                MouseArea {
                    anchors.fill: parent

                    onPressAndHold: {
                        if(copy2clipboard == 0 && transferTracker == 1) {
                            copyText2Clipboard(publicKey.text)
                            copy2clipboard = 1
                        }
                    }
                }
            }
        }

        DropShadow {
            z: 12
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
            visible: copy2clipboard == 1 && transferTracker == 1
        }

        Item {
            id: textPopup
            z: 12
            width: popupClipboard.width
            height: popupClipboardText.height + 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: publicKey.verticalCenter
            visible: copy2clipboard == 1 && transferTracker == 1

            Rectangle {
                id: popupClipboard
                height: 50
                width: popupClipboardText.width + 20
                color: "#34363D"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                id: popupClipboardText
                text: publicKey.text + "<br>Address copied!"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#F2F2F2"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        DropShadow {
            z: 12
            anchors.fill: imagePopup
            source: imagePopup
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.4
            transparentBorder: true
            visible: copyImage2clipboard == 1
        }

        Item {
            id: imagePopup
            z: 12
            width: qrBackground.width
            height: qrBackground.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            visible: copyImage2clipboard == 1

            Rectangle {
                id: qrBackground
                width: popupClipboardImage.width + 20
                height: qrCode.height + popupClipboardImage.height + 15
                color: "#34363D"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Image {
                id: qrCode
                height: 75
                width: 75
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 10
            }

            Label {
                id: popupClipboardImage
                text: "QR code copied!"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#F2F2F2"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
            }
        }

        // Send state

        Label {
            id:viewOnlyLabel
            text: "VIEW ONLY WALLET"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: walletBalance.bottom
            anchors.topMargin: 40
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            font.letterSpacing: 2
            visible: transferSwitch.on == true
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && walletList.get(selectedWallet).viewOnly === true
                     && publicKey.text != ""
        }

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
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            validator: DoubleValidator {bottom: 0; top: ((walletList.get(selectedWallet).balance))}
            visible: transferSwitch.on == true
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && walletList.get(selectedWallet).viewOnly === false
                     && publicKey.text != ""
            mobile: 1
            calculator: coinID.text == "XTEST"? 0 : 1
            onTextEdited: {
                commaArray = sendAmount.text.split(',')
                if (commaArray[1] !== undefined) {
                    detectComma = 1
                }
                else {
                    detectComma = 0
                }
                if (detectComma == 1){
                    replaceComma = sendAmount.text.replace(",",".")
                    transferArray = replaceComma.split('.')
                    if (transferArray[1] !== undefined) {
                        precision = transferArray[1].length
                    }
                    else {
                        precision = 0
                    }
                }
                else {
                    replaceComma = sendAmount.text
                    transferArray = sendAmount.text.split('.')
                    if (transferArray[1] !== undefined) {
                        precision = transferArray[1].length
                    }
                    else {
                        precision = 0
                    }
                }
                detectInteraction()
            }
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
            text: "Input amount too low"
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
                     && (coinID.text === "XBY"? inputAmount < 1 : (coinID.text === "XFUEL"? inputAmount < 1 : (coinID.text === "XTEST"? inputAmount < 1 : inputAmount < 0)))
                     && walletList.get(selectedWallet).viewOnly === false
                     && publicKey.text != ""
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
                     && inputAmount > ((walletList.get(selectedWallet).balance) - 1)
                     && (coinID.text === "XBY"? inputAmount >= 1 : (coinID.text === "XFUEL"? inputAmount >= 1 : (coinID.text === "XTEST"? inputAmount >= 1 : inputAmount > 0)))
                     && precision <= 8
                     && walletList.get(selectedWallet).viewOnly === false
                     && publicKey.text != ""
        }

        Label {
            text: "Too many decimals"
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
                     && precision > 8
                     && (coinID.text === "XBY"? inputAmount >= 1 : (coinID.text === "XFUEL"? inputAmount >= 1 : (coinID.text === "XTEST"? inputAmount >= 1 : inputAmount > 0)))
                     && walletList.get(selectedWallet).viewOnly === false
                     && publicKey.text != ""
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
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            visible: transferSwitch.on == true
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && walletList.get(selectedWallet).viewOnly === false
                     && publicKey.text != ""
            mobile: 1
            validator: RegExpValidator { regExp: /[0-9A-Za-z]+/ }
            onTextChanged: {
                detectInteraction()
                checkAddress()
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
                if (sendAddress.text != "" && transferTracker == 1) {
                    keyInput.text = sendAddress.text
                }
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
                     && publicKey.text != ""
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
                     && walletList.get(selectedWallet).viewOnly === false
                     && publicKey.text != ""

            MouseArea {
                anchors.fill: scanQrButton

                onPressed: {
                    click01.play()
                    parent.border.color = themecolor
                    detectInteraction()
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
                     && walletList.get(selectedWallet).viewOnly === false
                     && publicKey.text != ""

            MouseArea {
                anchors.fill: addressBookButton

                onPressed: {
                    click01.play()
                    parent.border.color = themecolor
                    detectInteraction()
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
                    selectedCoin = coinID.text
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
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            visible: transferSwitch.on == true
                     && transactionSend == 0
                     && addressbookTracker == 0
                     && scanQRTracker == 0
                     && calculatorTracker == 0
                     && walletList.get(selectedWallet).viewOnly === false
                     && publicKey.text != ""
            mobile: 1
            onTextChanged: detectInteraction()
        }

        Rectangle {
            id: sendButton
            width: keyInput.width
            height: 34
            color: (invalidAddress == 0
                    && keyInput.text !== ""
                    && sendAmount.text !== ""
                    && (coinID.text === "XBY"? inputAmount >= 1 : (coinID.text === "XFUEL"? inputAmount >= 1 : (coinID.text === "XTEST"? inputAmount >= 1 : inputAmount > 0)))
                    && precision <= 8
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
                     && walletList.get(selectedWallet).viewOnly === false
                     && publicKey.text != ""
                     && createTx == false

            MouseArea {
                anchors.fill: sendButton

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onCanceled: {
                }

                onReleased: {
                }

                onClicked: {
                    if (invalidAddress == 0
                            && keyInput.text !== ""
                            && sendAmount.text !== ""
                            && inputAmount >= 1
                            && precision <= 8
                            && inputAmount <= ((walletList.get(selectedWallet).balance) - 1)
                            && calculatorTracker == 0
                            && (network == "xtrabytes" || network == "xfuel" || network == "testnet")) {
                        txFailError = ""
                        selectNetwork = true
                        transactionInProgress = true
                        setNetwork(network)
                    }
                }

                Connections {
                    target: xUtility

                    onNewNetwork: {
                        if (transferTracker == 1 && selectNetwork == true) {
                            coinListTracker = 0
                            walletListTracker = 0
                            selectNetwork = false
                            createTx = true
                            var t = new Date().toLocaleString(Qt.locale(),"hh:mm:ss .zzz")
                            var msg = "UI - send coins - target:" + keyInput.text + ", amount:" +  sendAmount.text + ", private key: " +  getPrivKey(coinID.text, walletLabel.text)
                            xPingTread.append({"message": msg, "inout": "out", "author": myUsername, "time": t})
                            sendCoins(keyInput.text + "-" +  sendAmount.text + " " +  sendAmount.text + " " +  getPrivKey(coinID.text, walletLabel.text))
                        }
                    }

                    onBadNetwork: {
                        if (transferTracker == 1 && selectNetwork == true) {
                            badNetwork = 1
                            selectNetwork = false
                        }
                    }
                }


                Connections {
                    target: StaticNet

                    onSendFee: {
                        if (transferTracker == 1 && createTx == true) {
                            notification.play()
                            console.log("sender: " + sender_ + " receiver: " + receiver_ + " amount: " + sendAmount_)
                            var r
                            var splitReceivers = receiver_.split(";")
                            var splitReceiverInfo
                            if (splitReceivers.count > 1) {
                            }
                            else {
                                splitReceiverInfo = splitReceivers.at(0).split("-")
                                r = splitReceiverInfo.at(0)
                            }
                            if (getAddress(coinID.text, walletLabel.text) === sender_) {
                                console.log("raw transaction created: " + rawTx_ + ", fee: " + fee_ + ", id: " + traceId_)
                                txFee = fee_
                                rawTX = rawTx_
                                receivedReceiver = receiver_
                                receivedSender = sender_
                                usedCoins = usedCoins_
                                receivedAmount = sendAmount_
                                receivedLabel = ""
                                if (splitReceivers.count === 1) {
                                    for (var i = 0; i < walletList.count; i ++) {
                                        if (walletList.get(i).address === r){
                                            receivedLabel = walletList.get(i).label
                                        }
                                    }
                                }
                                receivedTxID = traceId_
                                transactionSend = 1
                                createTx = false
                            }
                        }
                    }
                    onRawTxFailed: {
                        if (transferTracker == 1 && createTx == true) {
                            console.log("failed to create raw transaction")
                            txFailError = "Failed to create raw transaction"
                            createTx = false
                            failedSend = 1
                            transactionSend = 1
                        }
                    }
                    onFundsLow: {
                        if (transferTracker == 1 && createTx == true) {
                            console.log("Funds too low")
                            txFailError = error
                            createTx = false
                            failedSend = 1
                            transactionSend = 1
                        }
                    }
                    onUtxoError: {
                        if (transferTracker == 1 && createTx == true) {
                            console.log("Error retrieving UTXO")
                            txFailError = "Error retrieving UTXO"
                            createTx = false
                            failedSend = 1
                            transactionSend = 1
                        }
                    }
                }
            }
        }

        AnimatedImage {
            id: waitingDots01
            source: 'qrc:/gifs/loading-gif_01.gif'
            width: 75
            height: 50
            anchors.horizontalCenter: sendButton.horizontalCenter
            anchors.verticalCenter: sendButton.verticalCenter
            anchors.verticalCenterOffset: -20
            playing: createTx == true
            visible: createTx == true
        }

        Text {
            text: "SEND"
            font.family: xciteMobile.name
            font.pointSize: 14
            font.bold: true
            color: (invalidAddress == 0
                    && keyInput.text !== ""
                    && sendAmount.text !== ""
                    && (coinID.text === "XBY"? inputAmount >= 1 : (coinID.text === "XFUEL"? inputAmount >= 1 : (coinID.text === "XTEST"? inputAmount >= 1 : inputAmount > 0)))
                    && precision <= 8
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
                           && (coinID.text === "XBY"? inputAmount >= 1 : (coinID.text === "XFUEL"? inputAmount >= 1 : (coinID.text === "XTEST"? inputAmount >= 1 : inputAmount > 0)))
                           && precision <= 8
                           && inputAmount <= (walletList.get(selectedWallet).balance)) ? maincolor : "#979797"
            border.width: 1
            opacity: darktheme == true? 0.5 : 0.75
            anchors.horizontalCenter: sendButton.horizontalCenter
            anchors.verticalCenter: sendButton.verticalCenter
            visible: sendButton.visible
        }

        // Transfer confirm state
        Controls.ReplyModal {
            id: sendConfirmation
            modalHeight: sendingLabel.height + to.height + confirmationAddressName.height + reference.height + feeLabel.height + cancelSendButton.height + 105
            visible: transactionSend == 1
                     && confirmationSend == 0
                     && failedSend == 0
                     && requestSend == 0

            Text {
                id: sendingLabel
                text: "SENDING:"
                anchors.left: confirmationSendButton.left
                anchors.top: sendConfirmation.modalTop
                anchors.topMargin: 20
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                visible: transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         && requestSend == 0
            }

            Item {
                id:amount
                implicitWidth: confirmationAmount.implicitWidth + confirmationAmount1.implicitWidth + confirmationAmount2.implicitWidth + 7
                implicitHeight: confirmationAmount.implicitHeight
                anchors.bottom: sendingLabel.bottom
                anchors.right: cancelSendButton.right
                anchors.rightMargin: 10
                visible: transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         && requestSend == 0
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
                         && failedSend == 0
                         && requestSend == 0
            }

            Text {
                property string transferAmount: receivedAmount.toLocaleString(Qt.locale("en_US"), "f", decimals)
                property var amountArray: transferAmount.split('.')
                id: confirmationAmount1
                text: amountArray[1] !== undefined?  ("." + amountArray[1]) : ".0000"
                anchors.bottom: confirmationAmount.bottom
                anchors.bottomMargin: 2
                anchors.right: confirmationAmount.left
                anchors.rightMargin: 7
                font.family: xciteMobile.name
                font.pixelSize: 12
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                visible: transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         && requestSend == 0
            }

            Text {
                property string transferAmount: receivedAmount.toLocaleString(Qt.locale("en_US"), "f", decimals)
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
                         && failedSend == 0
                         && requestSend == 0
            }

            Text {
                id: to
                text: "TO:"
                anchors.left: confirmationSendButton.left
                anchors.top: sendingLabel.bottom
                anchors.topMargin: 15
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                visible: transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         && requestSend == 0
            }

            Text {
                property var receiverList: receivedReceiver.split(";")
                property var countReceivers: receiverList.count
                property var receiverInfo: countReceivers === 1? receiverList[0].split("-") : countReceivers.toLocaleString(Qt.locale("en_US"))
                id: confirmationAddress
                text: receivedLabel != ""? receivedLabel : (countReceivers === 1? receiverInfo[0] : receiverInfo + " receivers")
                anchors.bottom: to.bottom
                anchors.bottomMargin: 2
                anchors.right: cancelSendButton.right
                anchors.rightMargin: 10
                font.family: xciteMobile.name
                font.pixelSize: addressName != ""? 16 : 10
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                visible: transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         &&requestSend == 0
            }

            Text {
                id: confirmationAddressName
                text: "(" + receivedReceiver + ")"
                anchors.top: confirmationAddress.bottom
                anchors.topMargin: 5
                anchors.right: cancelSendButton.right
                anchors.rightMargin: 10
                font.family: xciteMobile.name
                font.pixelSize: 10
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                visible: receivedReceiver != ""
                         && transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         &&requestSend == 0
            }

            Text {
                id: reference
                text: "REF.:"
                anchors.left: confirmationSendButton.left
                anchors.top: confirmationAddressName.bottom
                anchors.topMargin: 5
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                visible: referenceInput.text !== ""
                         && transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         && requestSend == 0
            }

            Text {
                id: referenceText
                text: referenceInput.text
                anchors.bottom: reference.bottom
                anchors.right: cancelSendButton.right
                anchors.rightMargin: 10
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                visible: referenceInput.text !== ""
                         && transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         && requestSend == 0
            }

            Text {
                id: feeLabel
                text: "TRANSACTION FEE:"
                anchors.left: confirmationSendButton.left
                anchors.top: reference.bottom
                anchors.topMargin: 15
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                visible: transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         && requestSend == 0
            }

            Item {
                id:feeAmount
                implicitWidth: confirmationFeeAmount.implicitWidth + confirmationFeeAmount1.implicitWidth + confirmationFeeAmount2.implicitWidth + 7
                implicitHeight: confirmationAmount.implicitHeight
                anchors.bottom: feeLabel.bottom
                anchors.right: cancelSendButton.right
                anchors.rightMargin: 10
                visible: transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         && requestSend == 0
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
                         && failedSend == 0
                         && requestSend == 0
            }

            Text {
                property string transferFee: txFee.toLocaleString(Qt.locale("en_US"), "f", decimals)
                property var feeArray: transferFee.split('.')
                id: confirmationFeeAmount1
                text: feeArray[1] !== undefined?  ("." + feeArray[1]) : ".0000"
                anchors.bottom: confirmationFeeAmount.bottom
                anchors.bottomMargin: 2
                anchors.right: confirmationFeeAmount.left
                anchors.rightMargin: 7
                font.family: xciteMobile.name
                font.pixelSize: 12
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                visible: transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         && requestSend == 0
            }

            Text {
                property string transferFee: txFee.toLocaleString(Qt.locale("en_US"), "f", decimals)
                property var feeArray: transferFee.split('.')
                id: confirmationFeeAmount2
                text: feeArray[0]
                anchors.top: confirmationFeeAmount.top
                anchors.left: feeAmount.left
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                visible: transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         && requestSend == 0
            }

            Rectangle {
                id: confirmationSendButton
                width: (doubbleButtonWidth - 30) / 2
                height: 34
                anchors.top: feeLabel.bottom
                anchors.topMargin: 25
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 5
                color: "#4BBE2E"
                opacity: darktheme == true? 0.25 : 0.5
                visible: transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         && requestSend == 0

                MouseArea {
                    anchors.fill: confirmationSendButton

                    onPressed: {
                        click01.play()
                        detectInteraction()
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
                            timer3.start()
                        }
                    }
                }

                Timer {
                    id: timer3
                    interval: pincodeTracker == 1? 1000 : 100
                    repeat: false
                    running: false

                    onTriggered: {
                        var dataModelParams = {"xdapp":network,"method":"sendrawtransaction","payload":rawTX,"id":receivedTxID}
                        var paramsJson = JSON.stringify(dataModelParams)
                        dicomRequest(paramsJson)
                        var t = new Date().toLocaleString(Qt.locale(),"hh:mm:ss .zzz")
                        var msg = "UI - confirming TX: " + paramsJson
                        xPingTread.append({"message": msg, "inout": "out", "author": myUsername, "time": t})
                        console.log("request TX broadcast: " + paramsJson)
                        var total = Number.fromLocaleString(Qt.locale("en_US"),replaceComma)
                        var totalFee = Number.fromLocaleString(Qt.locale("en_US"),txFee)
                        var totalUsed = Number.fromLocaleString(Qt.locale("en_US"),usedCoins)
                        transactionList.append({"requestID":receivedTxID,"txid":"","coin":coinID.text,"address":receivedSender,"receiver":receivedReceiver,"amount":total,"fee":totalFee,"used":totalUsed})
                        transferTracker = 0
                        transactionInProgress = false
                    }
                }

                Connections {
                    target: UserSettings

                    onPincodeCorrect: {
                        if (pincodeTracker == 1 && transferTracker == 1) {
                            timer3.start()
                        }
                    }
                }
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
                         && failedSend == 0
                         &&requestSend == 0
            }

            Rectangle {
                width: (doubbleButtonWidth - 30) / 2
                height: 34
                anchors.horizontalCenter: confirmationSendButton.horizontalCenter
                anchors.verticalCenter: confirmationSendButton.verticalCenter
                color: "transparent"
                border.color: "#4BBE2E"
                border.width: 1
                opacity: darktheme == true? 0.5 : 0.75
                visible: transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         &&requestSend == 0
            }

            Rectangle {
                id: cancelSendButton
                width: (doubbleButtonWidth - 30) / 2
                height: 34
                color: "#E55541"
                opacity: darktheme == true? 0.25 : 0.5
                anchors.top: feeLabel.bottom
                anchors.topMargin: 25
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 5
                visible: transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         &&requestSend == 0

                MouseArea {
                    anchors.fill: cancelSendButton

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onCanceled: {
                    }

                    onReleased: {
                    }

                    onClicked: {
                        failedSend = 0
                        transactionSend = 0
                        transactionInProgress = false
                        rawTX = ""
                        txFee = 0
                        receivedAmount = ""
                        receivedLabel = ""
                        receivedReceiver = ""
                        receivedSender = ""
                        receivedTxID = ""
                        usedCoins = ""
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
                         && failedSend == 0
                         &&requestSend == 0
            }

            Rectangle {
                width: (doubbleButtonWidth - 30) / 2
                height: 34
                color: "transparent"
                border.color: "#E55541"
                border.width: 1
                opacity: darktheme == true? 0.5 : 0.75
                anchors.horizontalCenter: cancelSendButton.horizontalCenter
                anchors.verticalCenter: cancelSendButton.verticalCenter
                visible: transactionSend == 1
                         && confirmationSend == 0
                         && failedSend == 0
                         &&requestSend == 0
            }
        }

        // Transfer failed state

        Controls.ReplyModal {
            id: transferFailed
            modalHeight: failedIcon.height + failedIconLabel.height + closeFail.height + 75
            visible: transactionSend == 1
                     && failedSend == 1

            Image {
                id: failedIcon
                source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
                width: 75
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: transferFailed.modalTop
                anchors.topMargin: 20
                visible: transactionSend == 1
                         && failedSend == 1
            }

            Label {
                id: failedIconLabel
                text: "Transaction failed!"
                anchors.top: failedIcon.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: failedIcon.horizontalCenter
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                font.pixelSize: 14
                font.family: xciteMobile.name
                font.bold: true
                visible: transactionSend == 1
                         && failedSend == 1
            }

            Label {
                id: failedErrorLabel
                text: txFailError
                anchors.top: failedIconLabel.bottom
                anchors.topMargin: 5
                anchors.horizontalCenter: failedIcon.horizontalCenter
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                font.pixelSize: 10
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
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter
                visible: transactionSend == 1
                         && failedSend == 1

                MouseArea {
                    anchors.fill: closeFail

                    onPressed: {
                        click01.play()
                        detectInteraction()
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
                        precision = 0
                        transactionInProgress = false
                        rawTX = ""
                        txFee = 0
                        receivedAmount = ""
                        receivedLabel = ""
                        receivedReceiver = ""
                        receivedSender = ""
                        receivedTxID = ""
                        usedCoins = ""
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
        state: addressbookTracker == 1? "up" : "down"

        onStateChanged: {
            if(addressbookTracker == 0) {
                searchForAddress.text = ""
            }
        }
    }

    Image {
        id: addressbookCoinLogo
        source: coinIcon.source
        height: 25
        width: 25
        anchors.top: addressbookTitle.bottom
        anchors.topMargin: 30
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

    Controls.TextInput {
        id: searchForAddress
        placeholder: "SEARCH ADDRESS BOOK"
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.leftMargin: 28
        anchors.left: parent.left
        anchors.top: addressbookCoinLogo.bottom
        anchors.topMargin: 20
        color: searchForAddress.text != "" ? "#2A2C31" : "#727272"
        textBackground: "#F2F2F2"
        font.pixelSize: 14
        font.capitalization: Font.AllUppercase
        mobile: 1
        addressBook: 1
        visible: transferSwitch.on == true
                 && transactionSend == 0
                 && addressbookTracker == 1
        onTextChanged: {
            detectInteraction()
            searchCriteria = searchForAddress.text
        }
    }

    Rectangle {
        id: addressPicklistArea
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: searchForAddress.bottom
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        color: "transparent"
        visible: transferSwitch.on == true
                 && transactionSend == 0
                 && addressbookTracker == 1
        Mobile.AddressPicklist {
            id: myAddressPicklist
            searchFilter: searchCriteria

        }
    }

    Item {
        width: parent.width
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
    /**
    Rectangle {
        id: cancelAddressButton
        width: doubbleButtonWidth / 2
        height: 34
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
                detectInteraction()
            }

            onCanceled: {
            }

            onReleased: {
            }

            onClicked: {
                addressbookTracker = 0
                currentAddress = ""
                searchForAddress.text = ""
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
    */

    // Crypto converter

    Mobile.CryptoCalculator {
        id: calculator
        toCurrency: coinID.text
        visible: calculatorTracker == 1 && transferTracker == 1
    }

    // Bottom bar

    Item {
        z: 3
        width: parent.width
        height: myOS === "android"? 125 : 145
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

    Timer {
        id: closeTimer
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
            transactionSend = 0
            confirmationSend = 0
            newCoinSelect = 0
            newCoinPicklist = 0
            newWalletPicklist = 0
            newWalletSelect = 0
            selectedAddress = ""
            selectedCoin = "XFUEL"
            sendAmount.text = ""
            keyInput.text = sendAddress.text
            referenceInput.text = ""
            invalidAddress = 0
            calculatorTracker = 0
            calculatedAmount = ""
            scanQRTracker = 0
            scanning = "scanning..."
            networkError = 0
            viewForScreenshot = 0
            precision = 0
            rawTX = ""
            txFee = ""
            receivedAmount = ""
            receivedLabel = ""
            receivedReceiver = ""
            receivedSender = ""
            usedCoins = ""
            createTx = false
        }
    }

    Controls.Pincode {
        id: myPincode
        z: 10
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        visible: transferTracker == 1
    }
}

