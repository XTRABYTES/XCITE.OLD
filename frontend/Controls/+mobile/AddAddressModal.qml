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
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0

import "qrc:/Controls" as Controls

Rectangle {
    id: addAddressModal
    width: 325
    height: (editSaved == 1)? 230 : 360
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 50


    property int editSaved: 0
    property int warningEmpty: 0
    property int doubbleAddress: 0
    property int doubbleLabel: 0
    property int addressExists: compareTx()
    property int labelExists: compareLabel()

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

    function compareLabel(){
        var duplicateLabel = 0
        for(var i = 0; i < addressList.count; i++) {
            if (addressList.get(i).coin === newCoinName.text) {
                if (addressList.get(i).name === newName.text) {
                    if (addressList.get(i).label === newLabel.text) {
                        duplicateLabel = 1
                    }
                }
            }
        }
        return duplicateLabel
    }



    Rectangle {
        id: addressTitleBar
        width: parent.width
        height: 50
        radius: 4
        anchors.top: parent.top
        anchors.left: parent.left
        color: "#34363D"

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
            anchors.leftMargin: 10
            anchors.verticalCenter: newIcon.verticalCenter
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: "#F2F2F2"
            visible: editSaved == 0 && picklistTracker == 0
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
            text: "Please fill out this field"
            color: "#FD2E2E"
            anchors.left: newName.left
            anchors.leftMargin: 5
            anchors.top: newName.bottom
            anchors.topMargin: 10
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.weight: Font.Normal
            visible: editSaved == 0 && doubbleAddress == 1 && nameWarning.text === ""
        }

        Controls.TextInput {
            id: newLabel
            height: 34
            // radius: 8
            placeholder: "WALLET LABEL"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newName.bottom
            anchors.topMargin: 25
            color: newLabel.text != "" ? "#F2F2F2" : "#727272"
            font.pixelSize: 14
            visible: editSaved == 0
            mobile: 1
        }

        Label {
            id: labelWarning1
            text: "Label already exists!"
            color: "#FD2E2E"
            anchors.left: newLabel.left
            anchors.leftMargin: 10
            anchors.top: newLabel.bottom
            anchors.topMargin: 5
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.weight: Font.Normal
            visible: editSaved == 0 && doubbleLabel == 1
        }

        Label {
            id: labelWarning2
            text: "Please fill out this field"
            color: "#FD2E2E"
            anchors.left: newLabel.left
            anchors.leftMargin: 10
            anchors.top: newLabel.bottom
            anchors.topMargin: 5
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.weight: Font.Normal
            visible: editSaved == 0 && warningEmpty == 1 && labelWarning2 === ""
        }

        Controls.TextInput {
            id: newAddress
            height: 34
            // radius: 8
            placeholder: "PUBLIC KEY"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newLabel.bottom
            anchors.topMargin: 25
            color: newAddress.text != "" ? "#F2F2F2" : "#727272"
            font.pixelSize: 14
            visible: editSaved == 0
            mobile: 1
        }

        Label {
            id: addressWarning1
            text: "Already a contact for this address!"
            color: "#FD2E2E"
            anchors.left: newAddress.left
            anchors.leftMargin: 5
            anchors.top: newAddress.bottom
            anchors.topMargin: 10
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.weight: Font.Normal
            visible: editSaved == 0 && doubbleAddress == 1
        }

        Label {
            id: addressWarning2
            text: "Please fill out this field"
            color: "#FD2E2E"
            anchors.left: newAddress.left
            anchors.leftMargin: 5
            anchors.top: newAddress.bottom
            anchors.topMargin: 10
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.weight: Font.Normal
            visible: editSaved == 0 && doubbleAddress == 1 && addressWarning2.text === ""
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
            id: saveEditButton
            width: newAddress.width
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: newAddress.bottom
            anchors.topMargin: 35
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 0

            MouseArea {
                anchors.fill: saveEditButton

                onClicked: {
                    if (newName.text != "" && newLabel.text != "" && newAddress.text != "") {
                        warningEmpty = 0
                        if (addressExists == 0) {
                            doubbleAddress = 0
                            if (labelExists == 0) {
                                doubbleLabel = 0
                                editSaved = 1
                                if (newCoinSelect == 1) {
                                    addressList.append({"address": newAddress.text, "name": newName.text, "label": newLabel.text, "logo": currencyList.get(newCoinPicklist).logo, "coin": newCoinName.text, "favorite": 0, "active": 1, "uniqueNR": addressID});
                                    addressID = addressID +1;
                                }
                                else {
                                    addressList.append({"address": newAddress.text, "name": newName.text, "label": newLabel.text, "logo": currencyList.get(0).logo, "coin": newCoinName.text, "favorite": 0, "active": 1, "uniqueNR": addressID});
                                    addressID = addressID +1;
                                }
                            }
                            else {
                                doubbleLabel = 1
                            }
                        }
                        else {
                            doubbleAddress = 1
                        }
                    }
                    else {
                        warningEmpty = 1
                    }
                }
            }

            Text {
                text: "SAVE"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Text {
            id: saveSuccess
            text: "You have succesfully added a new address!"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.weight: Font.Medium
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -15
            visible: editSaved == 1
        }

        Rectangle {
            id: closeSaveEdit
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
                anchors.fill: closeSaveEdit

                onClicked: {
                    addAddressTracker = 0;
                    editSaved = 0;
                    picklistTracker = 0
                    newCoinPicklist = 0
                    newCoinSelect = 0
                    newName.text = ""
                    newLabel.text = ""
                    newAddress.text = ""
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
                    warningEmpty = 0
                    doubbleAddress = 0
                    doubbleLabel = 0
                    newName.text = ""
                    newLabel.text = ""
                    newAddress.text = ""
                }

            }
        }
    }
}


