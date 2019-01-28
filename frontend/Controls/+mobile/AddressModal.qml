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
    width: 325
    state: addressTracker == 0 ? "down" : "up"
    height: (editSaved == 1 || deleteAddressTracker == 1 || deleteConfirmed == 1)? 360 : myAddress == 1? 300 : 320
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 50
    visible: scanQRTracker == 0

    states: [
        State {
            name: "up"
            PropertyChanges { target: addressModal; anchors.topMargin: 50}
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
            NumberAnimation { target: addressModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.OutCubic}
        }
    ]

    onStateChanged: {
        checkMyAddress()
    }

    property string coinName: addressList.get(addressIndex).coin
    property string addressHash: addressList.get(addressIndex).address
    property string addressName: addressList.get(addressIndex).label
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
                        if (addressList.get(i).coin === "XBY" && addressList.get(i).label === newName.text && addressList.get(i).remove === false && adressList.get(i).uniqueNR !== addressIndex) {
                        labelExists = 1
                        }
                    }
                    else {
                        if (addressList.get(i).coin === newCoinName.text && addressList.get(i).label === newName.text && addressList.get(i).remove === false && adressList.get(i).uniqueNR !== addressIndex) {
                            labelExists = 1
                        }
                    }
                }
                else {
                    if (newCoinName.text == "XBY") {
                        if (addressList.get(i).coin === "XBY" && addressList.get(i).label === newName.placeholder && addressList.get(i).remove === false && adressList.get(i).uniqueNR !== addressIndex) {
                        labelExists = 1
                        }
                    }
                    else {
                        if (addressList.get(i).coin === newCoinName.text && addressList.get(i).label === newName.placeholder && addressList.get(i).remove === false && adressList.get(i).uniqueNR !== addressIndex) {
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

    Rectangle {
        id: addressTitleBar
        width: parent.width
        height: 50
        radius: 4
        anchors.top: parent.top
        anchors.left: parent.left
        color: "transparent"
        visible: editSaved == 0
                 && deleteAddressTracker == 0

        Image {
            id: titleIcon
            width: 25
            height: 25
            source: addressList.get(addressIndex).logo
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 15
        }

        Text {
            id: addressModalLabel
            text: addressName + " (" + contactList.get(contactIndex).firstName + " " + contactList.get(contactIndex).lastName + ")"
            anchors.left: titleIcon.right
            anchors.leftMargin: 7
            anchors.right: favoriteAddressIcon.left
            anchors.rightMargin: 7
            anchors.verticalCenter: titleIcon.verticalCenter
            anchors.verticalCenterOffset: -1
            font.pixelSize: 20
            font.family: xciteMobile.name
            color: "#F2F2F2"
            elide: Text.ElideRight

            onTextChanged: {checkMyAddress()}
        }

        Image {
            id: favoriteAddressIcon
            source: 'qrc:/icons/icon-favorite.svg'
            width: 25
            height: 25
            anchors.verticalCenter: titleIcon.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 15
            visible: editSaved == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: addressList.get(addressIndex).favorite === 1 ? "#FDBC40" : (darktheme == false? "#2A2C31" : "#42454F")
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
    }

    Rectangle {
        id: addressBodyModal
        width: parent.width
        height: parent.height - 50
        radius: 4
        color: darktheme == false? "#F7F7F7" : "#1B2934"
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: newIcon
            source: getLogo(newCoinName.text)
            height: 25
            width: 25
            anchors.left: newName.left
            anchors.top: parent.top
            anchors.topMargin: 20
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
            font.pixelSize: 18
            font.family: xciteMobile.name
            font.bold: true
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
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
            radius: 5
            color: (doubleAddress == 0
                    && labelExists == 0
                    && invalidAddress == 0
                    && myAddress == 0) ? maincolor : (darktheme == false? "#727272" : "#14161B")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 0
                     && deleteAddressTracker == 0

            MouseArea {
                anchors.fill: saveEditButton

                onPressed: { click01.play() }

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

            Text {
                text: "SAVE"
                font.family: xciteMobile.name
                font.pointSize: 14
                font.bold: true
                color: (doubleAddress == 0
                        && labelExists == 0
                        && invalidAddress == 0
                        && myAddress == 0) ? "#F2F2F2" : (darktheme == false? "#979797" : "#3F3F3F")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
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

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
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
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.verticalCenter: picklistArrow1.verticalCenter
            visible: editSaved == 0
                     && deleteAddressTracker == 0
                     && myAddress == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
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

                onPressed: { click01.play() }

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
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newIcon.bottom
            anchors.topMargin: 15
            color: myAddress == 0 ? (newName.text == "" ? "#727272" : "#F2F2F2") : "#F2F2F2"
            textBackground: darktheme == false? "#484A4D" : "#0B0B09"
            font.pixelSize: 14
            visible: editSaved == 0
                     && deleteAddressTracker == 0
            mobile: 1
            readOnly: myAddress == 1
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
            placeholder: addressHash
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newName.bottom
            anchors.topMargin: 15
            color: myAddress == 0 ? (newAddress.text == "" ? "#727272" : "#F2F2F2") : "#F2F2F2"
            textBackground: darktheme == false? "#484A4D" : "#0B0B09"
            font.pixelSize: 14
            visible: editSaved == 0
                     && deleteAddressTracker == 0
            mobile: 1
            readOnly: myAddress == 1
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
            height: 33
            anchors.top: newAddress.bottom
            anchors.topMargin: 15
            anchors.left: newAddress.left
            radius: 5
            border.color: maincolor
            border.width: 2
            color: "transparent"
            visible: editSaved == 0
                     && deleteAddressTracker == 0
                     && myAddress == 0

            MouseArea {
                anchors.fill: scanQrButton

                onPressed: {
                    scanQrButton.color = maincolor
                    scanQrButton.border.color = "transparent"
                    scanQrButtonText.color = "#F2F2F2"
                    click01.play()
                }

                onReleased: {
                    scanQrButton.color = "transparent"
                    scanQrButton.border.color = maincolor
                    scanQrButtonText.color = maincolor
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
            text: "Changes saved!"
            anchors.top: saveSuccess.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: saveSuccess.horizontalCenter
            color: maincolor
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.bold: true
            visible: editSaved == 1
        }

        Rectangle {
            id: closeSaveEdit
            width: (parent.width - 45) / 2
            height: 33
            radius: 5
            color: "transparent"
            border.color: maincolor
            border.width: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
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
                    closeSaveEdit.color = maincolor
                    click01.play()
                }

                onCanceled: {
                    closeSaveEdit.color = "transparent"
                }

                onReleased: {
                   closeSaveEdit.color = "transparent"
                   addressTracker = 0;
                   timerSave.start()
                }
            }

            Text {
                text: "OK"
                font.family: xciteMobile.name
                font.pointSize: 14
                font.bold: true
                color: "#F2F2F2"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // Delete confirm state

        Rectangle {
            id: deleteConfirmation
            width: parent.width
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            visible: deleteAddressTracker == 1
                     && deleteConfirmed == 0

            Text {
                id: deleteText
                text: "You are about to delete:"
                anchors.top: parent.top
                anchors.topMargin: 60
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
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
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
            }

            Text {
                id: deleteAddressHash
                text: addressHash
                anchors.top: deleteAddressName.bottom
                anchors.topMargin: 7
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
            }

            Rectangle {
                id: confirmationDeleteButton
                width: (doubbleButtonWidth - 10) / 2
                height: 33
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 5
                radius: 5
                color: "#4BBE2E"

                MouseArea {
                    anchors.fill: parent

                    onPressed: { click01.play() }

                    onReleased: {
                        deleteConfirmed = 1
                        addressList.setProperty(addressIndex, "remove", true)
                        doubbleAddress = 0
                        labelExists = 0
                        invalidAddress = 0
                    }
                }

                Text {
                    text: "CONFIRM"
                    font.family: xciteMobile.name
                    font.pointSize: 14
                    color: "#F2F2F2"
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                id: cancelDeleteButton
                width: (doubbleButtonWidth - 10) / 2
                height: 33
                radius: 5
                color: "#E55541"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 5

                MouseArea {
                    anchors.fill: parent

                    onPressed: { click01.play() }

                    onReleased: {
                        deleteAddressTracker = 0
                    }
                }

                Text {
                    text: "CANCEL"
                    font.family: xciteMobile.name
                    font.pointSize: 14
                    font.bold: true
                    color: "#F2F2F2"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // Delete success state

        Image {
            id: deleteSuccess
            source: 'qrc:/icons/icon-delete-mobile.svg'
            height: 100
            width: 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -15
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
            color: maincolor
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.bold: true
            visible: deleteConfirmed == 1
        }

        Rectangle {
            id: closeDelete
            width: (parent.width - 45) / 2
            height: 33
            radius: 5
            color: "transparent"
            border.color: maincolor
            border.width: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
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
                    closeDelete.color = maincolor
                    click01.play()
                }

                onCanceled: {
                    closeDelete.color = "transparent"
                }

                onReleased: {
                   closeDelete.color = "transparent"
                   addressTracker = 0;
                   timerDelete.start()
                }
            }

            Text {
                text: "OK"
                font.family: xciteMobile.name
                font.pointSize: 14
                font.bold: true
                color: "#F2F2F2"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
    Label {
        id: closeAddressModal
        z: 10
        text: "CLOSE"
        anchors.top: addressBodyModal.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: addressBodyModal.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: "#F2F2F2"
        visible: editSaved == 0

        Rectangle{
            id: closeButton
            height: 34
            width: darktheme == false? closeAddressModal.width : doubbleButtonWidth
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
                parent.anchors.topMargin = 14
                click01.play()
            }

            onReleased: {
                parent.anchors.topMargin = 10
                addressTracker = 0;
                timer.start()
            }
        }
    }
}
