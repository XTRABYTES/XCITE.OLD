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

    property int nameError: 0
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
            radius: 5
            color: "#1B2934"

            Controls.TextInput {
                id: userName
                height: 34
                placeholder: "USERNAME"
                text: ""
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: loginModalBody.top
                anchors.topMargin: 25
                color: userName.text != "" ? "#F2F2F2" : "#727272"
                textBackground: "#0B0B09"
                font.pixelSize: 14
            }

            Text {
                id: userNameError
                text: "Username does not exist!"
                color: "#FD2E2E"
                anchors.left: userName.left
                anchors.leftMargin: 5
                anchors.top: userName.bottom
                anchors.topMargin: 1
                font.pixelSize: 11
                font.family: "Brandon Grotesque"
                font.weight: Font.Normal
                visible: nameError == 1
            }

            Controls.TextInput {
                id: passWord
                height: 34
                placeholder: "PASSWORD"
                text: ""
                echoMode: TextInput.Password
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: userName.bottom
                anchors.topMargin: 30
                color: passWord.text != "" ? "#F2F2F2" : "#727272"
                textBackground: "#0B0B09"
                font.pixelSize: 14
            }

            Text {
                id: passWordError
                text: "Password is not correct!"
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
                height: 33
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.left: userName.left
                radius: 5
                color: (userName.text != "" && passWord.text != "") ? maincolor : "#727272"

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                    }

                    onReleased: {
                        if (userName.text != "" && passWord.text != "") {
                            // function to add check if username exists
                            // if username does not exist return nameError = 1
                            // if username exists return nameError = 0, check password
                            // if password is wrong return passError = 1
                            // if password is correct return passError = 0 and proceed with login
                            mainRoot.pop()
                            mainRoot.push("../Home.qml")
                            loginTracker = 0
                            selectedPage = "home"
                            username = userName.text
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
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
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
                width: parent.width
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: "transparent"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
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
}

