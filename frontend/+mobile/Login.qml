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

    Rectangle {
        id: login
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: 325
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
            anchors.horizontalCenter: loginModalBody.horizontalCenter
            anchors.top: loginModalBody.top
            anchors.topMargin: 25
            color: userName.text != "" ? "#F2F2F2" : "#727272"
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
            anchors.horizontalCenter: loginModalBody.horizontalCenter
            anchors.top: userName.bottom
            anchors.topMargin: 30
            color: passWord.text != "" ? "#F2F2F2" : "#727272"
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
            width: userName.width
            height: 34
            anchors.bottom: loginModalBody.bottom
            anchors.bottomMargin: 20
            anchors.left: userName.left
            color: (userName.text != "" && passWord.text != "") ? "#1B2934" : "#727272"
            opacity: 0.50

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                }

                onReleased: {
                    if (userName.text != "" && passWord.text != "" && networkError == 0) {
                        userLogin(userName.text, passWord.text)
                    }
                }
            }
            Connections {
                target: UserSettings
                onContactsLoaded: {
                    console.log("contacts loaded")
                    loadContactList(contacts)
                    console.log("first contact in contactlist: " + contactList.get(0).firstName + " " + contactList.get(0).lastName)
                }

                onAddressesLoaded: {
                    console.log("addressbook loaded")
                    loadAddressList(addresses)
                    console.log("number of addresses: " + addressList.count)
                }

                onClearSettings:{
                    clearSettings();
                    console.log("Settings cleared: locale: " + userSettings.locale + ", default currency: " + userSettings.defaultCurrency + ", theme: " + userSettings.theme + ", pinlock: " + userSettings.pinlock + " account complete: " + userSettings.accountCreationCompleted + ", local keys: " + userSettings.localKeys)
                }

                onSettingsLoaded: {
                    console.log("settings loaded")
                    loadSettings(settings);
                    console.log("Loading settings from DB: locale: " + userSettings.locale + ", default currency: " + userSettings.defaultCurrency + ", theme: " + userSettings.theme + ", pinlock: " + userSettings.pinlock + " account complete: " + userSettings.accountCreationCompleted + ", local keys: " + userSettings.localKeys)
                }
                /** onTransactionsLoaded: {
                        loadHistoryList(history)
                    }**/

                /** onWalletsLoaded: {
                        if (userSettings.localKeys === false) {
                            loadWalletList(wallets);
                        }
                    }**/

                onLoginSucceededChanged: {
                    console.log("log in succeeded");
                    if (userSettings.localKeys === true) {
                        loadLocalWallets();
                    }
                    else {
                        walletList.append({"name": nameXFUEL1, "label": labelXFUEL1, "address": receivingAddressXFUEL1, "balance" : balanceXFUEL1, "unconfirmedCoins": unconfirmedXFUEL1, "active": true, "favorite": true, "viewOnly": false, "walletNR": walletID, "remove": false});
                        walletID = walletID +1;
                        walletList.append({"name": nameXBY1, "label": labelXBY1, "address": receivingAddressXBY1, "balance" : balanceXBY1, "unconfirmedCoins": unconfirmedXBY1, "active": true, "favorite": true, "viewOnly": false, "walletNR": walletID, "remove": false});
                        walletID = walletID +1;
                        walletList.append({"name": nameXFUEL2, "label": labelXFUEL2, "address": receivingAddressXFUEL2, "balance" : balanceXFUEL2, "unconfirmedCoins": unconfirmedXFUEL2, "active": true, "favorite": false, "viewOnly": false, "walletNR": walletID, "remove": false});
                        walletID = walletID +1;
                    }
                    username = userName.text
                    passError = 0
                    networkError = 0
                    loginTracker = 0
                    sessionStart = 1
                    selectedPage = "home"
                    mainRoot.pop()
                    mainRoot.push("../Home.qml")
                }

                onLoginFailedChanged: {
                    passError = 1
                    passWord.text = ""
                }

                onUsernameAvailable: {
                    passError = 1
                    passWord.text = ""
                }

                onSettingsServerError: {
                    networkError = 1
                    passWord.text = ""
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
        }

        Rectangle {
            width: userName.width
            height: 34
            anchors.bottom: loginModalBody.bottom
            anchors.bottomMargin: 20
            anchors.left: userName.left
            color: "transparent"
            border.color: (userName.text != "" && passWord.text != "") ? maincolor : "#727272"
            opacity: 0.50
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
            id: underline
            width: createAccount.width
            height: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: createAccount.bottom
            anchors.topMargin: 5
            color: "#F2F2F2"
        }
    }

    Rectangle {
        id: serverError
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.top
        width: Screen.width
        height: 100
        state: networkError == 0? "up" : "down"
        color: "black"
        opacity: 0.9


        states: [
            State {
                name: "up"
                PropertyChanges { target: serverError; anchors.bottomMargin: 0}
            },
            State {
                name: "down"
                PropertyChanges { target: serverError; anchors.bottomMargin: -100}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: serverError; property: "anchors.bottomMargin"; duration: 300; easing.type: Easing.OutCubic}
            }
        ]

        Label {
            id: serverErrorText
            text: "A network error occured, please try again later."
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "#FD2E2E"
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Rectangle {
            id: okButton
            width: (doubbleButtonWidth - 10) / 2
            height: 33
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            radius: 5
            color: "#1B2934"
            opacity: 0.5

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


            MouseArea {
                anchors.fill: parent

                onReleased: {
                    networkError = 0
                    passError = 0
                }
            }
        }

        Text {
            id: okButtonText
            text: "OK"
            font.family: xciteMobile.name
            font.pointSize: 14
            color: "#F2F2F2"
            font.bold: true
            anchors.horizontalCenter: okButton.horizontalCenter
            anchors.verticalCenter: okButton.verticalCenter
        }

        Rectangle {
            width: (doubbleButtonWidth - 10) / 2
            height: 33
            anchors.horizontalCenter: okButton.horizontalCenter
            anchors.bottom: okButton.bottom
            radius: 5
            color: "transparent"
            opacity: 0.5
            border.width: 1
            border.color: "#0ED8D2"
        }

        Rectangle {
            width: parent.width
            height: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            color: "black"
        }
    }
    Component.onDestruction: {
    }
}
