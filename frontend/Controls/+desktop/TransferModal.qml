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

    property int transactionSend: 0
    property int confirmationSend: 0
    property int failedSend: 0
    property int invalidAddress: 0
    property var inputAmount: Number.fromLocaleString(Qt.locale("en_US"),replaceComma)
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
    property string searchCriteria: ""
    property int copyImage2clipboard: 0
    property int badNetwork: 0
    property bool selectNetwork: false
    property bool createTx: false
    property string txFailError:""

    property var commaArray
    property int detectComma
    property string replaceComma
    property var transferArray
    property int precision: 0

    Timer {
        id: closeTimer
        interval: 300
        repeat: false
        running: false

        onTriggered: {/*
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
            createTx = false*/
        }
    }

    Rectangle {
        height: appWidth/24
        width: parent.width
        anchors.bottom: parent.bottom
        color: darktheme == true? "#14161B" : "#FDFDFD"
    }
}
