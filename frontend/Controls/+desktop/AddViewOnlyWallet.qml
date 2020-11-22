/**
 * Filename: AddViewOnlyWallet.qml
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
import QtMultimedia 5.5
import QtGraphicalEffects 1.0
import QZXing 2.3
import QtMultimedia 5.8
import QtQuick.Window 2.2

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop

Rectangle {
    id: addWalletModal
    width: appWidth*5/6
    height: appHeight
    anchors.horizontalCenter: parent.horizontalCenter
    state: viewOnlyTracker == 1? "up" : "down"
    color: bgcolor
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

    onStateChanged: {
        coin = coinIndex
        if(viewOnlyTracker == 0) {
            timer1.start()
        }
    }

    property int addressExists: 0
    property int labelExists: 0
    property int invalidAddress: 0
    property int coin: coinIndex
    property int scanQR: 0
    property int editFailed: 0
    property int editSaved: 0
    property bool walletSaved: false
    property int saveErrorNR: 0
    property string failError: ""
    property bool qrFound: false

    function compareTx() {
        addressExists = 0
        for(var i = 0; i < walletList.count; i++) {
            if (newAddress.text != "") {
                if (newCoinName.text === coinList.get(coin).name) {
                    if (walletList.get(i).address === newAddress.text && walletList.get(i).remove === false) {
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
        invalidAddress = 0
        if (newAddress.text != "") {
            if (newCoinName.text == "XBY") {
                if (newAddress.length == 34 && (newAddress.text.substring(0,1) == "B") && newAddress.acceptableInput == true) {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
            else if (newCoinName.text == "XFUEL") {
                if (newAddress.length == 34 && newAddress.text.substring(0,1) == "F" && newAddress.acceptableInput == true) {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
            else if (newCoinName.text == "XTEST") {
                if (newAddress.length == 34 && newAddress.text.substring(0,1) == "G" && newAddress.acceptableInput == true) {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
            else if (newCoinName.text == "BTC") {
                if (((newAddress.length > 25 && newAddress.length < 36 &&(newAddress.text.substring(0,1) == "1" || newAddress.text.substring(0,1) == "3"))
                     || (newAddress.length > 36 && newAddress.length < 63 && newAddress.text.substring(0,3) == "bc1"))
                        && newAddress.acceptableInput == true) {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
            else if (newCoinName.text == "ETH") {
                if (newAddress.length == 42 && newAddress.text.substring(0,2) == "0x" && newAddress.acceptableInput == true) {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
        }
    }

    Text {
        id: addWalletLabel
        text: "ADD VIEW ONLY WALLET"
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
        id: addViewOnlyWallet
        width: parent.width/2.5
        height: addWalletText.height + addWalletText.anchors.topMargin + selectedCoin.height + selectedCoin.anchors.topMargin + newName.height + newName.anchors.topMargin + newAddress.height + newAddress.anchors.topMargin + scanQrButton.height + scanQrButton.anchors.topMargin + saveButton.height*2 + saveButton.anchors.topMargin
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"
        visible: editFailed == 0 && editSaved == 0 && scanQRTracker == 0

        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.width: 1
            border.color: themecolor
            opacity: 0.1
        }

        Label {
            id: addWalletText
            text: "Let's add a wallet"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: appHeight/72
            color: themecolor
            font.pixelSize: appHeight/36
            font.family: xciteMobile.name
        }

        Item {
            id: selectedCoin
            width: newIcon.width + newCoinName.width + newCoinName.anchors.leftMargin
            height: newIcon.height
            anchors.top: addWalletText.bottom
            anchors.topMargin: appHeight/27
            anchors.horizontalCenter: parent.horizontalCenter

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
            anchors.left: parent.left
            anchors.leftMargin: appHeight/27
            anchors.right: parent.right
            anchors.rightMargin: appHeight/27
            anchors.top: selectedCoin.bottom
            anchors.topMargin: appHeight/36
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            mobile: 1
            deleteBtn: 0
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
            width: newName.width
            placeholder: "ADDRESS"
            text: ""
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newName.bottom
            anchors.topMargin: appHeight/27
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            mobile: 1
            deleteBtn: 0
            validator: RegExpValidator { regExp: /[0-9A-Za-z]+/ }
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
        }

        Label {
            id: addressWarning2
            z: 1
            text: "Invalid address format!"
            color: "#FD2E2E"
            anchors.left: newAddress.left
            anchors.leftMargin: 5
            anchors.top: newAddress.bottom
            anchors.topMargin: 1
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
            visible: newAddress.text != ""
                     && invalidAddress == 1
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
            radius: height/2
            anchors.top: newAddress.bottom
            anchors.topMargin: appHeight/27
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: themecolor
            border.width: 1
            color: "transparent"

            Rectangle {
                id: selectQR
                anchors.fill: parent
                radius: height/2
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
            id: saveButton
            width: appWidth/6
            height: appHeight/27
            radius: height/2
            color: "transparent"
            border.width: 1
            border.color: (newName.text != ""
                           && newAddress.text !== ""
                           && invalidAddress == 0
                           && addressExists == 0 && labelExists == 0) ? themecolor : "#727272"
            anchors.top: scanQrButton.bottom
            anchors.topMargin: appHeight/27
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: addingWallet == false? 1 : 0

            Rectangle {
                id: selectSave
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                text: "SAVE"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: saveButton
                hoverEnabled: true

                onEntered: {
                    if (newName.text != ""
                            && newAddress.text != ""
                            && invalidAddress == 0
                            && addressExists == 0
                            && labelExists == 0) {
                        selectSave.visible = true
                    }
                }

                onExited: {
                    selectSave.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (newName.text != ""
                            && newAddress.text != ""
                            && invalidAddress == 0
                            && addressExists == 0
                            && labelExists == 0) {
                        addingWallet = true
                        walletSaved = false
                        saveErrorNR = 0
                        addWalletToList(coinList.get(coin).name, newName.text, newAddress.text, "", "", true)
                    }
                }
            }

            Connections {
                target: UserSettings

                onSaveSucceeded: {
                    if (viewOnlyTracker == 1 && addingWallet == true) {
                        editSaved = 1
                        addingWallet = false
                    }
                }

                onSaveFailed: {
                    if (viewOnlyTracker == 1 && addingWallet == true) {
                        walletID = walletID - 1
                        walletList.remove(walletID)
                        addressID = addressID -1
                        addressList.remove(addressID)
                        editFailed = 1
                        addingWallet = false
                    }
                }

                onNoInternet: {
                    if (viewOnlyTracker == 1 && addingWallet == true) {
                        networkError = 1
                        walletID = walletID - 1
                        walletList.remove(walletID)
                        addressID = addressID -1
                        addressList.remove(addressID)
                        editFailed = 1
                        addingWallet = false
                    }
                }

                onSaveFileSucceeded: {
                    if (viewOnlyTracker == 1 && userSettings.localKeys === true && addingWallet == true) {
                        walletSaved = true

                    }
                }

                onSaveFileFailed: {
                    if (viewOnlyTracker == 1 && userSettings.localKeys === true && addingWallet == true) {
                        walletID = walletID - 1
                        walletList.remove(walletID)
                        addressID = addressID -1
                        addressList.remove(addressID)
                        editFailed = 1
                        addingWallet = false
                    }
                }

                onSaveFailedDBError: {
                    if (viewOnlyTracker == 1 && addingWallet == true) {
                        failError = "Database ERROR"
                    }
                }

                onSaveFailedAPIError: {
                    if (viewOnlyTracker == 1 && addingWallet == true) {
                        failError = "Network ERROR"
                    }
                }

                onSaveFailedInputError: {
                    if (viewOnlyTracker == 1 && addingWallet == true) {
                        failError = "Input ERROR"
                    }
                }

                onSaveFailedUnknownError: {
                    if (viewOnlyTracker == 1 && addingWallet == true) {
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
            anchors.horizontalCenter: saveButton.horizontalCenter
            anchors.verticalCenter: saveButton.verticalCenter
            playing: addingWallet == true
            visible: scanQRTracker == 0
                     && addingWallet == true
        }
    }

    // Save failed state
    Rectangle {
        id: addWalletFailed
        width: parent.width/2
        height: saveFailed.height + saveFailed.anchors.topMargin + saveFailedLabel.height + saveFailedLabel.anchors.topMargin + saveFailedError.height + saveFailedError.anchors.topMargin + closeFail.height*2 + closeFail.anchors.topMargin
        color: bgcolor
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        visible: editFailed == 1

        Image {
            id: saveFailed
            source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
            height: appHeight/12
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: height/2
        }

        Label {
            id: saveFailedLabel
            text: saveErrorNR === 0? "Failed to save your wallet!" : "Your wallet was added but we could not add the wallet address to your addressbook. You will need to add this wallet to your addressbook manually."
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
            radius: height/2
            color: "transparent"
            anchors.top: saveFailedError.bottom
            anchors.topMargin: appHeight/18
            anchors.horizontalCenter: parent.horizontalCenter
            border.width: 1
            border.color: maincolor

            Rectangle {
                id: selectCloseFail
                anchors.fill: parent
                radius: height/2
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
                    if (saveError == 1) {
                        saveErrorNR = 0
                        viewOnlyTracker = 0
                        newName.text = ""
                        newAddress.text = ""
                        addressExists = 0
                        labelExists = 0
                        invalidAddress = 0
                        scanQRTracker = 0
                        selectedAddress = ""
                        scanning = "scanning..."
                        closeAllClipboard = true
                    }
                    editFailed = 0
                    failError = ""
                }
            }
        }
    }

    Rectangle {
        id: addAddressSuccess
        width: parent.width/2
        height: saveSuccess.height + saveSuccess.anchors.topMargin + saveSuccessLabel.height + saveSuccessLabel.anchors.topMargin + closeSave.height*2 + closeSave.anchors.topMargin
        color: bgcolor
        anchors.verticalCenter: parent.verticalCenter
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
            text: "Address saved!"
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
            radius: height/2
            color: "transparent"
            anchors.top: saveSuccessLabel.bottom
            anchors.topMargin: appHeight/18
            anchors.horizontalCenter: parent.horizontalCenter
            border.width: 1
            border.color: maincolor

            Rectangle {
                id: selectCloseSave
                anchors.fill: parent
                radius: height/2
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
                    editSaved = 0
                    viewOnlyTracker = 0
                    addWalletTracker = 0
                }
            }
        }
    }

    Rectangle {
        id: qrScanner
        width: parent.width/3
        height: parent.height/2
        color: "transparent"
        border.width: 1
        border.color: maincolor
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
            cameraState: cameraPermission === true? ((viewOnlyTracker == 1) ? (scanQRTracker == 1 ? Camera.ActiveState : Camera.LoadedState) : Camera.UnloadedState) : Camera.UnloadedState
            focus {
                focusMode: Camera.FocusContinuous
                focusPointMode: CameraFocus.FocusPointAuto
            }

            onCameraStateChanged: {
                console.log("camera status: " + camera.cameraStatus)
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height
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
                text: "ADDRESS"
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

    Timer {
        id: timer1
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
            closeAllClipboard = true
            editSaved = 0
            editFailed = 0
            addingWallet = false
        }
    }
}
