/**
 * Filename: ImportWallet.qml
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
import "qrc:/Controls/+desktop" as Desktop

Rectangle {
    id: addWalletModal
    width: appWidth*5/6
    height: appHeight
    state: importKeyTracker == 1? "up" : "down"
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    onStateChanged: {
        if (importKeyTracker == 0) {
            timer1.start()
        }
        else {
            coin: coinList.get(coinIndex).name
        }
    }

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
            PropertyChanges { target: addWalletModal; anchors.topMargin: addWalletModal.height}
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
    property bool qrFound: false

    function compareTx() {
        addressExists = 0
        for(var i = 0; i < walletList.count; i++) {
            if (newAddress.text != "") {
                if (newCoinName.text === coinList.get(coin).name) {
                    if (walletList.get(i).privatekey === newAddress.text && walletList.get(i).remove === false) {
                        addressExists = 1
                    }
                }
            }
        }
    }

    function compareName() {
        labelExists = 0
        for(var i = 0; i < walletList.count; i++) {
            if (newCoinName.text === walletList.get(i).name) {
                if (walletList.get(i).label === newName.text && walletList.get(i).remove === false) {
                    labelExists = 1
                }
            }
        }
    }

    function checkAddress() {
        // check if provided private key has the correct format
    }

    Text {
        z: 2
        id: addWalletLabel
        text: "IMPORT EXISTING WALLET"
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Rectangle {
        id: infoBar
        width: parent.width
        height: appHeight/18
        anchors.top: addWalletLabel.bottom
        anchors.topMargin: appWidth*4/72 + appHeight/27
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
    }

    Item {
        id: importWalletArea
        width: (parent.width - appWidth*3/24)/2 - appWidth/24
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        anchors.top: infoBar.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: appWidth/24
        clip: true

        Item {
            id: selectedCoin
            width: newIcon.width + newCoinName.width + newCoinName.anchors.leftMargin
            height: newIcon.height
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            visible: importWalletFailed == 0

            Image {
                id: newIcon
                source: coinList.get(coin).logo
                height: appWidth/36
                fillMode: Image.PreserveAspectFit
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                id: newCoinName
                text: coinList.get(coin).name
                anchors.left: newIcon.right
                anchors.leftMargin: 7
                anchors.verticalCenter: newIcon.verticalCenter
                font.pixelSize: appHeight/27
                font.family: xciteMobile.name
                font.letterSpacing: 2
                color: themecolor
                onTextChanged: {
                    if (newCoinName.text != ""){
                        checkAddress();
                        compareTx();
                        compareName()
                    }
                }
            }
        }

        Controls.TextInput {
            id: newName
            height: appHeight/18
            placeholder: "ADDRESS LABEL"
            text: ""
            width: parent.width - appHeight*2/27
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: selectedCoin.bottom
            anchors.topMargin: appHeight/36
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            mobile: 1
            deleteBtn: 0
            visible: importWalletFailed == 0
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
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
            visible: newName.text != ""
                     && labelExists == 1
                     && scanQRTracker == 0
        }

        Controls.TextInput {
            id: newAddress
            height: appHeight/18
            placeholder: "ADDRESS"
            text: ""
            width: parent.width - appHeight*2/27
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newName.bottom
            anchors.topMargin: appHeight/27
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            mobile: 1
            deleteBtn: 0
            validator: RegExpValidator { regExp: /[0-9A-Za-z]+/ }
            visible: importWalletFailed == 0
            onTextChanged: {
                detectInteraction()
                if(newAddress.text != ""){
                    checkAddress();
                    compareTx()
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
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
            visible: newAddress.text != ""
                     && addressExists == 1
                     && importWalletFailed == 0
        }

        Label {
            id: addressWarning2
            z: 1
            text: "Invalid private key!"
            color: "#FD2E2E"
            anchors.left: newAddress.left
            anchors.leftMargin: 5
            anchors.top: newAddress.bottom
            anchors.topMargin: 1
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
            visible: newAddress.text != ""
                     && invalidAddress == 1
                     && importWalletFailed == 0
        }

        Text {
            id: destination
            text: selectedAddress
            anchors.left: newAddress.left
            anchors.top: newAddress.bottom
            anchors.topMargin: 3
            visible: false
            onTextChanged: {
                if (addWalletTracker == 1) {
                    newAddress.text = destination.text
                }
            }
        }

        Rectangle {
            id: scanQrButton
            width: appWidth/6
            height: appHeight/27
            anchors.top: newAddress.bottom
            anchors.topMargin: appHeight/27
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: themecolor
            border.width: 1
            color: "transparent"
            visible: importWalletFailed == 0

            Rectangle {
                id: selectQR
                anchors.fill: parent
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                id: scanButtonText
                text: "SCAN QR"
                font.family: "Brandon Grotesque"
                font.pointSize: parent.height/2
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: scanQrButton
                hoverEnabled: true

                onEntered: {
                    selectQR.visible = true
                }

                onExited: {
                    selectQR.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    addressExists = 0
                    scanQRTracker = 1
                    scanning = "scanning..."
                }
            }
        }

        Rectangle {
            id: importWalletButton
            width: appWidth/6
            height: appHeight/27
            color: "transparent"
            border.width: 1
            border.color: (newName.text != ""
                           && newAddress.text != ""
                           && invalidAddress == 0
                           && addressExists == 0
                           && labelExists == 0) ? themecolor : "#727272"
            anchors.top: scanQrButton.bottom
            anchors.topMargin: appHeight/27
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: addingWallet == false? 1 : 0
            visible: importWalletFailed == 0

            Rectangle {
                id: selectImport
                anchors.fill: parent
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                text: "IMPORT KEY"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: selectImport
                hoverEnabled: true

                onEntered: {
                    if (newName.text != ""
                            && newAddress.text != ""
                            && invalidAddress == 0
                            && addressExists == 0
                            && labelExists == 0) {
                        selectImport.visible = true
                    }
                }

                onExited: {
                    selectImport.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
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
            }

            Connections {
                target: xUtility

                onAddressExtracted: {
                    if (importKeyTracker == 1 && importInitiated == true) {
                        privateKey.text = newAddress.text
                        publicKeyString.text = publicKey.text
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

        Rectangle {
            id: qrScanner
            width: parent.width
            height: parent.height
            color: bgcolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            visible: scanQRTracker == 1
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
                id: timer
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
                cameraState: cameraPermission === true? ((importKeyTracker == 1) ? (scanQRTracker == 1 ? Camera.ActiveState : Camera.LoadedState) : Camera.UnloadedState) : Camera.UnloadedState
                focus {
                    focusMode: Camera.FocusContinuous
                    focusPointMode: CameraFocus.FocusPointAuto
                }

                onCameraStateChanged: {
                    console.log("camera status: " + camera.cameraStatus)
                }
            }

            Rectangle {
                width: appWidth*5/18
                height: appHeight/2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                color: "transparent"
                border.width: 1
                border.color: themecolor
                clip: true

                Label {
                    text: "activating camera..."
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: scanFrame.verticalCenter
                    color: themecolor
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
                    anchors.horizontalCenter: scanFrame.horizontalCenter
                    anchors.verticalCenter: scanFrame.verticalcenter
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
                    color: themecolor
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
                    border.color: themecolor
                }

                Label {
                    id: pubKey
                    text: "PUBLIC KEY"
                    anchors.top: scanFrame.bottom
                    anchors.topMargin: appHeight/36
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: themecolor
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
                    anchors.top: pubKey.bottom
                    anchors.topMargin: font.pixelSize
                    anchors.horizontalCenter: pubKey.horizontalCenter
                    color: themecolor
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
                        selectedAddress = ""
                        scanning = ""
                        publicKey.text = tag
                        newAddress.text = publicKey.text
                        timer.start()
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

        // Import key failed
        Rectangle {
            id: importFailed
            width: parent.width/2
            height: saveError.height + saveError.anchors.topMargin + errorLabel.height + errorLabel.anchors.topMargin + closeError.height*2 + closeError.anchors.topMargin
            color: bgcolor
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            visible: importWalletFailed == 1

            Image {
                id: saveError
                source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
                height: appHeight/12
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: height/2
            }

            Text {
                id: errorLabel
                text: "<b>ERROR</b>:" + walletError
                anchors.top: saveError.bottom
                anchors.topMargin: appHeight/24
                anchors.horizontalCenter: saveError.horizontalCenter
                color: maincolor
                font.pixelSize: appHeight/27
                font.family: xciteMobile.name
            }

            Rectangle {
                id: closeError
                width: appWidth/6
                height: appHeight/27
                color: "transparent"
                anchors.top: errorLabel.bottom
                anchors.topMargin: appHeight/18
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1
                border.color: maincolor

                Rectangle {
                    id: selectImportFail
                    anchors.fill: parent
                    color: maincolor
                    opacity: 0.3
                    visible: false
                }

                Text {
                    text:  "OK"
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
                        selectImportFail.visible = true
                    }

                    onExited: {
                        selectImportFail.visible = false
                    }

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
        }
    }

    Item {
        id: walletInfoArea
        width: (parent.width - appWidth*3/24)/2
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: infoBar.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: appWidth/24
        clip: true

        Text {
            id: walletCreatedText
            text: "New wallet details"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            color: themecolor
            font.pixelSize: appHeight/36
            font.family: xciteMobile.name
            visible: importWalletFailed == 0 && editFailed == 0 && editSaved == 0
        }

        Label {
            id: publicKeyLabel
            text: "Public Key:"
            anchors.left: parent.left
            anchors.top: walletCreatedText.bottom
            anchors.topMargin: appHeight/27
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
            visible: editFailed == 0 && editSaved == 0
        }

        Label {
            id: publicKeyString
            maximumLineCount: 3
            wrapMode: Text.WrapAnywhere
            text: "Here you will find your public key"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            anchors.top: publicKeyLabel.top
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            font.italic: newWallet == 0
            visible: editFailed == 0 && editSaved == 0
        }

        Label {
            id: privateKeyLabel
            text: "Private Key:"
            anchors.left: parent.left
            anchors.top: publicKeyLabel.bottom
            anchors.topMargin: appHeight/18
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
            visible: editFailed == 0 && editSaved == 0
        }

        Label {
            id: privateKey
            maximumLineCount: 3
            wrapMode: Text.WrapAnywhere
            text: "Here you will find your private key"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            anchors.top: privateKeyLabel.top
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            font.italic: newWallet == 0
            visible: editFailed == 0 && editSaved == 0
        }

        Label {
            id: addressLabel
            text: "Address:"
            anchors.left: parent.left
            anchors.top: privateKeyLabel.bottom
            anchors.topMargin: appHeight/18
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
            visible: editFailed == 0 && editSaved == 0
        }

        Label {
            id: addressHash
            text: "Here you will find your private key"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            anchors.top: addressLabel.top
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            font.italic: newWallet == 0
            visible: editFailed == 0 && editSaved == 0
        }

        Text {
            id: warningPrivateKey
            maximumLineCount: 3
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            text: "<b>WARNING</b>: Do not forget to backup your private key, you will not be able to restore your wallet without it!"
            anchors.top: addressHash.bottom
            anchors.topMargin: appHeight/18
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            visible: editFailed == 0 && editSaved == 0
        }

        Rectangle {
            id: addWalletButton
            width: appWidth/6
            height: appHeight/27
            anchors.top: warningPrivateKey.bottom
            anchors.topMargin: appHeight*2/27
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: themecolor
            border.width: 1
            color: "transparent"
            visible: addingWallet == false && editFailed == 0 && editSaved == 0

            Rectangle {
                id: selectSave
                anchors.fill: parent
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                id: saveButtonText
                text: "SAVE"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: themecolor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: selectSave
                hoverEnabled: true

                onEntered: {
                    selectSave.visible = true
                }

                onExited: {
                    selectSave.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onReleased: {
                    if (addingWallet == false) {
                        addingWallet = true
                        saveErrorNR = 0
                        addWalletToList(coin, newName.text, addressHash.text, publicKey.text, privateKey.text, false)
                    }
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
                            scanning = "scanning..."
                            editFailed = 1
                            saveErrorNR = 1
                            addingWallet = false
                            walletSaved = false
                        }
                    }
                }

                onNoInternet: {
                    if (importKeyTracker == 1 && addingWallet == true) {
                        networkError = 1
                        if (userSettings.localKeys === false) {
                            walletID = walletID - 1
                            walletList.remove(walletID)
                            addressID = addressID -1
                            addressList.remove(addressID)
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

        AnimatedImage  {
            id: waitingDots
            source: 'qrc:/gifs/loading-gif_01.gif'
            width: 90
            height: 60
            anchors.horizontalCenter: addWalletButton.horizontalCenter
            anchors.top: warningPrivateKey.bottom
            anchors.topMargin: 40
            playing: addingWallet == true
            visible: addingWallet == true
        }

        // Save failed state

        Rectangle {
            id: addWalletFailed
            width: parent.width/2
            height: saveFailed.height + saveFailed.anchors.topMargin + saveFailedLabel.height + saveFailedLabel.anchors.topMargin + saveFailedError.height + saveFailedError.anchors.topMargin + closeFail.height*2 + closeFail.anchors.topMargin
            color: bgcolor
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editFailed == 1

            Image {
                id: saveFailed
                source: saveErrorNR == 0? (darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg') : ('qrc:/icons/mobile/warning-icon_01.svg')
                height: appHeight/12
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: height/2
            }

            Label {
                id: saveFailedLabel
                maximumLineCount: saveErrorNR == 0? 1 : 4
                wrapMode: Text.WordWrap
                text: saveErrorNR == 0? "Failed to save your wallet!" : "Your wallet was added but we could not add the wallet address to your addressbook. You will need to add this wallet to your addressbook manually."
                anchors.top: saveFailed.bottom
                anchors.topMargin: appHeight/24
                anchors.horizontalCenter: saveFailed.horizontalCenter
                color: maincolor
                font.pixelSize: appHeight/27
                font.family: xciteMobile.name
            }

            Label {
                id: saveFailedError
                text: failError
                anchors.top: saveFailedLabel.bottom
                anchors.topMargin: font.pixelSize/2
                anchors.horizontalCenter: saveFailed.horizontalCenter
                color: maincolor
                font.pixelSize: appHeight/27
                font.family: xciteMobile.name
            }

            Rectangle {
                id: closeFail
                width: appWidth/6
                height: appHeight/27
                color: "transparent"
                anchors.top: saveFailedError.bottom
                anchors.topMargin: appHeight/18
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1
                border.color: themecolor

                Rectangle {
                    id: selectCloseFail
                    anchors.fill: parent
                    color: maincolor
                    opacity: 0.3
                    visible: false
                }

                Text {
                    text: saveErrorNR == 0? "TRY AGAIN" : "OK"
                    font.family: xciteMobile.name
                    font.pointSize: parent.height/2
                    color: parent.border.color
                    anchors.horizontalCenter: closeFail.horizontalCenter
                    anchors.verticalCenter: closeFail.verticalCenter
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        selectCloseFail.visible = true
                    }

                    onExited: {
                        selectCloseFail.visible = false
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        if(saveErrorNR == 1) {
                            saveErrorNR = 0
                            walletAdded = true
                            importKeyTracker = 0;
                        }
                        editFailed = 0
                        failError = ""
                    }
                }
            }
        }

        // Save success state
        Rectangle {
            id: addSuccess
            width: parent.width/2
            height: saveSuccess.height + saveSuccess.anchors.topMargin + saveSuccessLabel.height + saveSuccessLabel.anchors.topMargin + closeSave.height*2 + closeSave.anchors.topMargin
            color: bgcolor
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 1

            Image {
                id: saveSuccess
                source: darktheme == true? 'qrc:/icons/mobile/add_address-icon_01_light.svg' : 'qrc:/icons/mobile/add_address-icon_01_dark.svg'
                height: appHeight/12
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: height/2
            }

            Label {
                id: saveSuccessLabel
                text: "Wallet added!"
                anchors.top: saveSuccess.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: saveSuccess.horizontalCenter
                color: maincolor
                font.pixelSize: 14
                font.family: xciteMobile.name
            }

            Rectangle {
                id: closeSave
                width: appWidth/6
                height: appHeight/27
                color: "transparent"
                anchors.top: saveSuccessLabel.bottom
                anchors.topMargin: appHeight/18
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1
                border.color: themecolor

                Rectangle {
                    id: selectCloseSave
                    anchors.fill: parent
                    color: maincolor
                    opacity: 0.3
                    visible: false
                }

                Text {
                    text: "OK"
                    font.family: xciteMobile.name
                    font.pointSize: parent.height/2
                    color: parent.border.color
                    anchors.horizontalCenter: closeSave.horizontalCenter
                    anchors.verticalCenter: closeSave.verticalCenter
                }

                MouseArea {
                    anchors.fill: closeSave
                    hoverEnabled: true

                    onEntered: {
                        selectCloseSave.visible = true
                    }

                    onExited: {
                        selectCloseSave.visible = false
                    }

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
                    }
                }
            }
        }
    }

    Timer {
        id: timer1
        interval: 300
        repeat: false
        running: false

        onTriggered: {
            newName.text = ""
            newAddress.text = ""
            addressHash.text = "Here you will find your address hash"
            publicKeyString.text = "Here you will find your public key"
            privateKey.text = "Here you will find your private key"
            addressExists = 0
            labelExists = 0
            invalidAddress = 0
            scanQRTracker = 0
            selectedAddress = ""
            scanning = "scanning..."
            newWallet = 0
            editSaved = 0
            editFailed = 0
            importWalletFailed = 0
        }
    }
}
