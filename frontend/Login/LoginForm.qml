/**
 * Filename: LoginForm.qml
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
import QtQuick.Layouts 1.3
import "../Controls" as Controls

Controls.ImagePolygonal {
    id: loginFormRoot

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
            placeholder: qsTr("john@email.com")
        }

        Controls.TextInputBlue {
            anchors.horizontalCenter: parent.horizontalCenter
            placeholder: "**********"
            echoMode: TextInput.Password
        }

        Controls.ButtonSimple {
            text: qsTr("Login")
            backgroundColor: "transparent"
            hoverBackgroundColor: "#3310B9C5"
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                mainRoot.push("TwoFactorAuthForm.qml")
            }
        }

        Controls.ButtonPlainText {
            anchors.horizontalCenter: parent.horizontalCenter
            width: forgotPasswordText.width
            onButtonClicked: {
                mainRoot.push("ForgotPasswordForm.qml")
            }

            Text {
                id: forgotPasswordText
                anchors.centerIn: parent
                text: qsTr("Forgot password?")
                font.family: "Roboto Thin"
                font.pointSize: 10
                color: "#FFFFFF"
                opacity: 0.9
            }
        }

        Controls.ButtonPlainText {
            anchors.horizontalCenter: parent.horizontalCenter
            width: (dontHaveAccountText.contentWidth + signUpText.contentWidth)
            onButtonClicked: {
                mainRoot.push("SignUpForm.qml")
            }

            RowLayout {
                anchors.centerIn: parent

                Text {
                    id: dontHaveAccountText
                    text: qsTr("Don't have an account?")
                    font.family: "Roboto Thin"
                    font.pointSize: 10
                    color: "#FFFFFF"
                    opacity: 0.8
                }

                Text {
                    id: signUpText
                    text: qsTr("Sign Up!")
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
