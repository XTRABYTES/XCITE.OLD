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
    width: appWidth
    height: appHeight

    property int passError: 0
    property int checkUsername: 0
    property int keyPairSend: 0
    property int checkIdentity: 0
    property int sessionKey: 0
    property int receiveSessionID: 0
    property int loadingSettings:  0
    property int verifyingBalances: 0

    function logIn() {
        closeAllClipboard = true
        if (userName.text != "" && passWord.text != "" && networkError == 0) {
            loginInitiated = true
            checkUsername = 1
            userLogin(userName.text, passWord.text)
        }
    }

    Rectangle {
        id: login
        anchors.horizontalCenter: parent.horizontalCenter
        width: loginModalBody.width
        height: loginModalLabel.height + loginModalLabel.anchors.bottomMargin + loginModalBody.height
        color: "transparent"
        visible: loginTracker == 1
        anchors.verticalCenter: parent.verticalCenter

        states: [
            State {
                name: "up"
                PropertyChanges { target: login; anchors.verticalCenterOffset: 0}
            },
            State {
                name: "down"
                PropertyChanges { target: login; anchors.verticalCenterOffset: appHeight}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: login; property: "anchors.verticalCenterOffset"; duration: 300; easing.type: Easing.OutCubic}
            }
        ]

        Label {
            id: loginModalLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: loginModalBody.top
            anchors.bottomMargin: font.pixelSize/2
            text: "LOG IN TO YOUR ACCOUNT"
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
            color: "#F2F2F2"
            font.letterSpacing: 2
        }

        Rectangle {
            id: loginModalBody
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            width: userName.width + appWidth/12
            height: userName.height + userName.anchors.topMargin + passWord.height + passWord.anchors.topMargin + logInButton.height*2 + logInButton.anchors.topMargin
            color: "#1B2934"
            border.color: "#f2f2f2"
            border.width: 1
        }

        Controls.TextInput {
            id: userName
            width: appWidth/4.5
            height: appHeight/18
            placeholder: "USERNAME"
            text: ""
            anchors.top: loginModalBody.top
            anchors.topMargin: height/2
            anchors.horizontalCenter: parent.horizontalCenter
            color: themecolor
            textBackground: "#0B0B09"
            mobile: 1
            font.pixelSize: height/2
            onTextChanged: {
                if (userName.text != "") {
                    passError = 0
                }
            }
        }

        Controls.TextInput {
            id: passWord
            height: appHeight/18
            width: appWidth/4.5
            placeholder: "PASSWORD"
            text: ""
            echoMode: TextInput.Password
            anchors.top: userName.bottom
            anchors.topMargin: height
            anchors.horizontalCenter: parent.horizontalCenter
            color: themecolor
            textBackground: "#0B0B09"
            mobile: 1
            font.pixelSize: height/2
            font.letterSpacing: 2
            onTextChanged: {
                if (passWord.text != "") {
                    passError = 0
                }
            }

            Keys.onEnterPressed: logIn()
            Keys.onReturnPressed: logIn()
        }

        Text {
            id: passWordError
            text: "Username & Password combination is not correct!"
            color: "#FD2E2E"
            anchors.left: passWord.left
            anchors.leftMargin: 5
            anchors.top: passWord.bottom
            anchors.topMargin: 1
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            visible: passError == 1
        }

        Rectangle {
            id: logInButton
            height: appHeight/27
            width: appWidth/6
            radius: height/2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: passWord.bottom
            anchors.topMargin: height*1.5
            color: "transparent"
            border.width: 1
            border.color: (userName.text != "" && passWord.text != "") ? "#F2F2F2" : "#727272"
            visible: loginInitiated == false

            Rectangle {
                id: selectLogin
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                id: logInButtonText
                text: "LOG IN"
                font.family: xciteMobile.name
                font.pointSize: 14
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }



            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    selectLogin.visible = true
                }

                onExited: {
                    selectLogin.visible = false
                }

                onPressed: {
                    click01.play()
                }

                onClicked: {
                    logIn()
                }
            }

        }

       AnimatedImage  {
            id: waitingDots
            source: 'qrc:/gifs/loading-gif_01.gif'
            width: 90
            height: 60
            anchors.horizontalCenter: logInButton.horizontalCenter
            anchors.bottom: loginModalBody.bottom
            anchors.bottomMargin: -10
            playing: loginInitiated == true
            visible: loginInitiated == true
        }

        Label {
            id: loginRespons
            text: "Checking username ..."
            anchors.horizontalCenter: logInButton.horizontalCenter
            anchors.verticalCenter: logInButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: appHeight/54
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
            font.pixelSize: appHeight/54
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
            font.pixelSize: appHeight/54
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
            font.pixelSize: appHeight/54
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
            font.pixelSize: appHeight/54
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
            font.pixelSize: appHeight/54
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
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            font.italic: true
            visible: verifyingBalances == 1
        }

        Label {
            id: importAccount
            text: "Import an existing account"
            anchors.verticalCenter: restoreAccount.verticalCenter
            anchors.right: restoreAccount.left
            anchors.rightMargin: appWidth/21
            color: "#F2F2F2"
            font.pixelSize: appHeight/45
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
                    hoverEnabled: true

                    onEntered: {
                        underlineImport.visible = true
                    }

                    onExited: {
                        underlineImport.visible = false
                    }

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
                anchors.top: parent.bottom
                anchors.topMargin: 5
                color: "#0ED8D2"
                visible: false
            }
        }

        Label {
            id: createAccount
            text: "Create an account"
            anchors.verticalCenter: (myOS == "android" || myOS == "ios")? undefined : restoreAccount.verticalCenter
            anchors.left: restoreAccount.right
            anchors.leftMargin: appWidth/21
            color: "#F2F2F2"
            font.pixelSize: appHeight/45
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
                    hoverEnabled: true

                    onEntered: {
                        underlineCreate.visible = true
                    }

                    onExited: {
                        underlineCreate.visible = false
                    }

                    onClicked: {
                        userSettings.accountCreationCompleted = false
                        mainRoot.pop()
                        selectedPage = "createAccount"
                        mainRoot.push("qrc:/+desktop/CreateAccount.qml")
                        loginTracker = 0
                    }
                }
            }

            Rectangle {
                id: underlineCreate
                width: createAccount.width
                height: 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                anchors.topMargin: 5
                color: "#0ED8D2"
                visible: false
            }
        }

        Label {
            id: restoreAccount
            text: "Restore an existing account"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: loginModalBody.bottom
            anchors.topMargin: appWidth/12
            color: "#F2F2F2"
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name

            Rectangle {
                id: restoreAccountButton
                width: restoreAccount.width
                height: 30
                anchors.horizontalCenter: restoreAccount.horizontalCenter
                anchors.verticalCenter: restoreAccount.verticalCenter
                color: "transparent"

                MouseArea {
                    anchors.fill: restoreAccountButton
                    hoverEnabled: true

                    onEntered: {
                        underlineRestore.visible = true
                    }

                    onExited: {
                        underlineRestore.visible = false
                    }

                    onClicked: {
                        loginTracker = 0
                        restoreTracker = 1
                    }
                }
            }

            Rectangle {
                id: underlineRestore
                width: restoreAccount.width
                height: 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                anchors.topMargin: 5
                color: "#0ED8D2"
                visible: false
            }
        }
    }

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
                if (userSettings.accountCreationCompleted) {
                    verifyingBalances = 1
                }
            }
        }

        onLoginSucceededChanged: {
            console.log("my username is: " + userName.text.trim())
            if (loginTracker == 1){
                mainRoot.pop()
                mainRoot.push("qrc:/+mobile/Home.qml")
                myUsername = userName.text.trim()
                tttSetUsername(myUsername)
                initializeTtt()
                loginSuccesTimer.start()
                loadingSettings = 0
                verifyingBalances = 0
                status = userSettings.xChatDND === true? "dnd" : "idle"
                loginInitiated  = false
            }
        }

        onLoginFailedChanged: {
            if (loginTracker == 1){
                verifyingBalances = 0
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

        onNoInternet: {
            if (loginTracker == 1){
                networkError = 1
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
