/**
 * Filename: SignUpForm.qml
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
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import "../Controls" as Controls

Controls.ImagePolygonal {
    id: root

    Column {
        id: column
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 40
        spacing: 40

        Controls.ImageLogo {
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            font.family: "Roboto Thin"
            text: qsTr("XCITE")
            font.pointSize: 30
            color: "#10B9C5"
            anchors.horizontalCenter: parent.horizontalCenter
            font.weight: Font.Thin
        }

        Controls.TextInputBlue {
            anchors.horizontalCenter: parent.horizontalCenter
            placeholder: qsTr("username")
        }

        Controls.TextInputBlue {
            anchors.horizontalCenter: parent.horizontalCenter
            placeholder: qsTr("e-mail")
        }

        Controls.TextInputBlue {
            anchors.horizontalCenter: parent.horizontalCenter
            placeholder: qsTr("choose password")
            echoMode: TextInput.Password
        }

        Controls.CheckBoxBlue {
            text: qsTr("I agree to the terms and conditions")
        }

        Controls.ButtonSimple {
            text: qsTr("Sign Up")
            backgroundColor: "#10B9C4"
            hoverBackgroundColor: "#31d3de"
            foregroundColor: "#273A3B"
            hoverForegroundColor: "#273A3B"
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                mainRoot.replace("../DashboardForm.qml")
            }
        }

        Controls.ButtonPlainText {
            anchors.horizontalCenter: parent.horizontalCenter
            width: (alreadyMemberText.contentWidth + loginText.contentWidth)
            onButtonClicked: {
                mainRoot.push("LoginForm.qml")
            }

            RowLayout {
                anchors.centerIn: parent

                Text {
                    id: alreadyMemberText
                    text: qsTr("Already a member?")
                    font.family: "Roboto Thin"
                    font.pointSize: 10
                    color: "#FFFFFF"
                    opacity: 0.8
                }

                Text {
                    id: loginText
                    text: qsTr("Login!")
                    font.family: "Roboto Thin"
                    font.pointSize: 10
                    color: "#28D4E0"
                    opacity: 0.8
                }
            }
        }
    }

    Controls.Version {
    }
}
