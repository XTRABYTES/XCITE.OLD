/**
 * Filename: ContactAddressModal.qml
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
import "qrc:/Controls/+desktop" as Desktop
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: contactAddressModal
    width: parent.width
    height: parent.height
    anchors.horizontalCenter: parent.horizontalCenter
    state: addAddressTracker == 1 || addressTracker == 1? "up" : "down"
    color: bgcolor
    anchors.top: parent.top

    onStateChanged: {
        detectInteraction()

        if (state == "down") {
            addressIndex = -1
            timer.start()
        }
        else {
            oldCoin = addAddressTracker == 0? addressList.get(addressIndex).coin : ""
            oldLabel = addAddressTracker == 0?  addressList.get(addressIndex).label : ""
            oldAddress = addAddressTracker == 0? addressList.get(addressIndex).address : ""
            checkAddress()
        }
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: contactAddressModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: contactAddressModal; anchors.topMargin: contactAddressModal.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: contactAddressModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    property int editSaved: 0
    property int editFailed: 0
    property int invalidAddress: 0
    property int addressExists: 0
    property int labelExists: 0
    property int contact: contactIndex
    property string failError: ""
    property bool myTheme: darktheme
    property string oldCoin
    property string oldLabel
    property string oldAddress
    property int addressCopied: 0


    onMyThemeChanged: {
        if (darktheme) {
            editButton.source = "qrc:/icons/edit_icon_light01.png"
            clipBoard.source= "qrc:/icons/clipboard_icon_light01.png"
        }
        else {
            editButton.source = "qrc:/icons/edit_icon_dark01.png"
            clipBoard.source= "qrc:/icons/clipboard_icon_dark01.png"
        }
    }

    function compareTx(){
        addressExists = 0
        for(var i = 0; i < addressList.count; i++) {
            if (newAddress.text != "") {
                if (addressList.get(i).coin === newCoinName.text && addressList.get(i).address === newAddress.text && addressList.get(i).remove === false && addressList.get(i).uniqueNR !== addressIndex) {
                        addressExists = 1
                }
            }
            else {
                if (addressList.get(i).coin === newCoinName.text && addressList.get(i).address === addressString.text && addressList.get(i).remove === false && addressList.get(i).uniqueNR !== addressIndex) {
                        addressExists = 1
                }
            }
        }
    }

    function compareName(){
        labelExists = 0
        for(var i = 0; i < addressList.count; i++) {
            if (addressList.get(i).contact === contactIndex) {
                if (newName.text != "") {
                    if (addressList.get(i).coin === newCoinName.text && addressList.get(i).label === newName.text && addressList.get(i).remove === false && addressList.get(i).uniqueNR !== addressIndex) {
                            labelExists = 1
                    }
                }
                else {
                    if (addressList.get(i).coin === newCoinName.text && addressList.get(i).label === addressName.text && addressList.get(i).remove === false && addressList.get(i).uniqueNR !== addressIndex) {
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
                if (addressString.text.length == 34 && addressString.text.substring(0,1) == "B") {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
            else if (newCoinName.text == "XFUEL") {
                if (addressString.text.length == 34 && addressString.text.substring(0,1) == "F") {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
            else if (newCoinName.text == "XTEST") {
                if (addressString.text.length == 34 && addressString.text.substring(0,1) == "G") {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
            else if (newCoinName.text == "BTC") {
                if (addressString.text.length > 25 && addressString.text.length < 36 &&(addressString.text.substring(0,1) == "1" || addressString.text.substring(0,1) == "3" || addressString.text.substring(0,3) == "bc1")) {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
            else if (newCoinName.text == "ETH") {
                if (addressString.text.length == 42 && addressString.text.substring(0,2) == "0x") {
                    invalidAddress = 0
                }
                else {
                    invalidAddress = 1
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
    }

    Text {
        id: addressModalLabel
        text: "Address info"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        font.pixelSize: appHeight/27
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        visible: editSaved == 0
                 && editFailed == 0
    }

    Image {
        id: editButton
        source: darktheme == true? "qrc:/icons/edit_icon_light01.png" : "qrc:/icons/edit_icon_dark01.png"
        height: appWidth/48
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: addressModalLabel.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: appWidth/24
        visible: addressTracker == 1 && editAddressTracker == 0

        Rectangle {
            anchors.fill: parent
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    editButton.source = "qrc:/icons/edit_icon_green01.png"
                }

                onExited: {
                    if (darktheme) {
                        editButton.source = "qrc:/icons/edit_icon_light01.png"
                    }
                    else {
                        editButton.source = "qrc:/icons/edit_icon_dark01.png"
                    }
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    editAddressTracker = 1
                }
            }
        }
    }

    Image {
        id: newIcon
        source: newCoinSelect == 1? coinList.get(newCoinPicklist).logo : getLogo(newCoinName.text)
        height: appHeight/18
        fillMode: Image.PreserveAspectFit
        anchors.left: parent.left
        anchors.top: addressModalLabel.bottom
        anchors.topMargin: height/2
        visible: editSaved == 0
                 && editFailed == 0
                 && coinListTracker == 0
                 && scanQRTracker == 0
    }

    Label {
        id: newCoinName
        text: newCoinSelect == 1? coinList.get(newCoinPicklist).name : (addressIndex >= 0? addressList.get(addressIndex).coin : "")
        anchors.left: newIcon.right
        anchors.leftMargin: font.pixelSize/2
        anchors.verticalCenter: newIcon.verticalCenter
        font.pixelSize: appHeight/27
        font.family: xciteMobile.name
        font.letterSpacing: 2
        color: themecolor
        visible: editSaved == 0
                 && editFailed == 0
                 && coinListTracker == 0
                 && scanQRTracker == 0
    }

    Label {
        anchors.fill: newCoinName
        text: newCoinName.text
        visible: false
        onTextChanged: {
            if (newCoinName.text != ""){
                if (addAddressTracker == 1 && newAddress.text != "") {
                    checkAddress()
                }
                else if (addAddressTracker == 0){
                    checkAddress();
                }
                if (newName.text != "" && newName.text != oldLabel) {
                    compareName()
                }
                else if (newName.text == "" && addressName.text != oldLabel) {
                    compareName()
                }
                if (newAddress.text != "" && newAddress.text != oldAddress) {
                    compareTx();
                }
                else if (newAddress.text == "" && addressString.text != oldAddress) {
                    compareTx();
                }
            }
        }
    }

    Image {
        id: picklistArrow
        source: darktheme == true? 'qrc:/icons/mobile/dropdown-icon_01_light.svg' : 'qrc:/icons/mobile/dropdown-icon_01_dark.svg'
        height: appHeight/36
        fillMode: Image.PreserveAspectFit
        anchors.left: newCoinName.right
        anchors.leftMargin: height/2
        anchors.verticalCenter: newCoinName.verticalCenter
        visible: editSaved == 0
                 && editFailed == 0
                 && coinListTracker == 0
                 && scanQRTracker == 0
                 && (editAddressTracker == 1 || addAddressTracker == 1)

        Rectangle {
            id: picklistButton
            height: parent.height
            width: parent.width
            radius: height/2
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

    Label {
        id: addressNameLabel
        text: "Address label:"
        anchors.left: parent.left
        anchors.top: newIcon.bottom
        anchors.topMargin: appHeight/36
        color: themecolor
        font.pixelSize: appHeight/54
        font.family: xciteMobile.name
        opacity: 0.5
        visible: editSaved == 0
                 && editFailed == 0
    }

    Label {
        id: addressName
        text: addressIndex >= 0? addressList.get(addressIndex).label : ""
        anchors.left: parent.left
        anchors.leftMargin: appWidth/9
        anchors.right: parent.right
        anchors.top: addressNameLabel.top
        color: themecolor
        font.pixelSize: appHeight/54
        font.family: xciteMobile.name
        elide: Text.ElideRight
        visible: addAddressTracker == 0 && editAddressTracker == 0
    }

    Controls.TextInput {
        id: newName
        height: appHeight/27
        placeholder: editAddressTracker == 1? addressName.text : "ADDRESS LABEL"
        text: ""
        anchors.left: parent.left
        anchors.leftMargin: appWidth/9
        anchors.right: parent.right
        anchors.verticalCenter: addressNameLabel.verticalCenter
        color: themecolor
        textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
        font.pixelSize: height/2
        visible: editSaved == 0
                 && editFailed == 0
                 && (addAddressTracker == 1 || editAddressTracker == 1)
        mobile: 1
        deleteBtn: 0
        onTextChanged: {
            detectInteraction()
            if(newName.text != "") {
                if (newName.text != oldLabel) {
                    compareName();
                }
            }
        }
    }

    Label {
        id: nameWarning
        text: "Already an address with this label!"
        color: "#FD2E2E"
        anchors.left: newName.left
        anchors.leftMargin: font.pixelSize/2
        anchors.top: newName.bottom
        anchors.topMargin: 1
        font.pixelSize: appHeight/72
        font.family: xciteMobile.name
        visible: editSaved == 0
                 && editFailed == 0
                 && newName.text != ""
                 && labelExists == 1
                 && scanQRTracker == 0
    }

    Label {
        id: addressLabel
        text: "Address:"
        anchors.left: parent.left
        anchors.top: addressNameLabel.bottom
        anchors.topMargin: appHeight/27
        color: themecolor
        font.pixelSize: appHeight/54
        font.family: xciteMobile.name
        opacity: 0.5
        visible: editSaved == 0
                 && editFailed == 0
    }

    Label {
        id: addressString
        text: addressIndex >= 0? addressList.get(addressIndex).address : ""
        anchors.left: parent.left
        anchors.leftMargin: appWidth/9
        anchors.right: clipBoard.left
        anchors.top: addressLabel.top
        color: themecolor
        font.pixelSize: appHeight/54
        font.family: xciteMobile.name
        elide: Text.ElideRight
        visible: addAddressTracker == 0 && editAddressTracker == 0
    }

    Image {
        id: clipBoard
        source: darktheme == true? "qrc:/icons/clipboard_icon_light01.png" : "qrc:/icons/clipboard_icon_dark01.png"
        height: appHeight/27
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: addressString.verticalCenter
        anchors.right: parent.right
        visible: addressString.visible

        Rectangle {
            anchors.fill: parent
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if (copy2clipboard == 0) {
                        copyText2Clipboard(addressString.text)
                        copy2clipboard = 1
                        addressCopied = 1
                        copyTimer.start()
                    }
                }
            }
        }
    }

    DropShadow {
        anchors.fill: textPopup
        source: textPopup
        horizontalOffset: 0
        verticalOffset: 4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.4
        transparentBorder: true
        visible: textPopup.visible
    }

    Item {
        id: textPopup
        width: popupClipboard.width
        height: popupClipboardText.height
        anchors.horizontalCenter: addressString.horizontalCenter
        anchors.verticalCenter: addressString.verticalCenter
        visible: copy2clipboard == 1 && addressCopied == 1 && addressString.visible

        Rectangle {
            id: popupClipboard
            height: appHeight/27
            width: popupClipboardText.width + appHeight/18
            color: "#42454F"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: popupClipboardText
            text: "Address copied!"
            font.family: xciteMobile.name
            font.pointSize: popupClipboard.height/2
            color: "#F2F2F2"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Controls.TextInput {
        id: newAddress
        height: appHeight/27
        placeholder: editAddressTracker == 1? addressString.text : "ADDRESS"
        text: ""
        anchors.left: parent.left
        anchors.leftMargin: appWidth/9
        anchors.right: parent.right
        anchors.verticalCenter: addressLabel.verticalCenter
        color: themecolor
        textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
        font.pixelSize: height/2
        visible: editSaved == 0
                 && editFailed == 0
                 && (addAddressTracker == 1 || editAddressTracker == 1)
        mobile: 1
        deleteBtn: 0
        validator: RegExpValidator { regExp: /[0-9A-Za-z]+/ }
        onTextChanged: {
            detectInteraction()
            if(newAddress.text != ""){
                if(newAddress.text != oldAddress) {
                    checkAddress()
                    compareTx()
                }

            }
        }
    }

    Label {
        id: addressWarning1
        text: "Already a contact for this address!"
        color: "#FD2E2E"
        anchors.left: newAddress.left
        anchors.leftMargin: font.pixelSize/2
        anchors.top: newAddress.bottom
        anchors.topMargin: 1
        font.pixelSize: appHeight/72
        font.family: xciteMobile.name
        visible: editSaved == 0
                 && editFailed == 0
                 && addressExists == 1
                 && newAddress.text != ""
    }

    Label {
        id: addressWarning2
        text: "Invalid address format!"
        color: "#FD2E2E"
        anchors.left: newAddress.left
        anchors.leftMargin: font.pixelSize/2
        anchors.top: newAddress.bottom
        anchors.topMargin: 1
        font.pixelSize: appHeight/72
        font.family: xciteMobile.name
        visible: editSaved == 0
                 && editFailed == 0
                 && invalidAddress == 1
                 && newAddress.text != ""
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
        width: appWidth/6
        height: appHeight/27
        anchors.top: newAddress.bottom
        anchors.topMargin: appHeight/27
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: themecolor
        border.width: 1
        color: "transparent"
        visible: editSaved == 0
                 && editFailed == 0
                 && scanQRTracker == 0
                 && (addAddressTracker == 1 || editAddressTracker == 1)

        Rectangle {
            id: selectQr
            anchors.fill: parent
            color: maincolor
            opacity: 0.3
            visible: false
        }

        Text {
            id: scanButtonText
            text: "SCAN QR"
            font.family: xciteMobile.name
            font.pointSize: parent.height/2
            color: themecolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: scanQrButton
            hoverEnabled: true

            onEntered: {
                selectQr.visible = true
            }

            onExited: {
                selectQr.visible = false
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                //addressExists = 0
                //scanQRTracker = 1
                //scanning = "scanning..."
            }
        }
    }

    Rectangle {
        id: qrPlaceholder1
        width: parent.width/3
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: addAddressTracker == 0 && editAddressTracker == 0? addressLabel.bottom : scanQrButton.bottom
        anchors.topMargin: appHeight/36
        color: "white"
        border.color: themecolor
        border.width: 1
        visible: addAddressTracker == 0 && editAddressTracker == 0

        Image {
            width: parent.width*0.95
            height: parent.height*0.95
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: addressIndex >= 0? "image://QZXing/encode/" + addressList.get(addressIndex).address : undefined
            cache: false
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
                 && editFailed == 0
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
                 && editFailed == 0
                 && scanQRTracker == 0

        Mobile.CoinPicklist {
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
                 && editFailed == 0
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
        width: appWidth/6
        height: appHeight/27
        color: "transparent"
        border.width: 1
        border.color: (invalidAddress == 0
                       && addressExists == 0
                       && labelExists == 0)? (editAddressTracker == 0? ((newName.text == "" || newAddress.text == "")? "#727272" : themecolor) : themecolor) : "#727272"
        anchors.top: scanQrButton.bottom
        anchors.topMargin: appHeight/18
        anchors.horizontalCenter: parent.horizontalCenter
        visible: editSaved == 0
                 && scanQRTracker == 0
                 && editFailed == 0
                 && saveAddressInitiated == false
                 && (addAddressTracker == 1 || editAddressTracker == 1)

        Rectangle {
            id: selectSave
            anchors.fill: parent
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
            anchors.fill: parent
            hoverEnabled: true
            enabled: (invalidAddress == 0
                      && addressExists == 0
                      && labelExists == 0)? (editAddressTracker == 0? ((newName.text == "" || newAddress.text == "")? false : true) : true) : false


            onEntered: {
                selectSave.visible = true
            }

            onExited: {
                selectSave.visible = false
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                if (editAddressTracker == 0) {
                    saveAddressInitiated = true
                    addressList.append({"contact": contactIndex, "fullName": (contactList.get(contactIndex).lastName + contactList.get(contactIndex).fistName),"address": newAddress.text, "label": newName.text, "logo": getLogo(newCoinName.text), "coin": newCoinName.text, "favorite": 0, "active": true, "uniqueNR": addressID, "remove": false});
                    addressID = addressID +1;
                    addingAddress = true
                    updateToAccount()
                }
                else {
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
                if (addAddressTracker == 1 && addingAddress == true) {
                    editSaved = 1
                    coinListTracker = 0
                    addingAddress = false
                    saveAddressInitiated = false
                }
                else if (addressTracker == 1 && editingAddress == true) {
                    editSaved = 1
                    coinListTracker = 0
                    editingAddress = false
                    oldCoin = addressList.get(addressIndex).coin
                    oldLabel = addressList.get(addressIndex).label
                    oldAddress = addressList.get(addressIndex).address
                }
            }

            onSaveFailed: {
                if (addAddressTracker == 1 && addingAddress == true) {
                    addressID = addressID - 1
                    addressList.remove(addressID)
                    editFailed = 1
                    coinListTracker = 0
                    addingAddress = false
                    saveAddressInitiated = false
                }
                else if (addressTracker == 1 && editingAddress == true) {
                    addressList.setProperty(addressIndex, "logo", getLogo(oldCoin));
                    addressList.setProperty(addressIndex, "coin", oldCoin);
                    addressList.setProperty(addressIndex, "label", oldLabel);
                    addressList.setProperty(addressIndex, "address", oldAddress);
                    editFailed = 1
                    coinListTracker = 0
                    editingAddress = false
                }
            }

            onNoInternet: {
                if (addAddressTracker == 1 && addingAddress == true) {
                    networkError = 1
                    addressID = addressID - 1
                    addressList.remove(addressID)
                    editFailed = 1
                    coinListTracker = 0
                    addingAddress = false
                    saveAddressInitiated = false
                }
                else if (addressTracker == 1 && editingAddress == true) {
                    networkError = 1
                    addressList.setProperty(addressIndex, "logo", getLogo(oldCoin));
                    addressList.setProperty(addressIndex, "coin", oldCoin);
                    addressList.setProperty(addressIndex, "label", oldLabel);
                    addressList.setProperty(addressIndex, "address", oldAddress);
                    editFailed = 1
                    coinListTracker = 0
                    editingAddress = false
                }
            }

            onSaveFailedDBError: {
                if (addAddressTracker == 1 && addingAddress == true) {
                    failError = "Database ERROR"
                }
                else if (addressTracker == 1 && editingAddress == true) {
                    failError = "Database ERROR"
                }
            }

            onSaveFailedAPIError: {
                if (addAddressTracker == 1 && addingAddress == true) {
                    failError = "Network ERROR"
                }
                else if (addressTracker == 1 && editingAddress == true) {
                    failError = "Network ERROR"
                }
            }

            onSaveFailedInputError: {
                if (addAddressTracker == 1 && addingAddress == true) {
                    failError = "Input ERROR"
                }
                else if (addressTracker == 1 && editingAddress == true) {
                    failError = "Input ERROR"
                }
            }

            onSaveFailedUnknownError: {
                if (addAddressTracker == 1 && addingAddress == true) {
                    failError = "Unknown ERROR"
                }
                else if (addressTracker == 1 && editingAddress == true) {
                    failError = "Unknown ERROR"
                }
            }
        }
    }

    AnimatedImage {
        id: waitingDots2
        source: 'qrc:/gifs/loading-gif_01.gif'
        width: 90
        height: 60
        anchors.horizontalCenter: saveButton.horizontalCenter
        anchors.verticalCenter: saveButton.verticalCenter
        playing: saveAddressInitiated == true
        visible: editSaved == 0
                 && scanQRTracker == 0
                 && editFailed == 0
                 && (saveAddressInitiated == true || editingAddress == true)
    }

    Rectangle {
        id: backButton
        width: appWidth/6
        height: appHeight/27
        color: "transparent"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: appHeight/27
        anchors.horizontalCenter: parent.horizontalCenter
        border.width: 1
        border.color: (addingAddress == false && editingAddress == false)? themecolor : "#727272"
        visible: editSaved == 0
                 && editFailed == 0

        Rectangle {
            id: selectBack
            anchors.fill: parent
            color: maincolor
            opacity: 0.3
            visible: false
        }

        Text {
            text: editAddressTracker == 1? "CLOSE EDIT" : "BACK"
            font.family: xciteMobile.name
            font.pointSize: parent.height/2
            color: parent.border.color
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            enabled: addingAddress == false && editingAddress == false

            onEntered: {
                selectBack.visible = true
            }

            onExited: {
                selectBack.visible = false
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                if (editAddressTracker == 1 || addAddressTracker == 1) {
                    addAddressTracker = 0
                    editAddressTracker = 0
                }
                else {
                    addressTracker = 0
                }
            }
        }
    }

    // save failed state
    Rectangle {
        id: addAddressFailed
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
            text: "Failed to save your address!"
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
            color: "transparent"
            anchors.top: saveFailedError.bottom
            anchors.topMargin: appHeight/18
            anchors.horizontalCenter: parent.horizontalCenter
            border.width: 1
            border.color: maincolor

            Rectangle {
                id: selectCloseFail
                anchors.fill: parent
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                text: "TRY AGAIN"
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
                    editFailed = 0
                    failError = ""
                }
            }
        }
    }

    // save success state

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
            color: "transparent"
            anchors.top: saveSuccessLabel.bottom
            anchors.topMargin: appHeight/18
            anchors.horizontalCenter: parent.horizontalCenter
            border.width: 1
            border.color: maincolor

            Rectangle {
                id: selectCloseSave
                anchors.fill: parent
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
                    editAddressTracker = 0;
                    editSaved = 0;
                    if (addAddressTracker == 1) {
                        addAddressTracker = 0;
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
                        addressCopied = 0
                        copy2clipboard = 0
                        closeAllClipboard = true
                    }
                }
            }
        }
    }

    Timer {
        id: copyTimer
        interval: 2000
        repeat: false
        running: false

        onTriggered: {
            addressCopied = 0
            copy2clipboard = 0
            closeAllClipboard = true
        }
    }

    Timer {
        id: timer
        interval: 300
        repeat: false
        running: false

        onTriggered: {
            editAddressTracker = 0;
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
            addressCopied = 0
            copy2clipboard = 0
            closeAllClipboard = true
        }
    }
}
