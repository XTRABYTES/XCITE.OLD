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
    id: restoreModal
    width: appWidth
    height: appHeight
    anchors.horizontalCenter: xcite.horizontalCenter
    //anchors.verticalCenter: xcite.verticalCenter

    property int passError: 0
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
        state: restoreTracker == 1? "up" : "down"
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
            id: restoreModalLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 27
            text: "RESTORE AN EXISTING ACCOUNT"
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            color: "#F2F2F2"
            font.letterSpacing: 2
        }

        Rectangle {
            id: restoreModalBody
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

        Controls.TextInput {
            id: userName
            height: 34
            placeholder: "USERNAME"
            text: ""
            anchors.top: restoreModalBody.top
            anchors.topMargin: 25
            anchors.left: restoreModalBody.left
            anchors.leftMargin: 25
            anchors.right: restoreModalBody.right
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
            anchors.left: restoreModalBody.left
            anchors.leftMargin: 25
            anchors.right: restoreModalBody.right
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
            id: restoreButton
            height: 34
            anchors.bottom: restoreModalBody.bottom
            anchors.bottomMargin: 20
            anchors.left: restoreModalBody.left
            anchors.leftMargin: 25
            anchors.right: restoreModalBody.right
            anchors.rightMargin: 25
            color: (userName.text != "" && passWord.text != "") ? "#1B2934" : "#727272"
            opacity: 0.50
            visible: restoreInitiated == false

            Timer {
                id: restoreSuccesTimer
                interval: 2000
                repeat: false
                running: false

                onTriggered: {
                    passError = 0
                    networkError = 0
                    loginTracker = 0
                    sessionClosed = 0
                    sessionStart = 1
                    restoreInitiated  = false
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
                        restoreInitiated = true
                        checkUsername = 1
                        restoreAccount(userName.text, passWord.text)
                    }
                }
            }
            Connections {
                target: UserSettings

                onCreateUniqueKeyPair: {
                    if (restoreTracker == 1) {
                        checkUsername = 0
                        keyPairSend = 1
                    }
                }

                onCheckIdentity: {
                    if (restoreTracker == 1) {
                        keyPairSend = 0
                        checkIdentity = 1
                    }
                }

                onReceiveSessionEncryptionKey: {
                    if (restoreTracker == 1) {
                        checkIdentity = 0
                        sessionKey = 1
                    }
                }

                onReceiveSessionID: {
                    if (restoreTracker == 1) {
                        sessionKey = 0
                        receiveSessionID = 1
                    }
                }

                onLoadingSettings: {
                    if (restoreTracker == 1) {
                        receiveSessionID = 0
                        loadingSettings = 1
                    }
                }

                onContactsLoaded: {
                    if (restoreTracker == 1) {
                        loadContactList(contacts)
                    }
                }

                onAddressesLoaded: {
                    if (restoreTracker == 1) {
                        loadAddressList(addresses)
                    }
                }
                onWalletLoaded: {
                    if (restoreTracker == 1) {
                        loadWalletList(wallets)
                    }
                }

                onPendingLoaded: {
                    if (restoreTracker == 1){
                        loadPendingList(pending)
                    }
                }

                onClearSettings:{
                    if (restoreTracker == 1) {
                        clearSettings();
                    }
                }

                onSettingsLoaded: {
                    if (restoreTracker == 1) {
                        loadSettings(settings);
                        loadingSettings = 0
                        verifyingBalances = 1
                    }
                }

                onLoginSucceededChanged: {
                    if (restoreTracker == 1) {
                        mainRoot.pop()
                        mainRoot.push("../Home.qml")
                        myUsername = userName.text.trim()
                        restoreSuccesTimer.start()
                        loadingSettings = 0
                        verifyingBalances = 0
                        restoreInitiated  = false
                    }
                }

                onLoginFailedChanged: {
                    if (restoreTracker == 1) {
                        checkUsername = 0
                        keyPairSend = 0
                        checkIdentity = 0
                        sessionKey = 0
                        receiveSessionID = 0
                        loadingSettings = 0
                        verifyingBalances = 0
                        passError = 1
                        passWord.text = ""
                        restoreInitiated  = false
                    }
                }

                onNoInternet: {
                    if (restoreTracker == 1) {
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
                        restoreInitiated  = false
                    }
                }

                onUsernameAvailable: {
                    if (restoreTracker == 1) {
                        checkUsername = 0
                        passError = 1
                        passWord.text = ""
                        restoreInitiated  = false
                    }
                }
            }
        }

        Text {
            id: restoreButtonText
            text: "RESTORE ACCOUNT"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            color: (userName.text != "" && passWord.text != "") ? "#F2F2F2" : "#979797"
            font.bold: true
            anchors.horizontalCenter: restoreButton.horizontalCenter
            anchors.verticalCenter: restoreButton.verticalCenter
            visible: restoreButton.visible
        }

        Rectangle {
            height: 34
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.left: restoreModalBody.left
            anchors.leftMargin: 25
            anchors.right: restoreModalBody.right
            anchors.rightMargin: 25
            color: "transparent"
            border.color: (userName.text != "" && passWord.text != "") ? maincolor : "#727272"
            opacity: 0.50
            visible: restoreButton.visible
        }

        Label {
            id: restoreRespons
            text: "Checking username ..."
            anchors.horizontalCenter: restoreButton.horizontalCenter
            anchors.verticalCenter: restoreButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: checkUsername == 1
        }

        Label {
            id: restoreRespons1
            text: "Creating keypair for session ..."
            anchors.horizontalCenter: restoreButton.horizontalCenter
            anchors.verticalCenter: restoreButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: keyPairSend == 1
        }

        Label {
            id: restoreRespons2
            text: "Checking identity ..."
            anchors.horizontalCenter: restoreButton.horizontalCenter
            anchors.verticalCenter: restoreButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: checkIdentity == 1
        }

        Label {
            id: restoreRespons3
            text: "Retrieving session encryption key ..."
            anchors.horizontalCenter: restoreButton.horizontalCenter
            anchors.verticalCenter: restoreButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: sessionKey == 1
        }

        Label {
            id: restoreRespons4
            text: "Retrieving session ID ..."
            anchors.horizontalCenter: restoreButton.horizontalCenter
            anchors.verticalCenter: restoreButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: receiveSessionID == 1
        }

        Label {
            id: restoreRespons5
            text: "Loading account settings ..."
            anchors.horizontalCenter: restoreButton.horizontalCenter
            anchors.verticalCenter: restoreButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: loadingSettings == 1
        }

        Label {
            id: restoreRespons6
            text: "Verifying wallet balances ..."
            anchors.horizontalCenter: restoreButton.horizontalCenter
            anchors.verticalCenter: restoreButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: verifyingBalances == 1
        }

        Rectangle {
            anchors.horizontalCenter: restoreModalBody.horizontalCenter
            anchors.bottom: restoreModalBody.bottom
            width: restoreModalBody.width
            height: restoreModalBody.height
            color: "transparent"
            border.color: maincolor
            border.width: 1
            opacity: 0.25
        }



        Label {
            id: noAccount
            width: doubbleButtonWidth
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignJustify
            maximumLineCount: 5
            text: "If you try to restore an account, you need to use a device with which you already used the account."
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: login.bottom
            anchors.topMargin: 70
            color: "#F2F2F2"
            font.pixelSize: 18
            font.family: xciteMobile.name
        }
    }
}

