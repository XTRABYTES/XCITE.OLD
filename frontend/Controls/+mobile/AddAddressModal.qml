/**
 * Filename: AddAddressModal.qml
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
    id: addAddressModal
    width: Screen.width
    state: addAddressTracker == 1? "up" : "down"
    height: Screen.height
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    states: [
        State {
            name: "up"
            PropertyChanges { target: addAddressModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: addAddressModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: addAddressModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    property int editSaved: 0
    property int invalidAddress: 0
    property int addressExists: 0
    property int labelExists: 0
    property int contact: contactIndex

    function compareTx() {
        for(var i = 0; i < addressList.count; i++) {
            if (newAddress.text != "") {
                if (newCoinName.text == "XBY") {
                    if (addressList.get(i).coin === "XBY" && addressList.get(i).address === newAddress.text && addressList.get(i).remove === false) {
                        addressExists = 1
                    }
                }
                else {
                    if (addressList.get(i).coin === newCoinName.text && addressList.get(i).address === newAddress.text && addressList.get(i).remove === false) {
                        addressExists = 1
                    }
                }
            }
        }
    }

    function compareName() {
        labelExists = 0
        for(var i = 0; i < addressList.count; i++) {
            if (addressList.get(i).contact === contact) {
                if (newCoinName.text == "XBY") {
                    if (addressList.get(i).coin === "XBY" && addressList.get(i).label === newName.text && addressList.get(i).remove === false) {
                        labelExists = 1
                    }
                }
                else {
                    if (addressList.get(i).coin === newCoinName.text && addressList.get(i).label === newName.text && addressList.get(i).remove === false) {
                        labelExists = 1
                    }
                }
            }
        }
    }

    function checkAddress() {
        invalidAddress = 0
        if (newAddress.text != "") {
            if (newCoinName.text == "XBY") {
                if (newAddress.length == 34 && newAddress.text.substring(0,1) == "B" && newAddress.acceptableInput == true) {
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
        }
    }

    Text {
        id: addAddressModalLabel
        text: "ADD NEW ADDRESS"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        visible: editSaved == 0
    }

    Flickable {
        id: scrollArea
        height: parent.height
        width: parent.width
        contentHeight: editSaved == 0? addAddressScrollArea.height + 125  : scrollArea.height + 125
        anchors.left: parent.left
        anchors.top: addAddressModalLabel.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        Rectangle {
            id: addAddressScrollArea
            width: parent.width
            anchors.top: parent.top
            anchors.bottom: saveButton.bottom
            color: "transparent"
        }

        Image {
            id: newIcon
            source: newCoinSelect == 1? coinList.get(newCoinPicklist).logo : coinList.get(0).logo
            height: 30
            width: 30
            anchors.left: newName.left
            anchors.top: parent.top
            anchors.topMargin: 40
            visible: editSaved == 0
                     && coinListTracker == 0
                     && scanQRTracker == 0
        }

        Label {
            id: newCoinName
            text: newCoinSelect == 1? coinList.get(newCoinPicklist).name : coinList.get(0).name
            anchors.left: newIcon.right
            anchors.leftMargin: 7
            anchors.verticalCenter: newIcon.verticalCenter
            font.pixelSize: 24
            font.family: "Brandon Grotesque"
            font.letterSpacing: 2
            font.bold: true
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: editSaved == 0
                     && coinListTracker == 0
                     && scanQRTracker == 0
            onTextChanged: {
                if (newCoinName.text != ""){
                    checkAddress();
                    compareTx();
                    compareName()
                }
            }
        }

        Image {
            id: picklistArrow
            source: darktheme == true? 'qrc:/icons/mobile/dropdown-icon_01_light.svg' : 'qrc:/icons/mobile/dropdown-icon_01_dark.svg'
            height: 20
            width: 20
            anchors.left: coinListTracker == 0 ? newCoinName.right : newPicklist.right
            anchors.leftMargin: 10
            anchors.verticalCenter: newCoinName.verticalCenter
            visible: editSaved == 0
                     && coinListTracker == 0
                     && scanQRTracker == 0

            Rectangle {
                id: picklistButton
                height: 20
                width: 20
                radius: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                visible: coinListTracker == 0
            }

            MouseArea {
                anchors.fill: picklistButton

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    coinListLines(false)
                    coinListTracker = 1
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
            anchors.top: newIcon.bottom
            anchors.topMargin: 25
            color: newName.text != "" ? (darktheme == false? "#2A2C31" : "#F2F2F2") : "#727272"
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            visible: editSaved == 0
            mobile: 1
            onTextChanged: {
                detectInteraction()
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
        }

        Controls.TextInput {
            id: newAddress
            height: 34
            width: newName.width
            placeholder: "PUBLIC KEY"
            text: ""
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newName.bottom
            anchors.topMargin: 15
            color: newAddress.text != "" ? (darktheme == false? "#2A2C31" : "#F2F2F2") : "#727272"
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            visible: editSaved == 0
                     && scanQRTracker == 0
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
        }

        Label {
            id: addressWarning2
            text: "Invalid address format!"
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
            visible: editSaved == 0
                     && scanQRTracker == 0

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
            visible: coinListTracker == 1
                     && editSaved == 0
                     && scanQRTracker == 0
        }

        Rectangle {
            id: newPicklist
            width: 100
            height: ((totalLines + 1) * 35)-10
            color: "#2A2C31"
            anchors.top: newIcon.top
            anchors.topMargin: -5
            anchors.left: newIcon.left
            visible: coinListTracker == 1
                     && editSaved == 0
                     && scanQRTracker == 0

            Controls.CoinPicklist {
                id: myCoinPicklist
            }
        }

        Rectangle {
            id: picklistClose
            width: 100
            height: 25
            color: "#2A2C31"
            anchors.bottom: newPicklist.bottom
            anchors.horizontalCenter: newPicklist.horizontalCenter
            visible: coinListTracker == 1
                     && editSaved == 0
                     && scanQRTracker == 0

            Image {
                id: picklistCloseArrow
                height: 12
                fillMode: Image.PreserveAspectFit
                source: 'qrc:/icons/mobile/close_picklist-icon_01.svg'
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    detectInteraction()
                }

                onClicked: {
                    coinListTracker = 0
                }
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
            visible: editSaved == 0
                     && scanQRTracker == 0

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
                        addressList.append({"contact": contactIndex, "address": newAddress.text, "label": newName.text, "logo": getLogo(newCoinName.text), "coin": newCoinName.text, "favorite": 0, "active": true, "uniqueNR": addressID, "remove": false});
                        addressID = addressID +1;
                        console.log("Tuukka", addressList)
                        saveAddressBook(addressList)
                        editSaved = 1
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
            visible: editSaved == 0
                     && scanQRTracker == 0
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
            visible: editSaved == 0
                     && scanQRTracker == 0
        }

        // save success state

        Rectangle {
            id: saveConfirmed
            width: parent.width
            height: saveSuccess.height + saveSuccessLabel.height + closeSave.height + 60
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -125
            visible: editSaved == 1
        }

        Image {
            id: saveSuccess
            source: darktheme == true? 'qrc:/icons/mobile/add_address-icon_01_light.svg' : 'qrc:/icons/mobile/add_address-icon_01_dark.svg'
            height: 100
            width: 100
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: saveConfirmed.top
            visible: editSaved == 1
        }

        Label {
            id: saveSuccessLabel
            text: "Address saved!"
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
            width: doubbleButtonWidth / 2
            height: 34
            color: maincolor
            opacity: 0.25
            anchors.top: saveSuccessLabel.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 1

            MouseArea {
                anchors.fill: closeSave

                onPressed: {
                    parent.opacity = 0.5
                    click01.play()
                    detectInteraction()
                }

                onCanceled: {
                    parent.opacity = 0.25
                }

                onReleased: {
                    parent.opacity = 0.25
                }

                onClicked: {
                    addAddressTracker = 0;
                    editSaved = 0;
                    coinListTracker = 0
                    newCoinPicklist = 0
                    newCoinSelect = 0
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
        }
        Text {
            text: "OK"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: darktheme == true? "#F2F2F2" : maincolor
            anchors.horizontalCenter: closeSave.horizontalCenter
            anchors.verticalCenter: closeSave.verticalCenter
            visible: editSaved == 1
        }

        Rectangle {
            width: closeSave.width
            height: 34
            anchors.bottom: closeSave.bottom
            anchors.left: closeSave.left
            color: "transparent"
            opacity: 0.5
            border.color: maincolor
            border.width: 1
            visible: editSaved == 1
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
        id: closeAddressModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: addAddressTracker == 1
                 && editSaved == 0

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
                    coinListTracker = 0
                    newCoinPicklist = 0
                    newCoinSelect = 0
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
                click01.play()
                detectInteraction()
            }

            onReleased: {
                if (addAddressTracker == 1) {
                    addAddressTracker = 0;
                    timer.start()
                }
            }
        }
    }
}
