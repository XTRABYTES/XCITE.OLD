/**
 * Filename: ForgotPasswordForm.qml
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

        Text {
            font.family: "Roboto Thin"
            text: qsTr("Enter your email and we'll send you a reset link.")
            font.pointSize: 10
            color: "#FFFFFF"
            opacity: 0.9
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Controls.TextInputBlue {
            anchors.horizontalCenter: parent.horizontalCenter
            placeholder: qsTr("john@email.com")
        }

        Controls.ButtonSimple {
            text: qsTr("Send Link")
            backgroundColor: "transparent"
            hoverBackgroundColor: "#1A10B9C5"
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                mainRoot.replace("LoginForm.qml")
            }
        }

        Controls.ButtonPlainText {
            anchors.horizontalCenter: parent.horizontalCenter
            width: (rememberedPasswordText.contentWidth + goBackText.contentWidth)
            onButtonClicked: {
                mainRoot.push("LoginForm.qml")
            }

            RowLayout {
                anchors.centerIn: parent

                Text {
                    id: rememberedPasswordText
                    text: qsTr("Remembered your password?")
                    font.family: "Roboto Thin"
                    font.pointSize: 10
                    color: "#FFFFFF"
                    opacity: 0.8
                }

                Text {
                    id: goBackText
                    text: qsTr("Go Back!")
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
