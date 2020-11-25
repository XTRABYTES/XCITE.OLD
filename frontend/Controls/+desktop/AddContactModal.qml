/**
 * Filename: AddContactModal.qml
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
import QZXing 2.3

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: addContactModal
    width: appWidth/6 * 5
    height: appHeight
    state: addContactTracker == 1? "up" : "down"
    color: "transparent"

    onStateChanged: {
        if (state == "down") {
            addContactTracker = 0
            saveFailed = 0
            contactSaved = 0
            contactExists = 0
            validEmail = 1
            newFirstName.text = ""
            newLastName.text = ""
            newTel.text = ""
            newCell.text = ""
            newMail.text = ""
            newChat.text = ""
        }
    }

    Rectangle {
        anchors.fill: parent
        color: bgcolor
        opacity: 0.9
    }

    MouseArea {
        anchors.fill: parent
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: addContactModal; anchors.topMargin: 0}
            PropertyChanges { target: contactModal; opacity: 1}
        },
        State {
            name: "down"
            PropertyChanges { target: addContactModal; anchors.topMargin: addContactModal.height}
            PropertyChanges { target: addContactModal; opacity: 0}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: addContactModal; properties: "anchors.topMargin, opacity"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    property int contactSaved: 0
    property int saveFailed: 0
    property int contactExists: 0
    property int validEmail: 1
    property string failError: ""

    function compareName() {
        contactExists = 0
        for(var i = 0; i < contactList.count; i++) {
            if (newFirstName.text !== ""){
                if (contactList.get(i).firstName === newFirstName.text) {
                    if (contactList.get(i).lastName === newLastName.text) {
                            contactExists = 1
                    }
                }
            }
            else {
                if (newLastName.text !== "") {
                    if (contactList.get(i).lastName === newLastName.text) {
                        if (contactList.get(i).firstName === newFirstName.text) {
                                contactExists = 1
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

    Rectangle {
        anchors.fill: parent
        color: bgcolor
        opacity: 0.9
    }

    MouseArea {
        anchors.fill: parent
    }

    Rectangle {
        id: closeContact
        width: appWidth/48
        height: width
        radius: height/2
        color: "transparent"
        border.width: 1
        border.color: themecolor
        anchors.right: contactModal.right
        anchors.bottom: contactModal.top
        anchors.bottomMargin: height/2
        visible: contactModal.visible && !addingContact

        Item {
            width: parent.width*0.6
            height: width
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            rotation: 45

            Rectangle {
                width: parent.width
                height: 1
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                height: parent.height
                width: 1
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Rectangle {
            id: closeSelect
            anchors.fill: parent
            radius: height/2
            color: maincolor
            opacity: 0.3
            visible: false
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                closeSelect.visible = true
            }

            onExited: {
                closeSelect.visible = false
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                addContactTracker = 0
                saveFailed = 0
                contactSaved = 0
                contactExists = 0
                validEmail = 1
                newFirstName.text = ""
                newLastName.text = ""
                newTel.text = ""
                newCell.text = ""
                newMail.text = ""
                newChat.text = ""
            }
        }
    }

    DropShadow {
        anchors.fill: contactModal
        source: contactModal
        horizontalOffset: 4
        verticalOffset: 4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.3
        transparentBorder: true
        visible: contactModal.visible
    }

    Rectangle {
        id: contactModal
        width: appWidth*1.5/6 + appWidth/12
        height: parent.height - appWidth*5/24
        color: bgcolor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -appWidth/48
        anchors.top: parent.top
        anchors.topMargin: appWidth/12
        border.color: themecolor
        border.width: 1
        clip: true
        visible: contactSaved == 0 && saveFailed == 0

        Label {
            id: contactLabel
            text: "ADD NEW CONTACT"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: font.pixelSize/2
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
            color: themecolor
            font.letterSpacing: 2
        }

        Label {
            id: firstNameLabel
            text: "First name:"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/24
            anchors.top: contactLabel.bottom
            anchors.topMargin: appHeight/27
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
        }

        Label {
            id: lastNameLabel
            text: "Last name:"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/24
            anchors.top: firstNameLabel.bottom
            anchors.topMargin: font.pixelSize
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
        }

        Controls.TextInput {
            id: newFirstName
            text: ""
            height: appHeight/27
            placeholder: "FIRST NAME"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.verticalCenter: firstNameLabel.verticalCenter
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            validator: RegExpValidator { regExp: /[\w+\s+]+/ }
            mobile: 1
            deleteBtn: 0
            onTextChanged: {
                detectInteraction()
                compareName()
            }
        }

        Controls.TextInput {
            id: newLastName
            width: appWidth/6
            text: ""
            height: appHeight/27
            placeholder: "LAST NAME"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.verticalCenter: lastNameLabel.verticalCenter
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            validator: RegExpValidator { regExp: /[\w+\s+]+/ }
            mobile: 1
            deleteBtn: 0
            onTextChanged: {
                detectInteraction()
                compareName()
            }
        }

        Label {
            id: nameWarning1
            text: "Already a contact with this name!"
            anchors.left: newLastName.left
            anchors.leftMargin: font.pixelSize/2
            anchors.top: newLastName.bottom
            anchors.topMargin: 1
            font.pixelSize: appHeight/72
            font.family: xciteMobile.name
            color: "#FD2E2E"
            visible: contactExists == 1
                     && (newFirstName.text != "" || newLastName.text != "")
        }

        Rectangle {
            height: 1
            anchors.left: parent.left
            anchors.leftMargin: appWidth/24
            anchors.right: infoLabel.left
            anchors.rightMargin: infoLabel.font.pixelSize
            anchors.verticalCenter: infoLabel.verticalCenter
            color: themecolor
        }

        Label {
            id: infoLabel
            text: "CONTACT INFO"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newLastName.bottom
            anchors.topMargin: appHeight/27
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
            color: themecolor
        }

        Rectangle {
            height: 1
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.left: infoLabel.right
            anchors.leftMargin: infoLabel.font.pixelSize
            anchors.verticalCenter: infoLabel.verticalCenter
            color: themecolor
        }

        Label {
            id: telLabel
            text: "Telephone Nr.:"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/24
            anchors.verticalCenter: newTel.verticalCenter
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
        }

        Controls.TextInput {
            id: newTel
            text: ""
            height: appHeight/27
            placeholder: "TELEPHONE NUMBER"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/7.5
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.top: infoLabel.bottom
            anchors.topMargin: appHeight/27
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            validator: RegExpValidator { regExp: /[0-9+]+/ }
            mobile: 1
            deleteBtn: 0
            onTextChanged: detectInteraction()
        }

        Label {
            id: cellLabel
            text: "Cell phone Nr.:"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/24
            anchors.verticalCenter: newCell.verticalCenter
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
        }

        Controls.TextInput {
            id: newCell
            text: ""
            height: appHeight/27
            placeholder: "CELL PHONE NUMBER"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/7.5
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.top: telLabel.bottom
            anchors.topMargin: height
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            validator: RegExpValidator { regExp: /[0-9+]+/ }
            mobile: 1
            deleteBtn: 0
            onTextChanged: detectInteraction()
        }

        Label {
            id: mailLabel
            text: "E-mail address:"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/24
            anchors.verticalCenter: newMail.verticalCenter
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
        }

        Controls.TextInput {
            id: newMail
            text: ""
            height: appHeight/27
            placeholder: "E-MAIL ADDRESS"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/7.5
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.top: cellLabel.bottom
            anchors.topMargin: height
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            mobile: 1
            deleteBtn: 0
            onTextChanged: {
                detectInteraction()
                validation(newMail.text)
            }
        }

        Label {
            id: mailWarning
            text: "Not a valid e-mail format!"
            color: "#FD2E2E"
            anchors.left: newMail.left
            anchors.leftMargin: font.pixelSize/2
            anchors.top: newMail.bottom
            anchors.topMargin: 1
            font.pixelSize: appHeight/72
            font.family: xciteMobile.name
            visible: newMail.text != ""
                     && validEmail == 0
        }

        Label {
            id: chatLabel
            text: "X-CHAT ID.:"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/24
            anchors.verticalCenter: newChat.verticalCenter
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
        }

        Controls.TextInput {
            id: newChat
            text: ""
            height: appHeight/27
            placeholder: "X-CHAT ID"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/7.5
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.top: mailLabel.bottom
            anchors.topMargin: height
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            mobile: 1
            deleteBtn: 0
            onTextChanged: detectInteraction()
        }

        Rectangle {
            id: saveButton
            width: appWidth/6
            height: appHeight/27
            radius: height/2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: appHeight/27
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: ((newFirstName.text != "" || newLastName.text != "") && contactExists == 0 && validEmail == 1)? themecolor : "#727272"
            border.width: 1
            color: "transparent"

            Rectangle {
                id: selectSave
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                id: saveButtonText
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
                enabled: (newFirstName.text !== "" || newLastName.text !== "")
                              && contactExists == 0 && validEmail == 1

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
                    contactID = contactList.count;
                    contactList.append({"firstName": newFirstName.text, "lastName": newLastName.text, "photo": profilePictures.get(0).photo, "telNR": newTel.text, "cellNR": newCell.text, "mailAddress": newMail.text, "chatID": newChat.text, "favorite": false, "active": true, "contactNR": contactID, "remove": false});
                    contactID = contactID +1;
                    addingContact = true;
                    updateToAccount();
                }

                Connections {
                    target: UserSettings

                    onSaveSucceeded: {
                        if (addContactTracker == 1 && addingContact == true) {
                            contactSaved = 1
                            addingContact = false
                        }
                    }

                    onSaveFailed: {
                        if (addContactTracker == 1 && addingContact == true) {
                            contactID = contactID - 1
                            contactList.remove(contactID)
                            saveFailed = 1
                            addingContact = false
                        }
                    }

                    onNoInternet: {
                        if (addContactTracker == 1 && addingContact == true) {
                            networkError = 1
                            contactID = contactID - 1
                            contactList.remove(contactID)
                            saveFailed = 1
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
        }

        AnimatedImage {
            id: waitingDots
            source: 'qrc:/gifs/loading-gif_01.gif'
            width: 90
            height: 60
            anchors.horizontalCenter: saveButton.horizontalCenter
            anchors.verticalCenter: saveButton.verticalCenter
            playing: addingContact == true
            visible: addingContact == true
        }
    }

    // save failed state
    DropShadow {
        anchors.fill: editContactFailed
        source: editContactFailed
        horizontalOffset: 4
        verticalOffset: 4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.3
        transparentBorder: true
        visible: editContactFailed.visible
    }

    Rectangle {
        id: editContactFailed
        width: appWidth*1.5/6
        height: saveFailedIcon.height + saveFailedIcon.anchors.topMargin + saveFailedLabel.height + saveFailedLabel.anchors.topMargin + saveFailedError.height + saveFailedError.anchors.topMargin + closeFail.height*2 + closeFail.anchors.topMargin
        color: bgcolor
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -appWidth/48
        visible: saveFailed == 1

        Image {
            id: saveFailedIcon
            source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
            height: appHeight/12
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: height/2
        }

        Label {
            id: saveFailedLabel
            text: "Failed to add your contact!"
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
            radius: height/2
            color: "transparent"
            anchors.top: saveFailedError.bottom
            anchors.topMargin: appHeight/18
            anchors.horizontalCenter: parent.horizontalCenter
            border.width: 1
            border.color: maincolor

            Rectangle {
                id: selectCloseFail
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                text: "TRY AGAIN"
                font.family: xciteMobile.name
                font.pixelSize: parent.height/2
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
                    saveFailed = 0
                    failError = ""
                }
            }
        }
    }

    // save success state
    DropShadow {
        anchors.fill: editContactSuccess
        source: editContactSuccess
        horizontalOffset: 4
        verticalOffset: 4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.3
        transparentBorder: true
        visible: editContactSuccess.visible
    }

    Rectangle {
        id: editContactSuccess
        width: appWidth*1.5/6
        height: saveSuccess.height + saveSuccess.anchors.topMargin + saveSuccessLabel.height + saveSuccessLabel.anchors.topMargin + closeSave.height*2 + closeSave.anchors.topMargin
        color: bgcolor
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: themecolor
        border.width: 1
        visible: contactSaved == 1

        Image {
            id: saveSuccess
            source: darktheme == true? 'qrc:/icons/mobile/add_contact-icon_01_light.svg' : 'qrc:/icons/mobile/add_acontact-icon_01_dark.svg'
            height: appHeight/12
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: height/2
        }

        Label {
            id: saveSuccessLabel
            text: "Contact added!"
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
            radius: height/2
            color: "transparent"
            anchors.top: saveSuccessLabel.bottom
            anchors.topMargin: appHeight/18
            anchors.horizontalCenter: parent.horizontalCenter
            border.width: 1
            border.color: maincolor

            Rectangle {
                id: selectCloseSave
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                text: "OK"
                font.family: xciteMobile.name
                font.pixelSize: parent.height/2
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
                    addContactTracker = 0
                    saveFailed = 0
                    contactSaved = 0
                    contactExists = 0
                    validEmail = 1
                    newFirstName.text = ""
                    newLastName.text = ""
                    newTel.text = ""
                    newCell.text = ""
                    newMail.text = ""
                    newChat.text = ""
                }
            }
        }
    }
}
