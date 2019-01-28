/**
 * Filename: CreateAccount.qml
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

import "qrc:/Controls" as Controls

Rectangle {
    id: backgroundSignUp
    width: Screen.width
    height: Screen.height
    color: "#1B2934"

    property int accountCreated: 0
    property int usernameWarning: 0
    property int passwordWarning1: 0
    property int passwordWarning2: 0
    property int checkUsername: 0

    function validation(text){
        var regExp = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$/;
        if(regExp.test(text)) passwordWarning1 = 0;
        else passwordWarning1 = 1;
    }

    function usernameLength(text) {
        if (text.length <= 5) {
            usernameWarning = 3
        }
        else if (text.length >= 13) {
            usernameWarning = 4
        }
        else {
            usernameWarning = 0
        };
        if (userName.text == ""){
            usernameWarning = 0
        }
    }

    Image {
        id: largeLogo
        source: 'qrc:/icons/XBY_logo_large.svg'
        width: parent.width * 2
        height: (largeLogo.width / 75) * 65
        anchors.top: parent.top
        anchors.topMargin: 63
        anchors.right: parent.right
        opacity: 0.5
    }

    Flickable {
        id: scrollArea
        width: parent.width
        height: parent.height
        contentHeight: setupScrollArea.height
        anchors.left: parent.left
        anchors.top: parent.top
        boundsBehavior: Flickable.StopAtBounds

        Rectangle {
            id: setupScrollArea
            width: parent.width
            height: 800
            color: "transparent"

            Label {
                id: welcomeText
                text: "WELCOME TO XCITE"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 25
                color: maincolor
                font.pixelSize: 24
                font.family: xciteMobile.name
                font.bold: true
            }

            Label {
                id: createAccountText
                text: "Let's get started by creating an account"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: welcomeText.bottom
                color: "#F2F2F2"
                font.pixelSize: 18
                font.family: xciteMobile.name
            }

            Text {
                id: createUsernameText
                width: doubbleButtonWidth
                maximumLineCount: 3
                anchors.left: userName.left
                anchors.top: createAccountText.bottom
                anchors.topMargin: 40
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
                text: "Choose a username, only alphanumeric characters are allowed, no spaces, minimum 6 and no more than 12 characters"
                color: "#F2F2F2"
                font.pixelSize: 18
                font.family: xciteMobile.name
            }

            Controls.TextInput {
                id: userName
                height: 34
                width: doubbleButtonWidth
                placeholder: "USERNAME"
                text: ""
                deleteBtn: 0
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: createUsernameText.bottom
                anchors.topMargin: 10
                rightPadding: 34
                color: userName.text != "" ? "#F2F2F2" : "#727272"
                textBackground: "#0B0B09"
                font.pixelSize: 14

                onTextChanged: {
                    usernameLength(userName.text)
                }

                Image {
                    id: checkButton
                    source: 'qrc:/icons/icon-questionmark_01.svg'
                    height: 20
                    width: 13
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10

                    Rectangle {
                        height: 34
                        width: 34
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        color: "transparent"

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                //function to check is username is available, return usernameWarning = 1 if username ealready exists
                            }
                        }
                    }
                }
            }

            Label {
                id: usernameWarningText1
                text: userName.text != ""? (usernameWarning == 0? "" : (usernameWarning == 1? "This Username already exists!" : (usernameWarning == 2? "Username unknown!": (usernameWarning == 3? "Username too short!" : (usernameWarning == 4? "Username too long" : ""))))) : ""
                color: "#FD2E2E"
                anchors.left: userName.left
                anchors.leftMargin: 5
                anchors.top: userName.bottom
                anchors.topMargin: 1
                font.pixelSize: 11
                font.family: "Brandon Grotesque"
                font.weight: Font.Normal
            }

            Text {
                id: createPasswordText
                width: doubbleButtonWidth
                maximumLineCount: 4
                anchors.left: createUsernameText.left
                anchors.top: userName.bottom
                anchors.topMargin: 20
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
                text: "Choose a password, it should contain at least one capital letter, a number and a special character and must be at least 8 characters long."
                color: "#F2F2F2"
                font.pixelSize: 18
                font.family: xciteMobile.name
            }

            Controls.TextInput {
                id: passWord1
                height: 34
                width: doubbleButtonWidth
                placeholder: "PASSWORD"
                text: ""
                echoMode: TextInput.Password
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: createPasswordText.bottom
                anchors.topMargin: 10
                color: passWord1.text != "" ? "#F2F2F2" : "#727272"
                textBackground: "#0B0B09"
                font.pixelSize: 14

                onTextChanged: {
                    validation(passWord1.text);
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
            }

            Controls.TextInput {
                id: passWord2
                height: 34
                width: doubbleButtonWidth
                placeholder: "RETYPE PASSWORD"
                text: ""
                echoMode: TextInput.Password
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: passWord1.bottom
                anchors.topMargin: 20
                color: passWord2.text != "" ? "#F2F2F2" : "#727272"
                textBackground: "#0B0B09"
                font.pixelSize: 14

                onTextChanged: {
                    if (passWord2.text != passWord1.text){
                        passwordWarning2 = 1
                    }
                    else {
                        passwordWarning2 = 0
                    }
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
            }

            Rectangle {
                id: createAccountButton
                width: doubbleButtonWidth
                height: 33
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: passWord2.bottom
                anchors.topMargin: 30
                radius: 5
                color: (usernameWarning == 0 && passwordWarning1 == 0 && passwordWarning2 == 0)? maincolor : "#727272"


                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                    }

                    onReleased: {
                        if (usernameWarning == 0 && passwordWarning1 == 0 && passwordWarning2 == 0 && userName.text != "" && passWord1.text != "" && passWord2.text != "") {
                            // if checkUsername = 0 run fucntion to check if username exists and return usernameWarning
                            // if returned usernameWarning = 0 or checkUsername = 1 run function to create account

                            //accountCreated = 1
                            //username = userName.text

                            createUser(userName.text, passWord1.text)
                        }
                    }
                }

                Text {
                    id: createButtonText
                    text: "CREATE ACCOUNT"
                    font.family: xciteMobile.name
                    font.pointSize: 14
                    color: (usernameWarning == 0 && passwordWarning1 == 0 && passwordWarning2 == 0)? "#F2F2F2" : "#979797"
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                Connections {
                    target: UserSettings
                    onUserCreationSucceeded: {
                        mainRoot.pop()
                        mainRoot.push("../Home.qml")
                        loginTracker = 0
                        selectedPage = "home"
                    }
                    onUserAlreadyExists: {
                        usernameWarning = 1
                    }
                    onUserCreationFailed: {
                        //Called when for some other reason user creation failed. Maybe server not accessible etc
                    }
                }
            }

            Label {
                id: closeButtonLabel
                z:10
                text: "BACK"
                anchors.bottom: combinationMark.top
                anchors.bottomMargin: 50
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 14
                font.family: "Brandon Grotesque"
                color: "#F2F2F2"

                Rectangle{
                    id: closeButton
                    height: 34
                    width: doubbleButtonWidth
                    radius: 4
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    color: "transparent"
                }

                MouseArea {
                    anchors.fill: closeButton

                    onClicked: {
                        loginTracker = 1
                        mainRoot.pop()
                        mainRoot.push("../Onboarding.qml")
                    }
                }
            }

            Image {
                id: combinationMark
                source: 'qrc:/icons/xby_logo_TM.svg'
                height: 23.4
                width: 150
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: setupScrollArea.bottom
                anchors.bottomMargin: 90
            }
        }
    }

    Rectangle {
        id: overlay
        width: Screen.width
        height: Screen.height
        color: "black"
        opacity: (accountCreated == 1)? 0.95 : 0
    }

    Rectangle {
        id: accountSuccess
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: 325
        height: 270
        radius: 5
        state: accountCreated == 1? "up" : "down"
        color: "#1B2934"


        states: [
            State {
                name: "up"
                PropertyChanges { target: accountSuccess; anchors.topMargin: (parent.height/2) - (accountSuccess.height/1.5)}
            },
            State {
                name: "down"
                PropertyChanges { target: accountSuccess; anchors.topMargin: parent.height + 50}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: accountSuccess; property: "anchors.topMargin"; duration: 300; easing.type: Easing.OutCubic}
            }
        ]

        Label {
            id: welcomeUser
            text: "WELCOME " + username
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            color: maincolor
            font.pixelSize: 24
            font.family: xciteMobile.name
            font.bold: true
        }

        Label {
            id: confirmCreation
            text: "Your account has been created."
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: welcomeUser.bottom
            anchors.topMargin: 10
            color: "#F2F2F2"
            font.pixelSize: 16
            font.family: xciteMobile.name
        }

        Text {
            id: passwordWarning
            width: doubbleButtonWidth
            maximumLineCount: 4
            anchors.left: confirmAccountButton.left
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            text: "<b>WARNING</b>: Do not forget to backup your password, THERE IS NO PASSWORD RECOVERY, without your password you cannot access your account!"
            anchors.bottom: confirmAccountButton.top
            anchors.bottomMargin: 15
            color: "#F2F2F2"
            font.pixelSize: 16
            font.family: xciteMobile.name
        }

        Rectangle {
            id: confirmAccountButton
            width: doubbleButtonWidth
            height: 33
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            radius: 5
            color: maincolor


            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                }

                onReleased: {
                    mainRoot.pop()
                    mainRoot.push("../InitialSetup.qml")
                    accountCreated = 0
                }
            }

            Text {
                id: confirmButtonText
                text: "UNDERSTOOD"
                font.family: xciteMobile.name
                font.pointSize: 14
                color: "#F2F2F2"
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
