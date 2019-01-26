/**
 * Filename: InitialSetup.qml
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

        Label {
            id: welcomeText
            text: "WELCOME " + username
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 25
            color: maincolor
            font.pixelSize: 24
            font.family: xciteMobile.name
            font.bold: true
        }

        Label {
            id: addWalletText
            text: "Now let's add a wallet"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: welcomeText.bottom
            color: "#F2F2F2"
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Rectangle {
            id: selectAddMode
            height: 240
            width : parent.width - 50
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -25
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"

            Text {
                id: createAddressText
                width: doubbleButtonWidth
                maximumLineCount: 2
                anchors.left: createAddressButton.left
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
                text: "If you don’t have an <b>XFUEL</b> wallet or you wish to create a new one."
                anchors.top: parent.top
                color: "#F2F2F2"
                font.pixelSize: 18
                font.family: xciteMobile.name
            }

            Rectangle {
                id: createAddressButton
                width: doubbleButtonWidth
                height: 33
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: createAddressText.bottom
                anchors.topMargin: 15
                radius: 5
                color: maincolor

                MouseArea {
                    anchors.fill: createAddressButton

                    onPressed: {
                        click01.play()
                    }

                    onReleased: {
                        createWalletTracker = 1
                    }
                }

                Text {
                    id: createButtonText
                    text: "CREATE NEW ADDRESS"
                    font.family: xciteMobile.name
                    font.pointSize: 14
                    color: "#F2F2F2"
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Text {
                id: importAddressText
                width: doubbleButtonWidth
                anchors.left: importAddressButton.left
                horizontalAlignment: Text.AlignJustify
                text: "If you already have an <b>XFUEL</b> wallet."
                anchors.bottom: importAddressButton.top
                anchors.bottomMargin: 15
                color: "#F2F2F2"
                font.pixelSize: 18
                font.family: xciteMobile.name
            }

            Rectangle {
                id: importAddressButton
                width: doubbleButtonWidth
                height: 33
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                radius: 5
                color: maincolor

                MouseArea {
                    anchors.fill: importAddressButton

                    onPressed: {
                        click01.play()
                    }

                    onReleased: {
                        addWalletTracker = 1
                    }
                }

                Text {
                    id: importButtonText
                    text: "IMPORT PRIVATE KEY"
                    font.family: xciteMobile.name
                    font.pointSize: 14
                    color: "#F2F2F2"
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        Rectangle {
            id: skipButton
            width: skipButtonText.implicitWidth
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: selectAddMode.bottom
            anchors.topMargin: 25
            color: "transparent"

            MouseArea {
                anchors.fill: skipButton

                onReleased: {
                    mainRoot.pop()
                    mainRoot.push("../Home.qml")
                }
            }

            Text {
                id: skipButtonText
                text: "Skip"
                font.family: xciteMobile.name
                font.pointSize: 18
                color: "#F2F2F2"
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
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
            width: Screen.width
            height: Screen.height
            color: "black"
            opacity: (addWalletTracker == 1 || createWalletTracker == 1)? 0.95 : 0
        }

        Controls.AddWallet {
            id: addWalletModal
        }

        Controls.CreateWallet {
            id: createWalletModal
        }

        Controls.QrScanner {
            id: scanPrivateKey
            key: "PRIVATE KEY"
        }
    }
}
