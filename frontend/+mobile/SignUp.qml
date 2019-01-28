/**
 * Filename: SignUp.qml
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



    Rectangle {
        id: backgroundTrading
        z: 1
        width: Screen.width
        height: Screen.height
        color: "#14161B"
        visible: onboardingTracker == 1

        Label {
            id: welcomeText
            text: "Here we will handle the signup process"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 60
            color: maincolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Rectangle {
            id: startButton
            width: (doubbleButtonWidth - 10) / 2
            height: 33
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            radius: 5
            color: maincolor

            MouseArea {
                anchors.fill: startButton

                onReleased: {
                    signUpTracker = 1
                    mainRoot.pop()
                    mainRoot.push("../Login.qml")
                }
            }

            Text {
                id: qrButtonText
                text: "START"
                font.family: xciteMobile.name
                font.pointSize: 14
                color: "#F2F2F2"
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
