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
    color: bgcolor
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
            NumberAnimation { target: addressModal; property: "anchors.topMargin"; duration: 400; easing.type: Easing.InOutCubic}
        }
    ]

    onStateChanged: {
        if (addressModal.state === "up") {
            oldCoinName = addressList.get(addressIndex).coin
            oldLogo = getLogo(oldCoinName)
            oldAddressName = addressList.get(addressIndex).label
            oldAddressHash = addressList.get(addressIndex).address
            oldFavorite = addressList.get(addressIndex).favorite
            oldRemove = addressList.get(addressIndex).remove
        }
        else {
            oldAddressName = ""
            oldAddressHash = ""
        }
        newName.text = oldAddressName
        newAddress.text = oldAddressHash
    }

    property string coinName: addressList.get(addressIndex).coin
    property string addressHash: addressList.get(addressIndex).address
    property string addressName: addressList.get(addressIndex).label
    property int contact: addressList.get(addressIndex).contact
    property int deleteAddressTracker: 0
    property int editSaved: 0
    property int editFailed: 0
    property bool editingAddress: false
    property bool deletingAddress: false
    property int deleteConfirmed: 0
    property int deleteFailed: 0
    property int favoriteChanged: 0
    property int invalidAddress: 0
    property int doubleAddress: 0
    property int labelExists: 0
    property string oldCoinName
    property url oldLogo
    property string oldAddressHash
    property string oldAddressName
    property bool oldRemove
    property int oldFavorite
    property int newFavorite
    property string failError: ""

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
        else {
            if (newCoinName.text == "XBY") {
                if (newAddress.placeholder.length == 34 && (newAddress.text.substring(0,1) == "B")) {
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
            else if (newCoinName.text == "XTEST") {
                if (newAddress.placeholder.length == 34 && newAddress.placeholder.substring(0,1) == "G") {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
            else if (newCoinName.text == "BTC") {
                if (newAddress.placeholder.length > 25 && newAddress.placeholder.length < 36 &&(newAddress.placeholder.substring(0,1) == "1" || newAddress.placeholder.substring(0,1) == "3" || newAddress.placeholder.substring(0,3) == "bc1")) {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
            else if (newCoinName.text == "ETH") {
                if (newAddress.placeholder.length == 42 && newAddress.placeholder.substring(0,2) == "0x") {
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
        contentHeight: (editSaved == 0 && deleteAddressTracker == 0 && editFailed == 0)? addressScrollArea.height + 125 : scrollArea.height + 125
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
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteAddressTracker == 0
        }

        Image {
            id: favoriteAddressIcon
            source: addressList.get(addressIndex).favorite === 1 ? 'qrc:/icons/mobile/favorite-icon_01_color.svg' : (darktheme === true? 'qrc:/icons/mobile/favorite-icon_01_light.svg' : 'qrc:/icons/mobile/favorite-icon_01_dark.svg')
            width: 25
            height: 25
            anchors.verticalCenter: addressNameLabel.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 28
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteAddressTracker == 0

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    favoriteChanged = 1
                    if (addressList.get(addressIndex).favorite === 1 || newFavorite == 1) {
                        newFavorite = 0
                    }
                    else {
                        newFavorite = 1
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
                     && editFailed == 0
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
                     && editFailed == 0
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
                    && invalidAddress == 0) ? maincolor : "#727272"
            opacity: 0.25
            anchors.top: scanQrButton.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteAddressTracker == 0
                     && editingAddress == false

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
                            && invalidAddress == 0) {
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
                        if (favoriteChanged == 1) {
                            addressList.setProperty(addressIndex, "favorite", newFavorite);
                        }
                        editingAddress = true

                        var datamodel = []
                        for (var i = 0; i < addressList.count; ++i)
                            datamodel.push(addressList.get(i))

                        var addressListJson = JSON.stringify(datamodel)

                        saveAddressBook(addressListJson)




                    }
                }
            }

            Connections {
                target: UserSettings

                onSaveSucceeded: {
                    if (addressTracker == 1 && editingAddress == true) {
                        editSaved = 1
                        coinListTracker = 0
                        editingAddress = false
                    }
                }

                onSaveFailed: {
                    if (addressTracker == 1 && editingAddress == true) {

                        addressList.setProperty(addressIndex, "logo", oldLogo);
                        addressList.setProperty(addressIndex, "coin", oldCoinName);
                        addressList.setProperty(addressIndex, "label", oldAddressName);
                        addressList.setProperty(addressIndex, "address", oldAddressHash);
                        addressList.setProperty(addressIndex, "favorite", oldFavorite);
                        editFailed = 1
                        coinListTracker = 0
                        editingAddress = false
                    }
                }

                onSaveFailedDBError: {
                    if (addressTracker == 1 && editingAddress == true) {
                        failError = "Database ERROR"
                    }
                }

                onSaveFailedAPIError: {
                    if (addressTracker == 1 && editingAddress == true) {
                        failError = "Network ERROR"
                    }
                }

                onSaveFailedInputError: {
                    if (addressTracker == 1 && editingAddress == true) {
                        failError = "Input ERROR"
                    }
                }

                onSaveFailedUnknownError: {
                    if (addressTracker == 1 && editingAddress == true) {
                        failError = "Unknown ERROR"
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
                    && invalidAddress == 0) ? (darktheme == true? "#F2F2F2" : maincolor) : "#979797"
            anchors.horizontalCenter: saveEditButton.horizontalCenter
            anchors.verticalCenter: saveEditButton.verticalCenter
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteAddressTracker == 0
                     && editingAddress == false
        }

        Rectangle {
            width: saveEditButton.width
            height: 34
            color: "transparent"
            border.color: (doubleAddress == 0
                           && labelExists == 0
                           && invalidAddress == 0) ? maincolor : "#727272"
            border.width: 1
            opacity: 0.25
            anchors.bottom: saveEditButton.bottom
            anchors.horizontalCenter: saveEditButton.horizontalCenter
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteAddressTracker == 0
                     && editingAddress == false
        }

        AnimatedImage  {
            id: waitingDots
            source: 'qrc:/gifs/loading-gif_01.gif'
            width: 90
            height: 60
            anchors.horizontalCenter: saveEditButton.horizontalCenter
            anchors.verticalCenter: saveEditButton.verticalCenter
            playing: editingAddress == true
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteAddressTracker == 0
                     && editingAddress == true
        }

        Image {
            id: picklistArrow1
            source: darktheme == true? 'qrc:/icons/mobile/dropdown-icon_01_light.svg' : 'qrc:/icons/mobile/dropdown-icon_01_dark.svg'
            height: 20
            width: 20
            anchors.left: coinListTracker == 0 ? newCoinName.right : newPicklist1.right
            anchors.leftMargin: 10
            anchors.verticalCenter: newCoinName.verticalCenter
            visible: editSaved == 0
                     && editFailed == 0
                     && coinListTracker == 0
                     && deleteAddressTracker == 0
                     && contact != 0

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

        Image {
            id: deleteAddress
            source: darktheme == true? 'qrc:/icons/mobile/trash-icon_01_light.svg' : 'qrc:/icons/mobile/trash-icon_01_dark.svg'
            height: 25
            width: 25
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: saveEditButton.bottom
            anchors.topMargin: 40
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteAddressTracker == 0
                     && contact != 0

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
                    detectInteraction()
                }

                onClicked: {
                    deleteAddressTracker = 1
                }
            }
        }

        Controls.TextInput {
            id: newName
            z: 1.2
            text: ""
            height: 34
            placeholder: addressName
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.right: parent.right
            anchors.rightMargin: 28
            anchors.top: newIcon.bottom
            anchors.topMargin: 25
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            readOnly: contact == 0
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteAddressTracker == 0
            mobile: 1
            onTextChanged: {
                detectInteraction()
                compareName()
            }
        }

        Label {
            id: nameWarning
            z: 1.1
            text: "Already an address with this label for this contact!"
            color: "#FD2E2E"
            anchors.left: newName.left
            anchors.leftMargin: 5
            anchors.top: newName.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: xciteMobile.name
            visible: editSaved == 0
                     && editFailed == 0
                     && labelExists == 1
                     && deleteAddressTracker == 0
        }

        Controls.TextInput {
            id: newAddress
            z: 1.1
            text: ""
            height: 34
            width: newName.width
            placeholder: addressHash
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newName.bottom
            anchors.topMargin: 15
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            readOnly: contact == 0
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteAddressTracker == 0
            mobile: 1
            validator: RegExpValidator { regExp: /[0-9A-Za-z]+/ }
            onTextChanged: {
                checkAddress()
                compareTx()
                detectInteraction()
            }
        }

        Label {
            id: addressWarning1
            z: 1
            text: "Already a contact for this address!"
            color: "#FD2E2E"
            anchors.left: newAddress.left
            anchors.leftMargin: 5
            anchors.top: newAddress.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: xciteMobile.name
            visible: editSaved == 0
                     && editFailed == 0
                     && doubleAddress == 1
                     && deleteAddressTracker == 0
        }

        Label {
            id: addressWarning2
            z: 1
            text: "Invalid address!"
            color: "#FD2E2E"
            anchors.left: newAddress.left
            anchors.leftMargin: 5
            anchors.top: newAddress.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: xciteMobile.name
            visible: editSaved == 0
                     && editFailed == 0
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
            z: 1
            width: newAddress.width
            height: 34
            anchors.top: newAddress.bottom
            anchors.topMargin: 15
            anchors.left: newAddress.left
            border.color: maincolor
            border.width: 1
            color: "transparent"
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteAddressTracker == 0

            MouseArea {
                anchors.fill: scanQrButton

                onPressed: {
                    click01.play()
                    border.color = darktheme == true? "#F2F2F2" : "#2A2C31"
                    detectInteraction()
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
            z: 1
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
                     && editFailed == 0
                     && deleteAddressTracker == 0
        }

        Rectangle {
            id: newPicklist1
            z: 1
            width: 100
            height: ((totalLines + 1) * 35)-10
            radius: 4
            color: "#2A2C31"
            anchors.top: newIcon.top
            anchors.topMargin: -5
            anchors.left: newIcon.left
            visible: coinListTracker == 1
                     && editSaved == 0
                     && editFailed == 0
                     && deleteAddressTracker == 0

            Controls.CoinPicklist {
                id: myCoinPicklist
            }
        }

        Rectangle {
            id: picklistClose1
            z: 1
            width: 100
            height: 25
            radius: 4
            color: "#2A2C31"
            anchors.bottom: newPicklist1.bottom
            anchors.horizontalCenter: newPicklist1.horizontalCenter
            visible: coinListTracker == 1
                     && editSaved == 0
                     && editFailed == 0
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

                onPressed: {
                    detectInteraction()
                }

                onClicked: {
                    coinListTracker = 0
                }
            }
        }

        // Edit failed state
        Controls.ReplyModal {
            id: editAddressFailed
            modalHeight: saveFailed.height + saveFailedLabel.height + saveFailedError.height + closeFail.height + 85
            visible: editFailed == 1

            Image {
                id: saveFailed
                source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
                height: 75
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: editAddressFailed.modalTop
                anchors.topMargin: 20
            }

            Label {
                id: saveFailedLabel
                text: "Failed to edit your address!"
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
                        editFailed = 0
                    }
                }
            }

            Text {
                text: "TRY AGAIN"
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

        // Edit saved state
        Controls.ReplyModal {
            id: editAddressSucceed
            modalHeight: saveSuccess.height + saveSuccessLabel.height + closeSaveEdit.height + 75
            visible: editSaved == 1

            Image {
                id: saveSuccess
                source: darktheme == true? 'qrc:/icons/mobile/succes_icon_01_light.svg' : 'qrc:/icons/mobile/succes_icon_01_dark.svg'
                height: 75
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: editAddressSucceed.modalTop
                anchors.topMargin: 20
                visible: editSaved == 1
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
                anchors.topMargin: 25
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
                            editFailed = 0
                            favoriteChanged = 0
                            deleteAddressTracker = 0
                            deleteConfirmed = 0
                            scanQRTracker = 0
                            selectedAddress = ""
                            scanning = "scanning..."
                            closeAllClipboard = true
                        }
                    }

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
        }

        // Delete confirm state

        Controls.ReplyModal {
            id: deleteConfirmation
            modalHeight: deleteText.height + deleteAddressName.height + deleteAddressHash.height + confirmationDeleteButton.height + 79
            visible: deleteAddressTracker == 1
                     && deleteConfirmed == 0
                     && deleteFailed == 0
            Text {
                id: deleteText
                text: "You are about to delete:"
                anchors.top: deleteConfirmation.modalTop
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Text {
                id: deleteAddressName
                text: addressName + " (" + coinName + ")"
                width: doubbleButtonWidth - 20
                wrapMode: Text.Wrap
                maximumLineCount: 2
                horizontalAlignment: Text.AlignHCenter
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
                width: doubbleButtonWidth - 20
                wrapMode: Text.WrapAnywhere
                maximumLineCount: 2
                anchors.top: deleteAddressName.bottom
                anchors.topMargin: 7
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Rectangle {
                id: confirmationDeleteButton
                width: (doubbleButtonWidth - 30) / 2
                height: 34
                anchors.top: deleteAddressHash.bottom
                anchors.topMargin: 25
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 5
                color: "#4BBE2E"
                opacity: 0.25
                visible: deletingAddress == false

                MouseArea {
                    anchors.fill: parent

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
                        deleteConfirmed = 1

                        addressList.setProperty(addressIndex, "remove", true)
                        doubleAddress = 0
                        labelExists = 0
                        invalidAddress = 0
                        deletingAddress = true

                        var datamodel = []
                        for (var i = 0; i < addressList.count; ++i)
                            datamodel.push(addressList.get(i))

                        var addressListJson = JSON.stringify(datamodel)

                        saveAddressBook(addressListJson)
                    }
                }

                Connections {
                    target: UserSettings

                    onSaveSucceeded: {
                        if (addressTracker == 1 && deletingAddress == true) {
                            deleteConfirmed = 1
                            coinListTracker = 0
                            deletingAddress = false
                        }
                    }

                    onSaveFailed: {
                        if (addressTracker == 1 && deletingAddress == true) {

                            addressList.setProperty(addressIndex, "remove", oldRemove);
                            deleteFailed = 1
                            coinListTracker = 0
                            deletingAddress = false
                        }
                    }

                    onSaveFailedDBError: {
                        if (addressTracker == 1 && deletingAddress == true) {
                            failError = "Database ERROR"
                        }
                    }

                    onSaveFailedAPIError: {
                        if (addressTracker == 1 && deletingAddress == true) {
                            failError = "Network ERROR"
                        }
                    }

                    onSaveFailedInputError: {
                        if (addressTracker == 1 && deletingAddress == true) {
                            failError = "Input ERROR"
                        }
                    }

                    onSaveFailedUnknownError: {
                        if (addressTracker == 1 && deletingAddress == true) {
                            failError = "Unknown ERROR"
                        }
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
                visible: deletingAddress == false
            }

            Rectangle {
                width: (doubbleButtonWidth - 30) / 2
                height: 34
                anchors.top: deleteAddressHash.bottom
                anchors.topMargin: 25
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 5
                color: "transparent"
                border.color: "#4BBE2E"
                border.width: 1
                visible: deletingAddress == false
            }

            Rectangle {
                id: cancelDeleteButton
                width: (doubbleButtonWidth - 30) / 2
                height: 34
                anchors.top: deleteAddressHash.bottom
                anchors.topMargin: 25
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 5
                color: "#E55541"
                opacity: 0.25
                visible: deletingAddress == false

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        parent.opacity = 0.5
                        detectInteraction()
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
                visible: deletingAddress == false
            }

            Rectangle {
                width: (doubbleButtonWidth - 30) / 2
                height: 34
                anchors.top: deleteAddressHash.bottom
                anchors.topMargin: 25
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 5
                color: "transparent"
                border.color: "#E55541"
                border.width: 1
                visible: deletingAddress == false
            }

            AnimatedImage  {
                id: waitingDots2
                source: 'qrc:/gifs/loading-gif_01.gif'
                width: 90
                height: 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: confirmationDeleteButton.verticalCenter
                playing: deletingAddress == true
                visible: deletingAddress == true
            }
        }

        // Delete failed state
        Controls.ReplyModal {
            id: deleteAddressFailed
            modalHeight: failedIcon.height + deleteFailedLabel.height + deleteFailedError.height + closeDeleteFail.height + 85
            visible: deleteFailed == 1

            Image {
                id: failedIcon
                source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
                height: 75
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: deleteAddressFailed.modalTop
                anchors.topMargin: 20
            }

            Label {
                id: deleteFailedLabel
                text: "Failed to delete your address!"
                anchors.top: failedIcon.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: failedIcon.horizontalCenter
                color: maincolor
                font.pixelSize: 14
                font.family: "Brandon Grotesque"
                font.bold: true
            }

            Label {
                id: deleteFailedError
                text: failError
                anchors.top: deleteFailedLabel.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: failedIcon.horizontalCenter
                color: maincolor
                font.pixelSize: 14
                font.family: "Brandon Grotesque"
                font.bold: true
            }

            Rectangle {
                id: closeDeleteFail
                width: doubbleButtonWidth / 2
                height: 34
                color: maincolor
                opacity: 0.25
                anchors.top: deleteFailedError.bottom
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        deleteAddressTracker = 0
                        deleteFailed = 0
                        failError = ""
                    }
                }
            }

            Text {
                text: "TRY AGAIN"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#F2F2F2"
                anchors.horizontalCenter: closeDeleteFail.horizontalCenter
                anchors.verticalCenter: closeDeleteFail.verticalCenter
            }

            Rectangle {
                width: doubbleButtonWidth / 2
                height: 34
                anchors.bottom: closeDeleteFail.bottom
                anchors.left: closeDeleteFail.left
                color: "transparent"
                opacity: 0.5
                border.color: maincolor
                border.width: 1
            }
        }

        // Delete success state

        Controls.ReplyModal {
            id: deleteAddressSucceed
            modalHeight: deleteSuccess.height + deleteSuccessLabel.height + closeDelete.height + 75
            visible: deleteConfirmed == 1

            Image {
                id: deleteSuccess
                source: darktheme == true? 'qrc:/icons/mobile/delete_address-icon_01_light.svg' : 'qrc:/icons/mobile/delete_address-icon_01_dark.svg'
                height: 75
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: deleteAddressSucceed.modalTop
                anchors.topMargin: 20
                visible: deleteConfirmed == 1
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
                anchors.topMargin: 25
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
                            newName.text = oldAddressName
                            newAddress.text = oldAddressHash
                            invalidAddress = 0
                            editSaved = 0
                            deleteAddressTracker = 0
                            deleteConfirmed = 0
                            scanQRTracker = 0
                            selectedAddress = ""
                            scanning = "scanning..."
                            closeAllClipboard = true
                        }
                    }

                    onPressed: {
                        closeDelete.opacity = 0.5
                        click01.play()
                        detectInteraction()
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
        id: closeAddressModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : 70
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: editSaved == 0 && editFailed == 0 && deleteAddressTracker == 0

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
                    newName.text = oldAddressName
                    newAddress.text = oldAddressHash
                    invalidAddress = 0
                    editSaved = 0
                    deleteAddressTracker = 0
                    deleteConfirmed = 0
                    scanQRTracker = 0
                    selectedAddress = ""
                    scanning = "scanning..."
                    closeAllClipboard = true
                }
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onReleased: {
                addressTracker = 0;
                timer.start()
            }
        }
    }
}
