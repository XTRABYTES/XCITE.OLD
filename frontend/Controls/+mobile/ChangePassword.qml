/**
 * Filename: ChangePassword.qml
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
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtMultimedia 5.8
import QtQuick.Window 2.2

import "qrc:/Controls" as Controls

Rectangle {
    id: changePassWordModal
    width: appWidth
    height: appHeight
    state: changePasswordTracker == 1? "up" : "down"
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    onStateChanged: detectInteraction()

    property int myTracker: changePasswordTracker

    onMyTrackerChanged: {
        if (myTracker == 0) {
            currentPassword.text = ""
            passWord1.text = ""
            passWord2.text = ""
            editSaved = 0
            editFailed = 0
        }
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: changePassWordModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: changePassWordModal; anchors.topMargin: changePassWordModal.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: changePassWordModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    property int passwordWarning1: 0
    property int passwordWarning2: 0
    property int editSaved: 0
    property int editFailed: 0
    property string failError: ""

    function validation(text){
        var regExp = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$/;
        if(regExp.test(text)) passwordWarning1 = 0;
        else passwordWarning1 = 1;
    }

    Label {
        id: modalLabel
        z: 1
        text: "CHANGE PASSWORD"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        color: themecolor
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.bold: true
        font.letterSpacing: 2
        visible: editSaved == 0 & editFailed == 0
    }

    Label {
        id: oldPasswordLabel
        z: 1
        text: "Current password"
        font.pixelSize: 16
        font.family: xciteMobile.name
        font.bold: true
        color: themecolor
        anchors.top: modalLabel.bottom
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 28
        visible: editSaved == 0 & editFailed == 0
    }

    Controls.TextInput {
        id: currentPassword
        height: 34
        width: doubbleButtonWidth
        echoMode: TextInput.Password
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: oldPasswordLabel.bottom
        anchors.topMargin: 10
        color: themecolor
        textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
        font.pixelSize: 14
        mobile: 1
        visible: editSaved == 0 & editFailed == 0
    }

    Label {
        id: newPassword1Label
        z: 1
        text: "New password"
        font.pixelSize: 16
        font.family: xciteMobile.name
        font.bold: true
        color: themecolor
        anchors.top: currentPassword.bottom
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 28
        visible: editSaved == 0 & editFailed == 0
    }

    Controls.TextInput {
        id: passWord1
        height: 34
        width: doubbleButtonWidth
        mobile: 1
        echoMode: TextInput.Password
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: newPassword1Label.bottom
        anchors.topMargin: 10
        color: themecolor
        textBackground: "#0B0B09"
        font.pixelSize: 14
        deleteBtn: passwordWarning1 == 0? 0 : 1
        visible: editSaved == 0 & editFailed == 0

        onTextChanged: {
            //check if password has valid format
            validation(passWord1.text);
        }

        Image {
            id: pass1OK
            source: 'qrc:/icons/icon-ok_01.svg'
            height: 20
            width: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 7
            visible: passWord1.text != "" && passwordWarning1 == 0
        }
    }

    Label {
        id: passwordWarningText1
        text: passWord1.text != ""? (passwordWarning1 == 0? "" : (passwordWarning1 == 1? "This password does not have the correct format!": "")): ""
        color: "#FD2E2E"
        anchors.left: passWord1.left
        anchors.leftMargin: 5
        anchors.top: passWord1.bottom
        anchors.topMargin: 1
        font.pixelSize: 11
        font.family: "Brandon Grotesque"
        font.weight: Font.Normal
        visible: editSaved == 0 & editFailed == 0
    }

    Label {
        id: newPassword2Label
        z: 1
        text: "Repeat new password"
        font.pixelSize: 16
        font.family: xciteMobile.name
        font.bold: true
        color: themecolor
        anchors.top: passWord1.bottom
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 28
        visible: editSaved == 0 & editFailed == 0
    }

    Controls.TextInput {
        id: passWord2
        height: 34
        width: doubbleButtonWidth
        mobile: 1
        echoMode: TextInput.Password
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: newPassword2Label.bottom
        anchors.topMargin: 10
        color: themecolor
        textBackground: "#0B0B09"
        font.pixelSize: 14
        deleteBtn: passwordWarning2 == 0? 0 : 1
        visible: editSaved == 0 & editFailed == 0

        onTextChanged: {
            //check if passwords match
            if (passWord2.text != passWord1.text){
                passwordWarning2 = 1
            }
            else {
                passwordWarning2 = 0
            }
        }

        Image {
            id: pass2OK
            source: 'qrc:/icons/icon-ok_01.svg'
            height: 20
            width: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 7
            visible: passWord2.text != "" && passwordWarning2 == 0
        }
    }

    Label {
        id: passwordWarningText2
        text: passWord2.text != ""? (passwordWarning2 == 0? "" : (passwordWarning2 == 1? "The passwords don't match!": "")) : ""
        color: "#FD2E2E"
        anchors.left: passWord2.left
        anchors.leftMargin: 5
        anchors.top: passWord2.bottom
        anchors.topMargin: 1
        font.pixelSize: 11
        font.family: "Brandon Grotesque"
        font.weight: Font.Normal
        visible: editSaved == 0 & editFailed == 0
    }

    Rectangle {
        id: saveButton
        width: passWord2.width
        height: 34
        color: (currentPassword.text != ""
                && passWord1.text !== ""
                && passWord2.text != ""
                && passwordWarning1 == 0
                && passwordWarning2 == 0) ? maincolor : "#727272"
        opacity: 0.25
        anchors.top: passWord2.bottom
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        visible: editSaved == 0
                 && editFailed == 0
                 && savePasswordInitiated == false

        MouseArea {
            anchors.fill: saveButton

            onPressed: {
                parent.opacity = 1
                click01.play()
                detectInteraction()
            }

            onCanceled: {
                parent.opacity = 0.25
            }

            onReleased: {
                parent.opacity = 0.25
                if (currentPassword.text != ""
                        && passWord1.text !== ""
                        && passWord2.text != ""
                        && passwordWarning1 == 0
                        && passwordWarning2 == 0) {
                    savePasswordInitiated = true
                    changePassword(currentPassword.text, passWord1.text)
                }
            }
        }

        Connections {
            target: UserSettings

            onSaveSucceeded: {
                if (changePasswordTracker == 1 && savePasswordInitiated == true) {
                    editSaved = 1
                    savePasswordInitiated = false
                }
            }

            onSaveFailed: {
                if (changePasswordTracker == 1 && savePasswordInitiated == true) {
                    editFailed = 1
                    savePasswordInitiated = false
                }
            }

            onNoInternet: {
                if (changePasswordTracker == 1 && savePasswordInitiated == true) {
                    networkError = 1
                    editFailed = 1
                    savePasswordInitiated = false
                }
            }

            onPasswordChangedFailed: {
                if (changePasswordTracker == 1 && savePasswordInitiated == true) {
                    editFailed = 1
                    savePasswordInitiated = false
                }
            }

            onSaveFailedDBError: {
                if (changePasswordTracker == 1 && savePasswordInitiated == true) {
                    failError = "Database ERROR"
                    editFailed = 1
                    savePasswordInitiated = false
                }
            }

            onSaveFailedAPIError: {
                if (changePasswordTracker == 1 && savePasswordInitiated == true) {
                    failError = "Network ERROR"
                    editFailed = 1
                    savePasswordInitiated = false
                }
            }

            onSaveFailedInputError: {
                if (changePasswordTracker == 1 && savePasswordInitiated == true) {
                    failError = "Input ERROR"
                    editFailed = 1
                    savePasswordInitiated = false
                }
            }

            onSaveFailedUnknownError: {
                if (changePasswordTracker == 1 && savePasswordInitiated == true) {
                    failError = "Unknown ERROR"
                    editFailed = 1
                    savePasswordInitiated = false
                }
            }
        }
    }

    Text {
        text: "SAVE"
        font.family: "Brandon Grotesque"
        font.pointSize: 14
        font.bold: true
        color: (currentPassword.text != ""
                && passWord1.text !== ""
                && passWord2.text != ""
                && passwordWarning1 == 0
                && passwordWarning2 == 0) ? (darktheme == true? "#F2F2F2" : maincolor) : "#979797"
        anchors.horizontalCenter: saveButton.horizontalCenter
        anchors.verticalCenter: saveButton.verticalCenter
        visible: editSaved == 0
                 && editFailed == 0
                 && savePasswordInitiated == false
    }

    Rectangle {
        width: saveButton.width
        height: 34
        anchors.bottom: saveButton.bottom
        anchors.left: saveButton.left
        color: "transparent"
        opacity: 0.5
        border.color: (currentPassword.text != ""
                       && passWord1.text !== ""
                       && passWord2.text != ""
                       && passwordWarning1 == 0
                       && passwordWarning2 == 0) ? maincolor : "#979797"
        border.width: 1
        visible: editSaved == 0
                 && editFailed == 0
                 && savePasswordInitiated == false
    }

    AnimatedImage {
        id: waitingDots2
        source: 'qrc:/gifs/loading-gif_01.gif'
        width: 90
        height: 60
        anchors.horizontalCenter: saveButton.horizontalCenter
        anchors.verticalCenter: saveButton.verticalCenter
        playing: savePasswordInitiated == true
        visible: editSaved == 0
                 && editFailed == 0
                 && savePasswordInitiated == true
    }

    //change password failed

    ReplyModal {
        id: changePasswordFailed
        modalHeight: saveFailed.height + saveFailedLabel.height + saveFailedError.height + closeFail.height + 85
        visible: editFailed == 1

        Image {
            id: saveFailed
            source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: changePasswordFailed.modalTop
            anchors.topMargin: 20
        }

        Label {
            id: saveFailedLabel
            text: "Failed to change your password!"
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
                    currentPassword.text = ""
                    passWord1.text = ""
                    passWord2.text = ""
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

    //change password succeeded

    ReplyModal {
        id: changePasswordSucceed
        modalHeight: saveSuccess.height + saveSuccessLabel.height + closeSave.height + 75
        visible: editSaved == 1

        Image {
            id: saveSuccess
            source: darktheme == true? 'qrc:/icons/mobile/succes_icon_01_light.svg' : 'qrc:/icons/mobile/succes_icon_01_dark.svg'
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: changePasswordSucceed.modalTop
            anchors.topMargin: 20
            visible: editSaved == 1
        }

        Label {
            id: saveSuccessLabel
            text: "Password changed!"
            anchors.top: saveSuccess.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: saveSuccess.horizontalCenter
            color: maincolor
            font.pixelSize: 14
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
                    changePasswordTracker = 0
                    currentPassword.text = ""
                    passWord1.text = ""
                    passWord2.text = ""
                    editSaved = 0
                    editFailed = 0
                }
            }
        }

        Text {
            text: "OK"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: darktheme == true? "#F2F2F2" : maincolor
            anchors.horizontalCenter: closeSave.horizontalCenter
            anchors.verticalCenter: closeSave.verticalCenter
            visible: editSaved == 1
        }

        Rectangle {
            width: closeSave.width
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

    Item {
        z: 3
        width: parent.width
        height: myOS === "android"? 195 : 215
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
    /*
    Label {
        id: closeSettings
        z: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : (isIphoneX()? 90 : 70)
        anchors.horizontalCenter: parent.horizontalCenter
        text: "BACK"
        font.pixelSize: 14
        font.family: xciteMobile.name
        color: themecolor
        visible: editSaved == 0 & editFailed == 0

        Rectangle {
            id: backbutton
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            height: 34
            color: "transparent"
        }

        MouseArea {
            anchors.fill: backbutton

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                changePasswordTracker = 0
            }
        }
    }
    **/
}
