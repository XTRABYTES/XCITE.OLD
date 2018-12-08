/**
 * Filename: AddressModal.qml
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

import "qrc:/Controls" as Controls
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: addressModal
    width: 325
    state: addressTracker == 0 ? "down" : "up"
    height: scanQRTracker == 1 ? 450 : ((transactionSent == 1 || editSaved == 1 || deleteAddressTracker == 1 || deleteConfirmed == 1)? 350 : (addressSwitch.state == "off" || scanQRTracker == 0) ? 385 : 350)
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    visible: scanQRTracker == 0

    states: [
        State {
            name: "up"
            PropertyChanges { target: addressModal; anchors.topMargin: 50}
        },
        State {
            name: "down"
            PropertyChanges { target: addressModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: addressModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.OutCubic}
            //PropertyAnimation { target: addressModal; property: "visible"; duration: 300}
        }
    ]

    property string coinName: addressList.get(addressIndex).coin
    property string sendAddress: addressList.get(addressIndex).address
    property string addressName: addressList.get(addressIndex).name
    property int switchState: 0
    property int addressBookTracker: 0
    property int deleteAddressTracker: 0
    property int transactionSent: 0
    property int confirmationSent: 0
    property int editSaved: 0
    property int deleteConfirmed: 0
    property int addressNR: 0
    property int invalidAddress: 0
    property int doubbleAddress: 0
    property int labelExists: 0
    property int myAddress: 0
    property int decimals: (newCoinName.text) == "BTC" ? 8 : 4
    property var inputAmount: Number.fromLocaleString(Qt.locale("en_US"),sendAmount.text)
    property string amountTransfer: "AMOUNT (" + newCoinName.text + ")"
    property string referenceTransfer: "REFERENCE"
    property string transactionDate: ""
    property string transactionName: compareAddress()


    function compareAddress(){
        var fromto = ""
        for(var i = 0; i < addressList.count; i++) {
            if (addressList.get(i).address === keyInput.placeholder) {
                if (addressList.get(i).coin === newCoinName.text) {
                    fromto = (addressList.get(i).name)
                }
            }
        }
        return fromto
    }

    function checkMyAddress(){
        myAddress = 0
        for(var i = 0; i < addressList.count; i++) {
            if (addressList.get(i).name === newName.placeholder) {
                if (addressList.get(i).address === receivingAddress || addressList.get(i).address === receivingAddressXFUEL || addressList.get(i).address === receivingAddressBTC || addressList.get(i).address === receivingAddressETH) {
                    myAddress = 1
                }
            }
        }
    }

    function compareTx(){
        doubbleAddress = 0
        for(var i = 0; i < addressList.count; i++) {
            if (newAddress.text != "") {
                if (newCoinName.text == "XBY") {
                    if (addressList.get(i).coin === "XBY") {
                        if (addressList.get(i).address === newAddress.text) {
                            if (addressList.get(i).active === true) {
                                doubbleAddress = 1
                            }
                        }
                    }
                }
                else {
                    if (addressList.get(i).coin === newCoinName.text) {
                        if (addressList.get(i).address === newAddress.text) {
                            if (addressList.get(i).active === true) {
                                doubbleAddress = 1
                            }
                        }
                    }
                }
            }
            else {
                if (newCoinName.text == "XBY") {
                    if (addressList.get(i).coin === "XBY") {
                        if (addressList.get(i).address === newAddress.placeholder) {
                            if (addressList.get(i).active === true) {
                                doubbleAddress = 1
                            }
                        }
                    }
                }
                else {
                    if (addressList.get(i).coin === newCoinName.text) {
                        if (addressList.get(i).address === newAddress.placeholder) {
                            if (addressList.get(i).active === true) {
                                doubbleAddress = 1
                            }
                        }
                    }
                }
            }
        }
    }

    function compareName(){
        labelExists = 0
        for(var i = 0; i < addressList.count; i++) {
            if (newName.text != "") {
                if (newCoinName.text == "XBY") {
                    if (addressList.get(i).coin === "XBY") {
                        if (addressList.get(i).name === newName.text) {
                            if (addressList.get(i).active === true) {
                                labelExists = 1
                            }
                        }
                    }
                }
                else {
                    if (addressList.get(i).coin === newCoinName.text) {
                        if (addressList.get(i).name === newName.text) {
                            if (addressList.get(i).active === true) {
                                labelExists = 1
                            }
                        }
                    }
                }
            }
            else {
                if (newCoinName.text == "XBY") {
                    if (addressList.get(i).coin === "XBY") {
                        if (addressList.get(i).name === newName.placeholder) {
                            if (addressList.get(i).active === true) {
                                labelExists = 1
                            }
                        }
                    }
                }
                else {
                    if (addressList.get(i).coin === newCoinName.text) {
                        if (addressList.get(i).name === newName.placeholder) {
                            if (addressList.get(i).active === true) {
                                labelExists = 1
                            }
                        }
                    }
                }
            }
        }
    }

    function checkAddress() {
        invalidAddress = 0
        if (newAddress.text != "") {
            if (newCoinName.text == "XBY") {
                if (newAddress.length == 34
                        && newAddress.text.substring(0,1) == "B"
                        && newAddress.acceptableInput == true) {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
            else if (newCoinName.text == "XFUEL") {
                if (newAddress.length == 34
                        && newAddress.text.substring(0,1) == "F"
                        && newAddress.acceptableInput == true) {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
        }
        else {
            if (newCoinName.text == "XBY") {
                if (newAddress.placeholder.length == 34
                        && newAddress.placeholder.substring(0,1) == "B") {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
            else if (newCoinName.text == "XFUEL") {
                if (newAddress.placeholder.length == 34
                        && newAddress.placeholder.substring(0,1) == "F") {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
        }
    }

    function checkCurrencyIndex() {
        for(var i = 0; i < currencyList.count; i++) {
            if (newCoinSelect == 1 && currencyList.get(newCoinPicklist).name === currencyList.get(i).name) {
                currencyIndex = i
            }
        }
    }

    function getCurrentBalance(){
        var currentBalance = 0
        for(var i = 0; i < currencyList.count; i++) {
            if (currencyList.get(i).name === newCoinName.text) {
                currentBalance = currencyList.get(i).balance
            }
        }
        return currentBalance
    }

    Rectangle {
        id: addressTitleBar
        width: parent.width
        height: 50
        radius: 4
        anchors.top: parent.top
        anchors.left: parent.left
        color: "#34363D"
        visible: editSaved == 0
                 && transactionSent == 0
                 && deleteAddressTracker == 0

        Image {
            id: titleIcon
            width: 25
            height: 25
            source: addressList.get(addressIndex).logo
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -4
            anchors.left: parent.left
            anchors.leftMargin: 15
            visible: scanQRTracker == 0
        }

        Text {
            id: transferModalLabel
            text: addressName
            anchors.left: titleIcon.right
            anchors.leftMargin: 7
            anchors.verticalCenter: titleIcon.verticalCenter
            anchors.verticalCenterOffset: -1
            font.pixelSize: 20
            font.family: xciteMobile.name //"Brandon Grotesque"
            color: "#F2F2F2"
            visible: scanQRTracker == 0
        }

        Image {
            id: favoriteAddressIcon
            source: 'qrc:/icons/icon-favorite.svg'
            width: 25
            height: 25
            anchors.verticalCenter: titleIcon.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 15
            visible: editSaved == 0 && scanQRTracker == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: addressList.get(addressIndex).favorite === 1 ? "#FDBC40" : "#2A2C31"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (addressList.get(addressIndex).favorite === 1) {
                        addressList.setProperty(addressIndex, "favorite", 0)
                    }
                    else {
                        addressList.setProperty(addressIndex, "favorite", 1)
                    }
                }
            }
        }
    }

    Rectangle {
        id: addressBodyModal
        width: parent.width
        height: parent.height - 50
        radius: 4
        color: "#42454F"
        anchors.top: parent.top
        anchors.topMargin: 42
        anchors.horizontalCenter: parent.horizontalCenter

        Controls.Switch_mobile {
            id: addressSwitch
            anchors.horizontalCenter: addressBodyModal.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            state: switchState == 0 ? "off" : "on"
            visible: transactionSent == 0
                     && editSaved == 0
                     && deleteAddressTracker == 0
                     && scanQRTracker == 0
            onStateChanged: checkMyAddress()
        }

        Text {
            id: sendText
            text: "SEND"
            anchors.right: addressSwitch.left
            anchors.rightMargin: 7
            anchors.verticalCenter: addressSwitch.verticalCenter
            font.pixelSize: 14
            font.family: xciteMobile.name //"Brandon Grotesque"
            color: addressSwitch.on ? "#5F5F5F" : maincolor
            visible: transactionSent == 0
                     && editSaved == 0
                     && deleteAddressTracker == 0
                     && scanQRTracker == 0
        }

        Text {
            id: editText
            text: "EDIT"
            anchors.left: addressSwitch.right
            anchors.leftMargin: 7
            anchors.verticalCenter: addressSwitch.verticalCenter
            font.pixelSize: 14
            font.family: xciteMobile.name //"Brandon Grotesque"
            color: addressSwitch.on ? maincolor : "#5F5F5F"
            visible: transactionSent == 0
                     && editSaved == 0
                     && deleteAddressTracker == 0
                     && scanQRTracker == 0
        }

        // Send state

        Image {
            id: newIcon
            source: newCoinSelect == 1? currencyList.get(newCoinPicklist).logo : addressList.get(addressIndex).logo
            height: 25
            width: 25
            anchors.left: sendAmount.left
            anchors.top: addressSwitch.bottom
            anchors.topMargin: 10
            visible: picklistTracker == 0
                     && editSaved == 0
                     && transactionSent == 0
                     && deleteAddressTracker == 0
                     && scanQRTracker == 0
        }

        Label {
            id: newCoinName
            text: newCoinSelect == 1? currencyList.get(newCoinPicklist).name : addressList.get(addressIndex).coin
            anchors.left: newIcon.right
            anchors.leftMargin: 7
            anchors.verticalCenter: newIcon.verticalCenter
            font.pixelSize: 18
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.bold: true
            color: "#F2F2F2"
            visible: picklistTracker == 0
                     && editSaved == 0
                     && transactionSent == 0
                     && deleteAddressTracker == 0
                     && scanQRTracker == 0
            onTextChanged: if (addressSwitch.state == "on") {
                               checkAddress() && compareName() && compareTx()
                           }
        }

        Label {
            id: walletLabel
            text: currencyList.get(currencyIndex).label
            anchors.right: sendAmount.right
            anchors.verticalCenter: newIcon.verticalCenter
            font.pixelSize: 18
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.bold: true
            color: "#F2F2F2"
            visible: editSaved == 0
                     && transactionSent == 0
                     && addressSwitch.state == "off"
                     && scanQRTracker == 0
        }

        Text {
            id: walletBalance
            text: newCoinName.text
            anchors.right: sendAmount.right
            anchors.top: walletLabel.bottom
            anchors.topMargin: 5
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pixelSize: 14
            color: "#828282"
            visible: editSaved == 0
                     && transactionSent == 0
                     && addressSwitch.state == "off"
                     && scanQRTracker == 0
        }

        Text {
            property string balance: (currencyList.get(currencyIndex).balance).toLocaleString(Qt.locale("en_US"), "f", decimals)
            property var balanceArray: balance.split('.')
            id: walletBalance1
            text:  "." + balanceArray[1]
            anchors.right: walletBalance.left
            anchors.rightMargin: 5
            anchors.bottom: walletBalance.bottom
            anchors.topMargin: 5
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pixelSize: 14
            color: "#828282"
            visible: editSaved == 0
                     && transactionSent == 0
                     && addressSwitch.state == "off"
                     && scanQRTracker == 0
        }

        Text {
            property string balance: (currencyList.get(currencyIndex).balance).toLocaleString(Qt.locale("en_US"), "f", decimals)
            property var balanceArray: balance.split('.')
            id: walletBalance2
            text: balanceArray[0]
            anchors.right: walletBalance1.left
            anchors.top: walletLabel.bottom
            anchors.topMargin: 5
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pixelSize: 14
            color: "#828282"
            visible: editSaved == 0
                     && transactionSent == 0
                     && addressSwitch.state == "off"
                     && scanQRTracker == 0
        }

        Mobile.AmountInput {
            id: sendAmount
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: walletBalance.bottom
            anchors.topMargin: 15
            placeholder: amountTransfer
            color: sendAmount.text !== "" ? "#F2F2F2" : "#727272"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pixelSize: 14
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            validator: DoubleValidator {bottom: 0; top: (currencyList.get(currencyIndex).balance)}
            visible: transactionSent == 0
                     && addressSwitch.state == "off"
                     && scanQRTracker == 0
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
            text: "*insufficient funds"
            color: "#FD2E2E"
            anchors.left: sendAmount.left
            anchors.leftMargin: 5
            anchors.top: sendAmount.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: xciteMobile.name //"Brandon Grotesque"
            visible: transactionSent == 0
                     && addressSwitch.state == "off"
                     && inputAmount > (currencyList.get(currencyIndex).balance)
                     && scanQRTracker == 0
        }

        Controls.TextInput {
            id: keyInput
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: sendAmount.bottom
            anchors.topMargin: 15
            placeholder: sendAddress
            color: "#F2F2F2"
            font.pixelSize: 14
            visible: transactionSent == 0
                     && addressSwitch.state == "off"
                     && scanQRTracker == 0
            readOnly: true
            mobile: 1
            deleteBtn: 0
        }

        Controls.TextInput {
            id: referenceInput
            height: 34
            placeholder: referenceTransfer
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: keyInput.bottom
            anchors.topMargin: 15
            color: referenceInput.text != "" ? "#F2F2F2" : "#727272"
            font.pixelSize: 14
            visible: transactionSent == 0
                     && addressSwitch.state == "off"
                     && scanQRTracker == 0
            mobile: 1
        }

        DropShadow {
            id: shadowTransferButton
            anchors.fill: transferModalButton
            source: transferModalButton
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.3
            transparentBorder: true
            visible: ((addressSwitch.state == "off"
                      && sendAmount.text != ""
                      && inputAmount !== 0
                      && inputAmount <= (currencyList.get(currencyIndex).balance))
                      || (addressSwitch.state == "on"
                          && doubbleAddress == 0
                          && labelExists == 0
                          && invalidAddress == 0
                          && myAddress == 0))
                      && transactionSent == 0
                      && editSaved == 0
                      && deleteAddressTracker == 0
                      && scanQRTracker == 0
        }

        Rectangle {
            id: transferModalButton
            width: sendAmount.width
            height: 33
            radius: 5
            color: (addressSwitch.state == "off"
                    && sendAmount.text != ""
                    && inputAmount !== 0
                    && inputAmount <= (currencyList.get(currencyIndex).balance)) ? maincolor :
                                                                                   ((addressSwitch.state == "on"
                                                                                     && doubbleAddress == 0
                                                                                     && labelExists == 0
                                                                                     && invalidAddress == 0
                                                                                     && myAddress == 0) ? maincolor :
                                                                                                               "#727272")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.left: referenceInput.left
            visible: transactionSent == 0
                     && editSaved == 0
                     && deleteAddressTracker == 0
                     && scanQRTracker == 0

            MouseArea {
                anchors.fill: transferModalButton

                onPressed: {
                    shadowTransferButton.verticalOffset = 0
                }

                onClicked: {
                    shadowTransferButton.verticalOffset = 4
                    if (addressSwitch.state == "off"){
                        if (sendAmount.text !== ""
                                && inputAmount !== 0
                                && inputAmount <= (currencyList.get(currencyIndex).balance)
                                && myAddress == 0) {
                            transactionSent = 1
                            doubbleAddress = 0
                            labelExists = 0
                            invalidAddress = 0
                        }
                    }
                    else {
                        if (doubbleAddress == 0
                                && labelExists == 0
                                && invalidAddress == 0) {
                            checkCurrencyIndex()
                            if (newCoinSelect == 1) {
                                addressList.setProperty(addressIndex, "logo", currencyList.get(newCoinPicklist).logo);
                            }
                            if (newCoinSelect == 1) {
                                addressList.setProperty(addressIndex, "coin", currencyList.get(newCoinPicklist).name);
                            }
                            if (newName.text !== "") {
                                addressList.setProperty(addressIndex, "name", newName.text);
                            }
                            if (newAddress.text !== "") {
                                addressList.setProperty(addressIndex, "address", newAddress.text);
                            }
                            editSaved = 1
                            picklistTracker = 0
                        }
                    }
                }
            }

            Text {
                text: addressSwitch.state == "off" ? "SEND" : "SAVE"
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: (addressSwitch.state == "off"
                        && sendAmount.text != ""
                        && inputAmount !== 0
                        && inputAmount <= (currencyList.get(currencyIndex).balance)) ? "#F2F2F2" :
                                                                                       ((addressSwitch.state == "on"
                                                                                         && doubbleAddress == 0
                                                                                         && labelExists == 0
                                                                                         && invalidAddress == 0
                                                                                         && myAddress == 0) ? "#F2F2F2" :
                                                                                                                   "#979797")
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
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pixelSize: 16
                color: maincolor
            }

            Text {
                id: sendingLabel
                text: "SENDING:"
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: confirmationText.bottom
                anchors.topMargin: 40
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pixelSize: 16
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
                text: newCoinName.text
                anchors.top: amount.top
                anchors.right: amount.right
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pixelSize: 16
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
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pixelSize: 12
                color: "#F2F2F2"
            }

            Text {
                property string transferAmount: inputAmount.toLocaleString(Qt.locale("en_US"), "f", decimals)
                property var amountArray: transferAmount.split('.')
                id: confirmationAmount2
                text: amountArray[0]
                anchors.top: confirmationAmount.top
                anchors.left: amount.left
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pixelSize: 16
                color: "#F2F2F2"
            }

            Text {
                id: to
                text: "TO:"
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: sendingLabel.bottom
                anchors.topMargin: 15
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pixelSize: 16
                color: "#F2F2F2"
            }

            Text {
                id: confirmationAddress
                text: keyInput.placeholder
                anchors.bottom: to.bottom
                anchors.bottomMargin: 2
                anchors.right: parent.right
                anchors.rightMargin: 25
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pixelSize: 12
                color: "#F2F2F2"
            }

            Text {
                id: confirmationAddressName
                text: "(" + transactionName + ")"
                anchors.top: confirmationAddress.bottom
                anchors.topMargin: 5
                anchors.right: parent.right
                anchors.rightMargin: 25
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pixelSize: 16
                color: "#F2F2F2"
                visible: transactionName != ""
            }

            Text {
                id: reference
                text: "REF.:"
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: confirmationAddressName.bottom
                anchors.topMargin: 15
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pixelSize: 16
                color: "#F2F2F2"
                visible: referenceInput.text !== ""
            }

            Text {
                id: referenceText
                text: referenceInput.text
                anchors.bottom: reference.bottom
                anchors.right: parent.right
                anchors.rightMargin: 25
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pixelSize: 16
                color: "#F2F2F2"
                visible: referenceInput.text !== ""
            }

            DropShadow {
                id: shadowConfirmSendButton
                anchors.fill: confirmationSendButton
                source: confirmationSendButton
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color: "black"
                opacity: 0.3
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

                    onPressed: {
                        shadowConfirmSendButton.verticalOffset = 0
                    }

                    onReleased: {
                        shadowConfirmSendButton.verticalOffset = 4
                        confirmationSent = 1
                        // whatever function needed to execute payment
                    }
                }

                Text {
                    text: "CONFIRM"
                    font.family: xciteMobile.name //"Brandon Grotesque"
                    font.pointSize: 14
                    color: "#F2F2F2"
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            DropShadow {
                id: shadowCancelSendButton
                anchors.fill: cancelSendButton
                source: cancelSendButton
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color: "black"
                opacity: 0.3
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

                    onPressed: {
                        shadowCancelSendButton.verticalOffset = 0
                    }

                    onReleased: {
                        shadowCancelSendButton.verticalOffset = 4
                        transactionSent = 0
                    }
                }

                Text {
                    text: "CANCEL"
                    font.family: xciteMobile.name //"Brandon Grotesque"
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
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.bold: true
            }

            DropShadow {
                id: shadowCloseConfirmButton
                anchors.fill: closeConfirm
                source: closeConfirm
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color: "black"
                opacity: 0.3
                transparentBorder: true
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

                    onPressed: {
                        shadowCloseConfirmButton.verticalOffset = 0
                    }

                    onReleased: {
                        shadowCloseConfirmButton.verticalOffset = 0
                        transactionDate = new Date().toLocaleDateString(Qt.locale(), "MM/dd")
                        if (newCoinName.text == "XBY"){
                            xbyTXHistory.append ({"date": transactionDate, "amount": Number.fromLocaleString(Qt.locale("en_US"), ("-"+sendAmount.text)), "txid": "", "txpartnerHash": keyInput.placeholder, "reference": referenceText.text, "txNR": xbyTXID});
                            xbyTXID = xbyTXID + 1;
                            currencyList.setProperty(0, "balance", (getCurrentBalance() - Number.fromLocaleString(Qt.locale("en_US"), sendAmount.text)));
                            currencyList.setProperty(0, "fiatValue", ((currencyList.get(0).balance) * (currencyList.get(0).coinValue)));
                            totalBalance = sumBalance()
                        }
                        if (newCoinName.text == "XFUEL"){
                            xfuelTXHistory.append ({"date": transactionDate, "amount": Number.fromLocaleString(Qt.locale("en_US"), ("-"+sendAmount.text)), "txid": "", "txpartnerHash": keyInput.placeholder, "reference": referenceText.text, "txNR": xfuelTXID});
                            xfuelTXID = xfuelTXID + 1;
                            currencyList.setProperty(1, "balance", (getCurrentBalance() - Number.fromLocaleString(Qt.locale("en_US"), sendAmount.text)));
                            currencyList.setProperty(1, "fiatValue", ((currencyList.get(1).balance) * (currencyList.get(1).coinValue)));
                            totalBalance = sumBalance()
                        }

                        sendAmount.text = ""
                        referenceInput.text = ""
                        confirmationSent = 0
                        transactionSent = 0
                        transactionDate = ""
                    }
                }

                Text {
                    text: "OK"
                    font.family: xciteMobile.name //"Brandon Grotesque"
                    font.pointSize: 14
                    font.bold: true
                    color: "#F2F2F2"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // Edit address state

        Image {
            id: picklistArrow
            source: 'qrc:/icons/dropdown_icon.svg'
            height: 20
            width: 20
            anchors.left: picklistTracker == 0 ? newCoinName.right : newPicklist.right
            anchors.leftMargin: 10
            anchors.verticalCenter: newCoinName.verticalCenter
            visible: addressSwitch.state == "on"
                     && editSaved == 0
                     && picklistTracker == 0
                     && deleteAddressTracker == 0
                     && scanQRTracker == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: "#F2F2F2"
            }

            Rectangle {
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
                    picklistLines()
                    picklistTracker = 1
                }
            }
        }

        Image {
            id: deleteAddress
            source: 'qrc:/icons/trashcan_big.svg'
            height: 26
            width: 18
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.verticalCenter: picklistArrow.verticalCenter
            visible: addressSwitch.state == "on"
                     && editSaved == 0
                     && deleteAddressTracker == 0
                     && myAddress == 0
                     && scanQRTracker == 0
            Rectangle {
                id: deleteButton
                height: 20
                width: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
            }

            MouseArea {
                anchors.fill: deleteButton

                onClicked: {
                    deleteAddressTracker = 1
                }
            }
        }

        Controls.TextInput {
            id: newName
            height: 34
            // radius: 8
            placeholder: addressName
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: walletBalance.bottom
            anchors.topMargin: 15
            color: newName.text == "" ? "#727272" : "#F2F2F2"
            font.pixelSize: 14
            visible: addressSwitch.state == "on"
                     && editSaved == 0
                     && deleteAddressTracker == 0
                     && scanQRTracker == 0
            mobile: 1
            onTextChanged: compareName()
        }

        Label {
            id: nameWarning
            text: "Already a contact with this name!"
            color: "#FD2E2E"
            anchors.left: newName.left
            anchors.leftMargin: 5
            anchors.top: newName.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: xciteMobile.name //"Brandon Grotesque"
            visible: addressSwitch.state == "on"
                     && editSaved == 0
                     && newName.text != ""
                     && labelExists == 1
                     && deleteAddressTracker == 0
                     && scanQRTracker == 0
        }

        Controls.TextInput {
            id: newAddress
            height: 34
            // radius: 8
            placeholder: sendAddress
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newName.bottom
            anchors.topMargin: 15
            color: myAddress == 0 ? (newAddress.text == "" ? "#727272" : "#F2F2F2") : "#F2F2F2"
            font.pixelSize: 14
            visible: addressSwitch.state == "on"
                     && editSaved == 0
                     && deleteAddressTracker == 0
                     && scanQRTracker == 0
            mobile: 1
            readOnly: myAddress == 1
            validator: RegExpValidator { regExp: /[0-9A-Za-z]+/ }
            onTextChanged: checkAddress() && compareTx()
        }

        Label {
            id: addressWarning1
            text: "Already a contact for this address!"
            color: "#FD2E2E"
            anchors.left: newAddress.left
            anchors.leftMargin: 5
            anchors.top: newAddress.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: xciteMobile.name //"Brandon Grotesque"
            visible: addressSwitch.state == "on"
                     && editSaved == 0
                     && doubbleAddress == 1
                     && newAddress.text != ""
                     && deleteAddressTracker == 0
                     && scanQRTracker == 0
        }

        Label {
            id: addressWarning2
            text: "Invalid address!"
            color: "#FD2E2E"
            anchors.left: newAddress.left
            anchors.leftMargin: 5
            anchors.top: newAddress.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: xciteMobile.name //"Brandon Grotesque"
            visible: addressSwitch.state == "on"
                     && editSaved == 0
                     && invalidAddress == 1
                     && newAddress.text != ""
                     && deleteAddressTracker == 0
                     && scanQRTracker == 0
        }

        Text {
            id: destination
            text: selectedAddress
            anchors.left: newAddress.left
            anchors.top: newAddress.bottom
            anchors.topMargin: 3
            visible: false
            onTextChanged: {
                if (addressTracker == 1) {
                    newAddress.text = destination.text
                }
            }
        }

        Rectangle {
            id: scanQrButton
            width: newAddress.width
            height: 33
            anchors.top: newAddress.bottom
            anchors.topMargin: 15
            anchors.left: newAddress.left
            radius: 5
            border.color: maincolor
            border.width: 2
            color: "transparent"
            visible: editSaved == 0
                     && deleteAddressTracker == 0
                     && addressSwitch.state == "on"
                     && scanQRTracker == 0
                     && myAddress == 0

            MouseArea {
                anchors.fill: scanQrButton

                onPressed: {
                    scanQrButton.color = maincolor
                    scanQrButton.border.color = "transparent"
                    scanQrButtonText.color = "#F2F2F2"
                }

                onReleased: {
                    scanQrButton.color = "transparent"
                    scanQrButton.border.color = maincolor
                    scanQrButtonText.color = maincolor
                    scanQRTracker = 1
                    scanning = "scanning..."
                }
            }

            Text {
                id: scanQrButtonText
                text: "SCAN QR"
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pointSize: 14
                color: maincolor
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        DropShadow {
            id: shadowTransferPicklist
            anchors.fill: newPicklist
            source: newPicklist
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.3
            transparentBorder: true
            visible: addressSwitch.state == "on"
                     && picklistTracker == 1
                     && editSaved == 0
                     && deleteAddressTracker == 0
                     && scanQRTracker == 0
        }

        Rectangle {
            id: newPicklist
            width: 100
            height: ((totalLines + 1) * 35)-10
            radius: 4
            color: "#2A2C31"
            anchors.top: newIcon.top
            anchors.topMargin: -5
            anchors.left: newIcon.left
            visible: addressSwitch.state == "on"
                     && picklistTracker == 1
                     && editSaved == 0
                     && deleteAddressTracker == 0
                     && scanQRTracker == 0

            Controls.CurrencyPicklist {
                id: myCoinPicklist
            }
        }

        Rectangle {
            id: picklistClose
            width: 100
            height: 25
            radius: 4
            color: "#2A2C31"
            anchors.bottom: newPicklist.bottom
            anchors.horizontalCenter: newPicklist.horizontalCenter
            visible: addressSwitch.state == "on"
                     && picklistTracker == 1
                     && editSaved == 0
                     && deleteAddressTracker == 0
                     && scanQRTracker == 0

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

        // Edit saved state

        Image {
            id: saveSuccess
            source: 'qrc:/icons/icon-success.svg'
            height: 100
            width: 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -15
            visible: addressSwitch.state == "on"
                     && editSaved == 1

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: maincolor
            }
        }

        Label {
            id: saveSuccessLabel
            text: "Changes saved!"
            anchors.top: saveSuccess.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: saveSuccess.horizontalCenter
            color: "#5E8BFE"
            font.pixelSize: 14
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.bold: true
            visible: addressSwitch.state == "on"
                     && editSaved == 1
        }

        DropShadow {
            id: shadowCloseEditButton
            anchors.fill: closeSaveEdit
            source: closeSaveEdit
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.3
            transparentBorder: true
            visible: addressSwitch.state == "on"
                     && editSaved == 1
        }

        Rectangle {
            id: closeSaveEdit
            width: (parent.width - 45) / 2
            height: 33
            radius: 5
            color: maincolor
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: addressSwitch.state == "on"
                     && editSaved == 1

            MouseArea {
                anchors.fill: closeSaveEdit

                onPressed: {
                    shadowCloseEditButton.verticalOffset = 0
                }

                onReleased: {
                    shadowCloseEditButton.verticalOffset = 0
                    newName.text = ""
                    newAddress.text = ""
                    editSaved = 0
                    newCoinPicklist = 0
                    newCoinSelect = 0
                    doubbleAddress = 0
                    labelExists = 0
                    invalidAddress = 0
                }
            }

            Text {
                text: "OK"
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#F2F2F2"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // Delete confirm state

        Rectangle {
            id: deleteConfirmation
            width: parent.width
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            visible: deleteAddressTracker == 1
                     && deleteConfirmed == 0

            Text {
                id: deleteText
                text: "You are about to delete:"
                anchors.top: parent.top
                anchors.topMargin: 60
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pixelSize: 16
                color: "#F2F2F2"
            }

            Text {
                id: deleteAddressName
                text: addressName + " (" + coinName + ")"
                anchors.top: deleteText.bottom
                anchors.topMargin: 7
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pixelSize: 16
                font.bold: true
                color: "#F2F2F2"
            }

            Text {
                id: deleteAddressHash
                text: sendAddress
                anchors.top: deleteAddressName.bottom
                anchors.topMargin: 7
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pixelSize: 16
                color: "#F2F2F2"
            }

            DropShadow {
                id: shadowConfirmDeleteButton
                anchors.fill: confirmationDeleteButton
                source: confirmationDeleteButton
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color: "black"
                opacity: 0.3
                transparentBorder: true
            }

            Rectangle {
                id: confirmationDeleteButton
                width: (doubbleButtonWidth - 10) / 2
                height: 33
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 5
                radius: 5
                color: "#4BBE2E"

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        shadowConfirmDeleteButton.verticalOffset = 0
                    }

                    onReleased: {
                        shadowConfirmDeleteButton.verticalOffset = 4
                        deleteConfirmed = 1
                        addressList.setProperty(addressIndex, "active", false)
                        doubbleAddress = 0
                        labelExists = 0
                        invalidAddress = 0
                    }
                }

                Text {
                    text: "CONFIRM"
                    font.family: xciteMobile.name //"Brandon Grotesque"
                    font.pointSize: 14
                    color: "#F2F2F2"
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            DropShadow {
                id: shadowCancelDeleteButton
                anchors.fill: cancelDeleteButton
                source: cancelDeleteButton
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color: "black"
                opacity: 0.3
                transparentBorder: true
            }

            Rectangle {
                id: cancelDeleteButton
                width: (doubbleButtonWidth - 10) / 2
                height: 33
                radius: 5
                color: "#E55541"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 5

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        shadowCancelDeleteButton.verticalOffset = 0
                    }

                    onReleased: {
                        shadowCancelDeleteButton.verticalOffset = 4
                        deleteAddressTracker = 0
                    }
                }

                Text {
                    text: "CANCEL"
                    font.family: xciteMobile.name //"Brandon Grotesque"
                    font.pointSize: 14
                    font.bold: true
                    color: "#F2F2F2"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // Delete success state

        Image {
            id: deleteSuccess
            source: 'qrc:/icons/icon-delete-mobile.svg'
            height: 100
            width: 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -15
            visible: addressSwitch.state == "on"
                     && deleteConfirmed == 1

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: maincolor
            }
        }

        Label {
            id: deleteSuccessLabel
            text: "Address removed!"
            anchors.top: deleteSuccess.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: deleteSuccess.horizontalCenter
            color: maincolor
            font.pixelSize: 14
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.bold: true
            visible: addressSwitch.state == "on"
                     && deleteConfirmed == 1
        }

        DropShadow {
            id: shadowCloseDeleteButton
            anchors.fill: closeDelete
            source: closeDelete
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.3
            transparentBorder: true
            visible: addressSwitch.state == "on"
                     && deleteConfirmed == 1
        }

        Rectangle {
            id: closeDelete
            width: (parent.width - 45) / 2
            height: 33
            radius: 5
            color: maincolor
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: addressSwitch.state == "on"
                     && deleteConfirmed == 1

            MouseArea {
                anchors.fill: closeDelete

                onPressed: {
                    shadowCloseDeleteButton.verticalOffset = 0
                }

                onReleased: {
                    shadowCloseDeleteButton.verticalOffset = 4
                    if (addressTracker == 1) {
                        addressTracker = 0;
                        picklistTracker = 0
                        newCoinPicklist = 0
                        newCoinSelect = 0
                        addressIndex = 0
                        currencyIndex = 0
                        addressSwitch.state = "off"
                        transactionSent =0
                        confirmationSent = 0
                        sendAmount.text = ""
                        referenceInput.text = ""
                        newName.text = ""
                        newAddress.text = ""
                        invalidAddress = 0
                        deleteAddressTracker = 0
                        deleteConfirmed = 0
                        scanQRTracker = 0
                        selectedAddress = ""
                        scanning = "scanning..."
                    }
                }
            }

            Text {
                text: "OK"
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#F2F2F2"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: 4
        color: "black"
        opacity: 0.9
        visible: calculatorTracker == 1
    }

    // Crypto converter

    Mobile.CryptoCalculator {
        id: calculator
        toCurrency: newCoinName.text
        visible: calculatorTracker == 1
    }

    Label {
        id: closeAddressModal
        z: 10
        text: "CLOSE"
        anchors.top: addressBodyModal.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: addressBodyModal.horizontalCenter
        font.pixelSize: 14
        font.family: xciteMobile.name //"Brandon Grotesque"
        color: "#F2F2F2"
        visible: addressTracker == 1
                 && confirmationSent == 0
                 && editSaved == 0
                 && deleteConfirmed == 0
                 && calculatorTracker == 0
                 && scanQRTracker == 0

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

            Timer {
                id: timer
                interval: 300
                repeat: false
                running: false

                onTriggered: {
                    picklistTracker = 0
                    newCoinPicklist = 0
                    newCoinSelect = 0
                    addressIndex = 0
                    currencyIndex = 0
                    addressSwitch.state = "off"
                    transactionSent =0
                    confirmationSent = 0
                    sendAmount.text = ""
                    referenceInput.text = ""
                    newName.text = ""
                    newAddress.text = ""
                    invalidAddress = 0
                    deleteAddressTracker = 0
                    deleteConfirmed = 0
                    calculatorTracker = 0
                    calculatedAmount = ""
                    scanQRTracker = 0
                    selectedAddress = ""
                    scanning = "scanning..."
                }
            }

            onPressed: {
                closeAddressModal.anchors.topMargin = 12
            }

            onReleased: {
                closeAddressModal.anchors.topMargin = 10
                if (addressTracker == 1) {
                    addressTracker = 0;
                    timer.start()
                }
            }
        }
    }
}
