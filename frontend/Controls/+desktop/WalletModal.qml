/**
* Filename: WalletModal.qml
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
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import QtCharts 2.0
import QZXing 2.3

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: walletModal
    width: appWidth/6 * 5
    height: appHeight
    anchors.right: parent.right
    anchors.top: parent.top
    color: bgcolor
    state: walletDetailTracker == 0 ? "down" : "up"
    clip: true

    onStateChanged: {
        transferSwitchState = (coinIndex < 3 || walletList.get(walletIndex).viewOnly)? 0 : 1
        historySwitch.state = "off"
        transferSwitch.state = transferSwitchState == 0 ? "off" : "on"
        transactionSend = 0
        confirmationSend = 0
        failedSend = 0
        invalidAddress = 0
        if (state == "up") {
            historyTracker = 1
            transferTracker = 1
        }
        else {
            historyTracker = 0
            transferTracker = 0
            keyInput.text = ""
            sendAmount.text = ""
            referenceInput.text = ""
        }
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: walletModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: walletModal; anchors.topMargin: appHeight}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: walletModal; properties: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    property int decimals: totalCoinsSum == 0? 2 : (totalCoinsSum <= 1000? 8 : (totalCoinsSum <= 1000000? 4 : 2))
    property real totalCoinsSum: walletList.get(walletIndex).balance
    property var totalArray: (totalCoinsSum.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
    property bool myTheme: darktheme
    property int transferSwitchState: (coinIndex < 3 || walletList.get(walletIndex).viewOnly)? 0 : 1
    property int myIndex: walletIndex
    property int addressCopied: 0

    property int transactionSend: 0
    property int confirmationSend: 0
    property int failedSend: 0
    property int invalidAddress: 0
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

    onMyIndexChanged: {
        historySwitch.state = "off"
        transferSwitchState = walletList.get(walletIndex).viewOnly? 0 : transferSwitchState
        transferSwitch.state = transferSwitchState == 0 ? "off" : "on"
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
        invalidAddress = 0
        if (coinID === "XBY") {
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
        else if (coinID === "XFUEL") {
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
        else if (coinID === "XTEST") {
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
        else if (coinID === "BTC") {
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
        else if (coinID === "ETH") {
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
            if (walletList.get(i).address === getAddress (walletList.get(walletIndex).name, walletLabel.text)) {
                currentBalance = walletList.get(i).balance
            }
        }
        return currentBalance
    }

    MouseArea {
        anchors.fill: parent
    }

    Label {
        id: walletLabel
        text: "WALLET - " + walletList.get(walletIndex).name + " - " + walletList.get(walletIndex).label
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.left: parent.left
        anchors.leftMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        horizontalAlignment: Text.AlignRight
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        font.capitalization: Font.AllUppercase
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        elide: Text.ElideRight
    }

    Item {
        id: totalWalletValue
        width: valueTicker.implicitWidth + value1.implicitWidth + value2.implicitWidth
        height: value1.implicitHeight
        anchors.top: walletLabel.bottom
        anchors.topMargin: appWidth/72
        anchors.right: walletLabel.right

        Label {
            id: valueTicker
            anchors.left: value2.right
            anchors.bottom: value1.bottom
            leftPadding: appHeight/54
            text: walletList.get(walletIndex).name
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
            color: themecolor
            visible: userSettings.showBalance === true
        }

        Label {
            id: value1
            anchors.left: parent.left
            anchors.verticalCenter: totalWalletValue.verticalCenter
            text: totalArray[0]
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
            color: themecolor
        }

        Label {
            id: value2
            anchors.left: value1.right
            anchors.bottom: value1.bottom
            text: "." + totalArray[1]
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
            color: themecolor
        }
    }

    Rectangle {
        id: changeButton
        width: appWidth/6
        height: appHeight/27
        anchors.bottom: infoBar.top
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        border.color: themecolor
        border.width: 1
        color: "transparent"
        visible: walletListTracker == 0 && scanQRTracker == 0 && addressbookTracker == 0

        Rectangle {
            id: selectChange
            anchors.fill: parent
            color: maincolor
            opacity: 0.3
            visible: false
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                selectChange.visible = true
            }

            onExited: {
                selectChange.visible = false
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                walletListTracker = 1
            }
        }

        Text {
            id: changeButtonText
            text: "CHANGE WALLET"
            font.family: xciteMobile.name
            font.pointSize: parent.height/2
            color: themecolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: infoBar
        width: parent.width
        height: appHeight/18
        anchors.top: totalWalletValue.bottom
        anchors.topMargin: appWidth/24
        anchors.horizontalCenter: parent.horizontalCenter
        color: bgcolor
    }

    Rectangle {
        id: walletArea
        width: parent.width
        anchors.top: infoBar.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: appWidth/24
        color: "transparent"
        clip: true

        Item {
            id: transactionArea
            width: (parent.width - appWidth*3/24)/2
            anchors.left: parent.left
            anchors.leftMargin: appWidth/24
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: appWidth/24
            clip: true

            Label {
                id: transactionLabel
                text: "TRANSFER"
                color: themecolor
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Controls.Switch {
                id: transferSwitch
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: transactionLabel.bottom
                anchors.topMargin: appWidth/48
                state: transferSwitchState == 0 ? "off" : "on"
                switchActive: coinIndex < 3 && !walletList.get(walletIndex).viewOnly
                visible: transactionSend == 0
            }

            Text {
                id: activeText
                text: "RECEIVE"
                anchors.right: transferSwitch.left
                anchors.rightMargin: font.pixelSize/2
                anchors.verticalCenter: transferSwitch.verticalCenter
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                color: transferSwitch.switchOn ? "#757575" : maincolor
                visible: transactionSend == 0
            }

            Text {
                id: viewText
                text: "SEND"
                anchors.left: transferSwitch.right
                anchors.leftMargin: font.pixelSize/2
                anchors.verticalCenter: transferSwitch.verticalCenter
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                color: transferSwitch.switchOn ? maincolor : "#757575"
                visible: transactionSend == 0

                Label {
                    id: advancedSendLabel
                    text: "advanced"
                    anchors.left: parent.right
                    anchors.leftMargin: parent.font.pixelSize*2
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: xciteMobile.name
                    font.pixelSize: parent.font.pixelSize*2/3
                    color: transferSwitch.switchOn ? themecolor : "#757575"

                    Rectangle {
                        id: advancedSelector
                        width: parent.width
                        height: 1
                        color: maincolor
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        anchors.topMargin: parent.font.pixelSize/2
                        visible: false
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            enabled: transferSwitch.switchOn

                            onEntered: {
                                advancedSelector.visible = true
                            }

                            onExited: {
                                advancedSelector.visible = false
                            }

                            onPressed: {
                                click01.play()
                                detectInteraction()
                            }

                            onClicked: {
                                advancedTransferTracker = 1
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: qrArea
                height: parent.height*2/3
                width: height
                anchors.top: transferSwitch.bottom
                anchors.topMargin: appWidth/96
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                visible: !transferSwitch.switchOn

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    border.width: 1
                    border.color: themecolor
                    opacity: 0.1
                }

                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: appHeight/72
                    text: "Your wallet ADDRESS"
                    font.pixelSize: appHeight/36
                    font.family: xciteMobile.name
                    color: themecolor
                }

                Rectangle {
                    id: qrPlaceholder
                    width: parent.width/2
                    height: width
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: appWidth/24
                    color: "white"
                    border.color: themecolor
                    border.width: 1

                    Image {
                        width: parent.width*0.95
                        height: parent.height*0.95
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        source: "image://QZXing/encode/" + walletList.get(walletIndex).address
                        cache: false
                    }
                }

                Item {
                    width: parent.width*0.8
                    height: addressHashLabel.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: appHeight/36

                    Label {
                        id: addressHashLabel
                        width: parent.width - clipBoard1.width
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        text: walletList.get(walletIndex).address
                        maximumLineCount: 2
                        wrapMode: Text.WrapAnywhere
                        font.pixelSize: appHeight/54
                        font.family: xciteMobile.name
                        color: themecolor
                        rightPadding: appHeight/36
                    }

                    Image {
                        id: clipBoard1
                        source: darktheme == true? "qrc:/icons/clipboard_icon_light01.png" : "qrc:/icons/clipboard_icon_dark01.png"
                        height: appHeight/27
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: addressHashLabel.verticalCenter
                        anchors.left: addressHashLabel.right

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"

                            MouseArea {
                                anchors.fill: parent

                                onClicked: {
                                    if (copy2clipboard == 0) {
                                        copyText2Clipboard(addressHashLabel.text)
                                        copy2clipboard = 1
                                        addressCopied = 1
                                        timer.start()
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
                        visible: textPopup.visible
                    }

                    Item {
                        id: textPopup
                        z: 12
                        width: popupClipboard.width
                        height: popupClipboardText.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        visible: copy2clipboard == 1 && addressCopied == 1

                        Rectangle {
                            id: popupClipboard
                            height: appHeight/27
                            width: popupClipboardText.width + appHeight/18
                            color: "#42454F"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Label {
                            id: popupClipboardText
                            text: "Address copied!"
                            font.family: xciteMobile.name
                            font.pointSize: popupClipboard.height/2
                            color: "#F2F2F2"
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }

            Item {
                id: sendArea
                width: appWidth/6*1.5
                height: sendAmount.height + keyInput.height + keyInput.anchors.topMargin + scanQrButton.height + scanQrButton.anchors.topMargin + referenceInput.height + referenceInput.anchors.topMargin + sendButton.height*2 + sendButton.anchors.topMargin
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: transferSwitch.bottom
                anchors.topMargin: appWidth/96
                visible: transferSwitch.switchOn
                         && transactionSend == 0
                         && walletList.get(walletIndex).viewOnly === false

                Mobile.AmountInput {
                    id: sendAmount
                    height: appHeight/18
                    width: parent.width
                    anchors.top: parent.top
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
                    visible: (walletList.get(walletIndex).name === "XBY" || walletList.get(walletIndex).name === "XFUEL" || walletList.get(walletIndex).name === "XTEST")? inputAmount >= walletList.get(walletIndex).balance - 1 : inputAmount > walletList.get(walletIndex).balance - 1
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
                    text: sendAddress.text
                    height: appHeight/18
                    width: parent.width
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
                             && invalidAddress == 1
                }

                Rectangle {
                    id: scanQrButton
                    width: (parent.width*0.9) / 2
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
                    width: (parent.width*0.9) / 2
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

                Controls.TextInput {
                    id: referenceInput
                    height: appHeight/18
                    width: parent.width
                    placeholder: "REFERENCE"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: scanQrButton.bottom
                    anchors.topMargin: appHeight/27
                    color: themecolor
                    textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
                    font.pixelSize: height/2
                    mobile: 1
                    onTextChanged: detectInteraction()
                }

                Rectangle {
                    id: sendButton
                    width: appWidth/6
                    height: appHeight/27
                    color: "transparent"
                    border.width: 1
                    border.color: (invalidAddress == 0
                                   && keyInput.text !== ""
                                   && sendAmount.text !== ""
                                   && (walletList.get(walletIndex).name === "XBY" || walletList.get(walletIndex).name === "XFUEL" || walletList.get(walletIndex).name.text === "XTEST")? inputAmount >= 1 : inputAmount > 0
                                                                                                                                                                                         && precision <= 8
                                                                                                                                                                                         && inputAmount <= (walletList.get(walletIndex).balance)) ? themecolor : "#727272"
                    anchors.top: referenceInput.bottom
                    anchors.topMargin: height
                    anchors.horizontalCenter: referenceInput.horizontalCenter

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
                        color: themecolor
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: sendButton
                        hoverEnabled: true
                        enabled: invalidAddress == 0
                                 && keyInput.text !== ""
                                 && sendAmount.text !== ""
                                 && inputAmount >= 1
                                 && precision <= 8
                                 && inputAmount <= ((walletList.get(walletIndex).balance) - 1)
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

                        onClicked: {
                            txFailError = ""
                            selectNetwork = true
                            createTx = true
                            //transactionInProgress = true
                            setNetwork(network)
                        }

                        Connections {
                            target: xUtility

                            onNewNetwork: {
                                if (transferTracker == 1 && selectNetwork == true && advancedTransferTracker == 0) {
                                    coinListTracker = 0
                                    walletListTracker = 0
                                    selectNetwork = false
                                    var t = new Date().toLocaleString(Qt.locale(),"hh:mm:ss .zzz")
                                    var msg = "UI - send coins - target:" + keyInput.text + ", amount:" +  sendAmount.text + ", private key: " +  getPrivKey(walletList.get(walletIndex).name, walletList.get(walletIndex).label)
                                    xPingTread.append({"message": msg, "inout": "out", "author": myUsername, "time": t})
                                    sendCoins(keyInput.text + "-" +  sendAmount.text + " " +  sendAmount.text + " " +  getPrivKey(walletList.get(walletIndex).name, walletList.get(walletIndex).label))
                                }
                            }

                            onBadNetwork: {
                                if (transferTracker == 1 && selectNetwork == true && advancedTransferTracker == 0) {
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
                                    var splitReceivers = receiver_.split(";")
                                    var receiverInfo
                                    var splitReceiverInfo
                                    if (splitReceivers.count > 1) {
                                    }
                                    else {
                                        receiverInfo = splitReceivers[0]
                                        splitReceiverInfo = receiverInfo.split("-")
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
                                        if (splitReceivers.count === 1) {
                                            for (var i = 0; i < walletList.count; i ++) {
                                                if (walletList.get(i).address === r){
                                                    receivedLabel = walletList.get(i).label
                                                }
                                            }
                                        }
                                        else if (splitReceivers.count > 1) {
                                            receivedLabel = splitReceivers.count
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

                AnimatedImage {
                    id: waitingDots01
                    source: 'qrc:/gifs/loading-gif_01.gif'
                    width: 75
                    height: 50
                    anchors.horizontalCenter: sendButton.horizontalCenter
                    anchors.verticalCenter: sendButton.verticalCenter
                    playing: createTx == true
                    visible: createTx == true
                }
            }

            Rectangle {
                width: 1
                anchors.top: parent.top
                anchors.topMargin: appWidth/48
                anchors.bottom: parent.bottom
                anchors.bottomMargin: appWidth/24
                anchors.right: parent.right
                color: themecolor
                opacity: 0.1
            }
        }

        Item {
            id: historyArea
            width: (parent.width - appWidth*3/24)/2
            anchors.right: parent.right
            anchors.rightMargin: appWidth/12
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: appWidth/24
            clip: true

            Label {
                id: historyLabel
                text: "TRANSACTIONS"
                color: themecolor
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Controls.Switch {
                id: historySwitch
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: historyLabel.bottom
                anchors.topMargin: appWidth/48
                state: "off"
                switchActive: coinIndex < 3
            }

            Text {
                id: confirmedText
                text: "CONFIRMED"
                anchors.right: historySwitch.left
                anchors.rightMargin: font.pixelSize/2
                anchors.verticalCenter: historySwitch.verticalCenter
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                color: historySwitch.switchOn ? "#757575" : maincolor
            }

            Text {
                id: pendingText
                text: "PENDING"
                anchors.left: historySwitch.right
                anchors.leftMargin: font.pixelSize/2
                anchors.verticalCenter: historySwitch.verticalCenter
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                color: historySwitch.switchOn ? maincolor : "#757575"
            }

            Rectangle {
                anchors.fill: parent
                color: bgcolor
                opacity: 0.9
                visible: scanQRTracker == 1 || addressbookTracker == 1

                MouseArea {
                    anchors.fill: parent
                }
            }
        }
    }

    Rectangle {
        id: closeWalletList
        width: appWidth/48
        height: width
        radius: height/2
        color: "transparent"
        border.width: 1
        border.color: themecolor
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.bottom: selectWalletArea.top
        anchors.bottomMargin: height/2
        visible: walletListTracker == 1

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
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        state: walletListTracker == 0 ? "down" : "up"
        clip: true

        states: [
            State {
                name: "up"
                PropertyChanges { target: selectWalletArea; anchors.bottomMargin: appWidth/24}
            },
            State {
                name: "down"
                PropertyChanges { target: selectWalletArea; anchors.bottomMargin: -selectWalletArea.height}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: selectWalletArea; properties: "anchors.bottomMargin"; duration: 300; easing.type: Easing.InOutCubic}
            }
        ]

        Desktop.WalletListSmall {
            id: myWalletListSmall
            anchors.top: parent.top
        }
    }

    Item {
        id: scannerArea
        height: walletArea.height
        width: (walletArea.width - appWidth*3/24)/2
        anchors.left: walletArea.left
        anchors.leftMargin: appWidth/24
        anchors.top: walletArea.top
        state: scanQRTracker == 1? "up" : "down"

        onStateChanged: {
            if (scanQRTracker == 0 && qrFound == false) {
                selectedAddress = ""
                publicKey.text = "scanning..."
            }
            if (state == "up") {
                scanTimer.restart()
            }
        }

        states: [
            State {
                name: "up"
                PropertyChanges { target: scannerArea; anchors.topMargin: 0}
            },
            State {
                name: "down"
                PropertyChanges { target: scannerArea; anchors.topMargin: scannerArea.height + appWidth/24}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: scannerArea; properties: "anchors.bottomMargin"; duration: 300; easing.type: Easing.InOutCubic}
            }
        ]
    }

    Rectangle {
        id: qrScanner
        width: scannerArea.width
        height: scannerArea.height
        color: bgcolor
        anchors.horizontalCenter: scannerArea.horizontalCenter
        anchors.top: scannerArea.top

        Timer {
            id: scanTimer
            interval: 15000
            repeat: false
            running: false

            onTriggered: {
                scanQRTracker = 0
                publicKey.text = "scanning..."
            }
        }

        Timer {
            id: timer1
            interval: 1000
            repeat: false
            running: false

            onTriggered:{
                scanQRTracker = 0
                publicKey.text = "scanning..."
                qrFound = false
            }
        }

        Camera {
            id: camera
            position: Camera.FrontFace
            cameraState: cameraPermission === true? ((transferTracker == 1) ? (scanQRTracker == 1 ? Camera.ActiveState : Camera.LoadedState) : Camera.UnloadedState) : Camera.UnloadedState
            focus {
                focusMode: Camera.FocusContinuous
                focusPointMode: CameraFocus.FocusPointAuto
            }

            onCameraStateChanged: {
                console.log("camera status: " + camera.cameraStatus)
            }
        }

        Rectangle {
            width: scannerBg.width*1.05
            height: scannerBg.height*1.05
            color: bgcolor
            border.width: 2
            border.color: themecolor
            anchors.horizontalCenter: scannerBg.horizontalCenter
            anchors.verticalCenter: scannerBg.verticalCenter
        }

        Rectangle {
            id: scannerBg
            width: appWidth*5/18
            height: appHeight/2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            color: "transparent"
            clip: true

            Label {
                text: "activating camera..."
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: scanFrame.verticalCenter
                color: "#f2f2f2"
                font.family: xciteMobile.name
                font.pixelSize: appHeight/36
                font.italic: true

            }

            VideoOutput {
                id: videoOutput
                source: camera
                width: parent.width
                fillMode: VideoOutput.PreserveAspectCrop
                autoOrientation: true
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalcenter
                filters: [
                    qrFilter
                ]
            }

            Text {
                id: scanQRLabel
                text: "SCAN QR CODE"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: font.pixelSize
                font.pixelSize: appHeight/27
                font.family: xciteMobile.name
                color: "#f2f2f2"
            }

            Rectangle {
                id: scanFrame
                width: parent.width*0.5
                height: width
                radius: 10
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: "transparent"
                border.width: 1
                border.color: "#f2f2f2"
            }

            Label {
                id: pubKey
                text: "PUBLIC KEY"
                anchors.top: scanFrame.bottom
                anchors.topMargin: appHeight/36
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#f2f2f2"
                font.family: xciteMobile.name
                font.pixelSize: appHeight/36
                font.letterSpacing: 1
            }

            Label {
                id: publicKey
                text: scanning
                width: parent.width
                padding: appHeight/45
                maximumLineCount: 3
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                anchors.top: pubKey.bottom
                anchors.topMargin: font.pixelSize/2
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#f2f2f2"
                font.family: xciteMobile.name
                font.pixelSize: appHeight/45
                font.italic: publicKey.text == "scanning..."

            }
        }

        QZXingFilter {
            id: qrFilter
            decoder {
                enabledDecoders: QZXing.DecoderFormat_QR_CODE
                onTagFound: {
                    scanTimer.stop()
                    console.log(tag);
                    scanning = ""
                    publicKey.text = tag
                    keyInput.text = publicKey.text
                    timer1.start()
                }
                tryHarder: true

            }

            captureRect: {
                // setup bindings
                videoOutput.contentRect;
                videoOutput.sourceRect;
                return videoOutput.mapRectToSource(videoOutput.mapNormalizedRectToItem(Qt.rect(
                                                                                           0.125, 0.125, 0.75, 0.75
                                                                                           )));
            }
        }
    }

    Rectangle {
        height: appWidth/24
        width: parent.width
        anchors.bottom: parent.bottom
        color: darktheme == true? "#14161B" : "#FDFDFD"
    }

    Timer {
        id: timer
        interval: 2000
        repeat: false
        running: false

        onTriggered: {
            addressCopied = 0
            copy2clipboard = 0
            closeAllClipboard = true
        }
    }
}
