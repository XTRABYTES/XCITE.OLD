/**
 * Filename: ImportKey.qml
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

Rectangle {
    id: addWalletModal
    width: Screen.width
    state: importKeyTracker == 1? "up" : "down"
    height: Screen.height
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    MouseArea {
        anchors.fill: parent
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: addWalletModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: addWalletModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: addWalletModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    property int editSaved: 0
    property int editFailed : 0
    property int newWallet: 0
    property bool addingWallet: false
    property int importWalletFailed: 0
    property int invalidAddress: 0
    property int addressExists: 0
    property int labelExists: 0
    property string walletError:""
    property string error1: "there is no wallet associated with the private key you provided. Please try again with a different key."
    property string error2: " we are unable to import your private key at the moment."
    property string coin: coinList.get(coinIndex).name
    property bool walletSaved: false
    property int saveErrorNR: 0
    property bool importInitiated: false
    property string failError: ""

    function compareTx() {
        addressExists = 0
        for(var i = 0; i < walletList.count; i++) {
            if (newAddress.text != "") {
                if (newName.text == "XBY") {
                    if (walletList.get(i).name === "XBY" && walletList.get(i).privatekey === newAddress.text && walletList.get(i).remove === false) {
                        addressExists = 1
                    }
                }
                else {
                    if (walletList.get(i).name === newName.text && walletList.get(i).privatekey === newAddress.text && walletList.get(i).remove === false) {
                        addressExists = 1
                    }
                }
            }
        }
    }

    function compareName() {
        labelExists = 0
        for(var i = 0; i < walletList.count; i++) {
            if(walletList.get(i).name === coinList.get(coinIndex).name){
                if (walletList.get(i).label === newName.text && walletList.get(i).remove === false) {
                    labelExists = 1
                }
            }
        }
    }

    function checkAddress() {
        // check if provided private key has the correct format
    }

    Rectangle {
        z: 2
        width: Screen.width
        height: 50
        color: bgcolor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        visible: editSaved == 0 && newWallet == 0 && editFailed == 0 && importWalletFailed == 0
    }

    Text {
        z: 2
        id: addWalletLabel
        text: "ADD EXISTING WALLET"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        visible: editSaved == 0 && newWallet == 0 && editFailed == 0 && importWalletFailed == 0
    }

    Flickable {
        id: scrollArea
        width: parent.width
        contentHeight: addWalletScrollArea.height > scrollArea.height? addWalletScrollArea.height + 125 : scrollArea.height + 125
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        visible: scanQRTracker == 0

        Rectangle {
            id: addWalletScrollArea
            width: parent.width
            height: (editSaved == 1 || editFailed == 1)? addSucces.height : (importWalletFailed == 1? addError.height : addWallet.height)
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
        }

        Item {
            id: addWallet
            width: parent.width
            height: addWalletText.height + newName.height + newAddress.height + scanQrButton.height + addWalletButton.height + selectedCoin.height + 105
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            visible: editSaved == 0 && newWallet == 0 && importWalletFailed == 0 && editFailed == 0

            Item {
                id: selectedCoin
                width: newIcon.width + newCoinName.width + 7
                height: newIcon.height
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                Image {
                    id: newIcon
                    source: coinList.get(coinIndex).logo
                    height: 30
                    width: 30
                    anchors.left: parent.left
                    anchors.top: parent.top
                }

                Label {
                    id: newCoinName
                    text: coinList.get(coinIndex).name
                    anchors.left: newIcon.right
                    anchors.leftMargin: 7
                    anchors.verticalCenter: newIcon.verticalCenter
                    font.pixelSize: 24
                    font.family: "Brandon Grotesque"
                    font.letterSpacing: 2
                    font.bold: true
                    color: darktheme == true? "#F2F2F2" : "#2A2C31"
                }
            }

            Text {
                id: addWalletText
                width: newName.width
                maximumLineCount: 3
                anchors.left: newName.left
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                text: "YOU CAN ADD AN EXISTING <b>" + coin + "</b> WALLET BY IMPORTING YOUR PRIVATE KEY."
                anchors.top: selectedCoin.bottom
                anchors.topMargin: 20
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                font.pixelSize: 16
                font.family: xciteMobile.name
                visible: scanQRTracker == 0
            }

            Controls.TextInput {
                id: newName
                height: 34
                width: doubbleButtonWidth
                placeholder: "WALLET LABEL"
                text: ""
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: addWalletText.bottom
                anchors.topMargin: 25
                color: themecolor
                textBackground: darktheme == false? "#484A4D" : "#0B0B09"
                font.pixelSize: 14
                mobile: 1
                visible: scanQRTracker == 0
                onTextChanged: {
                    detectInteraction()
                    if(newName.text != "") {
                        compareName();
                    }
                }
            }

            Label {
                id: nameWarning
                text: "Already an address with this label!"
                color: "#FD2E2E"
                anchors.left: newName.left
                anchors.leftMargin: 5
                anchors.top: newName.bottom
                anchors.topMargin: 1
                font.pixelSize: 11
                font.family: "Brandon Grotesque"
                font.weight: Font.Normal
                visible: newName.text != ""
                         && labelExists == 1
                         && scanQRTracker == 0
            }

            Controls.TextInput {
                id: newAddress
                height: 34
                width: doubbleButtonWidth
                placeholder: "PRIVATE KEY"
                text: ""
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: newName.bottom
                anchors.topMargin: 15
                color: themecolor
                textBackground: darktheme == false? "#484A4D" : "#0B0B09"
                font.pixelSize: 14
                visible: scanQRTracker == 0
                mobile: 1
                validator: RegExpValidator { regExp: /[0-9A-Za-z]+/ }
                onTextChanged: {
                    detectInteraction()
                    if(newAddress.text != ""){
                        checkAddress();
                        compareTx()
                    }
                }
            }

            Text {
                id: scannedAddress
                text: selectedAddress
                anchors.left: newAddress.left
                anchors.top: newAddress.bottom
                anchors.topMargin: 5
                visible: false

                onTextChanged: {
                    if (scannedAddress.text != "" & importKeyTracker == 1){
                        newAddress.text = scannedAddress.text
                    }
                }
            }

            Label {
                id: addressWarning1
                text: "This address is already in your account!"
                color: "#FD2E2E"
                anchors.left: newAddress.left
                anchors.leftMargin: 5
                anchors.top: newAddress.bottom
                anchors.topMargin: 1
                font.pixelSize: 11
                font.family: "Brandon Grotesque"
                font.weight: Font.Normal
                visible: newAddress.text != ""
                         && addressExists == 1
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
                font.family: "Brandon Grotesque"
                font.weight: Font.Normal
                visible: newAddress.text != ""
                         && invalidAddress == 1
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
                    if (addAddressTracker == 1) {
                        newAddress.text = destination.text
                    }
                }
            }

            Rectangle {
                id: scanQrButton
                width: newAddress.width
                height: 34
                anchors.top: newAddress.bottom
                anchors.topMargin: 15
                anchors.left: newAddress.left
                border.color: maincolor
                border.width: 2
                color: "transparent"
                visible: scanQRTracker == 0

                MouseArea {
                    anchors.fill: scanQrButton

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onReleased: {
                        scanQRTracker = 1
                        scanning = "scanning..."
                    }
                }

                Text {
                    id: scanButtonText
                    text: "SCAN QR"
                    font.family: "Brandon Grotesque"
                    font.pointSize: 14
                    color: maincolor
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                id: importWalletButton
                width: newAddress.width
                height: 34
                anchors.top: scanQrButton.bottom
                anchors.topMargin: 30
                anchors.left: newAddress.left
                color: (newName.text != ""
                        && newAddress.text !== ""
                        && invalidAddress == 0
                        && addressExists == 0 && labelExists == 0) ? maincolor : "#727272"
                opacity: 0.25
                visible: scanQRTracker == 0 && importInitiated == false

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onReleased: {
                        closeAllClipboard = true
                        if (newName.text != ""
                                && newAddress.text != ""
                                && invalidAddress == 0
                                && addressExists == 0
                                && labelExists == 0) {
                            selectedAddress = ""
                            if (coinList.get(coinIndex).name === "XFUEL" || coinList.get(coinIndex).name === "XBY" || coinList.get(coinIndex).name === "XTEST") {
                                importInitiated = true
                                importPrivateKey((coinList.get(coinIndex).fullname), newAddress.text)
                            }
                            else {
                                importWalletFailed = 1
                                walletError = error2
                            }
                        }
                    }

                    Connections {
                        target: xUtility

                        onAddressExtracted: {
                            if (importKeyTracker == 1 && importInitiated == true) {
                                console.log("Address is: " + addressID)
                                console.log("PubKey is: " + publicKey)
                                privateKey.text = newAddress.text
                                publicKey.text = pubKey
                                addressHash.text = addressID
                                newWallet = 1
                                importInitiated = false
                            }
                        }

                        onBadKey: {
                            if (importKeyTracker == 1 && importInitiated == true) {
                                importWalletFailed = 1
                                walletError = error1
                                importInitiated = false
                            }
                        }
                    }
                }
            }

            Text {
                id: importWalletButtonText
                text: "IMPORT WALLET"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: (newName.text != ""
                        && newAddress.text !== ""
                        && invalidAddress == 0
                        && addressExists == 0 && labelExists == 0) ? "#F2F2F2" : "#979797"
                font.bold: true
                anchors.horizontalCenter: importWalletButton.horizontalCenter
                anchors.verticalCenter: importWalletButton.verticalCenter
                visible: scanQRTracker == 0 && importInitiated == false
            }

            Rectangle {
                width: importWalletButton.width
                height: 34
                anchors.bottom: importWalletButton.bottom
                anchors.left: importWalletButton.left
                color: "transparent"
                opacity: 0.5
                border.color: (newName.text != ""
                               && newAddress.text !== ""
                               && invalidAddress == 0
                               && addressExists == 0 && labelExists == 0) ? maincolor : "#979797"
                border.width: 1
                visible: scanQRTracker == 0 && importInitiated == false
            }

            AnimatedImage {
                id: waitingDots2
                source: 'qrc:/gifs/loading-gif_01.gif'
                width: 90
                height: 60
                anchors.horizontalCenter: importWalletButton.horizontalCenter
                anchors.verticalCenter: importWalletButton.verticalCenter
                playing: importInitiated == true
                visible: scanQRTracker == 0 && importInitiated == true
            }
        }

        Item {
            id: walletInfo
            width: parent.width
            height: walletCreatedText.height + coinID.height + publicKeyLabel.height + publicKey.height + privateKeyLabel.height + privateKey.height + addressLabel.height + addressHash.height + warningPrivateKey.height + addWalletButton.height + 115
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            visible: newWallet == 1 && editSaved == 0

            Text {
                id: walletCreatedText
                width: doubbleButtonWidth
                maximumLineCount: 2
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                text: "A NEW <b>" + coin + "</b> WALLET HAS BEEN CREATED FOR YOU"
                anchors.top: parent.top
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
            }

            Item {
                id: coinID
                width: coinLogo.width + coinName.width + 7
                height: coinLogo.height
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: walletCreatedText.bottom
                anchors.topMargin: 20

                Image {
                    id: coinLogo
                    source: coinList.get(coinIndex).logo
                    width: 30
                    height: 30
                    anchors.left: coinID.left
                    anchors.verticalCenter: parent.verticalCenter
                }

                Label {
                    id: coinName
                    text: coin + " " + newName.text
                    anchors.right: coinID.right
                    anchors.verticalCenter: coinLogo.verticalCenter
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                    font.pixelSize: 18
                    font.family: "Brandon Grotesque"
                    font.bold: true
                }
            }

            Label {
                id: publicKeyLabel
                anchors.left: walletCreatedText. left
                anchors.top: coinID.bottom
                anchors.topMargin: 10
                text: "Public Key:"
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                font.pixelSize: 18
                font.family: "Brandon Grotesque"
                font.bold: true
            }

            Label {
                id: publicKey
                width: doubbleButtonWidth
                maximumLineCount: 3
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WrapAnywhere
                anchors.left: publicKeyLabel. left
                anchors.top: publicKeyLabel.bottom
                anchors.topMargin: 5
                text: "Here you will find your public key"
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
            }

            Label {
                id: privateKeyLabel
                anchors.left: publicKey. left
                anchors.top: publicKey.bottom
                anchors.topMargin: 10
                text: "Private Key:"
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                font.pixelSize: 18
                font.family: "Brandon Grotesque"
                font.bold: true
            }

            Label {
                id: privateKey
                width: doubbleButtonWidth
                maximumLineCount: 3
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WrapAnywhere
                anchors.left: privateKeyLabel. left
                anchors.top: privateKeyLabel.bottom
                anchors.topMargin: 5
                text: "Here you will find your private key"
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
            }

            Label {
                id: addressLabel
                anchors.left: privateKey. left
                anchors.top: privateKey.bottom
                anchors.topMargin: 10
                text: "Address:"
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                font.pixelSize: 18
                font.family: "Brandon Grotesque"
                font.bold: true
            }

            Label {
                id: addressHash
                anchors.left: addressLabel. left
                anchors.top: addressLabel.bottom
                anchors.topMargin: 5
                text: "Here you will find your private key"
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
            }

            Text {
                id: warningPrivateKey
                width: doubbleButtonWidth
                maximumLineCount: 3
                anchors.left: addressHash.left
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
                text: "<b>WARNING</b>: Do not forget to backup your private key, you will not be able to restore your wallet without it!"
                anchors.top: addressHash.bottom
                anchors.topMargin: 25
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
            }

            Rectangle {
                id: addWalletButton
                width: doubbleButtonWidth
                height: 34
                anchors.top: warningPrivateKey.bottom
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter
                color: maincolor
                opacity: 0.25

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onReleased: {
                        addingWallet = true
                        saveErrorNR = 0
                        addWalletToList(coin, newName.text, addressHash.text, publicKey.text, privateKey.text, false)
                    }
                }

                Connections {
                    target: UserSettings

                    onSaveSucceeded: {
                        if (importKeyTracker == 1 && addingWallet == true) {
                            editSaved = 1
                            labelExists = 0
                            addressExists = 0
                            invalidAddress = 0
                            newName.text = ""
                            newAddress.text = ""
                            addressHash.text = ""
                            publicKey.text = ""
                            privateKey.text = ""
                            scanning = "scanning..."
                            addingWallet = false
                        }
                    }

                    onSaveFailed: {
                        if (importKeyTracker == 1 && addingWallet == true) {
                            if (userSettings.localKeys === false) {
                                walletID = walletID - 1
                                walletList.remove(walletID)
                                addressID = addressID -1
                                addressList.remove(addressID)
                                newName.text = ""
                                newAddress.text = ""
                                addressHash.text = ""
                                publicKey.text = ""
                                privateKey.text = ""
                                scanning = "scanning..."
                                editFailed = 1
                                addingWallet = false
                                walletSaved = false
                            }
                            else if (userSettings.localKeys === true && walletSaved ==true) {
                                addressID = addressID -1
                                addressList.remove(addressID)
                                labelExists = 0
                                addressExists = 0
                                invalidAddress = 0
                                newName.text = ""
                                newAddress.text = ""
                                addressHash.text = ""
                                publicKey.text = ""
                                privateKey.text = ""
                                scanning = "scanning..."
                                editFailed = 1
                                saveErrorNR = 1
                                addingWallet = false
                                walletSaved = false
                            }
                        }
                    }

                    onSaveFileSucceeded: {
                        if (importKeyTracker == 1 && userSettings.localKeys === true && addingWallet == true) {
                            walletSaved = true
                        }
                    }

                    onSaveFileFailed: {
                        if (importKeyTracker == 1 && userSettings.localKeys === true && addingWallet == true) {
                            walletID = walletID - 1
                            walletList.remove(walletID)
                            addressID = addressID -1
                            addressList.remove(addressID)
                            editFailed = 1
                            addingWallet = false
                        }
                    }

                    onSaveFailedDBError: {
                        if (importKeyTracker == 1 && addingWallet == true) {
                            failError = "Database ERROR"
                        }
                    }

                    onSaveFailedAPIError: {
                        if (importKeyTracker == 1 && addingWallet == true) {
                            failError = "Network ERROR"
                        }
                    }

                    onSaveFailedInputError: {
                        if (importKeyTracker == 1 && addingWallet == true) {
                            failError = "Input ERROR"
                        }
                    }

                    onSaveFailedUnknownError: {
                        if (importKeyTracker == 1 && addingWallet == true) {
                            failError = "Unknown ERROR"
                        }
                    }
                }
            }

            Text {
                id: addWalletButtonText
                text: "ADD WALLET"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#F2F2F2"
                font.bold: true
                anchors.horizontalCenter: addWalletButton.horizontalCenter
                anchors.verticalCenter: addWalletButton.verticalCenter
            }


            Rectangle {
                width: doubbleButtonWidth
                height: 34
                anchors.bottom: addWalletButton.bottom
                anchors.left: addWalletButton.left
                color: "transparent"
                opacity: 0.5
                border.color: maincolor
                border.width: 1
            }
        }

        // Save failed state

        Item {
            id: addWalletFailed
            width: parent.width
            height: saveFailed.height + saveFailedLabel.height + closeFail.height + 60
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            visible: editFailed == 1

            Image {
                id: saveFailed
                source: saveErrorNR == 0? (darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg') : ('qrc:/icons/mobile/warning-icon_01.svg')
                height: 100
                width: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
            }

            Label {
                id: saveFailedLabel
                width: doubbleButtonWidth
                maximumLineCount: saveErrorNR == 0? 1 : 4
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                text: saveErrorNR == 0? "Failed to save your wallet!" : "Your wallet was added but we could not add the wallet address to your addressbook. You will need to add this wallet to your addressbook manually."
                anchors.top: saveFailed.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: saveFailed.horizontalCenter
                color: maincolor
                font.pixelSize: 14
                font.family: "Brandon Grotesque"
                font.bold: true
            }

            Label {
                id: saveFailedError
                text: failError
                anchors.top: saveFailedLabel.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: saveFailed.horizontalCenter
                color: maincolor
                font.pixelSize: 14
                font.family: "Brandon Grotesque"
                font.bold: true
            }

            Rectangle {
                id: closeFail
                width: doubbleButtonWidth / 2
                height: 34
                color: maincolor
                opacity: 0.25
                anchors.top: saveFailedError.bottom
                anchors.topMargin: 50
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        if(saveErrorNR == 1) {
                            saveErrorNR = 0
                            walletAdded = true
                            importKeyTracker = 0
                        }

                        editFailed = 0
                        failError = ""
                    }
                }
            }

            Text {
                text: saveErrorNR == 0? "TRY AGAIN" : "OK"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#F2F2F2"
                anchors.horizontalCenter: closeFail.horizontalCenter
                anchors.verticalCenter: closeFail.verticalCenter
            }

            Rectangle {
                width: doubbleButtonWidth / 2
                height: 34
                anchors.bottom: closeFail.bottom
                anchors.left: closeFail.left
                color: "transparent"
                opacity: 0.5
                border.color: maincolor
                border.width: 1
            }
        }

        // Save success state
        Controls.ReplyModal {
            id: addSuccess
            modalHeight: saveSuccess.height + saveSuccessLabel.height + closeSave.height + 75
            visible: editSaved == 1

            Image {
                id: saveSuccess
                source: darktheme == true? 'qrc:/icons/mobile/add_address-icon_01_light.svg' : 'qrc:/icons/mobile/add_address-icon_01_dark.svg'
                height: 75
                fillMode: Image.PreserveAspectFit
                anchors.top: addSuccess.modalTop
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                id: saveSuccessLabel
                text: "Wallet added!"
                anchors.top: saveSuccess.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: saveSuccess.horizontalCenter
                color: maincolor
                font.pixelSize: 14
                font.family: "Brandon Grotesque"
                font.bold: true
            }

            Rectangle {
                id: closeSave
                width: doubbleButtonWidth / 2
                height: 34
                color: maincolor
                opacity: 0.25
                anchors.top: saveSuccessLabel.bottom
                anchors.bottomMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: closeSave

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        if (userSettings.accountCreationCompleted === false) {
                            userSettings.accountCreationCompleted = true
                        }
                        walletAdded = true
                        importKeyTracker = 0;
                        editSaved = 0;
                        addressExists = 0
                        labelExists = 0
                        invalidAddress = 0
                        scanQRTracker = 0
                        newName.text = ""
                        newAddress.text = ""
                        selectedAddress = ""
                        scanning = "scanning..."
                        importKeyTracker = 0
                    }
                }
            }

            Text {
                text: "OK"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#F2F2F2"
                anchors.horizontalCenter: closeSave.horizontalCenter
                anchors.verticalCenter: closeSave.verticalCenter
            }

            Rectangle {
                width: doubbleButtonWidth / 2
                height: 34
                anchors.bottom: closeSave.bottom
                anchors.left: closeSave.left
                color: "transparent"
                opacity: 0.5
                border.color: maincolor
                border.width: 1
            }
        }

        // Import key failed
        Controls.ReplyModal {
            id: createWalletFailed
            modalHeight: saveError.height + errorLabel.height + closeError.height + 75
            visible: importWalletFailed == 1

            Image {
                id: saveError
                source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
                height: 75
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: createWalletSuccess.modalTop
                anchors.topMargin: 20
            }

            Text {
                id: errorLabel
                width: doubbleButtonWidth
                text: "<b>ERROR</b>:" + walletError
                anchors.top: saveError.bottom
                anchors.topMargin: 10
                maximumLineCount: 3
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
                color: "#E55541"
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
            }

            Rectangle {
                id: closeError
                width: doubbleButtonWidth / 2
                height: 34
                color: maincolor
                opacity: 0.25
                anchors.top: errorLabel.bottom
                anchors.bottomMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        importWalletFailed = 0
                        selectedAddress = ""
                        scanning = "scanning..."
                    }
                }
            }

            Text {
                text: "TRY AGAIN"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: themecolor
                anchors.horizontalCenter: closeError.horizontalCenter
                anchors.verticalCenter: closeError.verticalCenter
            }

            Rectangle {
                width: doubbleButtonWidth / 2
                height: 34
                anchors.bottom: closeError.bottom
                anchors.left: closeError.left
                color: "transparent"
                opacity: 0.5
                border.color: maincolor
                border.width: 1
            }
        }
    }

    Item {
        z: 3
        width: Screen.width
        height: myOS === "android"? 125 : 145
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

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
        id: closeWalletModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : 70
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: importKeyTracker == 1
                 && editSaved == 0
                 && editFailed == 0
                 && scanQRTracker == 0
                 && importWalletFailed == 0

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
                    newName.text = ""
                    newAddress.text = ""
                    addressExists = 0
                    labelExists = 0
                    invalidAddress = 0
                    scanQRTracker = 0
                    selectedAddress = ""
                    scanning = "scanning..."
                }
            }

            onPressed: {
                parent.anchors.topMargin = 14
                click01.play()
                detectInteraction()
            }

            onClicked: {
                parent.anchors.topMargin = 10
                if (importKeyTracker == 1) {
                    importKeyTracker = 0;
                    timer.start()
                }
            }
        }
    }

    Controls.QrScanner{
        id: qrScanner
        z: 10
        visible: importKeyTracker == 1 && scanQRTracker == 1
    }
}
