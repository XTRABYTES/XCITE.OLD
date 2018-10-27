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

import "qrc:/Controls" as Controls

Rectangle {
    id: addAddressModal
    width: 325
    height: (editSaved == 1)? 350 : 285
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 50


    property int editSaved: 0
    property int invalidAddress: 0
    property int addressExists: compareTx()
    property int labelExists: compareName()

    function compareTx(){
        var duplicateAddress = 0
        for(var i = 0; i < addressList.count; i++) {
            if (addressList.get(i).coin === newCoinName.text) {
                if (addressList.get(i).address === newAddress.text) {
                    duplicateAddress = 1
                }
            }
        }
        return duplicateAddress
    }

    function compareName(){
        var duplicateName = 0
        for(var i = 0; i < addressList.count; i++) {
            if (addressList.get(i).coin === newCoinName.text) {
                if (addressList.get(i).name === newName.text) {
                    duplicateName = 1
                }
            }
        }
        return duplicateName
    }

    function checkAddress() {
        if (newName.text == "XBY" || newName.text == "BTC") {
            if (newAddress.length === 34
                    && newAddress.text !== ""
                    && newAddress.text.substring(0,1) == "B") {
                invalidAddress = 0
            }
            else {
                invalidAddress = 1
            }
        }
        else if (newName.text == "XFUEL") {
            if (newAddress.length === 34
                    && newAddress.text !== ""
                    && newAddress.text.substring(0,1) == "F") {
                invalidAddress = 0
            }
            else {
                invalidAddress = 1
            }
        }
        else {
            invalidAddress = 0
        }
    }

    Rectangle {
        id: addressTitleBar
        width: parent.width
        height: 50
        radius: 4
        anchors.top: parent.top
        anchors.left: parent.left
        color: "#34363D"
        visible: editSaved == 0

        Text {
            id: transferModalLabel
            text: "ADD NEW ADDRESS"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -3
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            color: "#F2F2F2"
            font.letterSpacing: 2
        }
    }

    Rectangle {
        id: addressBodyModal
        width: parent.width
        height: parent.height - 50
        radius: 4
        color: "#42454F"
        anchors.top: parent.top
        anchors.topMargin: 46
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: newIcon
            source: newCoinSelect == 1? currencyList.get(newCoinPicklist).logo : currencyList.get(0).logo
            height: 25
            width: 25
            anchors.left: newName.left
            anchors.top: parent.top
            anchors.topMargin: 20
            visible: editSaved == 0 && picklistTracker == 0
        }

        Label {
            id: newCoinName
            text: newCoinSelect == 1? currencyList.get(newCoinPicklist).name : currencyList.get(0).name
            anchors.left: newIcon.right
            anchors.leftMargin: 7
            anchors.verticalCenter: newIcon.verticalCenter
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: "#F2F2F2"
            visible: editSaved == 0 && picklistTracker == 0
            onTextChanged: if (newAddress.text != "") {
                               checkAddress()
                           }
        }

        Image {
            id: picklistArrow
            source: 'qrc:/icons/dropdown_icon.svg'
            height: 20
            width: 20
            anchors.left: picklistTracker == 0 ? newCoinName.right : newPicklist.right
            anchors.leftMargin: 10
            anchors.verticalCenter: newCoinName.verticalCenter
            rotation: picklistTracker == 0 ? 0 : 180
            visible: editSaved == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: "#F2F2F2"
            }

            Rectangle {
                id: picklistButton
                height: 20
                width: 20
                radius: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                visible: picklistTracker == 0
            }

            MouseArea {
                anchors.fill: picklistButton
                onClicked: {
                    if (picklistTracker == 0) {
                        picklistTracker = 1
                    }
                    else {
                        picklistTracker = 0
                    }
                }
            }
        }

        Controls.TextInput {
            id: newName
            height: 34
            placeholder: "CONTACT NAME"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newIcon.bottom
            anchors.topMargin: 25
            color: newName.text != "" ? "#F2F2F2" : "#727272"
            font.pixelSize: 14
            visible: editSaved == 0
            mobile: 1
        }

        Label {
            id: nameWarning
            text: "Already a contact with this name!"
            color: "#FD2E2E"
            anchors.left: newName.left
            anchors.leftMargin: 5
            anchors.top: newName.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.weight: Font.Normal
            visible: editSaved == 0 && labelExists == 1
        }
        /**
        Controls.TextInput {
            id: newLabel
            height: 34
            // radius: 8
            placeholder: "WALLET LABEL"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newName.bottom
            anchors.topMargin: 15
            color: newLabel.text != "" ? "#F2F2F2" : "#727272"
            font.pixelSize: 14
            visible: editSaved == 0
            mobile: 1
        }

        Label {
            id: labelWarning2
            text: "Please fill out this field"
            color: "#FD2E2E"
            anchors.left: newLabel.left
            anchors.leftMargin: 5
            anchors.top: newLabel.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.weight: Font.Normal
            visible: editSaved == 0 && warningEmpty == 1 && newLabel.text == ""
        }
        */
        Controls.TextInput {
            id: newAddress
            height: 34
            placeholder: "PUBLIC KEY"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newName.bottom
            anchors.topMargin: 15
            color: newAddress.text != "" ? "#F2F2F2" : "#727272"
            font.pixelSize: 14
            visible: editSaved == 0
            mobile: 1
            onTextChanged: checkAddress()
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
            visible: editSaved == 0 && addressExists == 1
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
            visible: editSaved == 0 && invalidAddress == 1
        }

        Rectangle {
            id: newPicklist
            width: 100
            height: totalLines * 35
            color: "#2A2C31"
            anchors.top: newIcon.top
            anchors.topMargin: -5
            anchors.left: newIcon.left
            visible: picklistTracker == 1 && editSaved == 0

            Controls.CurrencyPicklist {
                id: myCoinPicklist
            }
        }

        Rectangle {
            id: saveButton
            width: newAddress.width
            height: 33
            radius: 8
            border.color: (newName.text != "" && newAddress.text !== "" && invalidAddress == 0 && addressExists == 0 && labelExists == 0) ? "#5E8BFF" : "#727272"
            border.width: 2
            color: "transparent"
            anchors.bottom: addressBodyModal.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 0

            MouseArea {
                anchors.fill: saveButton

                onClicked: {
                    if (newName.text != "" && newAddress.text != "" && invalidAddress == 0 && addressExists == 0 && labelExists == 0) {
                        if (newCoinSelect == 1) {
                            addressList.append({"address": newAddress.text, "name": newName.text, /**"label": newLabel.text,*/ "logo": currencyList.get(newCoinPicklist).logo, "coin": newCoinName.text, "favorite": 0, "active": 1, "uniqueNR": addressID});
                            addressID = addressID +1;
                            editSaved = 1
                        }
                        else {
                            addressList.append({"address": newAddress.text, "name": newName.text, /**"label": newLabel.text,*/ "logo": currencyList.get(0).logo, "coin": newCoinName.text, "favorite": 0, "active": 1, "uniqueNR": addressID});
                            addressID = addressID +1;
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
                color: newName.text != "" && (newAddress.text !== "" && invalidAddress == 0 && addressExists == 0 && labelExists == 0) ? "#5E8BFF" : "#727272"
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
                color: "#5E8BFF"
            }
        }

        Rectangle {
            id: closeSave
            width: (parent.width - 45) / 2
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 1

            MouseArea {
                anchors.fill: closeSave

                onClicked: {
                    addAddressTracker = 0;
                    editSaved = 0;
                    picklistTracker = 0
                    newCoinPicklist = 0
                    newCoinSelect = 0
                    newName.text = ""
                    //newLabel.text = ""
                    newAddress.text = ""
                    invalidAddress = 0
                }
            }
            Text {
                text: "OK"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
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
        anchors.topMargin: 10
        anchors.horizontalCenter: addressBodyModal.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: "#F2F2F2"
        visible: addAddressTracker == 1 && editSaved == 0

        Rectangle{
            id: closeButton
            anchors.fill: parent
            color: "transparent"
        }

        MouseArea {
            anchors.fill: closeButton

            onClicked: {
                if (addAddressTracker == 1) {
                    addAddressTracker = 0;
                    picklistTracker = 0
                    newCoinPicklist = 0
                    newCoinSelect = 0
                   newName.text = ""
                    //newLabel.text = ""
                    newAddress.text = ""
                    invalidAddress = 0
                }

            }
        }
    }
}


