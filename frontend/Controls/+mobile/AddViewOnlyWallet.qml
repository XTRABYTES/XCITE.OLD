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

Rectangle {
    id: addWalletModal
    width: Screen.width
    state: viewOnlyTracker == 1? "up" : "down"
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

    onStateChanged: {
        coin = coinIndex
    }

    property int addressExists: 0
    property int labelExists: 0
    property int invalidAddress: 0
    property int coin: coinIndex
    property int scanQR: 0
    property int editFailed: 0
    property int editSaved: 0
    property bool addingWallet: false
    property bool walletSaved: false
    property int saveErrorNR: 0
    property string failError: ""

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
                if (newAddress.length > 25 && newAddress.length < 36 &&(newAddress.text.substring(0,1) == "1" || newAddress.text.substring(0,1) == "3" || newAddress.text.substring(0,3) == "bc1") && newAddress.acceptableInput == true) {
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
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        visible: editFailed == 0 && editSaved == 0
    }

    Item {
        id: addViewOnlyWallet
        width: parent.width
        height: addWalletText.height + newIcon.height + newName.height + newAddress.height + scanQrButton.height + saveButton.height + 135
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -100
        visible: addViewOnly == 1 && editFailed == 0 && editSaved == 0 && scanQRTracker == 0

        Label {
            id: addWalletText
            text: "Now let's add a wallet"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Item {
            id: selectedCoin
            width: newIcon.width + newCoinName.width + 7
            height: newIcon.height
            anchors.top: addWalletText.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: newIcon
                source: coinList.get(coin).logo
                height: 30
                width: 30
                anchors.left: parent.left
                anchors.top: parent.top
            }

            Label {
                id: newCoinName
                text: coinList.get(coin).name
                anchors.left: newIcon.right
                anchors.leftMargin: 7
                anchors.verticalCenter: newIcon.verticalCenter
                font.pixelSize: 24
                font.family: "Brandon Grotesque"
                font.letterSpacing: 2
                font.bold: true
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                visible: scanQR == 0
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
            height: 34
            placeholder: "ADDRESS LABEL"
            text: ""
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.right: parent.right
            anchors.rightMargin: 28
            anchors.top: selectedCoin.bottom
            anchors.topMargin: 25
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            mobile: 1
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
            z: 1.1
            height: 34
            width: newName.width
            placeholder: "ADDRESS"
            text: ""
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newName.bottom
            anchors.topMargin: 15
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
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
            z: 1
            text: "Invalid address format!"
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
                if (addWalletTracker == 1) {
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
                    parent.border.color = themecolor
                    scanButtonText.color = themecolor
                    click01.play()
                    detectInteraction()
                }

                onReleased: {
                    parent.border.color = maincolor
                    scanButtonText.color = maincolor
                }

                onCanceled: {
                    parent.border.color = maincolor
                    scanButtonText.color = maincolor
                }

                onClicked: {
                    addressExists = 0
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
            id: saveButton
            width: newAddress.width
            height: 34
            color: (newName.text != ""
                    && newAddress.text !== ""
                    && invalidAddress == 0
                    && addressExists == 0 && labelExists == 0) ? maincolor : "#727272"
            opacity: 0.25
            anchors.top: scanQrButton.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: scanQRTracker == 0
                     && addingWallet == false

            MouseArea {
                anchors.fill: saveButton

                onPressed: {
                    parent.opacity = 1
                    click01.play()
                    detectInteraction()
                }

                onCanceled: {
                    parent.opacity = 0.25
                }

                onReleased: {
                    parent.opacity = 0.25
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
                        walletAdded = true
                        viewOnlyTracker = 0
                        newName.text = ""
                        newAddress.text = ""
                        addressExists = 0
                        labelExists = 0
                        invalidAddress = 0
                        scanQRTracker = 0
                        selectedAddress = ""
                        scanning = "scanning..."
                        addingWallet = false
                        closeAllClipboard = true
                    }
                }

                onSaveFailed: {
                    if (viewOnlyTracker == 1 && addingWallet == true) {
                        if (userSettings.localKeys === false) {
                            walletID = walletID - 1
                            walletList.remove(walletID)
                            addressID = addressID -1
                            addressList.remove(addressID)
                            editFailed = 1
                            addingWallet = false
                        }
                        else if (userSettings.localKeys === true && walletSaved == true) {
                            addressID = addressID -1
                            addressList.remove(addressID)
                            saveErrorNR = 1
                            editFailed = 1
                            addingWallet = false
                            walletSaved = false
                        }
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

        Text {
            text: "SAVE"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: (newName.text != ""
                    && newAddress.text !== ""
                    && invalidAddress == 0
                    && addressExists == 0 && labelExists == 0) ? (darktheme == true? "#F2F2F2" : maincolor) : "#979797"
            anchors.horizontalCenter: saveButton.horizontalCenter
            anchors.verticalCenter: saveButton.verticalCenter
            visible: scanQRTracker == 0
                     && addingWallet == false
        }

        Rectangle {
            width: newAddress.width
            height: 34
            anchors.bottom: saveButton.bottom
            anchors.left: saveButton.left
            color: "transparent"
            opacity: 0.5
            border.color: (newName.text != ""
                           && newAddress.text !== ""
                           && invalidAddress == 0
                           && addressExists == 0 && labelExists == 0) ? maincolor : "#979797"
            border.width: 1
            visible: scanQRTracker == 0
                     && addingWallet == false
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
    Controls.ReplyModal {
        id: addWalletFailed
        modalHeight: saveFailed.height + saveFailedLabel.height + saveFailedError.height + closeFail.height + 85
        visible: editFailed == 1

        Image {
            id: saveFailed
            source: saveErrorNR === 0? (darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg') : ('qrc:/icons/mobile/warning-icon_01.svg')
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addWalletFailed.modalTop
            anchors.topMargin: 20
        }

        Label {
            id: saveFailedLabel
            width: doubbleButtonWidth
            maximumLineCount: saveErrorNR === 0? 1 : 4
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            text: saveErrorNR === 0? "Failed to save your wallet!" : "Your wallet was added but we could not add the wallet address to your addressbook. You will need to add this wallet to your addressbook manually."
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
            anchors.topMargin: 25
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                anchors.fill: parent

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

    Item {
        z: 3
        width: Screen.width
        height: 125
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

    Item {
        z: 10
        width: Screen.width
        height: Screen.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        visible: scanQRTracker == 1

        Timer {
            id: timer
            interval: 1000
            repeat: false
            running: false

            onTriggered:{
                scanQRTracker = 0
                publicKey.text = "scanning..."
            }
        }

        Camera {
            id: camera
            position: Camera.BackFace
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
            color: bgcolor
            clip: true

            Label {
                text: "activating camera..."
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: scanFrame.verticalCenter
                color: "#F2F2F2"
                font.family: xciteMobile.name
                font.bold: true
                font.pixelSize: 14
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

            Image {
                id: scanWindow
                source: 'qrc:/scan-window_02.svg'
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                opacity: 0.9

                ColorOverlay {
                    anchors.fill: scanWindow
                    source: scanWindow
                    color: darktheme == false? "white" : "black"
                    opacity: 0.9
                }
            }

            Text {
                id: scanQRLabel
                text: "SCAN QR CODE"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 10
                font.pixelSize: 20
                font.family: xciteMobile.name
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Rectangle {
                id: scanFrame
                width: 225
                height: 225
                radius: 10
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 150
                color: "transparent"
                border.width: 1
                border.color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Label {
                id: pubKey
                text: "PUBLIC KEY"
                anchors.top: scanFrame.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                font.family: xciteMobile.name
                font.bold: true
                font.pixelSize: 14
                font.letterSpacing: 1
            }

            Label {
                id: publicKey
                text: scanning
                anchors.top: pubKey.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: pubKey.horizontalCenter
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                font.family: xciteMobile.name
                font.pixelSize: 12
                font.italic: publicKey.text == "scanning..."

            }
        }

        Rectangle {
            id: cancelScanButton
            width: doubbleButtonWidth / 2
            height: 34
            color: "transparent"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: scanQRTracker == 1

            MouseArea {
                anchors.fill: cancelScanButton

                onPressed: {
                    click01.play()
                }

                onCanceled: {
                }

                onReleased: {
                }

                onClicked: {
                    scanQRTracker = 0
                    selectedAddress = ""
                    publicKey.text = "scanning..."
                }
            }
        }

        Text {
            text: "BACK"
            font.family: xciteMobile.name
            font.pointSize: 14
            font.bold: true
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            anchors.horizontalCenter: cancelScanButton.horizontalCenter
            anchors.verticalCenter: cancelScanButton.verticalCenter
        }

        QZXingFilter {
            id: qrFilter

            decoder {
                enabledDecoders: QZXing.DecoderFormat_QR_CODE
                onTagFound: {
                    console.log(tag);
                    selectedAddress = ""
                    scanning = ""
                    publicKey.text = tag
                    selectedAddress = publicKey.text
                    timer.start()
                }
            }

            captureRect: {
                // setup bindings
                videoOutput.contentRect;
                videoOutput.sourceRect;
                // only scan the central quarter of the area for a barcode
                return videoOutput.mapRectToSource(videoOutput.mapNormalizedRectToItem(Qt.rect(
                                                                                           0.22, 0.09, 0.56, 0.82)));
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
        visible: viewOnlyTracker == 1
                 && scanQRTracker == 0


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
                }
            }

            onPressed: {
                parent.anchors.topMargin = 14
                click01.play()
                detectInteraction()
            }

            onClicked: {
                parent.anchors.topMargin = 10
                if (viewOnlyTracker  == 1) {
                    viewOnlyTracker = 0;
                    timer1.start()
                }
            }
        }
    }
}
