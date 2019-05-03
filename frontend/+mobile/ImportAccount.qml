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
    id: importModal
    width: Screen.width
    height: Screen.height

    property int passError: 0
    property bool importInitiated: false
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
        state: importTracker == 1? "up" : "down"
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
            id: importModalLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 27
            text: "IMPORT AN EXISTING ACCOUNT"
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            color: "#F2F2F2"
            font.letterSpacing: 2
        }

        Rectangle {
            id: importModalBody
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
            anchors.top: importModalBody.top
            anchors.topMargin: 25
            anchors.left: importModalBody.left
            anchors.leftMargin: 25
            anchors.right: importModalBody.right
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
            anchors.left: importModalBody.left
            anchors.leftMargin: 25
            anchors.right: importModalBody.right
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
            id: importButton
            height: 34
            anchors.bottom: importModalBody.bottom
            anchors.bottomMargin: 20
            anchors.left: importModalBody.left
            anchors.leftMargin: 25
            anchors.right: importModalBody.right
            anchors.rightMargin: 25
            color: (userName.text != "" && passWord.text != "") ? "#1B2934" : "#727272"
            opacity: 0.50
            visible: importInitiated == false

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

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                }

                onReleased: {
                    closeAllClipboard = true
                    if (userName.text != "" && passWord.text != "" && networkError == 0) {
                        importInitiated = true
                        checkUsername = 1
                        importAccount(userName.text, passWord.text)
                    }
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
                        selectedPage = "home"
                        mainRoot.pop()
                        mainRoot.push("../Home.qml")
                        username = userName.text
                        importSuccesTimer.start()
                        loadingSettings = 0
                        verifyingBalances = 0
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

        Text {
            id: importButtonText
            text: "IMPORT ACCOUNT"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            color: (userName.text != "" && passWord.text != "") ? "#F2F2F2" : "#979797"
            font.bold: true
            anchors.horizontalCenter: importButton.horizontalCenter
            anchors.verticalCenter: importButton.verticalCenter
            visible: importButton.visible
        }

        Rectangle {
            height: 34
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.left: importModalBody.left
            anchors.leftMargin: 25
            anchors.right: importModalBody.right
            anchors.rightMargin: 25
            color: "transparent"
            border.color: (userName.text != "" && passWord.text != "") ? maincolor : "#727272"
            opacity: 0.50
            visible: importButton.visible
        }

        Label {
            id: importRespons
            text: "Checking username ..."
            anchors.horizontalCenter: importButton.horizontalCenter
            anchors.verticalCenter: importButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: checkUsername == 1
        }

        Label {
            id: importRespons1
            text: "Creating keypair for session ..."
            anchors.horizontalCenter: importButton.horizontalCenter
            anchors.verticalCenter: importButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: keyPairSend == 1
        }

        Label {
            id: importRespons2
            text: "Checking identity ..."
            anchors.horizontalCenter: importButton.horizontalCenter
            anchors.verticalCenter: importButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: checkIdentity == 1
        }

        Label {
            id: importRespons3
            text: "Retrieving session encryption key ..."
            anchors.horizontalCenter: importButton.horizontalCenter
            anchors.verticalCenter: importButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: sessionKey == 1
        }

        Label {
            id: importRespons4
            text: "Retrieving session ID ..."
            anchors.horizontalCenter: importButton.horizontalCenter
            anchors.verticalCenter: importButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: receiveSessionID == 1
        }

        Label {
            id: importRespons5
            text: "Loading account settings ..."
            anchors.horizontalCenter: importButton.horizontalCenter
            anchors.verticalCenter: importButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: loadingSettings == 1
        }

        Label {
            id: importRespons6
            text: "Verifying wallet balances ..."
            anchors.horizontalCenter: importButton.horizontalCenter
            anchors.verticalCenter: importButton.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.italic: true
            visible: verifyingBalances == 1
        }

        Rectangle {
            anchors.horizontalCenter: importModalBody.horizontalCenter
            anchors.bottom: importModalBody.bottom
            width: importModalBody.width
            height: importModalBody.height
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
            text: "Before you try to import an account, make sure you placed the exported wallet file in your device's download folder."
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: login.bottom
            anchors.topMargin: 70
            color: "#F2F2F2"
            font.pixelSize: 18
            font.family: xciteMobile.name
        }
    }
}
