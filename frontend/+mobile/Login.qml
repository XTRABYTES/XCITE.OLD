/**
 * Filename: Login.qml
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

Item {
    id: loginModal
    width: Screen.width
    height: Screen.height

    property int passError: 0
    property bool loginInitiated: false
    property int checkUsername: 0
    property int keyPairSend: 0
    property int checkIdentity: 0
    property int sessionKey: 0
    property int receiveSessionID: 0
    property int loadingSettings:  0
    property int verifyingBalances: 0

    Rectangle {
        id: login
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: parent.width - 50
        height: 250
        state: loginTracker == 1? "up" : "down"
        color: "transparent"

        states: [
            State {
                name: "up"
                PropertyChanges { target: login; anchors.topMargin: (parent.height/2) - (login.height)}
            },
            State {
                name: "down"
                PropertyChanges { target: login; anchors.topMargin: parent.height + 50}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: login; property: "anchors.topMargin"; duration: 300; easing.type: Easing.OutCubic}
            }
        ]

        // login function

        Label {
            id: loginModalLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 27
            text: "LOG IN TO YOUR ACCOUNT"
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            color: "#F2F2F2"
            font.letterSpacing: 2
        }

        Rectangle {
            id: loginModalBody
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            width: parent.width
            height: parent.height - 50
            color: "#1B2934"
            opacity: 0.05

            LinearGradient {
                anchors.fill: parent
                source: parent
                start: Qt.point(x, y)
                end: Qt.point(x, parent.height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: "#0ED8D2" }
                }
            }
        }

        Rectangle {
            anchors.horizontalCenter: loginModalBody.horizontalCenter
            anchors.bottom: loginModalBody.bottom
            width: loginModalBody.width
            height: loginModalBody.height
            color: "transparent"
            border.color: maincolor
            border.width: 1
            opacity: 0.25
        }

        Controls.TextInput {
            id: userName
            height: 34
            placeholder: "USERNAME"
            text: ""
            anchors.top: loginModalBody.top
            anchors.topMargin: 25
            anchors.left: loginModalBody.left
            anchors.leftMargin: 25
            anchors.right: loginModalBody.right
            anchors.rightMargin: 25
            color: themecolor
            textBackground: "#0B0B09"
            mobile: 1
            font.pixelSize: 14
            onTextChanged: {
                if (userName.text != "") {
                    passError = 0
                }
            }
        }

        Controls.TextInput {
            id: passWord
            height: 34
            placeholder: "PASSWORD"
            text: ""
            echoMode: TextInput.Password
            anchors.top: userName.bottom
            anchors.topMargin: 30
            anchors.left: loginModalBody.left
            anchors.leftMargin: 25
            anchors.right: loginModalBody.right
            anchors.rightMargin: 25
            color: themecolor
            textBackground: "#0B0B09"
            mobile: 1
            font.pixelSize: 14
            font.letterSpacing: 2
            onTextChanged: {
                if (passWord.text != "") {
                    passError = 0
                }
            }
        }

        Text {
            id: passWordError
            text: "Username & Password combination is not correct!"
            color: "#FD2E2E"
            anchors.left: passWord.left
            anchors.leftMargin: 5
            anchors.top: passWord.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.weight: Font.Normal
            visible: passError == 1
        }

        Rectangle {
            id: logInButton
            height: 34
            anchors.bottom: loginModalBody.bottom
            anchors.bottomMargin: 20
            anchors.left: loginModalBody.left
            anchors.leftMargin: 25
            anchors.right: loginModalBody.right
            anchors.rightMargin: 25
            color: (userName.text != "" && passWord.text != "") ? "#1B2934" : "#727272"
            opacity: 0.50
            visible: loginInitiated == false

            Timer {
                id: loginSuccesTimer
                interval: 2000
                repeat: false
                running: false

                onTriggered: {
                    passError = 0
                    networkError = 0
                    loginTracker = 0
                    sessionClosed = 0
                    sessionStart = 1
                    loginInitiated  = false
                    verifyingBalances = 0
                }
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                }

                onReleased: {
                    closeAllClipboard = true
                    if (userName.text != "" && passWord.text != "" && networkError == 0) {
                        loginInitiated = true
                        checkUsername = 1
                        userLogin(userName.text, passWord.text)
                    }
                }
            }
            Connections {
                target: UserSettings

                onCreateUniqueKeyPair: {
                    if (loginTracker == 1){
                        checkUsername = 0
                        keyPairSend = 1
                    }
                }

                onCheckIdentity: {
                    if (loginTracker == 1){
                        keyPairSend = 0
                        checkIdentity = 1
                    }
                }

                onReceiveSessionEncryptionKey: {
                    if (loginTracker == 1){
                        checkIdentity = 0
                        sessionKey = 1
                    }
                }

                onReceiveSessionID: {
                    if (loginTracker == 1){
                        sessionKey = 0
                        receiveSessionID = 1
                    }
                }

                onLoadingSettings: {
                    if (loginTracker == 1){
                        receiveSessionID = 0
                        loadingSettings = 1
                    }
                }

                onContactsLoaded: {
                    if (loginTracker == 1){
                        loadContactList(contacts)
                    }
                }

                onAddressesLoaded: {
                    if (loginTracker == 1){
                        loadAddressList(addresses)
                    }
                }
                onWalletLoaded: {
                    if (loginTracker == 1){
                        loadWalletList(wallets)
                    }
                }

                onPendingLoaded: {
                    if (loginTracker == 1){
                        loadPendingList(pending)
                    }
                }

                onClearSettings:{
                    if (loginTracker == 1){
                        clearSettings();
                    }
                }

                onSettingsLoaded: {
                    if (loginTracker == 1){
                        loadSettings(settings);
                        loadingSettings = 0
                        verifyingBalances = 1
                    }
                }

                onLoginSucceededChanged: {
                    if (loginTracker == 1){
                        selectedPage = "home"
                        mainRoot.pop()
                        mainRoot.push("../Home.qml")
                        username = userName.text
                        loginSuccesTimer.start()
                        loadingSettings = 0
                        verifyingBalances = 0
                    }
                }

                onLoginFailedChanged: {
                    if (loginTracker == 1){
                        checkUsername = 0
                        keyPairSend = 0
                        checkIdentity = 0
                        sessionKey = 0
                        receiveSessionID = 0
                        loadingSettings = 0
                        passError = 1
                        passWord.text = ""
                        loginInitiated  = false
                    }
                }

                onUsernameAvailable: {
                    if (loginTracker == 1){
                        checkUsername = 0
                        passError = 1
                        passWord.text = ""
                        loginInitiated  = false
                    }
                }

                onWalletNotFound: {
                    if (loginTracker == 1){
                        checkUsername = 0
                        keyPairSend = 0
                        checkIdentity = 0
                        sessionKey = 0
                        receiveSessionID = 0
                        loadingSettings = 0
                        passWord.text = ""
                        loginInitiated  = false
                    }
                }
            }
        }

        Text {
            id: logInButtonText
            text: "LOG IN"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            color: (userName.text != "" && passWord.text != "") ? "#F2F2F2" : "#979797"
            font.bold: true
            anchors.horizontalCenter: logInButton.horizontalCenter
            anchors.verticalCenter: logInButton.verticalCenter
            visible: logInButton.visible
        }

        Rectangle {
            height: 34
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.left: loginModalBody.left
            anchors.leftMargin: 25
            anchors.right: loginModalBody.right
            anchors.rightMargin: 25
            color: "transparent"
            border.color: (userName.text != "" && passWord.text != "") ? maincolor : "#727272"
            opacity: 0.50
            visible: logInButton.visible
        }

        Label {
            id: loginRespons
            text: "Checking username ..."
            anchors.horizontalCenter: logInButton.horizontalCenter
            anchors.verticalCenter: logInButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: checkUsername == 1
        }

        Label {
            id: loginRespons1
            text: "Creating keypair for session ..."
            anchors.horizontalCenter: logInButton.horizontalCenter
            anchors.verticalCenter: logInButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: keyPairSend == 1
        }

        Label {
            id: loginRespons2
            text: "Checking identity ..."
            anchors.horizontalCenter: logInButton.horizontalCenter
            anchors.verticalCenter: logInButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: checkIdentity == 1
        }

        Label {
            id: loginRespons3
            text: "Retrieving session encryption key ..."
            anchors.horizontalCenter: logInButton.horizontalCenter
            anchors.verticalCenter: logInButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: sessionKey == 1
        }

        Label {
            id: loginRespons4
            text: "Retrieving session ID ..."
            anchors.horizontalCenter: logInButton.horizontalCenter
            anchors.verticalCenter: logInButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: receiveSessionID == 1
        }

        Label {
            id: loginRespons5
            text: "Loading account settings ..."
            anchors.horizontalCenter: logInButton.horizontalCenter
            anchors.verticalCenter: logInButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: loadingSettings == 1
        }

        Label {
            id: loginRespons6
            text: "Verifying wallet balances ..."
            anchors.horizontalCenter: logInButton.horizontalCenter
            anchors.verticalCenter: logInButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: verifyingBalances == 1
        }

        Label {
            id: importAccount
            text: "Import an existing account?"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: login.bottom
            anchors.topMargin: 20
            color: "#F2F2F2"
            font.pixelSize: 18
            font.family: xciteMobile.name

            Rectangle {
                id: importAccountButton
                width: importAccount.width
                height: 30
                anchors.horizontalCenter: importAccount.horizontalCenter
                anchors.verticalCenter: importAccount.verticalCenter
                color: "transparent"

                MouseArea {
                    anchors.fill: importAccountButton

                    onClicked: {
                        loginTracker = 0
                        importTracker = 1
                    }
                }
            }

            Rectangle {
                id: underlineImport
                width: importAccount.width
                height: 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: importAccount.bottom
                anchors.topMargin: 5
                color: "#0ED8D2"
            }
        }

        Label {
            id: noAccount
            text: "You don't have an account?"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: login.bottom
            anchors.topMargin: 70
            color: "#F2F2F2"
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Label {
            id: createAccount
            text: "Create one here."
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: noAccount.bottom
            anchors.topMargin: 15
            color: "#F2F2F2"
            font.pixelSize: 18
            font.family: xciteMobile.name

            Rectangle {
                id: createAccountButton
                width: createAccount.width
                height: 30
                anchors.horizontalCenter: createAccount.horizontalCenter
                anchors.verticalCenter: createAccount.verticalCenter
                color: "transparent"

                MouseArea {
                    anchors.fill: createAccountButton

                    onClicked: {
                        userSettings.accountCreationCompleted = false
                        mainRoot.pop()
                        mainRoot.push("../CreateAccount.qml")
                        loginTracker = 0
                    }
                }
            }
        }

        Rectangle {
            id: underlineCreate
            width: createAccount.width
            height: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: createAccount.bottom
            anchors.topMargin: 5
            color: "#0ED8D2"
        }
    }
}
