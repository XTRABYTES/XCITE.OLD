/**
 * Filename: AddWallet.qml
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
    width: 325
    state: addWalletTracker == 1? "up" : "down"
    height: (editSaved == 1)? 358 : ((addWalletFailed == 1)? 300 : 380)
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    states: [
        State {
            name: "up"
            PropertyChanges { target: addWalletModal; anchors.topMargin: 50}
            //PropertyChanges { target: addAddressModal; visible: true}
        },
        State {
            name: "down"
            PropertyChanges { target: addWalletModal; anchors.topMargin: Screen.height}
            //PropertyChanges { target: addAddressModal; visible: false}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: addWalletModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.OutCubic}
            //PropertyAnimation { target: addAddressModal; property: "visible"; duration: 300}
        }
    ]

    property int editSaved: 0
    property int addWalletFailed: 0
    property int invalidAddress: 0
    property int addressExists: 0
    property int labelExists: 0
    property string walletError: error1
    property string error1: " there is no wallet associated with the private key you provided. Please try again with a different key"
    property string error2: " network not available at the moment"

    function compareTx() {

    }

    function compareName() {

    }

    function checkAddress() {

    }

    Rectangle {
        id: walletTitleBar
        width: parent.width
        height: 50
        radius: 4
        anchors.top: parent.top
        anchors.left: parent.left
        color: "transparent"
        visible: editSaved == 0
                 && scanQRTracker == 0

        Text {
            id: addWalletLabel
            text: "ADD EXISTING WALLET"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 27
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            color: "#F2F2F2"
            font.letterSpacing: 2
        }
    }

    Rectangle {
        id: addWalletBodyModal
        width: parent.width
        height: addWalletModal.height - 50
        radius: 4
        color: darktheme == false? "#F7F7F7" : "#1B2934"
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        visible: scanQRTracker == 0

        Text {
            id: addWalletText
            width: newName.implicitWidth
            maximumLineCount: 3
            anchors.left: newName.left
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            text: "YOU CAN ADD AN EXISTING <b>XFUEL</b> WALLET BY IMPORTING YOUR PRIVATE KEY."
            anchors.top: parent.top
            anchors.topMargin: 25
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            font.pixelSize: 16
            font.family: xciteMobile.name
            visible: editSaved == 0
                     && addWalletFailed == 0
        }

        Controls.TextInput {
            id: newName
            height: 34
            placeholder: "WALLET LABEL"
            text: ""
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addWalletText.bottom
            anchors.topMargin: 25
            color: newName.text != "" ? "#F2F2F2" : "#727272"
            textBackground: darktheme == false? "#484A4D" : "#0B0B09"
            font.pixelSize: 14
            visible: editSaved == 0
                     && addWalletFailed == 0
            mobile: 1
            onTextChanged: {
                if(newName.text != "") {
                    compareName();
                    compareTx()
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
            visible: editSaved == 0
                     && newName.text != ""
                     && labelExists == 1
                     && scanQRTracker == 0
                     && addWalletFailed == 0
        }

        Controls.TextInput {
            id: newAddress
            height: 34
            placeholder: "PRIVATE KEY"
            text: ""
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newName.bottom
            anchors.topMargin: 15
            color: newAddress.text != "" ? "#F2F2F2" : "#727272"
            textBackground: darktheme == false? "#484A4D" : "#0B0B09"
            font.pixelSize: 14
            visible: editSaved == 0
                     && scanQRTracker == 0
                     && addWalletFailed == 0
            mobile: 1
            validator: RegExpValidator { regExp: /[0-9A-Za-z]+/ }
            onTextChanged: {
                if(newAddress.text != ""){
                    checkAddress();
                    compareTx()
                }
            }
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
            visible: editSaved == 0
                     && newAddress.text != ""
                     && addressExists == 1
                     && scanQRTracker == 0
                     && addWalletFailed == 0
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
            visible: editSaved == 0
                     && newAddress.text != ""
                     && invalidAddress == 1
                     && scanQRTracker == 0
                     && addWalletFailed == 0
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
            height: 33
            anchors.top: newAddress.bottom
            anchors.topMargin: 15
            anchors.left: newAddress.left
            radius: 5
            border.color: darktheme == false? "#42454F" : "#0ED8D2"
            border.width: 2
            color: "transparent"
            visible: editSaved == 0
                     && scanQRTracker == 0
                     && addWalletFailed == 0

            MouseArea {
                anchors.fill: scanQrButton

                onPressed: {
                    parent.color = maincolor
                    parent.border.color = "transparent"
                    scanButtonText.color = "#F2F2F2"
                    click01.play()
                }

                onReleased: {
                    parent.color = "transparent"
                    parent.border.color = maincolor
                    scanButtonText.color = maincolor
                    scanQRTracker = 1
                    scanning = "scanning..."
                }
            }

            Text {
                id: scanButtonText
                text: "SCAN QR"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: darktheme == false? "#0ED8D2" : "#F2F2F2"
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Rectangle {
            id: addWalletButton
            width: newAddress.width
            height: 33
            anchors.top: scanQrButton.bottom
            anchors.topMargin: 30
            anchors.left: newAddress.left
            radius: 5
            color: (newName.text != ""
                    && newAddress.text !== ""
                    && invalidAddress == 0
                    && addressExists == 0 && labelExists == 0) ? maincolor : "#727272"
            visible: editSaved == 0
                     && scanQRTracker == 0
                     && addWalletFailed == 0

            MouseArea {
                anchors.fill: addWalletButton

                onPressed: {
                    click01.play()
                }

                onReleased: {
                    if (newName.text != ""
                            && newAddress.text != ""
                            && invalidAddress == 0
                            && addressExists == 0
                            && labelExists == 0) {
                        // function to add address to the wallet
                        //editSaved = 1
                        // or
                        addWalletFailed = 1 //&& walletError = ..., depending on the outcome
                    }
                }
            }

            Text {
                id: addWalletButtonText
                text: "ADD WALLET"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: (newName.text != ""
                        && newAddress.text !== ""
                        && invalidAddress == 0
                        && addressExists == 0 && labelExists == 0) ? "#F2F2F2" : "#979797"
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
                    addressExists = 0
                    labelExists = 0
                    invalidAddress = 0
                    scanQRTracker = 0
                    newName.text = ""
                    newAddress.text = ""
                    selectedAddress = ""
                    scanning = "scanning..."
                    loginTracker = 1
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
            visible: addWalletFailed == 1
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
            visible: addWalletFailed == 1
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
            visible: addWalletFailed == 1

            MouseArea {
                anchors.fill: parent

                onPressed: { click01.play() }

                onClicked: {
                    addWalletFailed = 0
                    selectedAddress = ""
                    scanning = "scanning..."
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
        anchors.top: addWalletBodyModal.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: addWalletBodyModal.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: "#F2F2F2"
        visible: addWalletTracker == 1
                 && editSaved == 0
                 && scanQRTracker == 0
                 && addWalletFailed == 0

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
            }

            onClicked: {
                parent.anchors.topMargin = 10
                if (addWalletTracker == 1) {
                    addWalletTracker = 0;
                    timer.start()
                }
            }
        }
    }
}
