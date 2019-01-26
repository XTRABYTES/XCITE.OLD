/**
 * Filename: ContactModal.qml
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
    id: editContactModal
    width: 325
    state: editContactTracker == 1? "up" : "down"
    height: editSaved == 1? 360 : 465
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    states: [
        State {
            name: "up"
            PropertyChanges { target: editContactModal; anchors.topMargin: 50}
        },
        State {
            name: "down"
            PropertyChanges { target: editContactModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: editContactModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.OutCubic}
        }
    ]

    property int editSaved: 0
    property int contactExists: 0

    function compareName() {
        contactExists = 0
        for(var i = 0; i < contactList.count; i++) {
            if (contactList.get(i).contactNR !== contactIndex && contactList.get(i).remove === false) {
                if (newFirstname.text !== ""){
                    if (contactList.get(i).firstName === newFirstname.text) {
                        if (newLastname.text !== "") {
                            if (contactList.get(i).lastName === newLastname.text) {
                                contactExists = 1
                            }
                        }
                        else {
                            if (contactList.get(i).lastName === newLastname.placeholder) {
                                contactExists = 1
                            }
                        }
                    }
                }
                else {
                    if (contactList.get(i).firstName === newFirstname.placeholder) {
                        if (newLastname.text !== "") {
                            if (contactList.get(i).lastName === newLastname.text) {
                                contactExists = 1
                            }
                        }
                        else {
                            if (contactList.get(i).lastName === newLastname.placeholder) {
                                contactExists = 1
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: contactTitleBar
        width: parent.width
        height: 50
        anchors.top: parent.top
        anchors.left: parent.left
        color: "transparent"
        visible: editSaved == 0


        Label {
            id: contactModalLabel
            width: parent.width - 28
            text: contactList.get(contactIndex).firstName + " " + contactList.get(contactIndex).lastName
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 27
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            color: "#F2F2F2"
            font.letterSpacing: 2
            elide: Text.ElideRight
        }

    }

    Rectangle {
        id: contactBodyModal
        width: parent.width
        height: parent.height - 50
        radius: 4
        color: darktheme == false? "#F7F7F7" : "#1B2934"
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter

        DropShadow {
            id: shadowPhoto
            anchors.fill: newPhoto
            source: newPhoto
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.3
            transparentBorder: true
            visible: editSaved == 0
        }

        Image {
            id: newPhoto
            source: contactList.get(contactIndex).photo
            height: 100
            width: 100
            anchors.left: parent.left
            anchors.leftMargin: 14
            anchors.top: parent.top
            anchors.topMargin: 20
            visible: editSaved == 0
        }

        Controls.TextInput {
            id: newFirstname
            text: contactList.get(contactIndex).firstName
            height: 34
            placeholder: "FIRST NAME"
            anchors.bottom: newPhoto.verticalCenter
            anchors.bottomMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 14
            anchors.left: newPhoto.right
            anchors.leftMargin: 25
            color: newFirstname.text != "" ? "#F2F2F2" : "#727272"
            textBackground: darktheme == false? "#484A4D" : "#0B0B09"
            font.pixelSize: 14
            visible: editSaved == 0
            mobile: 1
            deleteBtn: contactIndex == 0? 0 : 1
            readOnly: contactIndex == 0
            onTextChanged: compareName()
        }

        Controls.TextInput {
            id: newLastname
            text: contactList.get(contactIndex).lastName
            height: 34
            placeholder: "LAST NAME"
            anchors.left: newFirstname.left
            anchors.right: newFirstname.right
            anchors.top: newFirstname.bottom
            anchors.topMargin: 10
            color: newLastname.text !== "" ? "#F2F2F2" : "#727272"
            textBackground: darktheme == false? "#484A4D" : "#0B0B09"
            font.pixelSize: 14
            visible: editSaved == 0
            mobile: 1
            deleteBtn: contactIndex == 0? 0 : 1
            readOnly: contactIndex == 0
            onTextChanged: compareName()
        }

        Label {
            id: nameWarning1
            text: "Contact alreade exists!"
            color: "#FD2E2E"
            anchors.horizontalCenter: newLastname.horizontalCenter
            anchors.top: newLastname.bottom
            anchors.topMargin: 2
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.weight: Font.Normal
            visible: editSaved == 0
                     && newFirstname.text != ""
                     && newLastname.text != ""
                     && contactExists == 1
        }

        Controls.TextInput {
            id: newTel
            text: contactList.get(contactIndex).telNR
            height: 34
            placeholder: "TELEPHONE NUMBER"
            anchors.left: newPhoto.left
            anchors.right: newLastname.right
            anchors.top: newPhoto.bottom
            anchors.topMargin: 45
            color: newTel.text != "" ? "#F2F2F2" : "#727272"
            textBackground: darktheme == false? "#484A4D" : "#0B0B09"
            font.pixelSize: 14
            validator: RegExpValidator { regExp: /[0-9+]+/ }
            visible: editSaved == 0
            mobile: 1
        }

        Controls.TextInput {
            id: newCell
            text: contactList.get(contactIndex).cellNR
            height: 34
            placeholder: "CELLPHONE NUMBER"
            anchors.left: newTel.left
            anchors.right: newTel.right
            anchors.top: newTel.bottom
            anchors.topMargin: 10
            color: newCell.text != "" ? "#F2F2F2" : "#727272"
            textBackground: darktheme == false? "#484A4D" : "#0B0B09"
            font.pixelSize: 14
            validator: RegExpValidator { regExp: /[0-9+]+/ }
            visible: editSaved == 0
            mobile: 1
        }

        Controls.TextInput {
            id: newMail
            text: contactList.get(contactIndex).mailAddress
            height: 34
            placeholder: "EMAIL ADDRESS"
            anchors.left: newCell.left
            anchors.right: newCell.right
            anchors.top: newCell.bottom
            anchors.topMargin: 10
            color: newMail.text != "" ? "#F2F2F2" : "#727272"
            textBackground: darktheme == false? "#484A4D" : "#0B0B09"
            font.pixelSize: 14
            visible: editSaved == 0
            mobile: 1
        }

        Controls.TextInput {
            id: newChat
            text: contactList.get(contactIndex).chatID
            height: 34
            placeholder: "X-CHAT ID"
            anchors.left: newMail.left
            anchors.right: newMail.right
            anchors.top: newMail.bottom
            anchors.topMargin: 10
            color: newChat.text != "" ? "#F2F2F2" : "#727272"
            textBackground: darktheme == false? "#484A4D" : "#0B0B09"
            font.pixelSize: 14
            visible: editSaved == 0
            mobile: 1
        }

        Rectangle {
            id: saveButton
            width: parent.width - 28
            height: 34
            radius: 5
            color: (contactExists == 0) ? maincolor : "#727272"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 0

            MouseArea {
                anchors.fill: saveButton

                onPressed: { click01.play() }

                onReleased: {
                    if (contactExists == 0) {
                        if (newFirstname.text !== "") {
                            contactList.setProperty(contactIndex, "firstName", newFirstname.text)
                        };
                        if (newLastname.text !== "") {
                            contactList.setProperty(contactIndex, "lastName", newLastname.text)
                        };
                        contactList.setProperty(contactIndex, "telNR", newTel.text);
                        contactList.setProperty(contactIndex, "cellNR", newCell.text);
                        contactList.setProperty(contactIndex, "mailAddress", newMail.text);
                        contactList.setProperty(contactIndex, "chatID", newChat.text);
                        editSaved = 1
                    }
                }
            }

            Text {
                text: "SAVE"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: (contactExists == 0) ? "#F2F2F2" : "#979797"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // save state

        DropShadow {
            id: shadowPhotoSave
            anchors.fill: saveSuccess
            source: saveSuccess
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.3
            transparentBorder: true
            visible: editSaved == 1
        }

        Image {
            id: saveSuccess
            source: newPhoto.source
            height: 100
            width: 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 50
            visible: editSaved == 1
        }

        Label {
            id: saveSuccessName
            text: contactList.get(contactIndex).firstName + " " + contactList.get(contactIndex).lastName
            anchors.top: saveSuccess.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: saveSuccess.horizontalCenter
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editSaved == 1
        }

        Label {
            id: saveSuccessLabel
            text: "Changed!"
            anchors.top: saveSuccess.bottom
            anchors.topMargin: 40
            anchors.horizontalCenter: saveSuccess.horizontalCenter
            color: maincolor
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editSaved == 1
        }

        Rectangle {
            id: closeSave
            width: doubbleButtonWidth / 2
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
                    editContactTracker = 0;
                    contactExists = 0;
                    editSaved = 0
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
    }

    Label {
        id: closeAddressModal
        z: 10
        text: "CLOSE"
        anchors.top: editContactModal.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: editContactModal.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: "#F2F2F2"
        visible: editContactTracker == 1
                 && editSaved == 0

        Rectangle{
            id: closeButton
            height: 34
            width: doubbleButtonWidth / 2
            radius: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"
        }

        MouseArea {
            anchors.fill: closeButton

            onPressed: { click01.play() }

            onClicked: {
                editContactTracker = 0;
                contactExists = 0;
            }
        }
    }
}
