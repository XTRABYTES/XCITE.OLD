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
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: backgroundSignUp
    width: appWidth
    height: appHeight
    anchors.horizontalCenter: xcite.horizontalCenter
    anchors.verticalCenter: xcite.verticalCenter
    color: "#14161B"

    Image {
        id: largeLogo
        source: 'qrc:/icons/XBY_logo_large.svg'
        height: appHeight / 75 * 65
        fillMode: Image.PreserveAspectFit
        anchors.top: parent.top
        anchors.topMargin: appHeight/18
        anchors.horizontalCenter: parent.left
        opacity: 0.5
    }

    property int accountCreated: 0
    property int usernameWarning: 0
    property int passwordWarning1: 0
    property int passwordWarning2: 0
    property int availableUsername: 0
    property int signUpError: 0
    property int selectStorage: 0
    property int storageSwitchState: 0
    property int verifyUsername : 0
    property int saveFailed: 0
    property string failError: ""
    property int checkUsername: 0
    property int keyPairSend: 0
    property int sessionKey: 0
    property int receiveSessionID: 0
    property int savingSettings:  0

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

    Item {
        id: setupArea
        width: parent.width
        height: welcomeText.height
                + createAccountText.height + createAccountText.anchors.topMargin
                + createUsernameText.height + createUsernameText.anchors.topMargin
                + userName.height + userName.anchors.topMargin
                + createPasswordText.height + createPasswordText.anchors.topMargin
                + passWord1.height + passWord1.anchors.topMargin
                + passWord2.height + passWord2.anchors.topMargin
                + createAccountButton.height*2 + createAccountButton.anchors.topMargin
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        state: (accountCreated == 0  && signUpError == 0)? "up" : "down"

        states: [
            State {
                name: "up"
                PropertyChanges { target: setupArea; anchors.verticalCenterOffset: 0}
            },
            State {
                name: "down"
                PropertyChanges { target: setupArea; anchors.verticalCenterOffset: appHeight * 1.5}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: setupArea; property: "anchors.verticalCenterOffset"; duration: 300; easing.type: Easing.InOutCubic}
            }
        ]



        Label {
            id: welcomeText
            text: "WELCOME TO XCITE"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            color: maincolor
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
        }

        Label {
            id: createAccountText
            text: "Let's get started by creating an account"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: welcomeText.bottom
            anchors.topMargin: font.pixelSize*2
            color: "#F2F2F2"
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
        }

        Text {
            id: createUsernameText
            width: appWidth/3
            maximumLineCount: 3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: createAccountText.bottom
            anchors.topMargin: font.pixelSize*2
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            text: "Choose a username, only alphanumeric characters are allowed, no spaces, minimum 6 and no more than 12 characters"
            color: "#F2F2F2"
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
        }

        Controls.TextInput {
            id: userName
            height: appHeight/18
            width: appWidth/4.5
            placeholder: "USERNAME"
            text: ""
            mobile: 1
            deleteBtn: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: createUsernameText.bottom
            anchors.topMargin: font.pixelSize/2
            color: themecolor
            rightPadding: checkButton.width*1.75
            textBackground: "#0B0B09"
            font.pixelSize: height/2
            validator: RegExpValidator { regExp: /[0-9A-Za-z]+/ }

            onTextChanged: {
                usernameLength(userName.text)
                availableUsername = 0
                verifyUsername = 0
            }

            Image {
                id: checkButton
                source: 'qrc:/icons/icon-questionmark_01.svg'
                height: parent.height*2/3
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: height/2
                visible: verifyUsername == 0

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            verifyUsername = 1
                            userExists(userName.text)
                        }
                    }

                    Connections {
                        target: UserSettings
                        onUserAlreadyExists: {
                            usernameWarning = 1
                        }

                        onUsernameAvailable: {
                            availableUsername = 1
                            usernameWarning = 2
                        }

                        onNoInternet: {
                            networkError = 1
                        }

                        onSettingsServerError: {
                            networkError = 1
                        }
                    }
                }
            }

            Image {
                id: usernameOK
                source: 'qrc:/icons/icon-ok_01.svg'
                height: parent.height*2/3
                fillMode: Image.PreserveAspectFit
                rotation: availableUsername == 1? 0 : 180
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: height/2
                visible: verifyUsername == 1
            }
        }

        Label {
            id: usernameWarningText1
            text: userName.text != ""? (usernameWarning == 0? "" : (usernameWarning == 1? "This Username already exists!" : (usernameWarning == 2? "Username unknown!": (usernameWarning == 3? "Username too short!" : (usernameWarning == 4? "Username too long" : ""))))) : ""
            color: usernameWarning == 2 ? "#4BBE2E" : "#FD2E2E"
            anchors.left: userName.left
            anchors.leftMargin: 5
            anchors.top: userName.bottom
            anchors.topMargin: 1
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
        }

        Text {
            id: createPasswordText
            width: appWidth/3
            maximumLineCount: 4
            anchors.left: createUsernameText.left
            anchors.top: userName.bottom
            anchors.topMargin: font.pixelSize
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            text: "Choose a password, it should contain at least one capital letter, one number and one special character, and it must be at least 8 characters long."
            color: "#F2F2F2"
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
        }

        Controls.TextInput {
            id: passWord1
            height: appHeight/18
            width: appWidth/4.5
            placeholder: "PASSWORD"
            text: ""
            mobile: 1
            echoMode: TextInput.Password
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: createPasswordText.bottom
            anchors.topMargin: height/2
            color: themecolor
            textBackground: "#0B0B09"
            font.pixelSize: height/2
            deleteBtn: passwordWarning1 == 0? 0 : 1

            onTextChanged: {
                //check if password has valid format
                validation(passWord1.text);
            }

            Image {
                id: pass1OK
                source: 'qrc:/icons/icon-ok_01.svg'
                height: parent.height*2/3
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: height/2
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
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
        }

        Controls.TextInput {
            id: passWord2
            height: appHeight/18
            width: appWidth/4.5
            placeholder: "RETYPE PASSWORD"
            text: ""
            mobile: 1
            echoMode: TextInput.Password
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: passWord1.bottom
            anchors.topMargin: height/2
            color: themecolor
            textBackground: "#0B0B09"
            font.pixelSize: height/2
            deleteBtn: passwordWarning2 == 0? 0 : 1

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
                height: parent.height*2/3
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: height/2
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
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
        }

        Rectangle {
            id: createAccountButton
            width: appWidth/6
            height: appHeight/27
            radius: height/2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: passWord2.bottom
            anchors.topMargin: height
            color: "transparent"
            border.color: ((usernameWarning == 0 || usernameWarning == 2) && passwordWarning1 == 0 && passwordWarning2 == 0 && userName.text != "" && passWord1.text != "" && passWord2.text != "")? "#f2f2f2" : "#727272"
            visible: createAccountInitiated == false

            Rectangle {
                id: selectCreate
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                id: createButtonText
                text: "CREATE ACCOUNT"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Timer {
                id: accountCreationTimer
                interval: 1000
                repeat: false
                running: false

                onTriggered: {
                    usernameWarning = 1
                    checkUsername = 0
                    keyPairSend = 0
                    sessionKey = 0
                    receiveSessionID = 0
                    savingSettings = 0
                    availableUsername = 0
                    passWord1.text = ""
                    passWord2.text = ""
                    createAccountInitiated = false
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                enabled: ((usernameWarning == 0 || usernameWarning == 2) && passwordWarning1 == 0 && passwordWarning2 == 0 && userName.text != "" && passWord1.text != "" && passWord2.text != "")

                onEntered: {
                    selectCreate.visible =true
                }

                onExited: {
                    selectCreate.visible = false
                }

                onPressed: {
                    click01.play()
                }

                onClicked: {
                    createAccountInitiated = true
                    checkUsername = 1
                    createUser(userName.text.toLocaleLowerCase(), passWord1.text)
                }
            }

            Connections {
                target: UserSettings

                onCreateUniqueKeyPair: {
                    checkUsername = 0
                    keyPairSend = 1
                }

                onReceiveSessionEncryptionKey: {
                    keyPairSend = 0
                    sessionKey = 1
                }

                onReceiveSessionID: {
                    sessionKey = 0
                    receiveSessionID = 1
                }

                onLoadingSettings: {
                    receiveSessionID = 0
                    savingSettings = 1
                }

                onUserCreationSucceeded: {
                    if (createAccountInitiated == true) {
                        userSettings.locale = "en_us"
                        userSettings.defaultCurrency = 0
                        userSettings.theme = "dark"
                        userSettings.pinlock = false
                        userSettings.xby = true
                        userSettings.xfuel = true
                        userSettings.xtest = true
                        userSettings.btc = true
                        userSettings.eth = true
                        userSettings.sound = 0
                        userSettings.volume = 1
                        userSettings.systemVolume = 1
                        userSettings.tagMe = true
                        userSettings.tagEveryone = true
                        userSettings.accountCreationCompleted = false
                        initialisePincode("0000");
                        contactList.setProperty(0, "firstName", "My addresses");
                        updateToAccount();
                        myUsername = userName.text.trim()
                        newAccount = true
                        accountCreated = 1
                        availableUsername = 0
                        networkError = 0
                        signUpError = 0
                        createAccountInitiated = false
                        closeAllClipboard = true
                    }
                }

                onUserAlreadyExists: {
                    if (createAccountInitiated == true) {
                        accountCreationTimer.start()
                    }
                }

                onUserCreationFailed: {
                    if (createAccountInitiated == true) {
                        signUpError = 1
                        checkUsername = 0
                        keyPairSend = 0
                        sessionKey = 0
                        receiveSessionID = 0
                        savingSettings = 0
                        userName.text = ""
                        passWord1.text = ""
                        passWord2.text = ""
                        createAccountInitiated = false
                    }
                }

                onNoInternet: {
                    if (createAccountInitiated == true) {
                        networkError = 1
                        signUpError = 1
                        checkUsername = 0
                        keyPairSend = 0
                        sessionKey = 0
                        receiveSessionID = 0
                        savingSettings = 0
                        userName.text = ""
                        passWord1.text = ""
                        passWord2.text = ""
                        createAccountInitiated = false
                    }
                }

                onSaveFailedDBError: {
                    if (createAccountInitiated == true) {
                        failError = "Database ERROR"
                        signUpError = 1
                        checkUsername = 0
                        keyPairSend = 0
                        sessionKey = 0
                        receiveSessionID = 0
                        savingSettings = 0
                        userName.text = ""
                        passWord1.text = ""
                        passWord2.text = ""
                        createAccountInitiated = false

                    }
                }

                onSaveFailedAPIError: {
                    if (createAccountInitiated == true) {
                        failError = "Network ERROR"
                        signUpError = 1
                        checkUsername = 0
                        keyPairSend = 0
                        sessionKey = 0
                        receiveSessionID = 0
                        savingSettings = 0
                        userName.text = ""
                        passWord1.text = ""
                        passWord2.text = ""
                        createAccountInitiated = false
                    }
                }

                onSaveFailedInputError: {
                    if (createAccountInitiated == true) {
                        signUpError = 1
                        checkUsername = 0
                        keyPairSend = 0
                        sessionKey = 0
                        receiveSessionID = 0
                        savingSettings = 0
                        userName.text = ""
                        passWord1.text = ""
                        passWord2.text = ""
                        createAccountInitiated = false
                    }
                }

                onSaveFailedUnknownError: {
                    if (createAccountInitiated == true) {
                        signUpError = 1
                        checkUsername = 0
                        keyPairSend = 0
                        sessionKey = 0
                        receiveSessionID = 0
                        savingSettings = 0
                        userName.text = ""
                        passWord1.text = ""
                        passWord2.text = ""
                        createAccountInitiated = false
                    }
                }
            }
        }

        Label {
            id: createRespons
            text: "Checking username ..."
            anchors.horizontalCenter: createAccountButton.horizontalCenter
            anchors.verticalCenter: createAccountButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: checkUsername == 1
        }

        Label {
            id: createRespons1
            text: "Creating keypair for session ..."
            anchors.horizontalCenter: createAccountButton.horizontalCenter
            anchors.verticalCenter: createAccountButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: keyPairSend == 1
        }

        Label {
            id: createRespons2
            text: "Retrieving session encryption key..."
            anchors.horizontalCenter: createAccountButton.horizontalCenter
            anchors.verticalCenter: createAccountButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: sessionKey == 1
        }

        Label {
            id: loginRespons3
            text: "Saving account settings ..."
            anchors.horizontalCenter: createAccountButton.horizontalCenter
            anchors.verticalCenter: createAccountButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: savingSettings == 1
        }

        Label {
            id: createRespons4
            text: "Retrieving session ID ..."
            anchors.horizontalCenter: createAccountButton.horizontalCenter
            anchors.verticalCenter: createAccountButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: receiveSessionID == 1
        }

        Label {
            id: closeButtonLabel
            text: "BACK"
            anchors.top: createAccountButton.bottom
            anchors.topMargin: appWidth/48
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            color: "#F2F2F2"
            visible: accountCreated == 0

            Rectangle{
                id: closeButton
                anchors.fill: parent
                color: "transparent"
            }

            MouseArea {
                anchors.fill: closeButton
                hoverEnabled: true

                onEntered: {
                    parent.color = maincolor
                }

                onExited:  {
                    parent.color = "#f2f2f2"
                }

                onClicked: {
                    loginTracker = 1
                    selectedPage = "onBoarding"
                    mainRoot.pop()
                    mainRoot.push("qrc:/+desktop/Onboarding.qml")
                }
            }
        }
    }

    // Account creation failed

    Item {
        id: accountFailed
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: appWidth/3
        height: failedIcon.height + creationFailedLabel.height + creationFailedLabel.anchors.topMargin + closeFail.height + closeFail.anchors.topMargin
        state: signUpError == 1? "up" : "down"

        states: [
            State {
                name: "up"
                PropertyChanges { target: accountFailed; anchors.verticalCenterOffset: 0}
            },
            State {
                name: "down"
                PropertyChanges { target: accountFailed; anchors.verticalCenterOffset: appHeight * 1.5}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: accountFailed; property: "anchors.verticalCenterOffset"; duration: 300; easing.type: Easing.InOutCubic}
            }
        ]

        Image {
            id: failedIcon
            source: 'qrc:/icons/mobile/failed-icon_01_light.svg'
            height: appHeight/12
            fillMode: Image.PreserveAspectFit
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            id: creationFailedLabel
            text: "Account creation failed!"
            anchors.top: failedIcon.bottom
            anchors.topMargin: font.pixelSize
            anchors.horizontalCenter: failedIcon.horizontalCenter
            color: maincolor
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
        }

        Rectangle {
            id: closeFail
            width: appWidth/6
            height: appHeight/27
            radius: height/2
            color: "transparent"
            border.color: "#f2f2f2"
            border.width: 1
            anchors.top: creationFailedLabel.bottom
            anchors.topMargin: height*1.5
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: selectFailed
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                text: "TRY AGAIN"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: closeFail
                hoverEnabled: true

                onEntered: {
                    selectFailed.visible = true
                }

                onExited: {
                    selectFailed.visible = false
                }

                onPressed: {
                    click01.play()
                }

                onClicked: {
                    signUpError = 0;
                    failError = ""

                }
            }
        }
    }

    Item {
        id: accountSuccess
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: appWidth/3
        height: welcomeUser.height + confirmCreation.height + confirmCreation.anchors.topMargin + passwordWarning.height + passwordWarning.anchors.topMargin + confirmAccountButton.height + confirmAccountButton.anchors.topMargin
        state: accountCreated == 1? "up" : "down"

        states: [
            State {
                name: "up"
                PropertyChanges { target: accountSuccess; anchors.verticalCenterOffset: 0}
            },
            State {
                name: "down"
                PropertyChanges { target: accountSuccess; anchors.verticalCenterOffset: appHeight * 1.5}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: accountSuccess; property: "anchors.verticalCenterOffset"; duration: 300; easing.type: Easing.InOutCubic}
            }
        ]

        Label {
            id: welcomeUser
            text: "WELCOME " + myUsername
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            color: maincolor
            font.pixelSize: appHeight/36
            font.family: xciteMobile.name
            visible: selectStorage == 0
        }

        Label {
            id: confirmCreation
            text: "Your account has been created."
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: welcomeUser.bottom
            anchors.topMargin: font.pixelSize
            color: "#F2F2F2"
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
            visible: selectStorage == 0
        }

        Text {
            id: passwordWarning
            width: appWidth/3
            maximumLineCount: 4
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            text: "<b>WARNING</b>: Do not forget to backup your password, THERE IS NO PASSWORD RECOVERY, without your password you cannot access your account!"
            anchors.top: confirmCreation.bottom
            anchors.topMargin: font.pixelSize*1.5
            color: "#F2F2F2"
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
            visible: selectStorage == 0
        }

        Rectangle {
            id: confirmAccountButton
            width: appWidth/6
            height: appHeight/27
            radius: height/2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: passwordWarning.bottom
            anchors.topMargin: height*1.5
            color: "transparent"
            border.color: "#f2f2f2"
            border.width: 1
            visible: selectStorage == 0

            Rectangle {
                id: selectConfirm
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                id: confirmButtonText
                text: "UNDERSTOOD"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    selectConfirm.visible = true
                }

                onExited: {
                    selectConfirm.visible = false
                }

                onPressed: {
                    click01.play()
                }

                onReleased: {
                    // save account status to server
                    selectStorage = 1
                    storageSwitchState = 0
                }
            }
        }
    }

    Item {
        id: addWalletText
        width: parent.width
        height : addWalletText1.height + addWalletText2.height +addWalletText2.anchors.topMargin + addWalletText3.height + addWalletText3.anchors.topMargin + storageSwitch.height + storageSwitch.anchors.topMargin + continueButton.height + continueButton.anchors.topMargin
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: selectStorage == 1

        Label {
            id: addWalletText1
            width: appWidth/3
            maximumLineCount: 3
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            text: "You can now add a wallet. You can choose to store your wallet keys on your device or in your account."
            anchors.top: parent.top
            color: themecolor
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
            font.bold: true
        }

        Label {
            id: addWalletText2
            width: appWidth/3
            maximumLineCount: 3
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            text: "Storing your keys on your device will require you to import your keys in all the devices you wish to access your wallet from."
            anchors.top: addWalletText1.bottom
            anchors.topMargin: font.pixelSize
            color: themecolor
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
        }

        Label {
            id: addWalletText3
            width: appWidth/3
            maximumLineCount: 3
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            text: "Storing your keys in your account will allow you to access your wallet from any device running XCITE Mobile."
            anchors.top: addWalletText2.bottom
            anchors.topMargin: font.pixelSize
            color: themecolor
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
        }

        Controls.Switch {
            id: storageSwitch
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addWalletText3.bottom
            anchors.topMargin: appWidth/24
            state: storageSwitchState == 0 ? "off" : "on"


            onStateChanged: {
                if (storageSwitch.state === "off") {
                    userSettings.localKeys = false
                }
                else {
                    userSettings.localKeys = true
                }
            }
        }

        Text {
            id: activeText
            text: "ACCOUNT"
            anchors.right: storageSwitch.left
            anchors.rightMargin: font.pixelSize/2
            anchors.verticalCenter: storageSwitch.verticalCenter
            font.pixelSize: appHeight/36
            font.family: xciteMobile.name
            color: storageSwitch.switchOn ? "#757575" : maincolor
        }

        Text {
            id: viewText
            text: "DEVICE"
            anchors.left: storageSwitch.right
            anchors.leftMargin: font.pixelSize/2
            anchors.verticalCenter: storageSwitch.verticalCenter
            font.pixelSize: appHeight/36
            font.family: xciteMobile.name
            color: storageSwitch.switchOn ? maincolor : "#757575"
        }

        Rectangle {
            id: continueButton
            width: appWidth/6
            height: appHeight/27
            radius: height/2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: storageSwitch.bottom
            anchors.topMargin: height*1.5
            color: "transparent"
            border.color: "#f2f2f2"
            border.width: 1
            visible: saveAccountInitiated == false

            Rectangle {
                id: selectContinue
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                id: continueButtonText
                text: saveFailed == 0? "CONTINUE" : "TRY AGAIN"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    selectContinue.visible = true
                }

                onExited: {
                    selectContinue.visible = false
                }

                onPressed: {
                    click01.play()
                }

                onClicked: {
                    saveAccountInitiated = true
                    saveAppSettings()
                }
            }

            Connections {
                target: UserSettings

                onSaveSucceeded: {
                    if (saveAccountInitiated == true) {
                        mainRoot.pop()
                        selectedPage = "initialSetup"
                        mainRoot.push("qrc:/+desktop/InitialSetup.qml")
                        accountCreated = 0
                        selectStorage = 0
                        saveAccountInitiated = false
                    }
                }

                onSaveFailed: {
                    if (saveAccountInitiated == true) {
                        saveFailed = 1
                        saveAccountInitiated = false
                    }
                }

                onNoInternet: {
                    if (saveAccountInitiated == true) {
                        networkError = 1
                        saveFailed = 1
                        saveAccountInitiated = false
                    }
                }
            }
        }

        AnimatedImage {
            id: waitingDots2
            source: 'qrc:/gifs/loading-gif_01.gif'
            width: 90
            height: 60
            anchors.horizontalCenter: continueButton.horizontalCenter
            anchors.verticalCenter: continueButton.verticalCenter
            playing: saveAccountInitiated == true
            visible: saveAccountInitiated == true
        }
    }
}

