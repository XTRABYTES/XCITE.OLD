 /**
 * Filename: Onboarding.qml
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
        id: backgroundSplash
        z: 1
        width: Screen.width
        height: Screen.height
        color: "#1B2934"

        Image {
            id: largeLogo
            source: 'qrc:/icons/XBY_logo_large.svg'
            width: parent.width * 2
            height: (largeLogo.width / 75) * 65
            anchors.top: parent.top
            anchors.topMargin: 63
            anchors.right: parent.right
            opacity: 0.5
        }

        Rectangle {
            width: welcomeText.implicitWidth
            height: 180
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -50
            color: "transparent"

            Label {
                id: welcomeText
                text: "XCITE"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                color: "#F2F2F2"
                font.pixelSize: 64
                font.family: xciteMobile.name
            }

            Label {
                id: version
                text: "V 1.0"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: welcomeText.bottom
                anchors.topMargin: -20
                color: maincolor
                font.pixelSize: 24
                font.family: xciteMobile.name
            }

            Rectangle {
                id: startButton
                width: (doubbleButtonWidth - 10) / 2
                height: 33
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                radius: 5
                color: maincolor

                MouseArea {
                    anchors.fill: startButton

                    onReleased: {
                        loginTracker = 1
                    }
                }

                Text {
                    id: qrButtonText
                    text: "LET'S GO"
                    font.family: xciteMobile.name
                    font.pointSize: 14
                    color: "#F2F2F2"
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        Label {
            id: closeButtonLabel
            z:10
            text: "CLOSE"
            anchors.bottom: combinationMark.top
            anchors.bottomMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            color: "#F2F2F2"

            Rectangle{
                id: closeButton
                height: 34
                width: doubbleButtonWidth
                radius: 4
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: "transparent"
            }

            MouseArea {
                anchors.fill: closeButton

                onClicked: Qt.quit()
            }
        }

        Image {
            id: combinationMark
            source: 'qrc:/icons/xby_logo_TM.svg'
            height: 23.4
            width: 150
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 35
        }

        Rectangle {
            id: overlay
            z: 9
            height: parent.height
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "black"
            state: loginTracker == 1? "dark" : "clear"

            states: [
                State {
                    name: "dark"
                    PropertyChanges { target: overlay; opacity: 0.95}
                },
                State {
                    name: "clear"
                    PropertyChanges { target: overlay; opacity: 0}
                }
            ]

            transitions: [
                Transition {
                    from: "*"
                    to: "*"
                    NumberAnimation { target: overlay; property: "opacity"; duration: 300}
                }
            ]
        }

        Login {
            id: myLogin
            z: 9
        }
    }
}
