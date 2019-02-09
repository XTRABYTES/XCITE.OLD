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
import QtQuick.Window 2.2
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: addressModal
    width: Screen.width
    state: addressTracker == 0 ? "down" : "up"
    height: Screen.height
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 50
    visible: scanQRTracker == 0

    states: [
        State {
            name: "up"
            PropertyChanges { target: addressModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: addressModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: addressModal; property: "anchors.topMargin"; duration: 400; easing.type: Easing.OutCubic}
        }
    ]

    onStateChanged: {
        checkMyAddress()
    }

    property string coinName: addressList.get(addressIndex).coin
    property string addressHash: addressList.get(addressIndex).address
    property string addressName: addressList.get(addressIndex).label
    property int contact: addressList.get(addressIndex).contact
    property int deleteAddressTracker: 0
    property int editSaved: 0
    property int deleteConfirmed: 0
    property int invalidAddress: 0
    property int doubleAddress: 0
    property int labelExists: 0
    property int myAddress: 0

    function checkMyAddress(){
        myAddress = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === coinName && walletList.get(i).address === addressHash) {
                myAddress = 1
            }
        }
    }

    function compareTx(){
        doubleAddress = 0
        for(var i = 0; i < addressList.count; i++) {
            if (newAddress.text != "") {
                if (newCoinName.text == "XBY") {
                    if (addressList.get(i).coin === "XBY" && addressList.get(i).address === newAddress.text && addressList.get(i).remove === false && adressList.get(i).uniqueNR !== addressIndex) {
                        doubleAddress = 1
                    }
                }
                else {
                    if (addressList.get(i).coin === newCoinName.text && addressList.get(i).address === newAddress.text && addressList.get(i).remove === false && adressList.get(i).uniqueNR !== addressIndex) {
                        doubleAddress = 1
                    }
                }
            }
            else {
                if (newCoinName.text == "XBY") {
                    if (addressList.get(i).coin === "XBY" && addressList.get(i).address === newAddress.placeholder && addressList.get(i).remove === false && adressList.get(i).uniqueNR !== addressIndex) {
                        doubleAddress = 1
                    }
                }
                else {
                    if (addressList.get(i).coin === newCoinName.text && addressList.get(i).address === newAddress.placeholder && addressList.get(i).remove === false && adressList.get(i).uniqueNR !== addressIndex) {
                        doubleAddress = 1
                    }
                }
            }
        }
    }

    function compareName(){
        labelExists = 0
        for(var i = 0; i < addressList.count; i++) {
            if (addressList.get(i).contact === contactIndex) {
                if (newName.text != "") {
                    if (newCoinName.text == "XBY") {
                        if (addressList.get(i).coin === "XBY" && addressList.get(i).label === newName.text && addressList.get(i).remove === false && addressList.get(i).uniqueNR !== addressIndex) {
                            labelExists = 1
                        }
                    }
                    else {
                        if (addressList.get(i).coin === newCoinName.text && addressList.get(i).label === newName.text && addressList.get(i).remove === false && addressList.get(i).uniqueNR !== addressIndex) {
                            labelExists = 1
                        }
                    }
                }
                else {
                    if (newCoinName.text == "XBY") {
                        if (addressList.get(i).coin === "XBY" && addressList.get(i).label === newName.placeholder && addressList.get(i).remove === false && addressList.get(i).uniqueNR !== addressIndex) {
                            labelExists = 1
                        }
                    }
                    else {
                        if (addressList.get(i).coin === newCoinName.text && addressList.get(i).label === newName.placeholder && addressList.get(i).remove === false && addressList.get(i).uniqueNR !== addressIndex) {
                            labelExists = 1
                        }
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
        else {
            if (newCoinName.text == "XBY") {
                if (newAddress.placeholder.length == 34 && newAddress.placeholder.substring(0,1) == "B") {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
            else if (newCoinName.text == "XFUEL") {
                if (newAddress.placeholder.length == 34 && newAddress.placeholder.substring(0,1) == "F") {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
        }
    }

    Text {
        id: addressModalLabel
        text: "EDIT ADDRESS"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.letterSpacing: 2
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        elide: Text.ElideRight
    }

    Flickable {
        id: scrollArea
        width: parent.width
        contentHeight: (editSaved == 0 && deleteAddressTracker == 0)? addressScrollArea.height + 125 : scrollArea.height + 125
        anchors.left: parent.left
        anchors.top: addressModalLabel.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        Text {
            id: addressNameLabel
            text: addressName + " (" + contactList.get(contactIndex).firstName + " " + contactList.get(contactIndex).lastName + ")"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.right: favoriteAddressIcon.left
            anchors.rightMargin: 7
            anchors.top: parent.top
            font.pixelSize: 20
            font.family: xciteMobile.name
            font.letterSpacing: 2
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            elide: Text.ElideRight

            onTextChanged: {checkMyAddress()}
        }

        Image {
            id: favoriteAddressIcon
            source: 'qrc:/icons/icon-favorite.svg'
            width: 25
            height: 25
            anchors.verticalCenter: addressNameLabel.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 28
            visible: editSaved == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: addressList.get(addressIndex).favorite === 1 ? "#FDBC40" : "#979797"
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

        Rectangle {
            id: addressScrollArea
            width: parent.width
            anchors.top: parent.top
            anchors.bottom: deleteAddress.bottom
            color: "transparent"
        }


        Image {
            id: newIcon
            source: getLogo(newCoinName.text)
            height: 30
            width: 30
            anchors.left: newName.left
            anchors.top: parent.top
            anchors.topMargin: 50
            visible: coinListTracker == 0
                     && editSaved == 0
                     && deleteAddressTracker == 0
        }

        Label {
            id: newCoinName
            text: newCoinSelect == 1 ? coinList.get(newCoinPicklist).name : addressList.get(addressIndex).coin
            anchors.left: newIcon.right
            anchors.leftMargin: 7
            anchors.verticalCenter: newIcon.verticalCenter
            font.pixelSize: 24
            font.family: xciteMobile.name
            font.letterSpacing: 2
            font.bold: true
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: coinListTracker == 0
                     && editSaved == 0
                     && deleteAddressTracker == 0

            onTextChanged: {
                if (newCoinSelect == 1) {
                    checkAddress()
                    compareName()
                    compareTx()
                }
            }
        }

        Rectangle {
            id: saveEditButton
            width: newName.width
            height: 34
            color: (doubleAddress == 0
                    && labelExists == 0
                    && invalidAddress == 0
                    && myAddress == 0) ? maincolor : "#727272"
            opacity: 0.25
            anchors.top: scanQrButton.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 0
                     && deleteAddressTracker == 0

            MouseArea {
                anchors.fill: saveEditButton

                onPressed: {
                    parent.opacity = 0.5
                    click01.play()
                }

                onReleased: {
                    parent.opacity = 0.25
                }

                onCanceled: {
                    parent.opacity = 0.25
                }

                onClicked: {
                    if (doubleAddress == 0
                            && labelExists == 0
                            && invalidAddress == 0
                            && myAddress == 0) {
                        if (newCoinSelect == 1) {
                            addressList.setProperty(addressIndex, "logo", coinList.get(newCoinPicklist).logo);
                            addressList.setProperty(addressIndex, "coin", coinList.get(newCoinPicklist).name);
                        }
                        if (newName.text !== "") {
                            addressList.setProperty(addressIndex, "label", newName.text);
                        }
                        if (newAddress.text !== "") {
                            addressList.setProperty(addressIndex, "address", newAddress.text);
                        }
                        editSaved = 1
                        coinListTracker = 0
                    }
                }
            }
        }

        Text {
            text: "SAVE"
            font.family: xciteMobile.name
            font.pointSize: 14
            font.bold: true
            color: (doubleAddress == 0
                    && labelExists == 0
                    && invalidAddress == 0
                    && myAddress == 0) ? (darktheme == true? "#F2F2F2" : maincolor) : "#979797"
            anchors.horizontalCenter: saveEditButton.horizontalCenter
            anchors.verticalCenter: saveEditButton.verticalCenter
            visible: editSaved == 0
                     && deleteAddressTracker == 0
        }

        Rectangle {
            width: newName.width
            height: 34
            color: "transparent"
            border.color: (doubleAddress == 0
                           && labelExists == 0
                           && invalidAddress == 0
                           && myAddress == 0) ? maincolor : "#727272"
            border.width: 1
            opacity: 0.25
            anchors.top: scanQrButton.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 0
                     && deleteAddressTracker == 0
        }

        Image {
            id: picklistArrow1
            source: 'qrc:/icons/dropdown_icon.svg'
            height: 20
            width: 20
            anchors.left: coinListTracker == 0 ? newCoinName.right : newPicklist1.right
            anchors.leftMargin: 10
            anchors.verticalCenter: newCoinName.verticalCenter
            visible: editSaved == 0
                     && coinListTracker == 0
                     && deleteAddressTracker == 0
                     && myAddress == 0
                     && contact != 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Rectangle {
                id: picklistButton1
                height: 20
                width: 20
                radius: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
            }

            MouseArea {
                anchors.fill: picklistButton1

                onPressed: { click01.play() }

                onClicked: {
                    coinListLines(false)
                    coinListTracker = 1
                }
            }
        }

        Image {
            id: deleteAddress
            source: 'qrc:/icons/trashcan_big.svg'
            height: 26
            width: 18
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: saveEditButton.bottom
            anchors.topMargin: 40
            visible: editSaved == 0
                     && deleteAddressTracker == 0
                     && myAddress == 0
                     && contact != 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Rectangle {
                id: deleteButton
                height: 20
                width: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
            }

            MouseArea {
                anchors.fill: deleteButton

                onPressed: {
                    click01.play()
                }

                onClicked: {
                    deleteAddressTracker = 1
                }
            }
        }

        Controls.TextInput {
            id: newName
            text: ""
            height: 34
            placeholder: addressName
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.right: parent.right
            anchors.rightMargin: 28
            anchors.top: newIcon.bottom
            anchors.topMargin: 25
            color: newName.text != "" ? themecolor : "#727272"
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            readOnly: contact == 0
            visible: editSaved == 0
                     && deleteAddressTracker == 0
            mobile: 1
            onTextChanged: compareName()
        }

        Label {
            id: nameWarning
            text: "Already an address with this label for this contact!"
            color: "#FD2E2E"
            anchors.left: newName.left
            anchors.leftMargin: 5
            anchors.top: newName.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: xciteMobile.name
            visible: editSaved == 0
                     && labelExists == 1
                     && deleteAddressTracker == 0
        }

        Controls.TextInput {
            id: newAddress
            text: ""
            height: 34
            width: newName.width
            placeholder: addressHash
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newName.bottom
            anchors.topMargin: 15
            color: newAddress.text != "" ? themecolor : "#727272"
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            readOnly: contact == 0
            visible: editSaved == 0
                     && deleteAddressTracker == 0
            mobile: 1
            validator: RegExpValidator { regExp: /[0-9A-Za-z]+/ }
            onTextChanged: {
                checkAddress()
                compareTx()
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
            font.family: xciteMobile.name
            visible: editSaved == 0
                     && doubleAddress == 1
                     && deleteAddressTracker == 0
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
            font.family: xciteMobile.name
            visible: editSaved == 0
                     && invalidAddress == 1
                     && deleteAddressTracker == 0
        }

        Text {
            id: destination
            text: selectedAddress
            anchors.left: newAddress.left
            anchors.top: newAddress.bottom
            anchors.topMargin: 3
            visible: false
            onTextChanged: {
                if (addressTracker == 1) {
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
            border.width: 1
            color: "transparent"
            visible: editSaved == 0
                     && deleteAddressTracker == 0
                     && myAddress == 0

            MouseArea {
                anchors.fill: scanQrButton

                onPressed: {
                    click01.play()
                    border.color = darktheme == true? "#F2F2F2" : "#2A2C31"
                }

                onReleased: {
                    border.color = maincolor
                }

                onCanceled: {
                    border.color = maincolor
                }

                onClicked: {
                    scanQRTracker = 1
                    scanning = "scanning..."
                }
            }

            Text {
                id: scanQrButtonText
                text: "SCAN QR"
                font.family: xciteMobile.name
                font.pointSize: 14
                color: maincolor
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        DropShadow {
            id: shadowTransferPicklist1
            anchors.fill: newPicklist1
            source: newPicklist1
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
                     && deleteAddressTracker == 0
        }

        Rectangle {
            id: newPicklist1
            width: 100
            height: ((totalLines + 1) * 35)-10
            radius: 4
            color: "#2A2C31"
            anchors.top: newIcon.top
            anchors.topMargin: -5
            anchors.left: newIcon.left
            visible: coinListTracker == 1
                     && editSaved == 0
                     && deleteAddressTracker == 0

            Controls.CoinPicklist {
                id: myCoinPicklist
            }
        }

        Rectangle {
            id: picklistClose1
            width: 100
            height: 25
            radius: 4
            color: "#2A2C31"
            anchors.bottom: newPicklist1.bottom
            anchors.horizontalCenter: newPicklist1.horizontalCenter
            visible: coinListTracker == 1
                     && editSaved == 0
                     && deleteAddressTracker == 0

            Image {
                id: picklistCloseArrow
                source: 'qrc:/icons/dropdown-arrow.svg'
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                rotation: 180
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    coinListTracker = 0
                }
            }
        }

        // Edit saved state

        Rectangle {
            id: saveConfirmed
            width: parent.width
            height: saveSuccess.height + saveSuccessLabel.height + closeSaveEdit.height + 60
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -125
            visible: editSaved == 1
        }

        Image {
            id: saveSuccess
            source: 'qrc:/icons/icon-success.svg'
            height: 100
            width: 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: saveConfirmed.top
            visible: editSaved == 1

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: maincolor
            }
        }

        Label {
            id: saveSuccessLabel
            text: "Changes saved!"
            anchors.top: saveSuccess.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: saveSuccess.horizontalCenter
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.bold: true
            visible: editSaved == 1
        }

        Rectangle {
            id: closeSaveEdit
            width: doubbleButtonWidth / 2
            height: 34
            color: maincolor
            opacity: 0.25
            anchors.top: saveSuccessLabel.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 1

            MouseArea {
                anchors.fill: closeSaveEdit

                Timer {
                    id: timerSave
                    interval: 300
                    repeat: false
                    running: false

                    onTriggered: {
                        newCoinPicklist = 0
                        newCoinSelect = 0
                        coinListTracker = 0
                        newName.text = ""
                        newAddress.text = ""
                        invalidAddress = 0
                        editSaved = 0
                        deleteAddressTracker = 0
                        deleteConfirmed = 0
                        scanQRTracker = 0
                        selectedAddress = ""
                        scanning = "scanning..."
                    }
                }

                onPressed: {
                    parent.opacity = 0.5
                    click01.play()
                }

                onCanceled: {
                    parent.opacity = 0.25
                }

                onReleased: {
                    parent.opacity = 0.25

                }

                onClicked: {
                    addressTracker = 0;
                    timerSave.start()
                }
            }
        }

        Text {
            text: "OK"
            font.family: xciteMobile.name
            font.pointSize: 14
            font.bold: true
            color: darktheme == true? "#F2F2F2" : maincolor
            anchors.horizontalCenter: closeSaveEdit.horizontalCenter
            anchors.verticalCenter: closeSaveEdit.verticalCenter
            visible: editSaved == 1
        }

        Rectangle {
            width: doubbleButtonWidth / 2
            height: 34
            color: "transparent"
            opacity: 0.5
            border.color: maincolor
            border.width: 1
            anchors.bottom: closeSaveEdit.bottom
            anchors.horizontalCenter: closeSaveEdit.horizontalCenter
            visible: editSaved == 1
        }

        // Delete confirm state

        Rectangle {
            id: deleteConfirmation
            width: parent.width
            height: deleteText.height + deleteAddressName.height + deleteAddressHash.height + confirmationDeleteButton.height + 64
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -125
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            visible: deleteAddressTracker == 1
                     && deleteConfirmed == 0

            Text {
                id: deleteText
                text: "You are about to delete:"
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Text {
                id: deleteAddressName
                text: addressName + " (" + coinName + ")"
                anchors.top: deleteText.bottom
                anchors.topMargin: 7
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: xciteMobile.name
                font.pixelSize: 16
                font.bold: true
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Text {
                id: deleteAddressHash
                text: addressHash
                anchors.top: deleteAddressName.bottom
                anchors.topMargin: 7
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Rectangle {
                id: confirmationDeleteButton
                width: (doubbleButtonWidth - 10) / 2
                height: 34
                anchors.top: deleteAddressHash.bottom
                anchors.topMargin: 50
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 5
                color: "#4BBE2E"
                opacity: 0.25

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        parent.opacity = 0.5
                        click01.play()
                    }

                    onCanceled: {
                        parent.opacity = 0.25
                    }

                    onReleased: {
                        parent.opacity = 0.25
                    }

                    onClicked: {
                        deleteConfirmed = 1
                        addressList.setProperty(addressIndex, "remove", true)
                        doubleAddress = 0
                        labelExists = 0
                        invalidAddress = 0
                    }
                }
            }

            Text {
                text: "CONFIRM"
                font.family: xciteMobile.name
                font.pointSize: 14
                color: "#4BBE2E"
                font.bold: true
                anchors.horizontalCenter: confirmationDeleteButton.horizontalCenter
                anchors.verticalCenter: confirmationDeleteButton.verticalCenter
            }

            Rectangle {
                width: (doubbleButtonWidth - 10) / 2
                height: 34
                anchors.top: deleteAddressHash.bottom
                anchors.topMargin: 50
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 5
                color: "transparent"
                border.color: "#4BBE2E"
                border.width: 1
            }

            Rectangle {
                id: cancelDeleteButton
                width: (doubbleButtonWidth - 10) / 2
                height: 34
                anchors.top: deleteAddressHash.bottom
                anchors.topMargin: 50
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 5
                color: "#E55541"
                opacity: 0.25

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        parent.opacity = 0.5
                    }

                    onCanceled: {
                        parent.opacity = 0.25
                    }

                    onReleased: {
                        parent.opacity = 0.25
                    }

                    onClicked: {
                        deleteAddressTracker = 0
                    }
                }
            }

            Text {
                text: "CANCEL"
                font.family: xciteMobile.name
                font.pointSize: 14
                font.bold: true
                color: "#E55541"
                anchors.horizontalCenter: cancelDeleteButton.horizontalCenter
                anchors.verticalCenter: cancelDeleteButton.verticalCenter
            }

            Rectangle {
                width: (doubbleButtonWidth - 10) / 2
                height: 34
                anchors.top: deleteAddressHash.bottom
                anchors.topMargin: 50
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 5
                color: "transparent"
                border.color: "#E55541"
                border.width: 1
            }
        }

        // Delete success state

        Rectangle {
            id: deleted
            width: parent.width
            height: deleteSuccess.height + deleteSuccessLabel.height + closeDelete.height + 60
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -125
            visible: deleteConfirmed == 1
        }

        Image {
            id: deleteSuccess
            source: 'qrc:/icons/icon-delete-mobile.svg'
            height: 100
            width: 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: deleted.top
            visible: deleteConfirmed == 1

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: maincolor
            }
        }

        Label {
            id: deleteSuccessLabel
            text: "Address removed!"
            anchors.top: deleteSuccess.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: deleteSuccess.horizontalCenter
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.bold: true
            visible: deleteConfirmed == 1
        }

        Rectangle {
            id: closeDelete
            width: doubbleButtonWidth / 2
            height: 34
            color: maincolor
            opacity: 0.25
            anchors.top: deleteSuccessLabel.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: deleteConfirmed == 1

            MouseArea {
                anchors.fill: closeDelete

                Timer {
                    id: timerDelete
                    interval: 300
                    repeat: false
                    running: false

                    onTriggered: {
                        newCoinPicklist = 0
                        newCoinSelect = 0
                        coinListTracker = 0
                        newName.text = ""
                        newAddress.text = ""
                        invalidAddress = 0
                        editSaved = 0
                        deleteAddressTracker = 0
                        deleteConfirmed = 0
                        scanQRTracker = 0
                        selectedAddress = ""
                        scanning = "scanning..."
                    }
                }

                onPressed: {
                    closeDelete.opacity = 0.5
                    click01.play()
                }

                onCanceled: {
                    closeDelete.opacity = 0.25
                }

                onReleased: {
                    closeDelete.opacity = 0.25
                }

                onClicked: {
                    addressTracker = 0;
                    timerDelete.start()
                }
            }
        }

        Text {
            text: "OK"
            font.family: xciteMobile.name
            font.pointSize: 14
            font.bold: true
            color: darktheme == true? "#F2F2F2" : maincolor
            anchors.horizontalCenter: closeDelete.horizontalCenter
            anchors.verticalCenter: closeDelete.verticalCenter
            visible: deleteConfirmed == 1
        }

        Rectangle {
            width: doubbleButtonWidth / 2
            height: 34
            anchors.bottom: closeDelete.bottom
            anchors.horizontalCenter: closeDelete.horizontalCenter
            color: "transparent"
            border.color: maincolor
            border.width: 1
            opacity: 0.5
            visible: deleteConfirmed == 1
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
        visible: editSaved == 0 && deleteAddressTracker == 0

        Rectangle{
            id: closeButton
            height: 34
            width: doubbleButtonWidth / 2
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
                    newCoinPicklist = 0
                    newCoinSelect = 0
                    coinListTracker = 0
                    newName.text = ""
                    newAddress.text = ""
                    invalidAddress = 0
                    editSaved = 0
                    deleteAddressTracker = 0
                    deleteConfirmed = 0
                    scanQRTracker = 0
                    selectedAddress = ""
                    myAddress = 0
                    scanning = "scanning..."
                }
            }

            onPressed: {
                click01.play()
            }

            onReleased: {
                addressTracker = 0;
                timer.start()
            }
        }
    }
}
