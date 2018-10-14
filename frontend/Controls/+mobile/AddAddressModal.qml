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
            anchors.left: newPicklist.right
            anchors.leftMargin: 10
            anchors.verticalCenter: newCoinName.verticalCenter
            visible: editSaved == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: "#F2F2F2"
            }

            MouseArea {
                anchors.fill: parent
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
            // radius: 8
            placeholder: "CONTACT NAME"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newIcon.bottom
            anchors.topMargin: 25
            color: "#F2F2F2"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editSaved == 0
        }

        Controls.TextInput {
            id: newLabel
            height: 34
            // radius: 8
            placeholder: "WALLET LABEL"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newName.bottom
            anchors.topMargin: 25
            color: "#F2F2F2"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editSaved == 0
        }

        Controls.TextInput {
            id: newAddress
            height: 34
            // radius: 8
            placeholder: "PUBLIC KEY"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newLabel.bottom
            anchors.topMargin: 25
            color: "#F2F2F2"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editSaved == 0
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
                    // error handeling (not a number, insufficient funds, negative amount, incorrect address)

                    if (newName.text != "" && newLabel.text != "" && newAddress.text != "") {
                        warningEmpty = 0
                        editSaved = 1
                        if (newCoinSelect == 1) {
                            addressList.append({"address": newAddress.text, "name": newName.text, "label": newLabel.text, "logo": currencyList.get(newCoinPicklist).logo, "coin": newCoinName.text, "favorite": 0, "active": 1});
                        }
                        else {
                            addressList.append({"address": newAddress.text, "name": newName.text, "label": newLabel.text, "logo": currencyList.get(0).logo, "coin": newCoinName.text, "favorite": 0, "active": 1});
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
                    newName.text = ""
                    newLabel.text = ""
                    newAddress.text = ""
                    editSaved = 0
                    newCoinPicklist = 0
                    newCoinSelect = 0
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

        MouseArea {
            anchors.fill: closeAddressModal

            onClicked: {
                if (addAddressTracker == 1) {
                    addAddressTracker = 0;
                    picklistTracker = 0
                    newCoinPicklist = 0
                    newCoinSelect = 0
                    warningEmpty = 0
                    newName.text = ""
                    newLabel.text = ""
                    newAddress.text = ""
                }

            }
        }
    }
}


