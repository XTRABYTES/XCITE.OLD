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
    id: createWalletModal
    width: 325
    state: createWalletTracker == 1? "up" : "down"
    height: (editSaved == 1)? 358 : ((createWallet == 1) ? 480 : 270)
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    states: [
        State {
            name: "up"
            PropertyChanges { target: createWalletModal; anchors.topMargin: 50}
            //PropertyChanges { target: addAddressModal; visible: true}
        },
        State {
            name: "down"
            PropertyChanges { target: createWalletModal; anchors.topMargin: Screen.height}
            //PropertyChanges { target: addAddressModal; visible: false}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: createWalletModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.OutCubic}
            //PropertyAnimation { target: addAddressModal; property: "visible"; duration: 300}
        }
    ]

    property int editSaved: 0
    property int createWallet: 0
    property int createWalletFailed: 0
    property int labelExists: 0
    property string walletError: error1
    property string error1: " network not available at the moment"
    property alias coin: coinName.text
    property alias logo: coinLogo.source

    function compareName() {

    }

    Rectangle {
        id: walletTitleBar
        width: parent.width
        height: 50
        radius: 4
        anchors.top: parent.top
        anchors.left: parent.left
        color: "transparent"
        visible: createWallet == 0

        Text {
            id: createWalletLabel
            text: "CREATE NEW WALLET"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 27
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            font.letterSpacing: 2
        }
    }

    Rectangle {
        id: createWalletBodyModal
        width: parent.width
        height: parent.height - 50
        radius: 4
        color: darktheme == false? "#F7F7F7" : "#14161B"
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter

        LinearGradient {
                anchors.fill: parent
                source: parent
                start: Qt.point(0, 0)
                end: Qt.point(0, parent.height)
                opacity: darktheme == false? 0.05 : 0.2
                gradient: Gradient {
                    GradientStop { position: 0.0; color: darktheme == false?"#00072778" : "#FF162124" }
                    GradientStop { position: 1.0; color: darktheme == false?"#FF072778" : "#00162124" }
                }
        }


        Text {
            id: createWalletText
            width: newName.implicitWidth
            maximumLineCount: 2
            anchors.left: newName.left
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            text: "A NEW <b>XFUEL</b> WALLET WILL BE CREATED FOR YOU"
            anchors.top: parent.top
            anchors.topMargin: 25
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            font.pixelSize: 16
            font.family: xciteMobile.name
            visible: createWallet == 0
                     && createWalletFailed == 0
        }

        Controls.TextInput {
            id: newName
            height: 34
            placeholder: "WALLET LABEL"
            text: ""
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: createWalletText.bottom
            anchors.topMargin: 25
            color: newName.text != "" ? "#F2F2F2" : "#727272"
            textBackground: darktheme == false? "#484A4D" : "#0B0B09"
            font.pixelSize: 14
            visible: createWallet == 0
                     && createWalletFailed == 0
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
            visible: createWallet == 0
                     && newName.text != ""
                     && labelExists == 1
                     && createWalletFailed == 0
        }

        Rectangle {
            id: createWalletButton
            width: newName.width
            height: 33
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.left: newName.left
            radius: 5
            color: (newName.text != "" && labelExists == 0) ? maincolor : "#727272"
            visible: createWallet == 0
                     && createWalletFailed == 0

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                }

                onReleased: {
                    if (newName.text != "" && labelExists == 0) {
                        // function to add address to the wallet
                        createWallet = 1 // publicKey.text = "" && privateKey.text = ""
                        // or
                        //createWalletFailed = 1 //&& walletError = ..., depending on the outcome
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
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Text {
            id: walletCreatedText
            width: newName.implicitWidth
            maximumLineCount: 2
            anchors.left: newName.left
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            text: "A NEW <b>XFUEL</b> WALLET HAS BEEN CREATED FOR YOU"
            anchors.top: parent.top
            anchors.topMargin: 25
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            font.pixelSize: 16
            font.family: xciteMobile.name
            visible: createWallet == 1
                     && editSaved == 0
        }

        Item {
            id: coinID
            width: coinLogo.width + coinName.width + 7
            height: coinLogo.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: walletCreatedText.bottom
            anchors.topMargin: 20
            visible: createWallet == 1
                     && editSaved == 0

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
                text: "XFUEL"
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
            visible: createWallet == 1
                     && editSaved == 0
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
            visible: createWallet == 1
                     && editSaved == 0
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
            visible: createWallet == 1
                     && editSaved == 0
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
            visible: createWallet == 1
                     && editSaved == 0
        }

        Text {
            id: warningPrivateKey
            width: newName.implicitWidth
            maximumLineCount: 3
            anchors.left: privKey.left
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            text: "<b>WARNING</b>: Do not forget to backup your private key, you will not be able to restore your wallet without it!"
            anchors.bottom: addWalletButton.top
            anchors.bottomMargin: 15
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            font.pixelSize: 16
            font.family: xciteMobile.name
            visible: createWallet == 1
                     && editSaved == 0
        }

        Rectangle {
            id: addWalletButton
            width: newName.width
            height: 33
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.left: newName.left
            radius: 5
            color: maincolor
            visible: createWallet == 1
                     && editSaved == 0

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                }

                onReleased: {
                    editSaved = 1
                }
            }

            Text {
                id: addWalletButtonText
                text: "ADD WALLET"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#F2F2F2"
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
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
            visible: editSaved == 1

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: maincolor
            }
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
            visible: editSaved == 1
        }

        Rectangle {
            id: closeSave
            width: (parent.width - 45) / 2
            height: 33
            radius: 5
            color: maincolor
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 1

            MouseArea {
                anchors.fill: closeSave

                onPressed: { click01.play() }

                onClicked: {
                    addWalletTracker = 0;
                    editSaved = 0;
                    createWallet = 0
                    labelExists = 0
                    newName.text = ""
                    mainRoot.pop()
                    mainRoot.push("../Home.qml")
                }
            }
            Text {
                text: "OK"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#F2F2F2"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Image {
            id: saveError
            source: 'qrc:/icons/icon-error_01.svg'
            height: 27
            width: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 25
            visible: createWalletFailed == 1
        }

        Text {
            id: errorLabel
            width: doubbleButtonWidth
            text: "<b>ERROR</b>:" + walletError
            anchors.top: saveError.bottom
            anchors.topMargin: 20
            maximumLineCount: 3
            anchors.left: closeError.left
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            color: "#E55541"
            font.pixelSize: 16
            font.family: "Brandon Grotesque"
            visible: createWalletFailed == 1
        }

        Rectangle {
            id: closeError
            width: doubbleButtonWidth
            height: 33
            radius: 5
            color: "transparent"
            border.color: darktheme == false? "#42454F" : "#0ED8D2"
            border.width: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: createWalletFailed == 1

            MouseArea {
                anchors.fill: parent

                onPressed: { click01.play() }

                onClicked: {
                    createWalletFailed = 0
                }
            }
            Text {
                text: "TRY AGAIN"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: darktheme == false? "#0ED8D2" : "#F2F2F2"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Label {
        id: closeWalletModal
        z: 10
        text: "BACK"
        anchors.top: createWalletBodyModal.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: createWalletBodyModal.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: editSaved == 0
                 && createWallet == 0
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
