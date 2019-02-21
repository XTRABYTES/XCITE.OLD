/**
 * Filename: AddWallet.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

import QtQuick.Controls 2.3
import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtMultimedia 5.8

import "qrc:/Controls" as Controls

Rectangle {
    id: addWalletModal
    width: Screen.width
    state: addWalletTracker == 1? "up" : "down"
    height: Screen.height
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    MouseArea {
        anchors.fill: parent
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: addWalletModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: addWalletModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: addWalletModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    property string walletType: ""
    property int walletSwitchState: 0
    property int selectWallet: 0
    property int addActive: 0
    property int addViewOnly: 0

    Item {
        id: addWalletText
        width: parent.width
        height : addWalletText1.height + addWalletText2.height + addWalletText3.height + storageSwitch.height + continueButton.height + 90
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        visible: selectWallet = 0

        Label {
            id: addWalletText1
            width: doubbleButtonWidth
            maximumLineCount: 3
            anchors.left: continueButton.left
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            text: "You can choose between an <b>ACTIVE</b> wallet and a <b>VIEW ONLY</b> wallet."
            anchors.top: parent.top
            color: themecolor
            font.pixelSize: 16
            font.family: xciteMobile.name
            font.bold: true
        }

        Label {
            id: addWalletText2
            width: doubbleButtonWidth
            maximumLineCount: 3
            anchors.left: continueButton.left
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            text: "An <b>ACTIVE</b> wallet allows you to make transactions using XCITE mobile."
            anchors.top: addWalletText1.bottom
            anchors.topMargin: 20
            color: themecolor
            font.pixelSize: 16
            font.family: xciteMobile.name
            font.bold: true
        }

        Label {
            id: addWalletText3
            width: doubbleButtonWidth
            maximumLineCount: 3
            anchors.left: continueButton.left
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            text: "A <b>VIEW ONLY</b> wallet allows to track your wallet movement but does not allow you to make transctions using XCITE Mobile."
            anchors.top: addWalletText2.bottom
            anchors.topMargin: 20
            color: themecolor
            font.pixelSize: 16
            font.family: xciteMobile.name
            font.bold: true
        }

        Controls.Switch_mobile {
            id: walletSwitch
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addWalletText3.bottom
            anchors.topMargin: 20
            state: walletSwitchState == 0 ? "off" : "on"


            onStateChanged: {
                if (walletSwitch.state == "off") {
                    walletType = "active"
                }
                else {
                    walletType = "view"
                }
            }
        }

        Text {
            id: receiveText
            text: "ACTIVE"
            anchors.right: walletSwitch.left
            anchors.rightMargin: 7
            anchors.verticalCenter: walletSwitch.verticalCenter
            font.pixelSize: 14
            font.family: xciteMobile.name
            color: walletSwitch.on ? "#757575" : maincolor
        }

        Text {
            id: sendText
            text: "VIEW ONLY"
            anchors.left: walletSwitch.right
            anchors.leftMargin: 7
            anchors.verticalCenter: walletSwitch.verticalCenter
            font.pixelSize: 14
            font.family: xciteMobile.name
            color: walletSwitch.on ? maincolor : "#757575"
        }

        Rectangle {
            id: continueButton
            width: doubbleButtonWidth
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: walletSwitch.bottom
            anchors.topMargin: 30
            color: "transparent"
            opacity: 0.5

            LinearGradient {
                anchors.fill: parent
                start: Qt.point(x, y)
                end: Qt.point(x, parent.height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: "#0ED8D2" }
                }
            }


            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                }

                onReleased: {
                    if (walletType == "active") {
                        addActive = 1
                    }
                    else if (walletType == "view"){
                        addViewOnly = 1
                    }
                    selectWallet = 1
                }
            }
        }

        Text {
            id: continueButtonText
            text: "CONTINUE"
            font.family: xciteMobile.name
            font.pointSize: 14
            color: "#F2F2F2"
            font.bold: true
            anchors.horizontalCenter: continueButton.horizontalCenter
            anchors.verticalCenter: continueButton.verticalCenter
        }

        Rectangle {
            width: doubbleButtonWidth
            height: 34
            anchors.horizontalCenter: continueButton.horizontalCenter
            anchors.bottom: continueButton.bottom
            color: "transparent"
            opacity: 0.5
            border.width: 1
            border.color: "#0ED8D2"
        }
    }
}
