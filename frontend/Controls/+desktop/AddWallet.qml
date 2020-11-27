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
import "qrc:/Controls/+desktop" as Desktop

Rectangle {
    id: addWalletModal
    width: appWidth/6 * 5
    height: appHeight
    state: addWalletTracker == 1? "up" : "down"
    color: bgcolor

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
            PropertyChanges { target: addWalletModal; anchors.topMargin: addWalletModal.height}
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
    property int walletSwitchState: coinIndex < 3? 0 : 1
    property int coin: coinIndex

    Label {
        id: walletLabel
        text: "ADD NEW WALLET"
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Rectangle {
        id: infoBar
        width: parent.width
        height: appHeight/18
        anchors.top: walletLabel.bottom
        anchors.topMargin: appWidth*4/72 + appHeight/27
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
    }

    Item {
        id: addWalletAction
        width: (parent.width - appWidth*3/24)/2
        anchors.top: infoBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24

        Label {
            id: addWalletText1
            width: parent.width
            maximumLineCount: 3
            leftPadding: appWidth/24
            rightPadding: appWidth/24
            anchors.horizontalCenter: parent.horizontalCenter
            wrapMode: Text.WordWrap
            text: "You can choose between an <b>ACTIVE</b> wallet and a <b>VIEW ONLY</b> wallet."
            anchors.top: parent.top
            color: themecolor
            font.pixelSize: appHeight/36
            font.family: xciteMobile.name
        }

        Controls.Switch {
            id: walletSwitch
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addWalletText1.bottom
            anchors.topMargin: appWidth/24
            state: walletSwitchState == 0 ? "off" : "on"
            switchActive: coinIndex < 3


            onStateChanged: {
                if (walletSwitch.state == "off") {
                    walletType = "active"
                    addActive = 1
                    addViewOnly = 0
                }
                else {
                    walletType = "view"
                    addActive = 0
                    addViewOnly = 1
                }
            }
        }

        Text {
            id: activeText
            text: "ACTIVE"
            anchors.right: walletSwitch.left
            anchors.rightMargin: font.pixelSize/2
            anchors.verticalCenter: walletSwitch.verticalCenter
            font.pixelSize: appHeight/36
            font.family: xciteMobile.name
            color: walletSwitch.switchOn ? "#757575" : maincolor
        }

        Text {
            id: viewText
            text: "VIEW ONLY"
            anchors.left: walletSwitch.right
            anchors.leftMargin: font.pixelSize/2
            anchors.verticalCenter: walletSwitch.verticalCenter
            font.pixelSize: appHeight/36
            font.family: xciteMobile.name
            color: walletSwitch.switchOn ? maincolor : "#757575"
        }

        Rectangle {
            id: createButton
            width: appWidth/6
            height: appHeight/27
            radius: height/2
            anchors.top: walletSwitch.bottom
            anchors.topMargin: appWidth/24
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: themecolor
            border.width: 1
            color: "transparent"

            Rectangle {
                id: selectCreate
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    selectCreate.visible = true
                }

                onExited: {
                    selectCreate.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (!walletSwitch.switchOn) {
                        createWalletTracker = 1
                    }
                    else {
                        viewOnlyTracker = 1
                    }
                }
            }

            Text {
                id: createButtonText
                text: !walletSwitch.switchOn? "CREATE NEW WALLET" : "ADD NEW WALLET"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: themecolor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Rectangle {
            id: importButton
            width: appWidth/6
            height: appHeight/27
            radius: height/2
            anchors.top: createButton.bottom
            anchors.topMargin: appHeight/27
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: themecolor
            border.width: 1
            color: "transparent"
            visible: !walletSwitch.switchOn

            Rectangle {
                id: selectImport
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    selectImport.visible = true
                }

                onExited: {
                    selectImport.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                   importKeyTracker = 1
                }
            }

            Text {
                id: scanButtonText
                text: "IMPORT PRIVATE KEY"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: themecolor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Item {
        id: addWalletInfo
        width: (parent.width - appWidth*3/24)/2
        anchors.top: infoBar.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12

        Rectangle {
            width: 1
            anchors.top: parent.top
            anchors.topMargin: appWidth/48
            anchors.bottom: parent.bottom
            anchors.bottomMargin: appWidth/24
            anchors.right: parent.left
            color: themecolor
            opacity: 0.1
        }

        Label {
            id: addActiveWalletLabel
            text: "ACTIVE WALLET"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/24
            anchors.top: parent.top
            color: maincolor
            font.pixelSize: appHeight/36
            font.family: xciteMobile.name
            opacity: !walletSwitch.switchOn? 1 : 0.3
        }

        Label {
            id: addActiveWalletText
            maximumLineCount: 5
            anchors.left: addActiveWalletLabel.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            text: "When you select an <b>ACTIVE</b> wallet, it will allow you to make transactions (send and receive) from the address added to your account using the XCITE client application."
            anchors.top: addActiveWalletLabel.bottom
            anchors.topMargin: appHeight/36
            color: themecolor
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
            opacity: !walletSwitch.switchOn? 1 : 0.3
        }

        Label {
            id: addPassiveWalletLabel
            text: "PASSIVE WALLET"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/24
            anchors.top: addActiveWalletText.bottom
            anchors.topMargin: appHeight/18
            color: maincolor
            font.pixelSize: appHeight/36
            font.family: xciteMobile.name
            opacity: !walletSwitch.switchOn? 0.3 : 1
        }

        Label {
            id: addPassiveWalletText
            maximumLineCount: 5
            anchors.left: addPassiveWalletLabel.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            text: "When you select a <b>VIEW ONLY</b> wallet, it will only allow you to track your wallet balance and history. It will not allow you to make transactions using the XCITE client application."
            anchors.top: addPassiveWalletLabel.bottom
            anchors.topMargin: appHeight/36
            color: themecolor
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
            opacity: !walletSwitch.switchOn? 0.3 : 1
        }
    }

    Rectangle {
        height: appWidth/24
        width: parent.width
        anchors.bottom: parent.bottom
        color: darktheme == true? "#14161B" : "#FDFDFD"
    }
}
