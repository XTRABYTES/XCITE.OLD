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
    id: addWalletModal
    width: Screen.width
    state: createWalletTracker == 1? "up" : "down"
    height: Screen.height
    color: "transparent"
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
    property int newWallet: 0
    property int createWalletFailed: 0
    property int labelExists: 0
    property string walletError: "We were unable to create a wallet for you."
    property string coin: "XFUEL"
    property url logo: getLogo(coin)

    function compareName() {

    }

    Text {
        id: addWalletLabel
        text: "CREATE NEW WALLET"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        visible: editSaved == 0
    }

    Flickable {
        id: scrollArea
        width: parent.width
        contentHeight: addWalletScrollArea.height > scrollArea.height? addWalletScrollArea.height + 125 : scrollArea.height + 125
        anchors.left: parent.left
        anchors.top: addWalletLabel.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        boundsBehavior: Flickable.StopAtBounds
        clip: true


        Rectangle {
            id: addWalletScrollArea
            width: parent.width
            height: newWallet == 1? walletInfo.height : (editSaved == 1? createWalletSucces.height : (createWalletFailed == 1? createWalletError.height : createWallet.height))
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
        }

        Item {
            id: createWallet
            width: parent.width
            height: createWalletText.height + newName.height + createWalletButton.height + 75
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            visible: newWallet == 0 && editSaved == 0 && createWalletFailed == 0

            Text {
                id: createWalletText
                width: doubbleButtonWidth
                maximumLineCount: 2
                anchors.left: newName.left
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                text: "A NEW <b>" + coin + "</b> WALLET WILL BE CREATED FOR YOU"
                anchors.top: parent.top
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
                color: newName.text != "" ? "#F2F2F2" : "#727272"
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

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onReleased: {
                        if (newName.text != "" && labelExists == 0) {
                            // function to create new address and add to the app and retrieve public key
                            // walletList.append({"name": coin, "label": newName.Text, "address": publicKey.text, "balance" : function to retrive balance from BC, "unconfirmedCoins": function to retrive balance from BC, "active": true, "favorite": false, "walletNR": walletID, "remove": false});
                            // walletID = walletID + 1
                            // addressList.apped({"contact": 0, "address": publicKey.text, "label": newName.text, "logo": getLogo(coin), "coin": coin, "favorite": 0, "active": true, "uniqueNR": addressID, "remove": false});
                            // addressID = addressID + 1
                            // var datamodel = []
                            // for (var i = 0; i < addressList.count; ++i)
                            //     datamodel.push(addressList.get(i))
                            // var addressListJson = JSON.stringify(datamodel)
                            // saveAddressBook(addressListJson)
                            // publicKey.text = "" && privateKey.text = ""
                            // if (userSettings.accountCreationCompleted === false) {
                            //      userSettings.accountCreationCompleted = true
                            // }
                            newWallet = 1
                            // or
                            createWalletFailed = 1 //&& walletError = ..., depending on the outcome
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
            }
        }

        Item {
            id: walletInfo
            width: parent.width
            height: walletCreatedText.height + coinID.height + pubKey.height + publicKey.height + privKey.height + privateKey.height + warningPrivateKey.height + addWalletButton.height + 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
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
                font.family: xciteMobile.name
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
                    source: 'qrc:/icons/XFUEL_card_logo_01.svg'
                    width: 30
                    height: 30
                    anchors.left: coinID.left
                    anchors.verticalCenter: parent.verticalCenter
                }

                Label {
                    id: coinName
                    text: coin
                    anchors.right: coinID.right
                    anchors.verticalCenter: coinLogo.verticalCenter
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                    font.pixelSize: 18
                    font.family: xciteMobile.name
                    font.bold: true
                }
            }

            Label {
                id: pubKey
                anchors.left: walletCreatedText. left
                anchors.top: coinID.bottom
                anchors.topMargin: 10
                text: "Public Key:"
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                font.pixelSize: 18
                font.family: xciteMobile.name
                font.bold: true
            }

            Label {
                id: publicKey
                anchors.left: pubKey. left
                anchors.top: pubKey.bottom
                anchors.topMargin: 5
                text: "Here you will find your public key"
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                font.pixelSize: 18
                font.family: xciteMobile.name
            }

            Label {
                id: privKey
                anchors.left: publicKey. left
                anchors.top: publicKey.bottom
                anchors.topMargin: 10
                text: "Private Key:"
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                font.pixelSize: 18
                font.family: xciteMobile.name
                font.bold: true
            }

            Label {
                id: privateKey
                anchors.left: privKey. left
                anchors.top: privKey.bottom
                anchors.topMargin: 5
                text: "Here you will find your private key"
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                font.pixelSize: 18
                font.family: xciteMobile.name
            }

            Text {
                id: warningPrivateKey
                width: doubbleButtonWidth
                maximumLineCount: 3
                anchors.left: privKey.left
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
                text: "<b>WARNING</b>: Do not forget to backup your private key, you will not be able to restore your wallet without it!"
                anchors.top: privateKey.bottom
                anchors.topMargin: 25
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
                font.pixelSize: 16
                font.family: xciteMobile.name
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
                        editSaved = 1
                        userSettings.accountCreationCompleted = true
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

        Item {
            id: createWalletSucces
            width: parent.width
            height: saveSuccess.height + saveSuccessLabel.height + closeSave.height + 60
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            visible: editSaved == 1

            Image {
                id: saveSuccess
                source: darktheme == true? 'qrc:/icons/mobile/add_address-icon_01_light.svg' : 'qrc:/icons/mobile/add_address-icon_01_dark.svg'
                height: 100
                width: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
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
                anchors.topMargin: 50
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: closeSave

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        addWalletTracker = 0;
                        editSaved = 0;
                        newWallet = 0
                        labelExists = 0
                        newName.text = ""
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

        Item {
            id: createWalletError
            width: parent.width
            height: saveError.height + errorLabel.height + closeError.height + 60
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            visible: createWalletFailed == 1

            Image {
                id: saveError
                source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
                height: 100
                width: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
            }

            Text {
                id: errorLabel
                width: doubbleButtonWidth
                text: "<b>ERROR</b>:" + walletError
                anchors.top: saveError.bottom
                anchors.topMargin: 10
                maximumLineCount: 3
                anchors.left: closeError.left
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
                anchors.topMargin: 50
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        createWalletFailed = 0
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

    Label {
        id: closeWalletModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: editSaved == 0
                 && newWallet == 0
                 && scanQRTracker == 0
                 && createWalletFailed == 0

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
                if (createWalletTracker == 1) {
                    createWalletTracker = 0;
                    timer.start()
                }
            }
        }
    }
}
