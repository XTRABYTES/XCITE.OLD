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
import QtMultimedia 5.8
import QtQuick.Window 2.2

import "qrc:/Controls" as Controls

Rectangle {
    id: changePassWordModal
    width: appWidth
    height: appHeight
    state: changePasswordTracker == 1? "up" : "down"
    color: "transparent"
    onStateChanged: detectInteraction()

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

    Rectangle {
        anchors.fill: parent
        color: bgcolor
        opacity: 0.9

        MouseArea {
            anchors.fill: parent
        }
    }

    property int passwordWarning1: 0
    property int passwordWarning2: 0
    property int editSaved: 0
    property int editFailed: 0
    property string failError: ""
    property int myTracker: changePasswordTracker
    property int passwordInfoTracker: 0

    onMyTrackerChanged: {
        if (myTracker == 0) {
            currentPassword.text = ""
            passWord1.text = ""
            passWord2.text = ""
            editSaved = 0
            editFailed = 0
            failError = ""
            passwordWarning1 = 0
            passwordWarning2 = 0
            passwordInfoTracker = 0
        }
    }

    function validation(text){
        var regExp = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$/;
        if(regExp.test(text)) passwordWarning1 = 0;
        else passwordWarning1 = 1;
    }

    Label {
        id: modalLabel
        text: "CHANGE PASSWORD"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: editFailed == 1? changePassWordFailed.top : (editSaved == 1? changePasswordSucceed.top : changePasswordArea.top)
        anchors.bottomMargin: appHeight/72
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: themecolor
        font.letterSpacing: 2
    }

    Rectangle {
        id: changePasswordArea
        width: parent.width/2
        height: oldPasswordLabel.height + oldPasswordLabel.anchors.topMargin +
                currentPassword.height + currentPassword.anchors.topMargin +
                ((newPassword1Label.height + newPassword1Label.anchors.topMargin +
                  passWord1.height + passWord2.anchors.topMargin)*2) +
                (saveButton.height*2) + saveButton.anchors.topMargin
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: darktheme == true? "#0B0B09" : "#FFFFFF"
        border.color: maincolor
        border.width: 2
        visible: editSaved == 0 & editFailed == 0

        Label {
            id: oldPasswordLabel
            text: "Current password"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: appHeight/18
            font.pixelSize: appHeight/60
            font.family: xciteMobile.name
            color: themecolor
        }

        Controls.TextInput {
            id: currentPassword
            height: appHeight/18
            width: parent.width*2/3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: oldPasswordLabel.bottom
            anchors.topMargin: appHeight/108
            placeholder: ""
            horizontalAlignment: TextInput.AlignHCenter
            echoMode: TextInput.Password
            color: themecolor
            textBackground: bgcolor
            mobile: 1
        }

        Label {
            id: newPassword1Label
            text: "Choose a new password"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: currentPassword.bottom
            anchors.topMargin: appHeight/36
            font.pixelSize: appHeight/60
            font.family: xciteMobile.name
            color: themecolor
        }

        Controls.TextInput {
            id: passWord1
            height: appHeight/18
            width: parent.width*2/3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newPassword1Label.bottom
            anchors.topMargin: appHeight/108
            placeholder: ""
            echoMode: TextInput.Password
            horizontalAlignment: TextInput.AlignHCenter
            color: themecolor
            textBackground: bgcolor
            mobile: 1

            onTextChanged: {
                validation(passWord1.text);
            }

            Image {
                id: pass1OK
                source: 'qrc:/icons/icon-ok_01.svg'
                height: parent.height/2
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.height/2
                visible: passWord1.text != "" && passwordWarning1 == 0
            }
        }

        Rectangle {
            id: passwordInfo
            height: passWord1.height/2
            width: height
            radius: height/2
            anchors.left: passWord1.right
            anchors.leftMargin: width
            anchors.verticalCenter: passWord1.verticalCenter
            color: "transparent"
            border.width: 1
            border.color: maincolor

            Label {
                text: "!"
                color: maincolor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: parent.height/2
                font.family: xciteMobile.name
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    passwordInfoTracker = 1
                }
            }
        }

        Label {
            id: passwordHintText
            text: "Your password should contain at least one capital letter, one number and one special character, and it must be at least 8 characters long."
            width: appWidth/9
            color: themecolor
            horizontalAlignment: Text.AlignLeft
            wrapMode: Text.WordWrap
            padding: font.pixelsize
            font.pixelSize: appHeight/60
            anchors.verticalCenter: passWord1.verticalCenter
            anchors.left: passWord1.right
            anchors.leftMargin: passWord1.height/2
            background: Rectangle {
                color: darktheme == true? "#0B0B09" : "#FFFFFF"
                width: parent.width + parent.font.pixelSize
                height: parent.implicitHeight + parent.font.pixelSize
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1
                border.color: maincolor
            }
            visible: passwordInfoTracker == 1

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onExited: {
                    passwordInfoTracker = 0
                }
            }
        }

        Label {
            id: passwordWarningText1
            text: passWord1.text == ""? "" : (passwordWarning1 == 1? "This password does not have the correct format!": "")
            color: "#FD2E2E"
            anchors.left: passWord1.left
            anchors.leftMargin: font.pixelSize/2
            anchors.top: passWord1.bottom
            anchors.topMargin: 1
            font.pixelSize: appHeight/72
            font.family: xciteMobile.name
        }

        Label {
            id: newPassword2Label
            z: 1
            text: "Type your new password again"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: passWord1.bottom
            anchors.topMargin: appHeight/36
            font.pixelSize: appHeight/60
            font.family: xciteMobile.name
            color: themecolor
        }

        Controls.TextInput {
            id: passWord2
            height: appHeight/18
            width: parent.width*2/3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newPassword2Label.bottom
            anchors.topMargin: appHeight/108
            placeholder: ""
            echoMode: TextInput.Password
            horizontalAlignment: TextInput.AlignHCenter
            color: themecolor
            textBackground: bgcolor
            mobile: 1

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
                height: parent.height/2
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.height/2
                visible: passWord2.text != "" && passwordWarning2 == 0
            }
        }

        Label {
            id: passwordWarningText2
            text: passWord2.text == ""? "" : (passwordWarning2 == 1?"The passwords don't match!": "")
            anchors.left: passWord2.left
            anchors.leftMargin: font.pixelSize/2
            anchors.top: passWord2.bottom
            anchors.topMargin: 1
            font.pixelSize: appHeight/72
            font.family: xciteMobile.name
        }

        Rectangle {
            id: saveButton
            width: parent.width/3
            height: appHeight/18
            radius: height/2
            color: "transparent"
            border.width: 1
            border.color: (currentPassword.text != ""
                    && passWord1.text !== ""
                    && passWord2.text != ""
                    && passwordWarning1 == 0
                    && passwordWarning2 == 0) ? themecolor : "#727272"
            anchors.top: passWord2.bottom
            anchors.topMargin: appHeight/18
            anchors.horizontalCenter: parent.horizontalCenter
            visible: savePasswordInitiated == false

            Timer {
                id: timer1
                interval: 2000
                repeat: false
                running: false

                onTriggered: {
                    changePasswordTracker = 0
                    passwordInfoTracker = 0
                    currentPassword.text = ""
                    passWord1.text = ""
                    passWord2.text = ""
                    editSaved = 0
                    editFailed = 0
                }
            }

            Rectangle {
                id: selectSave
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            MouseArea {
                anchors.fill: saveButton
                hoverEnabled: true
                enabled: currentPassword.text != ""
                         && passWord1.text !== ""
                         && passWord2.text != ""
                         && passwordWarning1 == 0
                         && passwordWarning2 == 0

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
                        timer1.start()
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

            Text {
                text: "SAVE"
                font.pixelSize: parent.height/2
                font.family: xciteMobile.name
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        AnimatedImage {
            id: waitingDots2
            source: 'qrc:/gifs/loading-gif_01.gif'
            width: 90
            height: appHeight/18
            anchors.horizontalCenter: saveButton.horizontalCenter
            anchors.verticalCenter: saveButton.verticalCenter
            playing: savePasswordInitiated == true
            visible: savePasswordInitiated == true
        }
    }

    Rectangle {
        id: cancel
        width: parent.width/6
        height: appHeight/18
        radius: height/2
        color: "transparent"
        anchors.top: changePasswordArea.bottom
        anchors.topMargin: appHeight/72
        anchors.horizontalCenter: parent.horizontalCenter
        border.width: 1
        border.color: themecolor
        visible: editFailed == 0 && editSaved == 0 && savePasswordInitiated == false

        Rectangle {
            id: selectCancel
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
                selectCancel.visible = true
            }

            onExited: {
                selectCancel.visible = false
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                changePasswordTracker = 0
                passwordInfoTracker = 0
                currentPassword.text = ""
                passWord1.text = ""
                passWord2.text = ""
                editSaved = 0
                editFailed = 0
            }
        }

        Label {
            text: "CANCEL"
            font.pixelSize: parent.height/2
            font.family: xciteMobile.name
            color: themecolor
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    //change password failed

    Rectangle {
        id: changePassWordFailed
        width: parent.width/3
        height: saveFailedLabel.height + saveFailedLabel.anchors.topMargin +
                saveFailedError.height + saveFailedError.anchors.topMargin +
                (closeFailed.height*2) + closeFailed.anchors.topMargin
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: darktheme == true? "#0B0B09" : "#FFFFFF"
        border.color: maincolor
        border.width: 2
        visible: editFailed == 1

        Label {
            id: saveFailedLabel
            text: "Failed to change your password!"
            color: themecolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: appHeight/9
            font.pixelSize: appHeight/36*0.8
            font.family: xciteMobile.name
        }

        Label {
            id: saveFailedError
            text: failError
            anchors.top: saveFailedLabel.bottom
            anchors.topMargin: appHeight/72
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: appHeight/36*0.6
            font.family: xciteMobile.name
            color: themecolor
        }

        Rectangle {
            id: closeFailed
            width: appWidth/6
            height: appHeight/18
            radius: height/2
            color: "transparent"
            anchors.top: saveFailedError.bottom
            anchors.topMargin: appHeight/18
            anchors.horizontalCenter: parent.horizontalCenter
            border.width: 1
            border.color: themecolor

            Rectangle {
                id: selectFailed
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            MouseArea {
                anchors.fill: closeFailed
                hoverEnabled: true

                onEntered: {
                    selectFailed.visible = true
                }

                onExited: {
                    selectFailed.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    editFailed = 0;
                }
            }

            Text {
                text: "TRY AGAIN"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: maincolor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    //change password succeeded

    Rectangle {
        id: changePasswordSucceed
        width: parent.width/3
        height: appHeight*9/36
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: darktheme == true? "#0B0B09" : "#FFFFFF"
        border.color: maincolor
        border.width: 2
        visible: editSaved == 1

        Label {
            id: saveSuccessLabel
            text: "Password changed!"
            color: themecolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: appHeight/9
            font.pixelSize: appHeight/36*0.8
            font.family: xciteMobile.name
        }
    }
}

