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

import "qrc:/Controls" as Controls

Rectangle {
    id: addressModal
    width: 325
    height: (transactionSent == 1 || editSaved == 1)? 350 : (addressSwitch.state == "off" ? 385 : 350)
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 50

    property string coinName: addressList.get(addressIndex).coin
    property string sendAddress: addressList.get(addressIndex).address
    property string addressName: addressList.get(addressIndex).name
    //property string addressLabel: addressList.get(addressIndex).label
    property int switchState: 0
    property int addressBookTracker: 0
    property int transactionSent: 0
    property int confirmationSent: 0
    property int editSaved: 0
    property int addressNR: 0
    property int invalidAddress: 0
    property int doubbleAddress: compareTx()
    property int labelExists: compareName()
    property var inputAmount: Number.fromLocaleString(Qt.locale(),sendAmount.text)
    property string amountTransfer: "AMOUNT (" + newCoinName.text + ")"
    property string referenceTransfer: "REFERENCE"

    function compareTx(){
        var duplicateAddress = 0
        for(var i = 0; i < addressList.count; i++) {
            if (newCoinSelect == 1){
                if (addressList.get(i).coin === newCoinName.text) {
                    if (addressList.get(i).address === newAddress.placeholder || addressList.get(i).address === newAddress.text) {
                        duplicateAddress = 1
                    }
                }
            }
            else {
                if (addressList.get(i).coin === newCoinName.text) {
                    if (addressList.get(i).address === newAddress.text) {
                        duplicateAddress = 1
                    }
                }
            }
        }
        return duplicateAddress
    }

    function compareName(){
        var duplicateName = 0
        for(var i = 0; i < addressList.count; i++) {
            if (newCoinSelect == 1){
                if (addressList.get(i).coin === newCoinName.text) {
                    if (addressList.get(i).name === newName.placeholder || addressList.get(i).name === newName.text) {
                        duplicateName = 1
                    }
                }
            }
            else {
                if (addressList.get(i).coin === newCoinName.text) {
                    if (addressList.get(i).name === newName.text) {
                        duplicateName = 1
                    }
                }
            }
        }
        return duplicateName
    }

    function checkAddress() {
        if (newName.text != "") {
            if (newName.text == "XBY" || newName.text == "BTC") {
                if (newAddress.length == 34
                        && newAddress.text != ""
                        && newAddress.text.substring(0,1) == "B") {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
            else if (newName.text == "XFUEL") {
                if (newAddress.length == 34
                        && newAddress.text != ""
                        && newAddress.text.substring(0,1) == "F") {
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
        else {
            if (addressName == "XBY" || addressName == "BTC") {
                if (newAddress.length === 34
                        && newAddress.text !== ""
                        && newAddress.text.substring(0,1) == "B") {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
            else if (addressName == "XFUEL") {
                if (newAddress.length === 34
                        && newAddress.text !== ""
                        && newAddress.text.substring(0,1) == "F") {
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
    }

    Rectangle {
        id: addressTitleBar
        width: parent.width
        height: 50
        radius: 4
        anchors.top: parent.top
        anchors.left: parent.left
        color: "#34363D"
        visible: editSaved == 0 && transactionSent == 0

        Image {
            id: titleIcon
            width: 25
            height: 25
            source: addressList.get(addressIndex).logo
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -2
            anchors.left: parent.left
            anchors.leftMargin: 15
        }

        Text {
            id: transferModalLabel
            text: addressName //+ "  " + addressLabel
            anchors.left: titleIcon.right
            anchors.leftMargin: 7
            anchors.verticalCenter: titleIcon.verticalCenter
            anchors.verticalCenterOffset: -1
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            color: "#F2F2F2"
        }

        Image {
            id: favoriteAddressIcon
            source: 'qrc:/icons/icon-favorite.svg'
            width: 25
            height: 25
            anchors.verticalCenter: titleIcon.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 15
            visible: editSaved == 0

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
        anchors.topMargin: 46
        anchors.horizontalCenter: parent.horizontalCenter

        Controls.Switch_mobile {
            id: addressSwitch
            anchors.horizontalCenter: addressBodyModal.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            state: switchState == 0 ? "off" : "on"
            visible: transactionSent == 0 && editSaved == 0
        }

        Text {
            id: sendText
            text: "SEND"
            anchors.right: addressSwitch.left
            anchors.rightMargin: 7
            anchors.verticalCenter: addressSwitch.verticalCenter
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            font.weight: Font.Medium
            color: addressSwitch.on ? "#5F5F5F" : "#5E8BFE"
            visible: transactionSent == 0 && editSaved == 0
        }

        Text {
            id: editText
            text: "EDIT"
            anchors.left: addressSwitch.right
            anchors.leftMargin: 7
            anchors.verticalCenter: addressSwitch.verticalCenter
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            font.weight: Font.Medium
            color: addressSwitch.on ? "#5E8BFE" : "#5F5F5F"
            visible: transactionSent == 0 && editSaved == 0
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
            visible: picklistTracker == 0 && editSaved == 0 && transactionSent == 0
        }

        Label {
            id: newCoinName
            text: newCoinSelect == 1? currencyList.get(newCoinPicklist).name : addressList.get(addressIndex).coin
            anchors.left: newIcon.right
            anchors.leftMargin: 7
            anchors.verticalCenter: newIcon.verticalCenter
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: "#F2F2F2"
            visible: picklistTracker == 0 && editSaved == 0 && transactionSent == 0
            onTextChanged: if (addressSwitch.state == "on") {
                               checkAddress()
                           }
        }

        Label {
            id: walletLabel
            text: currencyList.get(currencyIndex).label
            anchors.right: sendAmount.right
            anchors.verticalCenter: newIcon.verticalCenter
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: "#F2F2F2"
            visible: editSaved == 0 && transactionSent == 0 && addressSwitch.state == "off"
        }

        Text {
            id: walletBalance
            text: (currencyList.get(currencyIndex).balance).toLocaleString(Qt.locale(), "f", 4) + " " + newCoinName.text
            anchors.right: sendAmount.right
            anchors.top: walletLabel.bottom
            anchors.topMargin: 1
            font.pixelSize: 13
            color: "#828282"
            visible: editSaved == 0 && transactionSent == 0 && addressSwitch.state == "off"
        }

        Controls.TextInput {
            id: sendAmount
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: walletBalance.bottom
            anchors.topMargin: 15
            placeholder: amountTransfer
            color: sendAmount.text != "" ? "#F2F2F2" : "#727272"
            font.pixelSize: 14
            validator: DoubleValidator {bottom: 0; top: (currencyList.get(currencyIndex).balance)}
            visible: transactionSent == 0 && addressSwitch.state == "off"
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
            visible: transactionSent == 0 && addressSwitch.state == "off" && inputAmount > (currencyList.get(currencyIndex).balance)
        }

        Controls.TextInput {
            id: keyInput
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: sendAmount.bottom
            anchors.topMargin: 15
            text: sendAddress
            color: "#F2F2F2"
            font.pixelSize: 14
            visible: transactionSent == 0 && addressSwitch.state == "off"
            readOnly: true
            mobile: 1
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
            visible: transactionSent == 0 && addressSwitch.state == "off"
            mobile: 1
        }

        Rectangle {
            id: transferModalButton
            width: sendAmount.width
            height: 33
            radius: 8
            border.color: (addressSwitch.state == "off"
                           && sendAmount.text != ""
                           && inputAmount !== 0
                           && inputAmount <= (currencyList.get(currencyIndex).balance)) ? "#5E8BFF" :
                                                                                          ((addressSwitch.state == "on"
                                                                                            && keyInput.text != ""
                                                                                            && keyInput.length == 34
                                                                                            && keyInput.text.substring(0,1) == "B"
                                                                                            && doubbleAddress == 0
                                                                                            && labelExists == 0
                                                                                            && invalidAddress == 0 ) ? "#5E8BFF" :
                                                                                                                       "#727272")
            border.width: 2
            color: "transparent"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.left: referenceInput.left
            visible: transactionSent == 0 && editSaved == 0

            MouseArea {
                anchors.fill: transferModalButton

                onClicked: {
                    if (addressSwitch.state == "off"){
                        if (sendAmount.text !== ""
                                && inputAmount !== 0
                                && inputAmount <= (currencyList.get(currencyIndex).balance)) {
                            transactionSent = 1
                        }
                    }
                    else {
                        if (doubbleAddress == 0
                                && labelExists == 0
                                && invalidAddress == 0) {
                            if (newCoinSelect == 1 && currencyList.get(newCoinPicklist).name === currencyList.get(0).name) {
                                currencyIndex = 0
                            }
                            if (newCoinSelect == 1 && currencyList.get(newCoinPicklist).name === currencyList.get(1).name) {
                                currencyIndex = 1
                            }
                            if (newCoinSelect == 1 && currencyList.get(newCoinPicklist).name === currencyList.get(2).name) {
                                currencyIndex = 2
                            }
                            if (newCoinSelect == 1 && currencyList.get(newCoinPicklist).name === currencyList.get(3).name) {
                                currencyIndex = 3
                            }
                            if (newCoinSelect == 1) {
                                addressList.setProperty(addressIndex, "logo", currencyList.get(newCoinPicklist).logo);
                            }
                            if (newCoinSelect == 1) {
                                addressList.setProperty(addressIndex, "coin", currencyList.get(newCoinPicklist).name);
                            }
                            if (newName.text !== "") {
                                addressList.setProperty(addressIndex, "name", newName.text);
                            }
                            /**
                                if (newLabel.text !== "") {
                                    addressList.setProperty(addressIndex, "label", newLabel.text);
                                }
                                */
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
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: (addressSwitch.state == "off"
                        && sendAmount.text != ""
                        && inputAmount !== 0
                        && inputAmount <= (currencyList.get(currencyIndex).balance)) ? "#5E8BFF" :
                                                                                       ((addressSwitch.state == "on"
                                                                                         && keyInput.text != ""
                                                                                         && invalidAddress == 0
                                                                                         && doubbleAddress == 0
                                                                                         && labelExists == 0
                                                                                         && invalidAddress == 0 ) ? "#5E8BFF" :
                                                                                                                    "#727272")
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
                text: sendAmount.text + " " + coinName
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
                width: (doubbleButtonWidth - 10) / 2
                height: 33
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 5
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
                width: (doubbleButtonWidth - 10) / 2
                height: 33
                radius: 8
                border.color: "#5E8BFF"
                border.width: 2
                color: "transparent"
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
                        referenceInput.text = ""
                        confirmationSent = 0
                        transactionSent = 0
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

        // Edit address state

        Image {
            id: picklistArrow
            source: 'qrc:/icons/dropdown_icon.svg'
            height: 20
            width: 20
            anchors.left: picklistTracker == 0 ? newCoinName.right : newPicklist.right
            anchors.leftMargin: 10
            anchors.verticalCenter: newCoinName.verticalCenter
            visible: addressSwitch.state == "on" && editSaved == 0 && picklistTracker == 0

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
                    if (picklistTracker == 0) {
                        picklistTracker = 1
                    }
                    else {
                        picklistTracker = 0
                    }
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
            color:"#F2F2F2"
            font.pixelSize: 14
            visible: addressSwitch.state == "on" && editSaved == 0
            mobile: 1
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
            font.family: "Brandon Grotesque"
            font.weight: Font.Normal
            visible: addressSwitch.state == "on" && editSaved == 0 && labelExists == 1
        }

        /**
        Controls.TextInput {
            id: newLabel
            height: 34
            // radius: 8
            placeholder: addressLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newName.bottom
            anchors.topMargin: 15
            color:"#F2F2F2"
            font.pixelSize: 14
            visible: addressSwitch.state == "on" && editSaved == 0
            mobile: 1
        }
        */
        Controls.TextInput {
            id: newAddress
            height: 34
            // radius: 8
            placeholder: sendAddress
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newName.bottom
            anchors.topMargin: 15
            color:"#F2F2F2"
            font.pixelSize: 14
            visible: addressSwitch.state == "on" && editSaved == 0
            mobile: 1
            onTextChanged: checkAddress()
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
            font.family: "Brandon Grotesque"
            font.weight: Font.Normal
            visible: addressSwitch.state == "on" && editSaved == 0 && doubbleAddress == 1
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
            font.family: "Brandon Grotesque"
            font.weight: Font.Normal
            visible: addressSwitch.state == "on" && editSaved == 0 && invalidAddress == 1
        }

        Rectangle {
            id: newPicklist
            width: 100
            height: totalLines * 35
            color: "#2A2C31"
            anchors.top: newIcon.top
            anchors.topMargin: -5
            anchors.left: newIcon.left
            visible: addressSwitch.state == "on" && picklistTracker == 1 && editSaved == 0

            Controls.CurrencyPicklist {
                id: myCoinPicklist
            }
        }

        Image {
            id: saveSuccess
            source: 'qrc:/icons/icon-success.svg'
            height: 100
            width: 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -15
            visible: addressSwitch.state == "on" && editSaved == 1

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: "#5E8BFF"
            }
        }

        Rectangle {
            id: closeSaveEdit
            width: (parent.width - 45) / 2
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: addressSwitch.state == "on" && editSaved == 1

            MouseArea {
                anchors.fill: closeSaveEdit

                onClicked: {
                    newName.text = ""
                    //newLabel.text = ""
                    newAddress.text = ""
                    editSaved = 0
                    newCoinPicklist = 0
                    newCoinSelect = 0
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

    Label {
        id: closeAddressModal
        z: 10
        text: "CLOSE"
        anchors.top: addressBodyModal.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: addressBodyModal.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: "#F2F2F2"
        visible: addressTracker == 1 && confirmationSent == 0 && editSaved == 0

        Rectangle{
            id: closeButton
            anchors.fill: parent
            color: "transparent"
        }

        MouseArea {
            anchors.fill: closeButton

            onClicked: {
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
                    //newLabel.text = ""
                    newAddress.text = ""
                    invalidAddress = 0
                }

            }
        }
    }
}
