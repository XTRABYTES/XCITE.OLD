/**
 * Filename: ImportAccount.qml
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

    function importWallet() {
        closeAllClipboard = true
        if (userName.text != "" && passWord.text != "" && networkError == 0) {
            importInitiated = true
            checkUsername = 1
            importAccount(userName.text, passWord.text)
        }
    }

    Rectangle {
        id: login
        anchors.horizontalCenter: parent.horizontalCenter
        width: loginModalBody.width
        height: loginModalLabel.height + loginModalLabel.anchors.bottomMargin + loginModalBody.height
        color: "transparent"
        visible: importTracker == 1
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
            text: "IMPORT AN EXISTING ACCOUNT"
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

            Keys.onEnterPressed: {
                closeAllClipboard = true
                importInitiated = true
                checkUsername = 1
                importAccount(userName.text, passWord.text)
            }

            Keys.onReturnPressed: {
                closeAllClipboard = true
                importInitiated = true
                checkUsername = 1
                importAccount(userName.text, passWord.text)
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
            visible: importInitiated == false

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
                text: "IMPORT ACCOUNT"
                font.family: xciteMobile.name
                font.pixelSize: parent.height/2
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
                    closeAllClipboard = true
                    importInitiated = true
                    checkUsername = 1
                    importAccount(userName.text, passWord.text)
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
            playing: importInitiated == true
            visible: importInitiated == true
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
            id: noAccount
            width: parent.width
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignJustify
            maximumLineCount: 5
            text: "Before you try to import an account, make sure you placed the exported wallet file in your device's download folder."
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: loginModalBody.bottom
            anchors.topMargin: font.pixelSize
            color: "#F2F2F2"
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
        }
    }

    Timer {
        id: importSuccesTimer
        interval: 2000
        repeat: false
        running: false

        onTriggered: {
            passError = 0
            networkError = 0
            loginTracker = 0
            sessionClosed = 0
            sessionStart = 1
            importInitiated  = false
            verifyingBalances = 0
        }
    }

    Connections {
        target: UserSettings

        onCreateUniqueKeyPair: {
            if (importTracker == 1) {
                checkUsername = 0
                keyPairSend = 1
            }
        }

        onCheckIdentity: {
            if (importTracker == 1) {
                keyPairSend = 0
                checkIdentity = 1
            }
        }

        onReceiveSessionEncryptionKey: {
            if (importTracker == 1) {
                checkIdentity = 0
                sessionKey = 1
            }
        }

        onReceiveSessionID: {
            if (importTracker == 1) {
                sessionKey = 0
                receiveSessionID = 1
            }
        }

        onLoadingSettings: {
            if (importTracker == 1) {
                receiveSessionID = 0
                loadingSettings = 1
            }
        }

        onContactsLoaded: {
            if (importTracker == 1) {
                loadContactList(contacts)
            }
        }

        onAddressesLoaded: {
            if (importTracker == 1) {
                loadAddressList(addresses)
            }
        }
        onWalletLoaded: {
            if (importTracker == 1) {
                loadWalletList(wallets)
            }
        }

        onPendingLoaded: {
            if (importTracker == 1){
                loadPendingList(pending)
            }
        }

        onClearSettings:{
            if (importTracker == 1) {
                clearSettings();
            }
        }

        onSettingsLoaded: {
            if (importTracker == 1) {
                loadSettings(settings);
                loadingSettings = 0
                verifyingBalances = 1
            }
        }

        onLoginSucceededChanged: {
            if (importTracker == 1) {
                mainRoot.pop()
                mainRoot.push("qrc:/+mobile/Home.qml")
                myUsername = userName.text.trim()
                tttSetUsername(myUsername)
                initializeTtt()
                importSuccesTimer.start()
                loadingSettings = 0
                verifyingBalances = 0
                status = userSettings.xChatDND === true? "dnd" : "idle"
                importInitiated  = false
            }
        }

        onLoginFailedChanged: {
            if (importTracker == 1) {
                checkUsername = 0
                keyPairSend = 0
                checkIdentity = 0
                sessionKey = 0
                receiveSessionID = 0
                loadingSettings = 0
                verifyingBalances = 0
                passError = 1
                passWord.text = ""
                importInitiated  = false
            }
        }

        onNoInternet: {
            if (importTracker == 1) {
                networkError = 1
                checkUsername = 0
                keyPairSend = 0
                checkIdentity = 0
                sessionKey = 0
                receiveSessionID = 0
                loadingSettings = 0
                verifyingBalances = 0
                passError = 1
                passWord.text = ""
                importInitiated  = false
            }
        }

        onUsernameAvailable: {
            if (importTracker == 1) {
                checkUsername = 0
                passError = 1
                passWord.text = ""
                importInitiated  = false
            }
        }
    }
}
