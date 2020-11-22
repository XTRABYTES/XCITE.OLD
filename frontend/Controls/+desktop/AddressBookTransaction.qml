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
import QZXing 2.3

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: transactionModal
    width: appWidth/6 * 5
    height: appHeight
    state: transferTracker == 1? "up" : "down"
    color: "transparent"

    onStateChanged: {
        if (transferTracker == 0) {
            closeTimer.start()
        }
        else {
            console.log("receiver address: " + selectedAddress)
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

    property int decimals: coinIndex < 3? 4 : 8
    property real estimatedAmount: sendAmount.text !== ""? Number.fromLocaleString(Qt.locale("en_US"),sendAmount.text) + 1 : 0
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

    function getCurrentBalance(){
        var currentBalance = 0
        if (walletIndex >= 0) {
            for(var i = 0; i < walletList.count; i++) {
                if (walletList.get(i).address === walletList.get(walletIndex).address) {
                    currentBalance = walletList.get(i).balance
                }
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

    Rectangle {
        id: closeTX
        width: appWidth/48
        height: width
        radius: height/2
        color: "transparent"
        border.width: 1
        border.color: themecolor
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.bottom: txModal.top
        anchors.bottomMargin: height/2
        visible: createTx == false && transactionInProgress == false

        Item {
            width: parent.width*0.6
            height: width
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            rotation: 45

            Rectangle {
                width: parent.width
                height: 1
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                height: parent.height
                width: 1
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Rectangle {
            id: closeSelect
            anchors.fill: parent
            radius: height/2
            color: maincolor
            opacity: 0.3
            visible: false
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                closeSelect.visible = true
            }

            onExited: {
                closeSelect.visible = false
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                transferTracker = 0
                closeTimer.start()
            }
        }
    }

    DropShadow {
        anchors.fill: txModal
        source: txModal
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
        id: txModal
        width: parent.width - appWidth*3/24
        height: parent.height - appWidth*5/24
        color: bgcolor
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/12
        border.color: themecolor
        border.width: 1
        clip: true

        Item {
            id: createTransaction
            anchors.fill: parent

            Label {
                id: txLabel
                text: "DIRECT TRANSACTION"
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
                anchors.top: txLabel.bottom
                anchors.topMargin: txLabel.font.pixelSize/2
                anchors.bottom: parent.bottom
                anchors.left: parent.left

                Label {
                    id: availableAmount
                    text: "Available amount:"
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    font.capitalization: Font.AllUppercase
                    color: themecolor
                    anchors.left: sendAmount.left
                    anchors.bottom: parent.top
                    anchors.bottomMargin: txLabel.font.pixelSize/2
                }

                Label {
                    text: walletIndex >= 0? walletList.get(walletIndex).balance - estimatedAmount + " <sup>*</sup>" : "0" + " <sup>*</sup>"
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    font.capitalization: Font.AllUppercase
                    textFormat: Text.RichText
                    color: themecolor
                    anchors.right: sendAmount.right
                    anchors.bottom: parent.top
                    anchors.bottomMargin: txLabel.font.pixelSize/2
                }

                Label {
                    id: sendLabel
                    text: "From:"
                    anchors.left: sendAmount.left
                    anchors.top: parent.top
                    anchors.topMargin: font.pixelSize/2
                    color: themecolor
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                }

                Label {
                    id: addressInput
                    text: myWalletListSmall.availableWallets == 0? "No wallets available" : (walletIndex >= 0? walletList.get(walletIndex).address : "")
                    anchors.right: sendAmount.right
                    anchors.left: sendLabel.right
                    anchors.leftMargin: font.pixelSize*2
                    anchors.top: sendLabel.top
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideRight
                    color: myWalletListSmall.availableWallets > 0? themecolor : "#E55541"
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    font.italic: myWalletListSmall.availableWallets == 0
                }

                Rectangle {
                    id: walletListButton
                    width: sendAmount.width
                    height: appHeight/27
                    radius: height/2
                    anchors.top: addressInput.bottom
                    anchors.topMargin: height
                    anchors.left: sendAmount.left
                    border.color: themecolor
                    border.width: 1
                    color: "transparent"
                    opacity: myWalletListSmall.availableWallets > 0? 1 : 0.3

                    Rectangle {
                        id: selectWallet
                        anchors.fill: parent
                        radius: height/2
                        color: maincolor
                        opacity: 0.3
                        visible: false
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: enabled && transactionSend == 0
                        enabled: myWalletListSmall.availableWallets > 0

                        onEntered: {
                            selectWallet.visible = true
                        }

                        onExited: {
                            selectWallet.visible = false
                        }

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            walletListTracker = 1
                            selectedCoin = addressList.get(addressIndex).coin
                        }
                    }

                    Text {
                        id: addressButtonText
                        text: "SELECT WALLET"
                        font.family: xciteMobile.name
                        font.pointSize: parent.height/2
                        color: themecolor
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Mobile.AmountInput {
                    id: sendAmount
                    text: ""
                    height: appHeight/18
                    width: parent.width - appWidth/12
                    anchors.top: walletListButton.bottom
                    anchors.topMargin: appHeight/27
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholder: "AMOUNT"
                    color: themecolor
                    textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
                    font.pixelSize: height/2
                    validator: DoubleValidator {bottom: 0; top: walletIndex >= 0? ((walletList.get(walletIndex).balance)): 0}
                    mobile: 1
                    calculator: walletIndex >= 0? (walletList.get(walletIndex).name === "XTEST"? 0 : 1) : 1
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
                    visible: walletIndex >= 0? (precision <= 8
                             && (walletList.get(walletIndex).name === "XBY"? inputAmount < 1 : (walletList.get(walletIndex).name === "XFUEL"? inputAmount < 1 : (walletList.get(walletIndex).name === "XTEST"? inputAmount < 1 : inputAmount < 0)))) : false
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
                    visible: walletIndex >= 0? (inputAmount > walletList.get(walletIndex).balance - estimatedAmount
                             && precision <= 8) : false
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

                Label {
                    id: addressLabel
                    text: "To:"
                    anchors.left: sendAmount.left
                    anchors.top: sendAmount.bottom
                    anchors.topMargin: font.pixelSize
                    color: themecolor
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                }

                Label {
                    id: keyInput
                    text: selectedAddress
                    anchors.right: sendAmount.right
                    anchors.left: addressLabel.right
                    anchors.leftMargin: font.pixelSize*2
                    anchors.top: addressLabel.top
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideRight
                    color: themecolor
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                }

                Controls.TextInput {
                    id: referenceInput
                    height: appHeight/18
                    width: sendAmount.width
                    placeholder: "REFERENCE"
                    anchors.left: sendAmount.left
                    anchors.top: keyInput.bottom
                    anchors.topMargin: appHeight/27
                    color: themecolor
                    textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
                    font.pixelSize: height/2
                    mobile: 1
                    onTextChanged: detectInteraction()
                }

                Rectangle {
                    id: sendButton
                    width: sendAmount.width
                    height: appHeight/27
                    radius: height/2
                    anchors.top: referenceInput.bottom
                    anchors.topMargin: height
                    anchors.left: sendAmount.left
                    border.color: ((network == "xtrabytes" || network == "xfuel" || network == "testnet")
                                   && walletIndex >= 0
                                   && sendAmount.text != ""
                                   && precision <= 8
                                   && (walletList.get(walletIndex).name === "XBY"? inputAmount > 1 : (walletList.get(walletIndex).name === "XFUEL"? inputAmount > 1 : (walletList.get(walletIndex).name === "XTEST"? inputAmount > 1 : inputAmount > 0)))
                                   && inputAmount < walletList.get(walletIndex).balance - estimatedAmount)? themecolor : "#727272"
                    border.width: 1
                    color: "transparent"

                    Rectangle {
                        id: selectSend
                        anchors.fill: parent
                        radius: height/2
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
                        hoverEnabled: enabled && transactionSend == 0
                        enabled: ((network == "xtrabytes" || network == "xfuel" || network == "testnet")
                                  && walletIndex >= 0
                                  && sendAmount.text != ""
                                  && precision <= 8
                                  && (walletList.get(walletIndex).name === "XBY"? inputAmount > 1 : (walletList.get(walletIndex).name === "XFUEL"? inputAmount > 1 : (walletList.get(walletIndex).name === "XTEST"? inputAmount > 1 : inputAmount > 0)))
                                  && inputAmount < walletList.get(walletIndex).balance - estimatedAmount)

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

                        onClicked: {
                            txFailError = ""
                            selectNetwork = true
                            createTx = true
                            setNetwork(network)
                        }

                        Connections {
                            target: xUtility

                            onNewNetwork: {
                                if (transferTracker == 1 && selectNetwork == true && pageTracker == 1) {
                                    coinListTracker = 0
                                    walletListTracker = 0
                                    selectNetwork = false
                                    var r = selectedAddress
                                    var t = new Date().toLocaleString(Qt.locale(),"hh:mm:ss .zzz")
                                    var msg = "UI - send coins - target:" + r + ", amount:" +  sendAmount.text + ", private key: " +  walletList.get(walletIndex).privatekey
                                    xPingTread.append({"message": msg, "inout": "out", "author": myUsername, "time": t})
                                    sendCoins(selectedAddress + "-" + sendAmount.text + " " +  sendAmount.text + " " +  walletList.get(walletIndex).privatekey)
                                }
                            }

                            onBadNetwork: {
                                if (transferTracker == 1 && selectNetwork == true && pageTracker == 1) {
                                    badNetwork = 1
                                    selectNetwork = false
                                    createTx = false
                                    transactionSend = 1
                                    failedSend = 1
                                }
                            }
                        }

                        Connections {
                            target: StaticNet

                            onSendFee: {
                                if (transferTracker == 1 && createTx == true && pageTracker == 1) {
                                    notification.play()
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
                                    if (walletList.get(walletIndex).address === sender_) {
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
                                if (transferTracker == 1 && createTx == true && pageTracker == 1) {
                                    console.log("failed to create raw transaction")
                                    txFailError = "Failed to create raw transaction"
                                    createTx = false
                                    transactionSend = 1
                                    failedSend = 1
                                }
                            }
                            onFundsLow: {
                                if (transferTracker == 1 && createTx == true && pageTracker == 1) {
                                    console.log("Funds too low")
                                    txFailError = error
                                    createTx = false
                                    transactionSend = 1
                                    failedSend = 1
                                }
                            }
                            onUtxoError: {
                                if (transferTracker == 1 && createTx == true && pageTracker == 1) {
                                    console.log("Error retrieving UTXO")
                                    txFailError = "Error retrieving UTXO"
                                    createTx = false
                                    txFailError = "Wrong network"
                                    transactionSend = 1
                                    failedSend = 1
                                }
                            }
                        }
                    }
                }

                Label {
                    text: "(*) an estimated fee of 1" + coinList.get(coinIndex).name + " is taken into account."
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/72
                    font.italic: true
                    color: themecolor
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: font.pixelSize*2
                    anchors.left: parent.left
                    anchors.leftMargin: appWidth/24
                }

                Rectangle {
                    id: closeWalletList
                    width: appWidth/48
                    height: width
                    radius: height/2
                    color: "transparent"
                    border.width: 1
                    border.color: themecolor
                    anchors.right: selectWalletArea.right
                    anchors.bottom: selectWalletArea.top
                    anchors.bottomMargin: height/2
                    visible: walletListTracker == 1 && pageTracker == 1

                    Item {
                        width: parent.width*0.6
                        height: width
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        rotation: 45

                        Rectangle {
                            width: parent.width
                            height: 1
                            color: themecolor
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Rectangle {
                            height: parent.height
                            width: 1
                            color: themecolor
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }

                    Rectangle {
                        id: closeWalletSelect
                        anchors.fill: parent
                        radius: height/2
                        color: maincolor
                        opacity: 0.3
                        visible: false
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true

                        onEntered: {
                            closeWalletSelect.visible = true
                        }

                        onExited: {
                            closeWalletSelect.visible = false
                        }

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            walletListTracker = 0
                        }
                    }
                }

                DropShadow {
                    anchors.fill: selectWalletArea
                    source: selectWalletArea
                    horizontalOffset: 4
                    verticalOffset: -4
                    radius: 12
                    samples: 25
                    spread: 0
                    color: "black"
                    opacity: 0.3
                    transparentBorder: true
                }

                Rectangle {
                    id: selectWalletArea
                    width: appWidth/3
                    height: myWalletListSmall.walletCount*appHeight/15 < parent.height/2? myWalletListSmall.walletCount*appHeight/15 : parent.height/2
                    color: "#2A2C31"
                    anchors.top: parent.bottom
                    anchors.left: sendAmount.left
                    state: walletListTracker == 0 && pageTracker == 1? "down" : "up"
                    clip: true

                    states: [
                        State {
                            name: "up"
                            PropertyChanges { target: selectWalletArea; anchors.topMargin: -selectWalletArea.height}
                        },
                        State {
                            name: "down"
                            PropertyChanges { target: selectWalletArea; anchors.topMargin: appWidth/24}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: selectWalletArea; properties: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Desktop.WalletListSmall {
                        id: myWalletListSmall
                        anchors.top: parent.top
                        onlyView: false
                        onlyViewActive: true
                        coinFilter: selectedCoin
                    }
                }

                Rectangle {
                    height: txModal.height
                    width: txModal.width/2
                    anchors.bottom : parent.bottom
                    anchors.right: parent.right
                    color: bgcolor
                    opacity: 0.5
                    visible: transactionSend == 1

                    MouseArea {
                        anchors.fill: parent
                    }
                }
            }

            Item {
                id: outputArea
                width: parent.width/2
                anchors.top: txLabel.bottom
                anchors.topMargin: txLabel.font.pixelSize/2
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Item {
                    id: createTXFailed
                    anchors.fill: parent
                    visible: transactionSend == 1 && failedSend == 1

                    Item {
                        id: transferFailed
                        height: failedIcon.height + failedIconLabel.height + failedIconLabel.anchors.topMargin + closeFail.height + closeFail.anchors.topMargin
                        width: parent.width - appWidth/12
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            id: failedIcon
                            source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
                            width: appWidth/24
                            fillMode: Image.PreserveAspectFit
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: transferFailed.modalTop
                        }

                        Label {
                            id: failedIconLabel
                            text: "Transaction failed!"
                            anchors.top: failedIcon.bottom
                            anchors.topMargin: failedIcon.height/2
                            anchors.horizontalCenter: failedIcon.horizontalCenter
                            color: themecolor
                            font.pixelSize: appHeight/36
                            font.family: xciteMobile.name
                        }

                        Label {
                            id: failedErrorLabel
                            text: txFailError
                            anchors.top: failedIconLabel.bottom
                            anchors.topMargin: font.pixelSize/2
                            anchors.horizontalCenter: failedIcon.horizontalCenter
                            color: themecolor
                            font.pixelSize: appHeight/45
                            font.family: xciteMobile.name
                        }

                        Rectangle {
                            id: closeFail
                            width: appWidth/6
                            height: appHeight/27
                            radius: height/2
                            color: "transparent"
                            anchors.top: failedIconLabel.bottom
                            anchors.topMargin: height*2
                            anchors.horizontalCenter: parent.horizontalCenter
                            border.color: themecolor
                            border.width: 1

                            Rectangle {
                                id: selectClose
                                anchors.fill: parent
                                radius: height/2
                                color: maincolor
                                opacity: 0.3
                                visible: false
                            }

                            Text {
                                id: closeButtonText
                                text: "OK"
                                font.family: xciteMobile.name
                                font.pointSize: parent.height/2
                                color: parent.border.color
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true

                                onEntered: {
                                    selectClose.visible = true
                                }

                                onExited: {
                                    selectClose.visible = false
                                }

                                onPressed: {
                                    click01.play()
                                    detectInteraction()
                                }

                                onClicked: {
                                    sendAmount.text = ""
                                    referenceInput.text = ""
                                    failedSend = 0
                                    transactionSend = 0
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
                    }
                }

                Item {
                    id: confirmTransaction
                    anchors.fill: parent
                    visible: transactionSend == 1
                             && failedSend == 0

                    Item {
                        width: parent.width - appWidth/12
                        height: sendingLabel.height
                                + to.height + to.anchors.topMargin
                                + confirmationAddressName.height + confirmationAddressName.anchors.topMargin
                                + reference.height + reference.anchors.topMargin
                                + feeLabel.height + feeLabel.anchors.topMargin
                                + confirmTX.height + confirmTX.anchors.topMargin
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: appHeight/108

                        Text {
                            id: sendingLabel
                            text: "SENDING:"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            font.family: xciteMobile.name
                            font.pixelSize: appHeight/54
                            color: themecolor
                        }

                        Item {
                            id:amount
                            width: confirmationAmount.implicitWidth + confirmationAmount1.implicitWidth + confirmationAmount2.implicitWidth + appHeight/36
                            height: confirmationAmount.implicitHeight
                            anchors.bottom: sendingLabel.bottom
                            anchors.right: parent.right
                        }

                        Text {
                            id: confirmationAmount
                            text: walletIndex >= 0? walletList.get(walletIndex).name : ""
                            anchors.top: amount.top
                            anchors.right: amount.right
                            font.family: xciteMobile.name
                            font.pixelSize: appHeight/54
                            color: themecolor
                        }

                        Text {
                            property int dec: receivedAmount > 1000? 2 : (receivedAmount > 1? 4 : 8)
                            property string transferAmount: receivedAmount.toLocaleString(Qt.locale("en_US"), "f", dec)
                            property var amountArray: transferAmount.split('.')
                            id: confirmationAmount1
                            text: amountArray[1] !== undefined?  ("." + amountArray[1]) : ".0000"
                            anchors.bottom: confirmationAmount.bottom
                            anchors.right: confirmationAmount.left
                            anchors.rightMargin: appHeight/54
                            font.family: xciteMobile.name
                            font.pixelSize: appHeight/54
                            color: themecolor
                        }

                        Text {
                            property int dec: receivedAmount > 1000? 2 : (receivedAmount > 1? 4 : 8)
                            property string transferAmount: receivedAmount.toLocaleString(Qt.locale("en_US"), "f", dec)
                            property var amountArray: transferAmount.split('.')
                            id: confirmationAmount2
                            text: amountArray[0]
                            anchors.top: confirmationAmount.top
                            anchors.right: confirmationAmount1.left
                            font.family: xciteMobile.name
                            font.pixelSize: appHeight/54
                            color: themecolor
                        }

                        Text {
                            id: to
                            text: "TO:"
                            anchors.left: parent.left
                            anchors.top: sendingLabel.bottom
                            anchors.topMargin: appHeight/36
                            font.family: xciteMobile.name
                            font.pixelSize: appHeight/54
                            color: themecolor
                        }

                        Text {
                            id: confirmationAddress
                            text: selectedAddress
                            anchors.bottom: to.bottom
                            anchors.right: parent.right
                            anchors.left: to.right
                            anchors.leftMargin: font.pixelSize*2
                            horizontalAlignment: Text.AlignRight
                            elide: Text.ElideRight
                            font.family: xciteMobile.name
                            font.pixelSize: appHeight/54
                            color: themecolor
                        }

                        Text {
                            property int contactID: addressIndex >= 0? addressList.get(addressIndex).contact : 0
                            property string contactFirst: contactList.get(contactID).firstName
                            property string contactLast: contactList.get(contactID).lastName
                            id: confirmationAddressName
                            text: "(" + contactFirst + " " + contactLast + ")"
                            anchors.top: confirmationAddress.bottom
                            anchors.topMargin: font.pixelSize/3
                            anchors.right: parent.right
                            font.family: xciteMobile.name
                            font.pixelSize: appHeight/54
                            color: themecolor
                            visible: receivedLabel != ""
                        }

                        Text {
                            id: reference
                            text: "REF.:"
                            anchors.left: parent.left
                            anchors.top: confirmationAddressName.bottom
                            anchors.topMargin: appHeight/27
                            font.family: xciteMobile.name
                            font.pixelSize: appHeight/54
                            color: themecolor
                        }

                        Text {
                            id: referenceText
                            text: referenceInput.text !== ""? referenceInput.text : "no reference"
                            anchors.bottom: reference.bottom
                            anchors.right: parent.right
                            anchors.left: reference.right
                            leftPadding: font.pixelSize*2
                            horizontalAlignment: Text.AlignRight
                            font.family: xciteMobile.name
                            font.pixelSize: appHeight/54
                            font.italic: referenceText.text == "no reference"
                            color: themecolor
                            elide: Text.ElideRight
                        }

                        Text {
                            id: feeLabel
                            text: "TX FEE:"
                            anchors.left: parent.left
                            anchors.top: reference.bottom
                            anchors.topMargin: appHeight/36
                            font.family: xciteMobile.name
                            font.pixelSize: appHeight/54
                            color: themecolor
                        }

                        Item {
                            id:feeAmount
                            implicitWidth: confirmationFeeAmount.implicitWidth + confirmationFeeAmount1.implicitWidth + confirmationFeeAmount2.implicitWidth + appHeight/36
                            implicitHeight: confirmationAmount.implicitHeight
                            anchors.bottom: feeLabel.bottom
                            anchors.right: parent.right
                        }

                        Text {
                            id: confirmationFeeAmount
                            text: walletIndex >= 0? walletList.get(walletIndex).name : ""
                            anchors.top: feeAmount.top
                            anchors.right: feeAmount.right
                            font.family: xciteMobile.name
                            font.pixelSize: appHeight/54
                            color: themecolor
                        }

                        Text {
                            property string transferFee: txFee.toLocaleString(Qt.locale("en_US"), "f", decimals)
                            property var feeArray: transferFee.split('.')
                            id: confirmationFeeAmount1
                            text: feeArray[1] !== undefined?  ("." + feeArray[1]) : ".0000"
                            anchors.bottom: confirmationFeeAmount.bottom
                            anchors.right: confirmationFeeAmount.left
                            anchors.rightMargin: font.pixelSize
                            font.family: xciteMobile.name
                            font.pixelSize: appHeight/54
                            color: themecolor
                        }

                        Text {
                            property string transferFee: txFee.toLocaleString(Qt.locale("en_US"), "f", decimals)
                            property var feeArray: transferFee.split('.')
                            id: confirmationFeeAmount2
                            text: feeArray[0]
                            anchors.top: confirmationFeeAmount.top
                            anchors.right: confirmationFeeAmount1.left
                            font.family: xciteMobile.name
                            font.pixelSize: appHeight/54
                            color: themecolor
                        }

                        Rectangle {
                            id: confirmTX
                            width: parent.width*0.9/2
                            height: appHeight/27
                            radius: height/2
                            anchors.left: parent.left
                            anchors.top: confirmationFeeAmount.bottom
                            anchors.topMargin: height
                            color: "transparent"
                            border.width: 1
                            border.color: themecolor

                            Rectangle {
                                id: selectConfirm
                                anchors.fill: parent
                                radius: height/2
                                color: maincolor
                                opacity: 0.3
                                visible: false
                            }

                            Text {
                                id: confirmButtonText
                                text: "CONFIRM"
                                font.family: xciteMobile.name
                                font.pointSize: parent.height/2
                                color: parent.border.color
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            MouseArea {
                                anchors.fill: confirmTX
                                hoverEnabled: true

                                onEntered: {
                                    selectConfirm.visible = true
                                }

                                onExited: {
                                    selectConfirm.visible = false
                                }

                                onPressed: {
                                    click01.play()
                                    detectInteraction()
                                }

                                onClicked: {
                                    transactionInProgress = true
                                    if (userSettings.pinlock === true){
                                        pincodeTracker = 1
                                    }
                                    else {
                                        timer3.start()
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
                                        var total = Number.fromLocaleString(Qt.locale("en_US"),sendAmount.text)
                                        var totalFee = Number.fromLocaleString(Qt.locale("en_US"),txFee)
                                        var totalUsed = Number.fromLocaleString(Qt.locale("en_US"),usedCoins)
                                        transactionList.append({"requestID":receivedTxID,"txid":"","coin":walletList.get(walletIndex).name,"address":receivedSender,"receiver":receivedReceiver,"amount":total,"fee":totalFee,"used":totalUsed})
                                        transactionInProgress = false
                                        closeTimer.start()
                                    }
                                }

                                Connections {
                                    target: UserSettings

                                    onPincodeCorrect: {
                                        if (pincodeTracker == 1 && transferTracker == 1 && pageTracker == 1) {
                                            timer3.start()
                                        }
                                    }
                                }
                            }
                        }

                        Rectangle {
                            id: cancelTX
                            width: parent.width*0.9/2
                            height: appHeight/27
                            radius: height/2
                            anchors.right: parent.right
                            anchors.top: confirmationFeeAmount.bottom
                            anchors.topMargin: height
                            color: "transparent"
                            border.width: 1
                            border.color: themecolor

                            Rectangle {
                                id: cancelConfirm
                                anchors.fill: parent
                                radius: height/2
                                color: maincolor
                                opacity: 0.3
                                visible: false
                            }

                            Text {
                                id: cancelButtonText
                                text: "CANCEL"
                                font.family: xciteMobile.name
                                font.pointSize: parent.height/2
                                color: parent.border.color
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            MouseArea {
                                anchors.fill: cancelTX
                                hoverEnabled: true

                                onEntered: {
                                    cancelConfirm.visible = true
                                }

                                onExited: {
                                    cancelConfirm.visible = false
                                }

                                onPressed: {
                                    click01.play()
                                    detectInteraction()
                                }

                                onClicked: {
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
                    }
                }
            }
        }


    }

    Timer {
        id: closeTimer
        interval: 300
        repeat: false
        running: false

        onTriggered: {
            walletListTracker = 0
            walletIndex = -1
            transactionSend = 0
            sendAmount.text = ""
            referenceInput.text = ""
            validAddress = 0
            calculatorTracker = 0
            calculatedAmount = ""
            networkError = 0
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
