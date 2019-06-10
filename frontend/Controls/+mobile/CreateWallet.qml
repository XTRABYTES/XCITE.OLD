/**
 * Filename: CreateWallet.qml
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

Rectangle {
    z: 1
    id: addWalletModal
    width: Screen.width
    state: createWalletTracker == 1? "up" : "down"
    height: Screen.height
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    Component.onCompleted: darktheme = true

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
    property int editFailed: 0
    property int newWallet: 0
    property bool addingWallet: false
    property int createFailed: 0
    property int labelExists: 0
    property string walletError: "We were unable to create a wallet for you."
    property string coin: coinList.get(coinIndex).name
    property url logo: getLogo(coin)
    property bool walletSaved: false
    property int saveErrorNR: 0
    property bool createInitiated: false
    property string failError: ""

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

    Rectangle {
        z: 2
        width: Screen.width
        height: 50
        color: bgcolor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        visible: editSaved == 0 && newWallet == 0 && editFailed == 0 && createFailed == 0
    }

    Text {
        z: 2
        id: addWalletLabel
        text: "CREATE NEW WALLET"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        visible: editSaved == 0 && newWallet == 0 && editFailed == 0 && createFailed == 0
    }

    Flickable {
        z: 1
        id: scrollArea
        width: parent.width
        contentHeight: addWalletScrollArea.height > scrollArea.height? addWalletScrollArea.height + 125 : scrollArea.height + 125
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        boundsBehavior: Flickable.StopAtBounds
        clip: true


        Rectangle {
            id: addWalletScrollArea
            width: parent.width
            height: newWallet == 1? walletInfo.height : ((editSaved == 1 || editFailed == 1)? createWalletSucces.height : (createFailed == 1? createWalletError.height : createWallet.height))
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
        }

        Item {
            id: createWallet
            width: parent.width
            height: createWalletText.height + newName.height + createWalletButton.height + selectedCoin.height + 95
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            visible: newWallet == 0 && editSaved == 0 && createFailed == 0

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
                id: createWalletText
                width: doubbleButtonWidth
                maximumLineCount: 2
                anchors.left: newName.left
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                text: "A NEW <b>" + coin + "</b> WALLET WILL BE CREATED FOR YOU"
                anchors.top: selectedCoin.bottom
                anchors.topMargin: 20
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                font.pixelSize: 16
                font.family: xciteMobile.name
            }

            Controls.TextInput {
                id: newName
                height: 34
                width: doubbleButtonWidth
                placeholder: "WALLET LABEL"
                text: ""
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: createWalletText.bottom
                anchors.topMargin: 25
                color: themecolor
                textBackground: darktheme == false? "#484A4D" : "#0B0B09"
                font.pixelSize: 14
                mobile: 1
                onTextChanged: {
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
            }

            Rectangle {
                id: createWalletButton
                width: doubbleButtonWidth
                height: 34
                anchors.top: newName.bottom
                anchors.topMargin: 30
                anchors.left: newName.left
                color: (newName.text != "" && labelExists == 0) ? maincolor : "#727272"
                opacity: 0.25
                visible: createInitiated == false

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onReleased: {
                        closeAllClipboard = true
                        if (newName.text != "" && labelExists == 0) {
                            if (coinList.get(coinIndex).name === "XFUEL" || coinList.get(coinIndex).name === "XBY" || coinList.get(coinIndex).name === "XTEST") {
                                createInitiated = true
                                createKeyPair(coinList.get(coinIndex).fullname)
                            }
                            else {
                                createFailed = 1
                            }
                        }
                    }

                    Connections {
                        target: xUtility

                        onKeyPairCreated: {
                            if (createWalletTracker == 1 && createInitiated == true) {
                                console.log("Address is: " + address)
                                console.log("PubKey is: " + pubKey)
                                console.log("PrivKey is: " + privKey)
                                privateKey.text = privKey
                                publicKey.text = pubKey
                                addressHash.text = address
                                newWallet = 1
                                createInitiated = false
                            }
                        }

                        onCreateKeypairFailed: {
                            failSound.play()
                            createFailed = 1
                        }
                    }
                }
            }

            Text {
                id: createWalletButtonText
                text: "CREATE WALLET"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: (newName.text != "" && labelExists == 0) ? "#F2F2F2" : "#979797"
                font.bold: true
                anchors.horizontalCenter: createWalletButton.horizontalCenter
                anchors.verticalCenter: createWalletButton.verticalCenter
                visible: createInitiated == false
            }

            Rectangle {
                width: createWalletButton.width
                height: 34
                anchors.bottom: createWalletButton.bottom
                anchors.left: createWalletButton.left
                color: "transparent"
                opacity: 0.5
                border.color: (newName.text != "" && labelExists == 0) ? maincolor : "#979797"
                border.width: 1
                visible: createInitiated == false
            }

            AnimatedImage {
                id: waitingDots2
                source: 'qrc:/gifs/loading-gif_01.gif'
                width: 90
                height: 60
                anchors.horizontalCenter: createWalletButton.horizontalCenter
                anchors.verticalCenter: createWalletButton.verticalCenter
                playing: createInitiated == true
                visible: createInitiated == true
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
                width: doubbleButtonWidth
                maximumLineCount: 2
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WrapAnywhere
                anchors.left: addressLabel. left
                anchors.top: addressLabel.bottom
                anchors.topMargin: 5
                text: "Here you will find your address"
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
                visible: addingWallet == false

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onReleased: {
                        addingWallet = true
                        walletSaved = false
                        saveErrorNR = 0
                        addWalletToList(coin, newName.text, addressHash.text, publicKey.text, privateKey.text, false)
                    }
                }

                Connections {
                    target: UserSettings

                    onSaveSucceeded: {
                        if (createWalletTracker == 1 && addingWallet == true) {
                            editSaved = 1
                            labelExists = 0
                            newName.text = ""
                            addressHash.text = ""
                            publicKey.text = ""
                            privateKey.text = ""
                            addingWallet = false
                        }
                    }

                    onSaveFailed: {
                        if (createWalletTracker == 1 && addingWallet == true) {
                            if (userSettings.localKeys === false) {
                                walletID = walletID - 1
                                walletList.remove(walletID)
                                addressID = addressID -1
                                addressList.remove(addressID)
                                newName.text = ""
                                addressHash.text = ""
                                publicKey.text = ""
                                privateKey.text = ""
                                editFailed = 1
                                addingWallet = false
                                walletSaved = false
                            }
                            else if (userSettings.localKeys === true && walletSaved == true) {
                                addressID = addressID -1
                                addressList.remove(addressID)
                                labelExists = 0
                                newName.text = ""
                                addressHash.text = ""
                                publicKey.text = ""
                                privateKey.text = ""
                                editFailed = 1
                                saveErrorNR = 1
                                addingWallet = false
                                walletSaved = false
                            }
                        }
                    }

                    onSaveFileSucceeded: {
                        if (createWalletTracker == 1 && userSettings.localKeys === true && addingWallet == true) {
                            walletSaved = true
                        }
                    }

                    onSaveFileFailed: {
                        if (createWalletTracker == 1 && userSettings.localKeys === true && addingWallet == true) {
                            walletID = walletID - 1
                            walletList.remove(walletID)
                            addressID = addressID -1
                            addressList.remove(addressID)
                            editFailed = 1
                            addingWallet = false
                        }
                    }

                    onSaveFailedDBError: {
                        if (createWalletTracker == 1 && addingWallet == true) {
                            failError = "Database ERROR"
                        }
                    }

                    onSaveFailedAPIError: {
                        if (createWalletTracker == 1 && addingWallet == true) {
                            failError = "Network ERROR"
                        }
                    }

                    onSaveFailedInputError: {
                        if (createWalletTracker == 1 && addingWallet == true) {
                            failError = "Input ERROR"
                        }
                    }

                    onSaveFailedUnknownError: {
                        if (createWalletTracker == 1 && addingWallet == true) {
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
                visible: addingWallet == false
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
                visible: addingWallet == false
            }

            AnimatedImage  {
                id: waitingDots
                source: 'qrc:/gifs/loading-gif_01.gif'
                width: 90
                height: 60
                anchors.horizontalCenter: addWalletButton.horizontalCenter
                anchors.verticalCenter: addWalletButton.verticalCenter
                playing: addingWallet == true
                visible: addingWallet == true
            }
        }

        // Save failed state
        Item {
            id: createWalletFailed
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
                        if (saveErrorNR == 1) {
                            saveErrorNR = 0
                            walletAdded = true
                            addWalletTracker = 0;
                            editSaved = 0;
                            newWallet = 0
                            createWalletTracker = 0
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

        // Save succes state
        Controls.ReplyModal {
            id: createWalletSuccess
            modalHeight: saveSuccess.height + saveSuccessLabel.height + closeSave.height + 75
            visible: editSaved == 1

            Image {
                id: saveSuccess
                source: darktheme == true? 'qrc:/icons/mobile/add_address-icon_01_light.svg' : 'qrc:/icons/mobile/add_address-icon_01_dark.svg'
                height: 75
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: createWalletSuccess.modalTop
                anchors.topMargin: 20
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
                anchors.topMargin: 25
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
                        addWalletTracker = 0;
                        editSaved = 0;
                        newWallet = 0
                        createWalletTracker = 0
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

        // Create wallet failed
        Controls.ReplyModal {
            id: createWalletError
            modalHeight: saveError.height + errorLabel.height + closeError.height + 75
            visible: createFailed == 1

            Image {
                id: saveError
                source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
                height: 100
                width: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: createWalletError.modalTop
                anchors.topMargin: 20
            }

            Text {
                id: errorLabel
                width: doubbleButtonWidth
                text: "<b>ERROR</b>:<br>" + walletError
                anchors.top: saveError.bottom
                anchors.topMargin: 10
                maximumLineCount: 3
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
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
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        createFailed = 0
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
        visible: editSaved == 0
                 && newWallet == 0
                 && scanQRTracker == 0
                 && createFailed == 0

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
                }
            }

            onPressed: {
                parent.anchors.topMargin = 14
                click01.play()
                detectInteraction()
            }

            onClicked: {
                parent.anchors.topMargin = 10
                if (createWalletTracker == 1) {
                    createWalletTracker = 0;
                    timer.start()
                }
            }
        }
    }
}
