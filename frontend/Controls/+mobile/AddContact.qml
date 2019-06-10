/**
 * Filename: AddContact.qml
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
    id: addContactModal
    width: Screen.width
    state: addContactTracker == 1? "up" : "down"
    height: Screen.height
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    states: [
        State {
            name: "up"
            PropertyChanges { target: addContactModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: addContactModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: addContactModal; property: "anchors.topMargin"; duration: 400; easing.type: Easing.InOutCubic}
        }
    ]

    property int editSaved: 0
    property int editFailed: 0
    property bool addingContact: false
    property int contactExists: 0
    property int validEmail: 1
    property string failError: ""

    function compareName() {
        contactExists = 0
        for(var i = 0; i < contactList.count; i++) {
            if (contactList.get(i).firstName === newFirstname.text && contactList.get(i).lastName === newLastname.text  && contactList.get(i).remove === false) {
                contactExists = 1
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

    Text {
        id: addContactModalLabel
        text: "ADD NEW CONTACT"
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
        width: parent.width
        contentHeight: (editSaved == 0 || editFailed == 0)? addContactScrollArea.height + 125 : scrollArea.height + 125
        anchors.left: parent.left
        anchors.top: addContactModalLabel.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        Rectangle {
            id: addContactScrollArea
            width: parent.width
            anchors.top: parent.top
            anchors.bottom: saveButton.bottom
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
        }

        Image {
            id: newPhoto
            source: profilePictures.get(0).photo
            height: 100
            width: 100
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: parent.top
            anchors.topMargin: 30
            visible: editSaved == 0
                     && editFailed == 0
        }

        Controls.TextInput {
            id: newFirstname
            z: 1.6
            height: 34
            placeholder: "FIRST NAME"
            anchors.bottom: newPhoto.verticalCenter
            anchors.bottomMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 28
            anchors.left: newPhoto.right
            anchors.leftMargin: 25
            color: (darktheme == false? "#2A2C31" : "#F2F2F2")
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            validator: RegExpValidator { regExp: /[\w+\s+]+/ }
            visible: editSaved == 0
                     && editFailed == 0
            mobile: 1
            onTextChanged: {
                detectInteraction()
                compareName()
            }
        }

        Controls.TextInput {
            id: newLastname
            height: 34
            placeholder: "LAST NAME"
            anchors.left: newFirstname.left
            anchors.right: newFirstname.right
            anchors.top: newFirstname.bottom
            anchors.topMargin: 10
            color: (darktheme == false? "#2A2C31" : "#F2F2F2")
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            validator: RegExpValidator { regExp: /[\w+\s+]+/ }
            visible: editSaved == 0
                     && editFailed == 0
            mobile: 1
            onTextChanged: {
                detectInteraction()
                compareName()
            }
        }

        Label {
            id: nameWarning1
            text: "Contact already exists!"
            color: "#FD2E2E"
            anchors.horizontalCenter: newLastname.horizontalCenter
            anchors.top: newLastname.bottom
            anchors.topMargin: 2
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.weight: Font.Normal
            visible: editSaved == 0
                     && editFailed == 0
                     && newFirstname.text != ""
                     && newLastname.text != ""
                     && contactExists == 1
        }

        Controls.TextInput {
            id: newTel
            height: 34
            placeholder: "TELEPHONE NUMBER"
            anchors.left: newPhoto.left
            anchors.right: newLastname.right
            anchors.top: newPhoto.bottom
            anchors.topMargin: 45
            color: (darktheme == false? "#2A2C31" : "#F2F2F2")
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            validator: RegExpValidator { regExp: /[0-9+]+/ }
            visible: editSaved == 0
                     && editFailed == 0
            mobile: 1
            onTextChanged: {
                detectInteraction()
            }
        }

        Controls.TextInput {
            id: newCell
            height: 34
            placeholder: "CELLPHONE NUMBER"
            anchors.left: newTel.left
            anchors.right: newTel.right
            anchors.top: newTel.bottom
            anchors.topMargin: 10
            color: (darktheme == false? "#2A2C31" : "#F2F2F2")
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            validator: RegExpValidator { regExp: /[0-9+]+/ }
            visible: editSaved == 0
                     && editFailed == 0
            mobile: 1
            onTextChanged: {
                detectInteraction()
            }
        }

        Controls.TextInput {
            id: newMail
            height: 34
            placeholder: "EMAIL ADDRESS"
            anchors.left: newCell.left
            anchors.right: newCell.right
            anchors.top: newCell.bottom
            anchors.topMargin: 10
            color: validEmail == 1? themecolor : "#FD2E2E"
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            visible: editSaved == 0
                     && editFailed == 0
            mobile: 1
            onTextChanged: {
                detectInteraction()
                validation(newMail.text)
            }
        }

        Controls.TextInput {
            id: newChat
            height: 34
            placeholder: "X-CHAT ID"
            anchors.left: newMail.left
            anchors.right: newMail.right
            anchors.top: newMail.bottom
            anchors.topMargin: 10
            color: (darktheme == false? "#2A2C31" : "#F2F2F2")
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            visible: editSaved == 0
                     && editFailed == 0
            mobile: 1
            onTextChanged: {
                detectInteraction()
            }
        }

        Rectangle {
            id: saveButton
            width: parent.width - 56
            height: 34
            color: ((newFirstname.text !== ""
                     || newLastname.text !== "")
                    && contactExists == 0 && validEmail == 1) ? maincolor : "#727272"
            opacity: 0.25
            anchors.top: newChat.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 0
                     && editFailed == 0
                     && addingContact == false

            MouseArea {
                anchors.fill: saveButton

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
                    if ((newFirstname.text !== "" || newLastname.text !== "")
                            && contactExists == 0 && validEmail == 1) {
                        contactID = contactList.count;
                        contactList.append({"firstName": newFirstname.text, "lastName": newLastname.text, "photo": profilePictures.get(0).photo, "telNR": newTel.text, "cellNR": newCell.text, "mailAddress": newMail.text, "chatID": newChat.text, "favorite": false, "active": true, "contactNR": contactID, "remove": false});
                        contactID = contactID +1;
                        addingContact = true

                        var datamodel = []
                        for (var i = 0; i < contactList.count; ++i)
                            datamodel.push(contactList.get(i))

                        var contactListJson = JSON.stringify(datamodel)
                        saveContactList(contactListJson)
                    }
                }
            }

            Connections {
                target: UserSettings

                onSaveSucceeded: {
                    if (addContactTracker == 1 && addingContact == true) {
                        succesSound.play()
                        editSaved = 1
                        addingContact = false
                    }
                }

                onSaveFailed: {
                    if (addContactTracker == 1 && addingContact == true) {
                        failSound.play()
                        contactID = contactID - 1
                        contactList.remove(contactID)
                        editFailed = 1
                        addingContact = false
                    }
                }

                onSaveFailedDBError: {
                    if (addContactTracker == 1 && addingContact == true) {
                        failError = "Database ERROR"
                    }
                }

                onSaveFailedAPIError: {
                    if (addContactTracker == 1 && addingContact == true) {
                        failError = "Network ERROR"
                    }
                }

                onSaveFailedInputError: {
                    if (addContactTracker == 1 && addingContact == true) {
                        failError = "Input ERROR"
                    }
                }

                onSaveFailedUnknownError: {
                    if (addContactTracker == 1 && addingContact == true) {
                        failError = "Unknown ERROR"
                    }
                }
            }
        }

        Text {
            text: "SAVE"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: ((newFirstname.text !== ""
                     || newLastname.text !== "")
                    && contactExists == 0 && validEmail == 1) ? (darktheme == true? "#F2F2F2" : maincolor) : "#979797"
            anchors.horizontalCenter: saveButton.horizontalCenter
            anchors.verticalCenter: saveButton.verticalCenter
            visible: editSaved == 0
                     && editFailed == 0
                     && addingContact == false
        }

        Rectangle {
            width: newTel.width
            height: 34
            anchors.bottom: saveButton.bottom
            anchors.left: saveButton.left
            color: "transparent"
            opacity: 0.5
            border.color: (newFirstname.text !== ""
                           && newLastname.text !== ""
                           && contactExists == 0) ? maincolor : "#979797"
            border.width: 1
            visible: editSaved == 0
                     && editFailed == 0
                     && addingContact == false
        }

        AnimatedImage  {
            id: waitingDots
            source: 'qrc:/gifs/loading-gif_01.gif'
            width: 90
            height: 60
            anchors.horizontalCenter: saveButton.horizontalCenter
            anchors.verticalCenter: saveButton.verticalCenter
            playing: addingContact == true
            visible: editSaved == 0
                     && editFailed == 0
                     && addingContact == true
        }

        // save failed state
        Controls.ReplyModal {
            id: addContactFailed
            modalHeight: saveFailed.height + saveFailedLabel.height + saveFailedError.height + closeFail.height + 85
            visible: editFailed == 1

            Image {
                id: saveFailed
                source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
                height: 75
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: addContactFailed.modalTop
                anchors.topMargin: 20
            }

            Label {
                id: saveFailedLabel
                text: "Failed to save your contact!"
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

        // save success state

        Controls.ReplyModal {
            id: addContactSucceed
            modalHeight: saveSuccess.height + saveSuccessLabel.height + closeSave.height + 105
            visible: editSaved == 1

            Image {
                id: saveSuccess
                source: darktheme == true? 'qrc:/icons/mobile/add_contact-icon_01_light.svg' : 'qrc:/icons/mobile/add_contact-icon_01_dark.svg'
                height: 75
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: addContactSucceed.modalTop
                anchors.topMargin: 20
                visible: editSaved == 1
            }

            Label {
                id: saveSuccessName
                text: newFirstname.text + " " + newLastname.text
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
                text: "Saved!"
                anchors.top: saveSuccess.bottom
                anchors.topMargin: 40
                anchors.horizontalCenter: saveSuccess.horizontalCenter
                color: darktheme == false? "#2A2C31" : "#F2F2F2"
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
                        addContactTracker = 0;
                        newFirstname.text = "";
                        newLastname.text = "";
                        newTel.text = "";
                        newCell.text = "";
                        newMail.text = "";
                        newChat.text = "";
                        contactExists = 0;
                        validEmail = 1;
                        editSaved = 0;
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
                anchors.bottom: closeSave.bottom
                anchors.left: closeSave.left
                color: "transparent"
                opacity: 0.5
                border.color: maincolor
                border.width: 1
                visible: editSaved == 1
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
        visible: addContactTracker == 1
                 && editSaved == 0

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
                addContactTracker = 0;
                newFirstname.text = "";
                newLastname.text = "";
                newTel.text = "";
                newCell.text = "";
                newMail.text = "";
                newChat.text = "";
                contactExists = 0;
                validEmail = 1;
            }
        }
    }
}
