/**
* Filename: ContactInfo.qml
*
* XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
* blockchain protocol to host decentralized applications
*
* Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
*
* This file is part of an XTRABYTES Ltd. project.
*
*/

import QtQuick 2.7
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import QtCharts 2.0

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop

Rectangle {
    id: backgroundContact
    width: appWidth/6 * 5
    height: appHeight
    anchors.right: parent.right
    anchors.top: parent.top
    color: bgcolor
    state: contactTracker == 1? "up" : "down"
    clip: true

    states: [
        State {
            name: "up"
            PropertyChanges { target: backgroundContact; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: backgroundContact; anchors.topMargin: appHeight}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: backgroundContact; properties: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    onStateChanged: {
        if (state == "down") {
            editName = 0
            editContactTracker = 0
            addAddressTracker = 0
            addressTracker = 0
        }
    }

    property bool editingName: false
    property int editSaved: 0
    property int editNameSaved: 0
    property int editNameFailed: 0
    property int editFailed: 0
    property int contactExists: 0
    property int validEmail: 1
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
    property bool myTheme: darktheme
    property int editTracker: editContactTracker
    property int editNameTracker: editName

    onEditTrackerChanged: {
        if (editTracker == 1) {
            oldTel = contactList.get(contactIndex).telNR;
            oldText = contactList.get(contactIndex).cellNR;
            oldMail = contactList.get(contactIndex).mailAddress;
            oldChat = contactList.get(contactIndex).chatID;
            validEmail = 1;
            newTel.text = oldTel;
            newCell.text = oldText;
            newMail.text = oldMail;
            newChat.text = oldChat;
        }
    }

    onEditNameTrackerChanged: {
        if (editName == 1) {
            contactExists = 0;
            oldFirstName = contactList.get(contactIndex).firstName;
            oldLastName = contactList.get(contactIndex).lastName;
            newFirstName.text = oldFirstName
            newLastName.text = oldLastName
        }
    }

    onMyThemeChanged: {
        addAddressButton.border.color = themecolor

        if (darktheme) {
            editButton.source = "qrc:/icons/edit_icon_light01.png"
            editNameButton.source = "qrc:/icons/edit_icon_light01.png"
        }
        else {
            editButton.source = "qrc:/icons/edit_icon_dark01.png"
            editNameButton.source = "qrc:/icons/edit_icon_dark01.png"
        }
    }

    function compareName() {
        contactExists = 0
        for(var i = 0; i < contactList.count; i++) {
            if (contactList.get(i).contactNR !== contactIndex && contactList.get(i).remove === false) {
                if (newFirstName.text !== ""){
                    if (contactList.get(i).firstName === newFirstName.text) {
                        if (newLastName.text !== "") {
                            if (contactList.get(i).lastName === newLastName.text) {
                                contactExists = 1
                            }
                        }
                        else {
                            if (contactList.get(i).lastName === newLastName.placeholder) {
                                contactExists = 1
                            }
                        }
                    }
                }
                else {
                    if (contactList.get(i).firstName === newFirstName.placeholder) {
                        if (newLastname.text !== "") {
                            if (contactList.get(i).lastName === newLastName.text) {
                                contactExists = 1
                            }
                        }
                        else {
                            if (contactList.get(i).lastName === newLastName.placeholder) {
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

    Timer {
        id: timer1
        interval: 2000
        repeat: false
        running: false

        onTriggered:{
            if (editNameFailed == 1) {
                editNameFailed = 0
            }
            else if (editNameSaved == 1) {
                editNameSaved = 0
                editName = 0
            }
        }
    }

    MouseArea {
        anchors.fill: parent
    }

    Label {
        id: firstName
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        anchors.top: parent.top
        anchors.topMargin: appHeight/6
        text: coinIndex >= 0? contactList.get(contactIndex).firstName : ""
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        color: themecolor
        opacity: editName == 1? 0 : 1
    }

    Label {
        id: lastName
        anchors.left: firstName.right
        anchors.leftMargin: appHeight/27
        anchors.bottom: firstName.bottom
        anchors.right: parent.right
        anchors.rightMargin: appWidth/6
        text: coinIndex >= 0? contactList.get(contactIndex).lastName : ""
        color: themecolor
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        font.capitalization: Font.AllUppercase
        elide: Text.ElideRight
        opacity: editName == 1? 0 : 1
    }

    Image {
        id: editNameButton
        source: darktheme == true? "qrc:/icons/edit_icon_light01.png" : "qrc:/icons/edit_icon_dark01.png"
        height: appWidth/48
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: firstName.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: appWidth/12 + firstName.implicitWidth + lastName.anchors.leftMargin + lastName.implicitWidth
        visible: editName == 0 && editContactTracker == 0 && addressTracker == 0 && addAddressTracker == 0

        Rectangle {
            anchors.fill: parent
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    editNameButton.source = "qrc:/icons/edit_icon_green01.png"
                }

                onExited: {
                    if (darktheme) {
                        editNameButton.source = "qrc:/icons/edit_icon_light01.png"
                    }
                    else {
                        editNameButton.source = "qrc:/icons/edit_icon_dark01.png"
                    }
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    editName = 1
                }
            }
        }
    }

    Label {
        id: firstNameLabel
        text: "First name:"
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        anchors.bottom: lastNameLabel.top
        anchors.bottomMargin: appHeight/27
        color: themecolor
        font.pixelSize: appHeight/54
        font.family: xciteMobile.name
        opacity: 0.5
        visible: editNameSaved == 0 && editNameFailed == 0 && editName == 1
    }

    Label {
        id: lastNameLabel
        text: "Last name:"
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        anchors.bottom: firstName.bottom
        color: themecolor
        font.pixelSize: appHeight/54
        font.family: xciteMobile.name
        opacity: 0.5
        visible: editNameSaved == 0 && editNameFailed == 0 && editName == 1
    }

    Controls.TextInput {
        id: newFirstName
        width: appWidth/6
        text: coinIndex >= 0? contactList.get(contactIndex).firstName : ""
        height: appHeight/27
        placeholder: "FIRST NAME"
        anchors.left: parent.left
        anchors.leftMargin: appWidth/9 + appWidth/24
         anchors.verticalCenter: firstNameLabel.verticalCenter
        color: themecolor
        textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
        font.pixelSize: height/2
        validator: RegExpValidator { regExp: /[\w+\s+]+/ }
        visible: editName == 1 && editNameSaved == 0 && editNameFailed == 0
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
        text: coinIndex >= 0? contactList.get(contactIndex).lastName : ""
        height: appHeight/27
        placeholder: "LAST NAME"
        anchors.left: parent.left
        anchors.leftMargin: appWidth/9 + appWidth/24
         anchors.verticalCenter: lastNameLabel.verticalCenter
        color: themecolor
        textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
        font.pixelSize: height/2
        validator: RegExpValidator { regExp: /[\w+\s+]+/ }
        visible: editName == 1 && editNameSaved == 0 && editNameFailed == 0
        mobile: 1
        deleteBtn: 0
        onTextChanged: {
            detectInteraction()
            compareName()
        }
    }

    Rectangle {
        id: saveNameButton
        width: (newLastName.width + appWidth/9)/2*0.9
        height: appHeight/27
        color: "transparent"
        anchors.top: newLastName.bottom
        anchors.topMargin: appHeight/27
        anchors.right: newLastName.right
        border.width: 1
        border.color: contactExists == 0? themecolor : "#727272"
        visible: editNameSaved == 0
                 && editNameFailed == 0
                 && editName == 1
                 && editingName == false

        Rectangle {
            id: selectSaveName
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
            enabled: contactExists == 0? true : false


            onEntered: {
                selectSaveName.visible = true
            }

            onExited: {
                selectSaveName.visible = false
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                editingName = true
                if (newFirstName.text !== "") {
                    contactList.setProperty(contactIndex, "firstName", newFirstName.text)
                    newFirst = newFirstName.text
                }
                else {
                    newFirst = oldFirstName
                }

                ;
                if (newLastName.text !== "") {
                    contactList.setProperty(contactIndex, "lastName", newLastName.text)
                    newLast = newLastName.text
                }
                else {
                    newLast = oldLastName
                }

                ;
                replaceName(contactIndex, newFirst, newLast)
                updateToAccount()
            }
        }

        Connections {
            target: UserSettings

            onSaveSucceeded: {
                if (editName == 1 && editingName == true) {
                    editNameSaved = 1
                    editingName = false
                    timer1.start()
                }
            }

            onSaveFailed: {
                if (editName == 1 && editingName == true) {
                    replaceName(contactIndex, oldFirstName, oldFirstName);
                    contactList.setProperty(contactIndex, "firstName", oldFirstName);
                    contactList.setProperty(contactIndex, "lastName", oldLastName);
                    editNameFailed = 1
                    editingName = false
                    timer1.start()
                }
            }

            onNoInternet: {
                if (editName == 1 && editingName == true) {
                    replaceName(contactIndex, oldFirstName, oldFirstName);
                    contactList.setProperty(contactIndex, "firstName", oldFirstName);
                    contactList.setProperty(contactIndex, "lastName", oldLastName);
                    editNameFailed = 1
                    editingName = false
                    timer1.start()
                }
            }

            onSaveFailedDBError: {
                if (editName == 1 && editingName == true) {
                    failError = "Database ERROR"
                }
            }

            onSaveFailedAPIError: {
                if (editName == 1 && editingName == true) {
                    failError = "Network ERROR"
                }
            }

            onSaveFailedInputError: {
                if (editName == 1 && editingName == true) {
                    failError = "Input ERROR"
                }
            }

            onSaveFailedUnknownError: {
                if (editName == 1 && editingName == truee) {
                    failError = "Unknown ERROR"
                }
            }
        }
    }

    AnimatedImage {
        id: waitingDots
        source: 'qrc:/gifs/loading-gif_01.gif'
        width: 90
        height: 60
        anchors.horizontalCenter: saveNameButton.horizontalCenter
        anchors.verticalCenter: saveNameButton.verticalCenter
        playing: editingName == true
        visible: editNameSaved == 0
                 && editNameFailed == 0
                 && editingName == true
    }

    Rectangle {
        id: closeButton
        width: (newLastName.width + appWidth/9)/2*0.9
        height: appHeight/27
        color: "transparent"
        anchors.top: newLastName.bottom
        anchors.topMargin: appHeight/27
        anchors.left: lastNameLabel.left
        border.width: 1
        border.color: editingName == false? themecolor : "#727272"
        visible: editNameSaved == 0
                 && editNameFailed == 0
                 && editName == 1

        Rectangle {
            id: selectClose
            anchors.fill: parent
            color: maincolor
            opacity: 0.3
            visible: false
        }

        Text {
            text: "CLOSE EDIT"
            font.family: xciteMobile.name
            font.pointSize: parent.height/2
            color: parent.border.color
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            enabled: editingName == false

            onEntered: {
                selectClose.visible = true
            }

            onExited: {
                selectClose.visible = false
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                editName = 0
            }
        }
    }

    Label {
        id: nameWarning1
        text: "Contact already exists!"
        anchors.left: newLastName.left
        anchors.leftMargin: font.pixelSize/2
        anchors.top: newLastName.bottom
        anchors.topMargin: 1
        font.pixelSize: appHeight/72
        font.family: xciteMobile.name
        visible: editNameSaved == 0
                 && editNameFailed == 0
                 && editName == 1
                 && contactExists == 1
                 && (newFirstName.text != "" || newLastName.text != "")
    }

    Label {
        id: saveNameFailedLabel
        text: "Failed to edit your contact's name!"
        anchors.verticalCenter: firstName.verticalCenter
        anchors.horizontalCenter: infoArea.horizontalCenter
        color: maincolor
        font.pixelSize: appHeight/27
        font.family: xciteMobile.name
        visible: editName == 1 && editNameFailed == 1
    }

    Label {
        id: saveNameSavedLabel
        text: "Your contact's name has been changed!"
        anchors.verticalCenter: firstName.verticalCenter
        anchors.horizontalCenter: infoArea.horizontalCenter
        color: maincolor
        font.pixelSize: appHeight/27
        font.family: xciteMobile.name
        visible: editName == 1 && editNameSaved == 1
    }

    Item {
        id: infoArea
        width: (parent.width - appWidth*3/24)/2
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        anchors.top: firstName.bottom
        anchors.topMargin: appHeight/24
        anchors.bottom: parent.bottom
        anchors.bottomMargin: appWidth/24
        clip: true

        Image {
            id: photo
            source: profilePictures.get(contactIndex).photo
            anchors.left: parent.left
            anchors.top: parent.top
            height: appWidth/12
            fillMode: Image.PreserveAspectFit
            opacity: editName == 1? 0 : 1
        }

        Label {
            id: telLabel
            text: "Telephone Nr.:"
            anchors.left: parent.left
            anchors.top: photo.bottom
            anchors.topMargin: appHeight/36
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
            visible: editSaved == 0 && editFailed == 0
        }

        Label {
            id: telNr
            text: coinIndex >= 0? contactList.get(contactIndex).telNR : ""
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.top: telLabel.top
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            visible: editContactTracker == 0
        }

        Controls.TextInput {
            id: newTel
            text: coinIndex >= 0? contactList.get(contactIndex).telNR : ""
            height: appHeight/27
            placeholder: "TELEPHONE NUMBER"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.verticalCenter: telLabel.verticalCenter
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            validator: RegExpValidator { regExp: /[0-9+]+/ }
            visible: editContactTracker == 1 && editSaved == 0 && editFailed == 0
            mobile: 1
            deleteBtn: 0
            onTextChanged: detectInteraction()
        }

        Label {
            id: cellLabel
            text: "Cell phone Nr.:"
            anchors.left: parent.left
            anchors.top: telLabel.bottom
            anchors.topMargin: appHeight/27
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
            visible: editSaved == 0 && editFailed == 0
        }

        Label {
            id: cellNr
            text: coinIndex >= 0? contactList.get(contactIndex).cellNR : ""
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.top: cellLabel.top
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            visible: editContactTracker == 0
        }

        Controls.TextInput {
            id: newCell
            text: coinIndex >= 0? contactList.get(contactIndex).cellNR : ""
            height: appHeight/27
            placeholder: "CELL PHONE NUMBER"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.verticalCenter: cellLabel.verticalCenter
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            validator: RegExpValidator { regExp: /[0-9+]+/ }
            visible: editContactTracker == 1 && editSaved == 0 && editFailed == 0
            mobile: 1
            deleteBtn: 0
            onTextChanged: detectInteraction()
        }

        Label {
            id: mailLabel
            text: "E-mail address:"
            anchors.left: parent.left
            anchors.top: cellLabel.bottom
            anchors.topMargin: appHeight/27
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
            visible: editSaved == 0 && editFailed == 0
        }

        Label {
            id: emailAddress
            text: coinIndex >= 0? contactList.get(contactIndex).mailAddress : ""
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            maximumLineCount: 2
            wrapMode: Text.WrapAnywhere
            anchors.top: mailLabel.top
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            elide: Text.ElideRight
            visible: editContactTracker == 0

            Rectangle {
                id: mailLine
                width: parent.implicitWidth
                height: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                color: maincolor
                visible: false
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        mailLine.visible = true
                    }

                    onExited: {
                        mailLine.visible = false
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        if(contactList.get(contactIndex).mailAddress !== "") {
                            Qt.openUrlExternally('mailto:' + contactList.get(contactIndex).mailAddress)
                        }
                    }
                }
            }
        }

        Controls.TextInput {
            id: newMail
            text: coinIndex >= 0? contactList.get(contactIndex).mailAddress : ""
            height: appHeight/27
            placeholder: "E-MAIL ADDRESS"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.verticalCenter: mailLabel.verticalCenter
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            visible: editContactTracker == 1 && editSaved == 0 && editFailed == 0
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
            visible: editSaved == 0
                     && editFailed == 0
                     && newMail.text != ""
                     && validEmail == 0
        }

        Label {
            id: chatLabel
            text: "X-CHAT ID.:"
            anchors.left: parent.left
            anchors.top: mailLabel.bottom
            anchors.topMargin: appHeight/27
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
            visible: editSaved == 0 && editFailed == 0
        }

        Label {
            id: xchatID
            text: coinIndex >= 0? contactList.get(contactIndex).chatID : ""
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            maximumLineCount: 2
            wrapMode: Text.WrapAnywhere
            anchors.top: chatLabel.top
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            elide: Text.ElideRight
            visible: editContactTracker == 0

            Rectangle {
                id: chatLine
                width: parent.implicitWidth
                height: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                color: maincolor
                visible: false
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        chatLine.visible = true
                    }

                    onExited: {
                        chatLine.visible = false
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        if(contactList.get(contactIndex).chatID !== "") {

                        }
                    }
                }
            }
        }

        Controls.TextInput {
            id: newChat
            text: coinIndex >= 0? contactList.get(contactIndex).chatID : ""
            height: appHeight/27
            placeholder: "X-CHAT ID"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.verticalCenter: chatLabel.verticalCenter
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            visible: editContactTracker == 1 && editSaved == 0 && editFailed == 0
            mobile: 1
            deleteBtn: 0
            onTextChanged: detectInteraction()
        }

        Item {
            id: addAddress
            width: addAddressButton.width + addAddressLabel.width
            height: addAddressButton.height
            anchors.left: parent.left
            anchors.top: chatLabel.bottom
            anchors.topMargin: appHeight/18
            visible: editContactTracker == 0 && editName == 0 && addressTracker == 0 && addAddressTracker == 0

            Rectangle {
                id: addAddressButton
                height: appWidth/48
                width: height
                radius: height/2
                color: "transparent"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                border.width: 2
                border.color: themecolor

                Rectangle {
                    height: 2
                    width: parent.width*0.6
                    radius: height/2
                    color: parent.border.color
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Rectangle {
                    width: 2
                    height: parent.height*0.6
                    radius: width/2
                    color: parent.border.color
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Label {
                id: addAddressLabel
                text: "ADD ADDRESS"
                leftPadding: addAddressButton.height/2
                font.pixelSize: addAddressButton.height/2
                font.family: xciteMobile.name
                color: addAddressButton.border.color
                anchors.left: addAddressButton.right
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    addAddressButton.border.color = maincolor
                }

                onExited: {
                    addAddressButton.border.color = themecolor
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    addAddressTracker = 1
                }
            }
        }

        Image {
            id: editButton
            source: darktheme == true? "qrc:/icons/edit_icon_light01.png" : "qrc:/icons/edit_icon_dark01.png"
            height: appWidth/48
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: addAddress.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            visible: editName == 0 && editContactTracker == 0 && addressTracker == 0 && addAddressTracker == 0

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
                        editContactTracker = 1
                    }
                }
            }
        }

        Rectangle {
            id: saveButton
            width: appWidth/6
            height: appHeight/27
            color: "transparent"
            border.width: 1
            border.color: validEmail == 1? themecolor : "#727272"
            anchors.top: chatLabel.bottom
            anchors.topMargin: appHeight/18
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -appWidth/48
            visible: editSaved == 0
                     && deleteContactTracker == 0
                     && editFailed == 0
                     && editingContact == false
                     && editContactTracker == 1
                     && editName == 0

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
                enabled: validEmail == 1 && editName == 0? true : false


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
                    editingContact = true
                    contactList.setProperty(contactIndex, "telNR", newTel.text);
                    contactList.setProperty(contactIndex, "cellNR", newCell.text);
                    contactList.setProperty(contactIndex, "mailAddress", newMail.text);
                    contactList.setProperty(contactIndex, "chatID", newChat.text);

                    updateToAccount()
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
                        contactList.setProperty(contactIndex, "telNR", oldTel);
                        contactList.setProperty(contactIndex, "cellNR", oldText);
                        contactList.setProperty(contactIndex, "mailAddress", oldMail);
                        contactList.setProperty(contactIndex, "chatID", oldChat);
                        editFailed = 1
                        editingContact = false
                    }
                }

                onNoInternet: {
                    if (editContactTracker == 1 && editingContact == true) {
                        contactList.setProperty(contactIndex, "telNR", oldTel);
                        contactList.setProperty(contactIndex, "cellNR", oldText);
                        contactList.setProperty(contactIndex, "mailAddress", oldMail);
                        contactList.setProperty(contactIndex, "chatID", oldChat);
                        editFailed = 1
                        editingContact = false
                    }
                }

                onSaveFailedDBError: {
                    if (editContactTracker == 1 && editingContact == true) {
                        failError = "Database ERROR"
                    }
                }

                onSaveFailedAPIError: {
                    if (editContactTracker == 1 && editingContact == true) {
                        failError = "Network ERROR"
                    }
                }

                onSaveFailedInputError: {
                    if (editContactTracker == 1 && editingContact == true) {
                        failError = "Input ERROR"
                    }
                }

                onSaveFailedUnknownError: {
                    if (editContactTracker == 1 && editingContact == true) {
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
            playing: editingContact == true
            visible: editSaved == 0
                     && scanQRTracker == 0
                     && editFailed == 0
                     && editingContact == true
        }

        Rectangle {
            id: backButton
            width: appWidth/6
            height: appHeight/27
            color: "transparent"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: appHeight/27
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -appWidth/48
            border.width: 1
            border.color: editingContact == false? themecolor : "#727272"
            visible: editSaved == 0
                     && editFailed == 0
                     && editContactTracker == 1

            Rectangle {
                id: selectBack
                anchors.fill: parent
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                text: "CLOSE EDIT"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                enabled: editingContact == false

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
                    editContactTracker = 0
                }
            }
        }

        // save failed state
        Rectangle {
            id: editContactFailed
            width: parent.width/2
            height: saveFailed.height + saveFailed.anchors.topMargin + saveFailedLabel.height + saveFailedLabel.anchors.topMargin + saveFailedError.height + saveFailedError.anchors.topMargin + closeFail.height*2 + closeFail.anchors.topMargin
            color: bgcolor
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -appWidth/48
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
                text: "Failed to edit your contact!"
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
            id: editContactSuccess
            width: parent.width/2
            height: saveSuccess.height + saveSuccess.anchors.topMargin + saveSuccessLabel.height + saveSuccessLabel.anchors.topMargin + closeSave.height*2 + closeSave.anchors.topMargin
            color: bgcolor
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -appWidth/48
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
                text: "Contact Edited!"
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
                        editContactTracker = 0;
                        editSaved = 0;
                        newTel.text = oldTel;
                        newCell.text = oldText;
                        newMail.text = oldMail;
                        newChat.text = oldChat;
                        validEmail = 1;
                    }
                }
            }
        }
    }

    Item {
        id: walletArea
        width: (parent.width - appWidth*3/24)/2
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: firstName.bottom
        anchors.topMargin: appHeight/24
        anchors.bottom: parent.bottom
        anchors.bottomMargin: appWidth/24
        clip: true

        Label {
            id: walletListLabel
            text: "Addresses"
            color: themecolor
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: walletListArea
            width: parent.width
            anchors.top: walletListLabel.bottom
            anchors.topMargin: appHeight/36
            anchors.bottom: parent.bottom
            color: darktheme == true? "#14161B" : "#FDFDFD"
            clip: true

            Desktop.ContactAddressList {
                id: myContactAddressList
                anchors.top: parent.top
            }
        }

        Desktop.ContactAddressModal {
            id: myContactAddressModal
            anchors.top: parent.top
        }
    }

    Rectangle {
        height: appWidth/24
        width: parent.width
        anchors.bottom: parent.bottom
        color: darktheme == true? "#14161B" : "#FDFDFD"
    }
}
