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
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: transactionModal
    width: appWidth/6 * 5
    height: appHeight
    state: advancedTransferTracker == 1? "up" : "down"
    color: "transparent"

    onStateChanged: {
        if (transferTracker == 0) {
            closeTimer.start()
        }
    }

    Rectangle {
        anchors.fill: parent
        color: bgcolor
        opacity: 0.9
    }

    MouseArea {
        anchors.fill: parent
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: transactionModal; anchors.topMargin: 0}
            PropertyChanges { target: transactionModal; opacity: 1}
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

    property string receiverList: ""
    property string totalSendAmount: "0"
    property int estimatedFee: (advancedTXList.count/3)
    property real estimatedAmount:advancedTXList.count !== 0? (1 + Number.fromLocaleString(Qt.locale("en_US"),totalSendAmount) + estimatedFee) : 0
    property int transactionSend: 0
    property int failedSend: 0
    property int requestSend: 0
    property int validAddress: 0
    property var inputAmount: Number.fromLocaleString(Qt.locale("en_US"),replaceComma)
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
    property string network: coinList.get(coinIndex).fullname
    property real amountSend: 0
    property string transferReply: ""
    property var replyArray
    property string searchTxText: ""
    property string transactionDate: ""
    property int timestamp: 0
    property string addressName: compareAddress()
    property real currentBalance: getCurrentBalance()
    property string searchCriteria: ""
    property int copyImage2clipboard: 0
    property int badNetwork: 0
    property bool selectNetwork: false
    property string txFailError:""
    property var commaArray
    property int detectComma
    property string replaceComma
    property var transferArray
    property int precision: 0
    property bool qrFound: false

    function createReceiverList() {
        var l = ""
        for (var i = 0; i < advancedTXList.count; i++){
            if (i === 0) {
                l = advancedTXList.get(i).receiver + "-" + advancedTXList.get(i).amount
            }
            else {
                l = l + ";" + advancedTXList.get(i).receiver + "-" + advancedTXList.get(i).amount
            }
        }
        receiverList = l
        console.log("receiver list: " + receiverList)
    }

    function calculateTotalSendAmount() {
        var a = ""
        var n = 0
        for (var i = 0; i < advancedTXList.count; i++){
            var o
            var r
            var comma
            o = advancedTXList.get(i).amount
            comma = o.split(',')
            if (comma.length === 2) {
                r = o.replace(",",".")
            }
            else {
                r = o
            }
            n = n + Number.fromLocaleString(Qt.locale("en_US"),r)
        }
        totalSendAmount = n.toLocaleString(Qt.locale("en_US"), "f", 8)
    }

    function compareAddress(){
        var fromto = ""
        for(var i = 0; i < addressList.count; i++) {
            if (addressList.get(i).address === keyInput.text) {
                if (addressList.get(i).coin === walletList.get(walletIndex).name) {
                    fromto = (contactList.get(addressList.get(i).contact).firstName) + " " + (contactList.get(addressList.get(i).contact).lastName) + " (" + (addressList.get(i).label) + ")"
                }
            }
        }
        return fromto
    }

    function checkAddress() {
        var coinID = walletList.get(walletIndex).name
        validAddress = 0
        if (coinID === "XBY") {
            if (keyInput.length === 34
                    && keyInput.text !== ""
                    && (keyInput.text.substring(0,1) == "B")
                    && keyInput.acceptableInput == true) {
                validAddress = 1
            }
            else {
                invalidAddress = 0
            }
        }
        else if (coinID === "XFUEL") {
            if (keyInput.length === 34
                    && keyInput.text !== ""
                    && keyInput.text.substring(0,1) == "F"
                    && keyInput.acceptableInput == true) {
                validAddress = 1
            }
            else {
                validAddress = 0
            }
        }
        else if (coinID === "XTEST") {
            if (keyInput.length === 34
                    && keyInput.text !== ""
                    && keyInput.text.substring(0,1) == "G"
                    && keyInput.acceptableInput == true) {
                validAddress = 1
            }
            else {
                validAddress = 0
            }
        }
        else if (coinID === "BTC") {
            if (keyInput.length > 25
                    && keyInput.length < 36
                    &&(keyInput.text.substring(0,1) == "1" || keyInput.text.substring(0,1) == "3" || keyInput.text.substring(0,3) == "bc1")
                    && keyInput.acceptableInput == true) {
                validAddress = 1
            }
            else {
                validAddress = 0
            }
        }
        else if (coinID === "ETH") {
            if (keyInput.length == 42
                    && keyInput.text.substring(0,2) == "0x"
                    && keyInput.acceptableInput == true) {
                validAddress = 1
            }
            else {
                validAddress = 0
            }
        }
    }

    function getCurrentBalance(){
        var currentBalance = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).address === getAddress (walletList.get(walletIndex).name, walletLabel.text)) {
                currentBalance = walletList.get(i).balance
            }
        }
        return currentBalance
    }

    Rectangle {
        anchors.fill: parent
        color: bgcolor
        opacity: 0.9
    }

    MouseArea {
        anchors.fill: parent
    }

    DropShadow {
        anchors.fill: advancedTxModal
        source: advancedTxModal
        horizontalOffset: 4
        verticalOffset: 4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.3
        transparentBorder: true
    }

    Rectangle {
        id: advancedTxModal
        width: parent.width - appWidth*3/24
        height: parent.height - appWidth*5/24
        color: bgcolor
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/12
        border.color: themecolor
        border.width: 1

        Label {
            id: advancedTxLabel
            text: "ADVANCED TRANSACTION"
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.top: parent.top
            anchors.topMargin: appWidth/27
            horizontalAlignment: Text.AlignRight
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
            font.capitalization: Font.AllUppercase
            color: themecolor
            font.letterSpacing: 2
            elide: Text.ElideRight
        }

        Item {
            id: inputArea
            width: parent.width/2
            anchors.top: advancedTxLabel.bottom
            anchors.topMargin: advancedTxLabel.font.pixelSize/2
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            Label {
                text: "Available amount:"
                font.pixelSize: appHeight/54
                font.family: xciteMobile.name
                font.capitalization: Font.AllUppercase
                color: themecolor
                anchors.left: sendAmount.left
                anchors.bottom: parent.top
                anchors.bottomMargin: advancedTxLabel.font.pixelSize/2
            }

            Label {
                text: walletList.get(walletIndex).balance - estimatedAmount + " <sup>*</sup>"
                font.pixelSize: appHeight/54
                font.family: xciteMobile.name
                font.capitalization: Font.AllUppercase
                textFormat: Text.RichText
                color: themecolor
                anchors.right: sendAmount.right
                anchors.bottom: parent.top
                anchors.bottomMargin: advancedTxLabel.font.pixelSize/2
            }

            Mobile.AmountInput {
                id: sendAmount
                text: ""
                height: appHeight/18
                width: parent.width - appWidth/12
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                placeholder: "AMOUNT"
                color: themecolor
                textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
                font.pixelSize: height/2
                validator: DoubleValidator {bottom: 0; top: ((walletList.get(walletIndex).balance))}
                mobile: 1
                calculator: walletList.get(walletIndex).name === "XTEST"? 0 : 1
                onTextChanged: {
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
                font.pixelSize: appHeight/45
                font.family: xciteMobile.name
                visible: precision <= 8
                         && (walletList.get(walletIndex).name === "XBY"? inputAmount < 1 : (walletList.get(walletIndex).name === "XFUEL"? inputAmount < 1 : (walletList.get(walletIndex).name === "XTEST"? inputAmount < 1 : inputAmount < 0)))
            }

            Label {
                text: "Insufficient funds"
                color: "#FD2E2E"
                anchors.left: sendAmount.left
                anchors.leftMargin: 5
                anchors.top: sendAmount.bottom
                anchors.topMargin: 1
                font.pixelSize: appHeight/45
                font.family: xciteMobile.name
                visible: inputAmount > walletList.get(walletIndex).balance - estimatedAmount
                         && precision <= 8
            }

            Label {
                text: "Too many decimals"
                color: "#FD2E2E"
                anchors.left: sendAmount.left
                anchors.leftMargin: 5
                anchors.top: sendAmount.bottom
                anchors.topMargin: 1
                font.pixelSize: appHeight/45
                font.family: xciteMobile.name
                visible: precision > 8
            }

            Controls.TextInput {
                id: keyInput
                text: ""
                height: appHeight/18
                width: parent.width - appWidth/12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: sendAmount.bottom
                anchors.topMargin: height/2
                placeholder: "WALLET ADDRESS"
                color: themecolor
                textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
                font.pixelSize: height/2
                mobile: 1
                validator: RegExpValidator { regExp: /[0-9A-Za-z]+/ }
                onTextChanged: {
                    detectInteraction()
                    checkAddress()
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
                font.pixelSize: appHeight/45
                font.family: xciteMobile.name
                visible: keyInput.text != ""
                         && validAddress == 0
            }

            Rectangle {
                id: scanQrButton
                width: ((parent.width - appWidth/12)*0.9) / 2
                height: appHeight/27
                anchors.top: keyInput.bottom
                anchors.topMargin: height
                anchors.left: keyInput.left
                border.color: themecolor
                border.width: 1
                color: "transparent"

                Rectangle {
                    id: selectQr
                    anchors.fill: parent
                    color: maincolor
                    opacity: 0.3
                    visible: false
                }

                MouseArea {
                    anchors.fill: scanQrButton
                    hoverEnabled: true

                    onEntered: {
                        selectQr.visible = true
                    }

                    onExited: {
                        selectQr.visible = false
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
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
                    font.pointSize: parent.height/2
                    color: themecolor
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                id: addressBookButton
                width: ((parent.width - appWidth/12)*0.9) / 2
                height: appHeight/27
                anchors.top: keyInput.bottom
                anchors.topMargin: height
                anchors.right: keyInput.right
                border.color: themecolor
                border.width: 1
                color: "transparent"

                Rectangle {
                    id: selectAddress
                    anchors.fill: parent
                    color: maincolor
                    opacity: 0.3
                    visible: false
                }

                MouseArea {
                    anchors.fill: addressBookButton
                    hoverEnabled: true

                    onEntered: {
                        selectAddress.visible = true
                    }

                    onExited: {
                        selectAddress.visible = false
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
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
                    font.pointSize: parent.height/2
                    color: themecolor
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                id: addButton
                width: parent.width - appWidth/12
                height: appHeight/27
                anchors.top: scanQrButton.bottom
                anchors.topMargin: height
                anchors.right: keyInput.right
                border.color: (keyInput.text != ""
                               && sendAmount.text != ""
                               && validAddress == 1
                               && inputAmount >= 1
                               && precision <= 8
                               && inputAmount <= ((walletList.get(walletIndex).balance) - estimatedAmount)
                               && (network == "xtrabytes" || network == "xfuel" || network == "testnet"))? themecolor : "#727272"
                border.width: 1
                color: "transparent"

                Rectangle {
                    id: selectAdd
                    anchors.fill: parent
                    color: maincolor
                    opacity: 0.3
                    visible: false
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    enabled: keyInput.text != ""
                             && sendAmount.text != ""
                             && validAddress == 1
                             && inputAmount >= 1
                             && precision <= 8
                             && inputAmount <= ((walletList.get(walletIndex).balance) - estimatedAmount)
                             && (network == "xtrabytes" || network == "xfuel" || network == "testnet")

                    onEntered: {
                        selectAdd.visible = true
                    }

                    onExited: {
                        selectAdd.visible = false
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        selectAdd.visible = false
                        advancedTXList.append({"receiver": keyInput.text, "amount": sendAmount.text})
                        keyInput.text = ""
                        sendAmount.text = ""
                        createReceiverList()
                        calculateTotalSendAmount()
                    }
                }

                Text {
                    id: addButtonText
                    text: "ADD TRANSACTION"
                    font.family: xciteMobile.name
                    font.pointSize: parent.height/2
                    color: parent.border.color
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        Item {
            id: outputArea
            width: parent.width/2
            anchors.top: advancedTxLabel.bottom
            anchors.topMargin: advancedTxLabel.font.pixelSize/2
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            property int deleteTracker: myTransactionList.deleteTx

            onDeleteTrackerChanged: {
                createReceiverList()
                calculateTotalSendAmount()
            }

            Rectangle {
                id: outputWindow
                width: parent.width - appWidth/12
                height: parent.height/2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                color: darktheme? "black" : "white"
                border.color: themecolor
                border.width: 1
                clip: true

                Desktop.TransactionList {
                    id: myTransactionList
                    anchors.top: parent.top
                }
            }

            Label {
                id: totalAmountLabel
                text: "Total:"
                font.family: xciteMobile.name
                font.pixelSize: appHeight/54
                color: themecolor
                anchors.left: outputWindow.left
                anchors.top: outputWindow.bottom
                anchors.topMargin: font.pixelSize/2
            }

            Label {
                id: totalAmountValue
                text: totalSendAmount
                font.family: xciteMobile.name
                font.pixelSize: appHeight/54
                color: themecolor
                anchors.right: totalAmountTicker.left
                anchors.rightMargin: font.pixelSize/2
                anchors.top: outputWindow.bottom
                anchors.topMargin: font.pixelSize/2
            }

            Label {
                id: totalAmountTicker
                text: walletList.get(walletIndex).name
                font.family: xciteMobile.name
                font.pixelSize: appHeight/54
                color: themecolor
                anchors.right: outputWindow.right
                anchors.top: outputWindow.bottom
                anchors.topMargin: font.pixelSize/2
            }

            Controls.TextInput {
                id: referenceInput
                height: appHeight/18
                width: parent.width - appWidth/12
                placeholder: "REFERENCE"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: outputWindow.bottom
                anchors.topMargin: appHeight*2/27
                color: themecolor
                textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
                font.pixelSize: height/2
                mobile: 1
                onTextChanged: detectInteraction()
            }

            Rectangle {
                id: sendButton
                width: (outputWindow.width*0.9) / 2
                height: appHeight/27
                anchors.top: referenceInput.bottom
                anchors.topMargin: height
                anchors.left: outputWindow.left
                border.color: (advancedTXList.count > 0
                               && (network == "xtrabytes" || network == "xfuel" || network == "testnet"))? themecolor : "#727272"
                border.width: 1
                color: "transparent"

                Rectangle {
                    id: selectSend
                    anchors.fill: parent
                    color: maincolor
                    opacity: 0.3
                    visible: false
                }

                Text {
                    id: sendButtonText
                    text: "SEND"
                    font.family: xciteMobile.name
                    font.pointSize: parent.height/2
                    color: parent.border.color
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    enabled: advancedTXList.count > 0
                             && (network == "xtrabytes" || network == "xfuel" || network == "testnet")

                    onEntered: {
                        selectSend.visible = true
                    }

                    onExited: {
                        selectSend.visible = false
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {/*
                        txFailError = ""
                        selectNetwork = true
                        createTx = true
                        setNetwork(network)*/
                    }

                    Connections {
                        target: xUtility

                        onNewNetwork: {
                            if (transferTracker == 1 && selectNetwork == true && advancedTransferTracker == 1) {
                                coinListTracker = 0
                                walletListTracker = 0
                                selectNetwork = false
                                var c = advancedTXList.count
                                var r = c.toLocaleString(Qt.locale("en_US", "f", 0)) + " receivers"
                                var t = new Date().toLocaleString(Qt.locale(),"hh:mm:ss .zzz")
                                var msg = "UI - send coins - target:" + r + ", amount:" +  totalSendAmount + ", private key: " +  getPrivKey(walletList.get(walletIndex).name, walletList.get(walletIndex).label)
                                xPingTread.append({"message": msg, "inout": "out", "author": myUsername, "time": t})
                                sendCoins(receiverList + " " +  totalSendAmount + " " +  getPrivKey(walletList.get(walletIndex).name, walletList.get(walletIndex).label))
                            }
                        }

                        onBadNetwork: {
                            if (transferTracker == 1 && selectNetwork == true && advancedTransferTracker == 1) {
                                badNetwork = 1
                                selectNetwork = false
                                createTx = false
                            }
                        }
                    }

                    Connections {
                        target: StaticNet

                        onSendFee: {
                            if (transferTracker == 1 && createTx == true && advancedTransferTracker == 0) {
                                notification.play()
                                console.log("sender: " + sender_ + " receiver: " + receiver_ + " amount: " + sendAmount_)
                                var r
                                var splitArray = receiver_.split(';')
                                var receiverInfo
                                var splitReceiverInfo
                                if (splitArray.length > 1) {
                                }
                                else {
                                    receiverInfo = splitArray[0]
                                    splitReceiverInfo = receiverInfo.split('-')
                                    r = splitReceiverInfo[0]
                                }
                                if (getAddress(walletList.get(walletIndex).name, walletList.get(walletIndex).label) === sender_) {
                                    console.log("raw transaction created: " + rawTx_ + ", fee: " + fee_ + ", id: " + traceId_)
                                    txFee = fee_
                                    rawTX = rawTx_
                                    receivedReceiver = receiver_
                                    receivedSender = sender_
                                    usedCoins = usedCoins_
                                    receivedAmount = sendAmount_
                                    receivedLabel = ""
                                    if (splitArray.length === 1) {
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
                            if (transferTracker == 1 && createTx == true && advancedTransferTracker == 0) {
                                console.log("failed to create raw transaction")
                                txFailError = "Failed to create raw transaction"
                                createTx = false
                                failedSend = 1
                                transactionSend = 1
                            }
                        }
                        onFundsLow: {
                            if (transferTracker == 1 && createTx == true && advancedTransferTracker == 0) {
                                console.log("Funds too low")
                                txFailError = error
                                createTx = false
                                failedSend = 1
                                transactionSend = 1
                            }
                        }
                        onUtxoError: {
                            if (transferTracker == 1 && createTx == true && advancedTransferTracker == 0) {
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


            Rectangle {
                id: clearButton
                width: (outputWindow.width*0.9) / 2
                height: appHeight/27
                anchors.top: referenceInput.bottom
                anchors.topMargin: height
                anchors.right: outputWindow.right
                border.color: advancedTXList.count > 0? themecolor : "#727272"
                border.width: 1
                color: "transparent"

                Rectangle {
                    id: selectClear
                    anchors.fill: parent
                    color: maincolor
                    opacity: 0.3
                    visible: false
                }

                Text {
                    id: clearButtonText
                    text: "CLEAR LIST"
                    font.family: xciteMobile.name
                    font.pointSize: parent.height/2
                    color: parent.border.color
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    enabled: advancedTXList.count > 0

                    onEntered: {
                        selectClear.visible = true
                    }

                    onExited: {
                        selectClear.visible = false
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        advancedTXList.clear()
                        receiverList = ""
                        totalSendAmount = "0"
                    }
                }
            }
        }

        Label {
            text: "(*) an estimated fee is taken into account."
            font.family: xciteMobile.name
            font.pixelSize: appHeight/72
            font.italic: true
            color: themecolor
            anchors.bottom: parent.bottom
            anchors.bottomMargin: font.pixelSize*2
            anchors.left: parent.left
            anchors.leftMargin: appWidth/24
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
            newWalletPicklist = 0
            newWalletSelect = 0
            selectedAddress = ""
            sendAmount.text = ""
            keyInput.text = ""
            referenceInput.text = ""
            advancedTXList.clear()
            receiverList = ""
            totalSendAmount = "0"
            validAddress = 0
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

    Rectangle {
        height: appWidth/24
        width: parent.width
        anchors.bottom: parent.bottom
        color: darktheme == true? "#14161B" : "#FDFDFD"
    }
}
