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
    width: Screen.width
    state: editContactTracker == 1? "up" : "down"
    height: Screen.height
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    onStateChanged: {
        if (editContactModal.state === "up") {
            contactName.text = contactList.get(contactIndex).firstName + " " + contactList.get(contactIndex).lastName;
            oldFirstName = contactList.get(contactIndex).firstName;
            oldLastName = contactList.get(contactIndex).lastName;
            oldTel = contactList.get(contactIndex).telNR;
            oldText = contactList.get(contactIndex).cellNR;
            oldMail = contactList.get(contactIndex).mailAddress;
            oldChat = contactList.get(contactIndex).chatID;
        }
        else {
            contactName.text = "";
            oldFirstName = "";
            oldLastName = "";
            oldTel = "";
            oldText = "";
            oldMail = "";
            oldChat = "";
        }
        newFirstname.text = oldFirstName
        newLastname.text = oldLastName
        newTel.text = oldTel
        newCell.text = oldText
        newMail.text = oldMail
        newChat.text = oldChat
        contactExists = 0
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: editContactModal; anchors.topMargin: 0}
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
            NumberAnimation { target: editContactModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    property int editSaved: 0
    property int editFailed: 0
    property bool editingContact: false
    property bool deletingContact: false
    property int contactExists: 0
    property int validEmail: 1
    property int deleteContactTracker: 0
    property int deleteConfirmed: 0
    property int deleteFailed: 0
    property string oldFirstName
    property string oldLastName
    property string oldTel
    property string oldText
    property string oldMail
    property string oldChat
    property string newFirst
    property string newLast
    property string failError

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

    function validation(text){
        var regExp = /^[0-9A-Za-z._%+-]+@(?:[0-9A-Za-z-]+\.)+[a-z]{2,}$/;
        if(regExp.test(text) || text === "") {
            validEmail = 1;
        }
        else {
            validEmail = 0;
        }
    }

    Label {
        id: contactModalLabel
        text: "EDIT CONTACT"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        visible: editSaved == 0
                 && deleteContactTracker == 0
    }

    Flickable {
        id: scrollArea
        width: parent.width
        contentHeight: (editSaved == 0 && deleteContactTracker == 0 && editFailed == 0)? contactScrollArea.height + 125 : scrollArea.height + 125
        anchors.left: parent.left
        anchors.top: contactModalLabel.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        Label {
            id: contactName
            text: ""
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: 28
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            font.letterSpacing: 2
            elide: Text.ElideRight
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteContactTracker == 0
        }

        Image {
            id: deleteContact
            source: darktheme == true? 'qrc:/icons/mobile/trash-icon_01_light.svg' : 'qrc:/icons/mobile/trash-icon_01_dark.svg'
            height: 25
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: saveButton.bottom
            anchors.topMargin: 40
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteContactTracker == 0

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
                    deleteContactTracker = 1
                }
            }
        }

        Rectangle {
            id: contactScrollArea
            width: parent.width
            anchors.top: parent.top
            anchors.bottom: deleteContact.bottom
            color: "transparent"
        }

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
                     && editFailed == 0
                     && deleteContactTracker == 0
        }

        Image {
            id: newPhoto
            source: contactList.get(contactIndex).photo
            height: 100
            width: 100
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: parent.top
            anchors.topMargin: 40
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteContactTracker == 0
        }

        Controls.TextInput {
            id: newFirstname
            text: oldFirstName
            height: 34
            placeholder: "FIRST NAME"
            anchors.bottom: newPhoto.verticalCenter
            anchors.bottomMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 28
            anchors.left: newPhoto.right
            anchors.leftMargin: 28
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            validator: RegExpValidator { regExp: /[\w+\s+]+/ }
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteContactTracker == 0
            mobile: 1
            deleteBtn: 1
            onTextChanged: {
                detectInteraction()
                compareName()
            }
        }

        Controls.TextInput {
            id: newLastname
            text: oldLastName
            height: 34
            placeholder: "LAST NAME"
            anchors.left: newFirstname.left
            anchors.right: newFirstname.right
            anchors.top: newFirstname.bottom
            anchors.topMargin: 10
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            validator: RegExpValidator { regExp: /[\w+\s+]+/ }
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteContactTracker == 0
            mobile: 1
            deleteBtn: 1
            onTextChanged: {
                detectInteraction()
                compareName()
            }
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
                     && editFailed == 0
                     && deleteContactTracker == 0
                     && newFirstname.text != ""
                     && newLastname.text != ""
                     && contactExists == 1
        }

        Controls.TextInput {
            id: newTel
            text: oldTel
            height: 34
            placeholder: "TELEPHONE NUMBER"
            anchors.left: newPhoto.left
            anchors.right: newLastname.right
            anchors.top: newPhoto.bottom
            anchors.topMargin: 45
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            validator: RegExpValidator { regExp: /[0-9+]+/ }
            visible: editSaved == 0
                     && deleteContactTracker == 0
                     && editFailed == 0
            mobile: 1
            onTextChanged: detectInteraction()
        }

        Controls.TextInput {
            id: newCell
            text: oldText
            height: 34
            placeholder: "CELLPHONE NUMBER"
            anchors.left: newTel.left
            anchors.right: newTel.right
            anchors.top: newTel.bottom
            anchors.topMargin: 10
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            validator: RegExpValidator { regExp: /[0-9+]+/ }
            visible: editSaved == 0
                     && deleteContactTracker == 0
                     && editFailed == 0
            mobile: 1
            onTextChanged: detectInteraction()
        }

        Controls.TextInput {
            id: newMail
            text: oldMail
            height: 34
            placeholder: "EMAIL ADDRESS"
            anchors.left: newCell.left
            anchors.right: newCell.right
            anchors.top: newCell.bottom
            anchors.topMargin: 10
            color: validEmail == 1? themecolor : "#FD2E2E"
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            //validator: RegExpValidator { regExp: /^[0-9A-Za-z._%+-]+@(?:[0-9A-Za-z-]+\.)+[a-z]{2,}$/ }
            visible: editSaved == 0
                     && deleteContactTracker == 0
                     && editFailed == 0
            mobile: 1
            onTextChanged: {
                detectInteraction()
                validation(newMail.text)
            }
        }

        Controls.TextInput {
            id: newChat
            text: oldChat
            height: 34
            placeholder: "X-CHAT ID"
            anchors.left: newMail.left
            anchors.right: newMail.right
            anchors.top: newMail.bottom
            anchors.topMargin: 10
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            visible: editSaved == 0
                     && deleteContactTracker == 0
                     && editFailed == 0
            mobile: 1
            onTextChanged: detectInteraction()
        }

        Rectangle {
            id: saveButton
            width: newTel.width
            height: 34
            color: (contactExists == 0 && validEmail == 1)? maincolor : "#727272"
            opacity: 0.25
            anchors.top: newChat.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 0
                     && deleteContactTracker == 0
                     && editFailed == 0
                     && editingContact == false

            MouseArea {
                anchors.fill: saveButton

                onPressed: {
                    click01.play()
                    parent.opacity = 0.5
                    detectInteraction()
                }

                onReleased: {
                    parent.opacity = 0.25
                }

                onCanceled: {
                    parent.opacity = 0.25
                }

                onClicked: {
                    if (contactExists == 0 && validEmail == 1) {
                        if (newFirstname.text !== "") {
                            contactList.setProperty(contactIndex, "firstName", newFirstname.text)
                            newFirst = newFirstname.text
                        }
                        else {
                            newFirst = oldFirstName
                        }

                        ;
                        if (newLastname.text !== "") {
                            contactList.setProperty(contactIndex, "lastName", newLastname.text)
                            newLast = newLastname.text
                        }
                        else {
                            newLast = oldLastName
                        }

                        ;
                        replaceName(contactIndex, newFirst, newLast)
                        contactList.setProperty(contactIndex, "telNR", newTel.text);
                        contactList.setProperty(contactIndex, "cellNR", newCell.text);
                        contactList.setProperty(contactIndex, "mailAddress", newMail.text);
                        contactList.setProperty(contactIndex, "chatID", newChat.text);
                        editingContact = true

                        updateToAccount()
                    }
                }
            }

            Connections {
                target: UserSettings

                onSaveSucceeded: {
                    if (editContactTracker == 1 && editingContact == true) {
                        editSaved = 1
                        editingContact = false
                    }
                }

                onSaveFailed: {
                    if (editContactTracker == 1 && editingContact == true) {
                        replaceName(contactIndex, oldFirstName, oldFirstName);
                        contactList.setProperty(contactIndex, "firstName", oldFirstName);
                        contactList.setProperty(contactIndex, "lastName", oldLastName);
                        contactList.setProperty(contactIndex, "telNR", oldTel);
                        contactList.setProperty(contactIndex, "cellNR", oldText);
                        contactList.setProperty(contactIndex, "mailAddress", oldMail);
                        contactList.setProperty(contactIndex, "chatID", oldChat);
                        editFailed = 1
                        editingContact = false
                    }
                }

                onSaveFailedDBError: {
                    failError = "Database ERROR"
                }

                onSaveFailedAPIError: {
                    failError = "Network ERROR"
                }

                onSaveFailedInputError: {
                    failError = "Input ERROR"
                }

                onSaveFailedUnknownError: {
                    failError = "Unknown ERROR"
                }
            }
        }

        Text {
            text: "SAVE"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: (contactExists == 0 && validEmail == 1)? "#F2F2F2" : "#979797"
            anchors.horizontalCenter: saveButton.horizontalCenter
            anchors.verticalCenter: saveButton.verticalCenter
            visible: editSaved == 0
                     && deleteContactTracker == 0
                     && editFailed == 0
                     && editingContact == false
        }

        Rectangle {
            width: newTel.width
            height: 34
            anchors.bottom: saveButton.bottom
            anchors.left: saveButton.left
            color: "transparent"
            opacity: 0.5
            border.color: (contactExists == 0)? maincolor : "#979797"
            border.width: 1
            visible: editSaved == 0
                     && deleteContactTracker == 0
                     && editFailed == 0
                     && editingContact == false
        }

        AnimatedImage  {
            id: waitingDots
            source: 'qrc:/gifs/loading-gif_01.gif'
            width: 90
            height: 60
            anchors.horizontalCenter: saveButton.horizontalCenter
            anchors.verticalCenter: saveButton.verticalCenter
            playing: editingContact == true
            visible: editSaved == 0
                     && deleteContactTracker == 0
                     && editFailed == 0
                     && editingContact == true
        }

        // save failed state
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

        // save succes state
        Controls.ReplyModal {
            id: saveConfirmed
            modalHeight: saveSuccess.height + saveSuccessName.height + saveSuccessLabel.height + closeSave.height + 105
            visible: editSaved == 1

            Image {
                id: saveSuccess
                source: darktheme == true? 'qrc:/icons/mobile/succes_icon_01_light.svg' : 'qrc:/icons/mobile/succes_icon_01_dark.svg'
                height: 75
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: saveConfirmed.modalTop
                anchors.topMargin: 20
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
                height: 34
                color: maincolor
                opacity: 0.25
                anchors.top: saveSuccessLabel.bottom
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter
                visible: editSaved == 1

                MouseArea {
                    anchors.fill: closeSave

                    onPressed: {
                        click01.play()
                        parent.opacity = 0.5
                        detectInteraction()
                    }

                    onReleased: {
                        parent.opacity = 0.25
                    }

                    onCanceled: {
                        parent.opacity = 0.25
                    }

                    onClicked: {
                        editContactTracker = 0;
                        contactExists = 0;
                        newFirstname.text = oldFirstName;
                        newLastname.text = oldLastName;
                        newTel.text = oldTel;
                        newCell.text = oldText;
                        newMail.text = oldMail;
                        newChat.text = oldChat;
                        validEmail = 1;
                        contactIndex = 0;
                        editSaved = 0
                        closeAllClipboard = true
                    }
                }
            }

            Text {
                text: "OK"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#F2F2F2"
                anchors.horizontalCenter: closeSave.horizontalCenter
                anchors.verticalCenter: closeSave.verticalCenter
                visible: editSaved == 1

            }

            Rectangle {
                width: doubbleButtonWidth / 2
                height: 34
                color: "transparent"
                border.color: maincolor
                border.width: 1
                opacity: 0.50
                anchors.top: closeSave.top
                anchors.horizontalCenter: closeSave.horizontalCenter
                visible: editSaved == 1
            }
        }

        // Delete confirm state
        Controls.ReplyModal {
            id: deleteConfirmation
            modalHeight: deleteText.height + deleteContactName.height + confirmationDeleteButton.height + 72
            visible: deleteContactTracker == 1
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
                id: deleteContactName
                text: contactList.get(contactIndex).firstName + " " + contactList.get(contactIndex).lastName
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

            Rectangle {
                id: confirmationDeleteButton
                width: (doubbleButtonWidth - 30) / 2
                height: 34
                anchors.top: deleteContactName.bottom
                anchors.topMargin: 25
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 5
                color: "#4BBE2E"
                opacity: 0.25
                visible: deletingContact == false

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

                        contactList.setProperty(contactIndex, "remove", true)
                        deletingContact = true

                        var datamodel = []
                        for (var i = 0; i < contactList.count; ++i)
                            datamodel.push(contactList.get(i))

                        var contactListJson = JSON.stringify(datamodel)
                        saveContactList(contactListJson)
                    }
                }

                Connections {
                    target: UserSettings

                    onSaveSucceeded: {
                        if (editContactTracker == 1 && deletingContact == true) {
                            deleteConfirmed = 1
                            contactExists = 0
                            validEmail = 1
                            deletingContact = false
                        }
                    }

                    onSaveFailed: {
                        if (editContactTracker == 1 && deletingContact == true) {

                            contactList.setProperty(contactIndex, "remove", false);
                            deleteFailed = 1
                            deletingContact = false
                        }
                    }

                    onSaveFailedDBError: {
                        if (editContactTracker == 1 && deletingContact == true) {
                            failError = "Database ERROR"
                        }
                    }

                    onSaveFailedAPIError: {
                        if (editContactTracker == 1 && deletingContact == true) {
                            failError = "Network ERROR"
                        }
                    }

                    onSaveFailedInputError: {
                        if (editContactTracker == 1 && deletingContact == true) {
                            failError = "Input ERROR"
                        }
                    }

                    onSaveFailedUnknownError: {
                        if (editContactTracker == 1 && deletingContact == true) {
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
                visible: deletingContact == false
            }

            Rectangle {
                width: (doubbleButtonWidth - 30) / 2
                height: 34
                anchors.top: confirmationDeleteButton.top
                anchors.right: confirmationDeleteButton.right
                color: "transparent"
                border.color: "#4BBE2E"
                border.width: 1
                visible: deletingContact == false
            }

            Rectangle {
                id: cancelDeleteButton
                width: (doubbleButtonWidth - 30) / 2
                height: 34
                anchors.top: deleteContactName.bottom
                anchors.topMargin: 25
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 5
                color: "#E55541"
                opacity: 0.25
                visible: deletingContact == false

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
                        deleteContactTracker = 0
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
                visible: deletingContact == false
            }

            Rectangle {
                width: (doubbleButtonWidth - 30) / 2
                height: 34
                anchors.top: cancelDeleteButton.top
                anchors.left: cancelDeleteButton.left
                color: "transparent"
                border.color: "#E55541"
                border.width: 1
                visible: deletingContact == false
            }

            AnimatedImage  {
                id: waitingDots2
                source: 'qrc:/gifs/loading-gif_01.gif'
                width: 90
                height: 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: confirmationDeleteButton.verticalCenter
                playing: deletingContact == true
                visible: deletingContact == true
            }
        }

        // Delete failed state
        Controls.ReplyModal {
            id: deleteContactFailed
            modalHeight: saveFailed.height + deleteFailedLabel.height + deleteFailedError.height + closeDeleteFail.height + 85
            visible: deleteFailed == 1

            Image {
                id: failedIcon
                source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
                height: 75
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: deleteContactFailed.modalTop
                anchors.topMargin: 20
            }

            Label {
                id: deleteFailedLabel
                text: "Failed to delete your contact!"
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
                        deleteContactTracker = 0
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
            id: deleted
            modalHeight: deleteSuccess.height + deleteSuccessLabel.height + closeDelete.height + 75
            visible: deleteConfirmed == 1

            Image {
                id: deleteSuccess
                source: darktheme == true? 'qrc:/icons/mobile/delete_contact-icon_01_light.svg' : 'qrc:/icons/mobile/delete_contact-icon_01_dark.svg'
                height: 75
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: deleted.ModalTop
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
                            deleteContactTracker = 0
                            deleteConfirmed = 0
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
                        editContactTracker = 0;
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
        id: closeContactModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : 70
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: editSaved == 0
                 && deleteContactTracker == 0

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

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                editContactTracker = 0;
                contactExists = 0;
                newFirstname.text = oldFirstName;
                newLastname.text = oldLastName;
                newTel.text = oldTel;
                newCell.text = oldText;
                newMail.text = oldMail;
                newChat.text = oldChat;
                validEmail = 1;
                contactIndex = 0;
            }
        }
    }
}
