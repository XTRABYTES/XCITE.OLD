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
    color: bgcolor

    LinearGradient {
        anchors.fill: parent
        start: Qt.point(0, 0)
        end: Qt.point(0, parent.height)
        opacity: 0.05
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 1.0; color: maincolor }
        }
    }

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
    property int coin: coinIndex


    Item {
        id: addWalletText
        width: parent.width
        height : addWalletText1.height + addWalletText2.height + addWalletText3.height + walletSwitch.height + continueButton.height + 90
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        visible: selectWallet == 0

        Label {
            id: addWalletText1
            width: doubbleButtonWidth
            maximumLineCount: 3
            anchors.horizontalCenter: parent.horizontalCenter
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
            anchors.horizontalCenter: parent.horizontalCenter
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
            anchors.horizontalCenter: parent.horizontalCenter
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
            anchors.rightMargin: 7
            anchors.verticalCenter: walletSwitch.verticalCenter
            font.pixelSize: 14
            font.family: xciteMobile.name
            color: walletSwitch.on ? "#757575" : maincolor
        }

        Text {
            id: viewText
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

    Item {
        id: addActiveWallet
        width: parent.width
        height: addWalletText4.height + createAddressText.height + createAddressButton.height + importAddressText.height + importAddressButton.height + 90
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -100
        visible: selectWallet == 1 && addActive == 1 && walletAdded == false

        Label {
            id: addWalletText4
            text: "Now let's add a wallet"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addActiveWallet.top
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Text {
            id: createAddressText
            width: doubbleButtonWidth
            maximumLineCount: 2
            anchors.left: createAddressButton.left
            horizontalAlignment: Text.AlignJustify
            text: "You can create a new <b><br>" + coinList.get(coinIndex).name + "</b> address."
            anchors.top: addWalletText4.bottom
            anchors.topMargin: 30
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Rectangle {
            id: createAddressButton
            width: doubbleButtonWidth
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: createAddressText.bottom
            anchors.topMargin: 15
            color: "transparent"
            border.color: maincolor
            border.width: 1

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
                color: maincolor
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
            maximumLineCount: 2
            text: "You can import an existing <b><br>" + coinList.get(coinIndex).name + "</b> wallet."
            anchors.top: createAddressButton.bottom
            anchors.topMargin: 30
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Rectangle {
            id: importAddressButton
            width: doubbleButtonWidth
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: importAddressText.bottom
            anchors.topMargin: 15
            color: "transparent"
            border.color: maincolor
            border.width: 1

            MouseArea {
                anchors.fill: importAddressButton

                onPressed: {
                    click01.play()
                }

                onReleased: {
                    importKeyTracker = 1
                }
            }

            Text {
                id: importButtonText
                text: "IMPORT PRIVATE KEY"
                font.family: xciteMobile.name
                font.pointSize: 14
                color: maincolor
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Item {
        id: addViewOnlyWallet
        width: parent.width
        height: addViewOnlyTextText1.height + addViewOnlyTextText2.height + addViewOnlyButton.height + 45
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        visible: selectWallet == 1 && addViewOnly == 1 && walletAdded == false

        Text {
            id: addViewOnlyTextText1
            anchors.horizontalCenter: parent.horizontalCenter
            text: "REMEMBER:"
            anchors.top: parent.top
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
            font.bold: true
        }

        Text {
            id: addViewOnlyTextText2
            width: doubbleButtonWidth
            maximumLineCount: 3
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            text: "If you add a <b>VIEW ONLY</b> wallet you will not be able to make transactions."
            anchors.top: addViewOnlyTextText1.bottom
            anchors.topMargin: 20
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Rectangle {
            id: addViewOnlyButton
            width: doubbleButtonWidth
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addViewOnlyTextText2.bottom
            anchors.topMargin: 25
            color: "transparent"
            border.color: maincolor
            border.width: 1

            MouseArea {
                anchors.fill: addViewOnlyButton

                onPressed: {
                    click01.play()
                }

                onReleased: {
                    viewOnlyTracker = 1
                }
            }

            Text {
                id: viewOnlyButtonText
                text: "CONTINUE"
                font.family: xciteMobile.name
                font.pointSize: 14
                color: maincolor
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Controls.ReplyModal {
        id: addWalletComplete
        modalHeight: saveSuccess.height + saveSuccessLabel.height + moreWallets.height + 75
        visible: selectWallet == 1 && walletAdded == true

        Image {
            id: saveSuccess
            source: darktheme == true? 'qrc:/icons/mobile/add_address-icon_01_light.svg' : 'qrc:/icons/mobile/add_address-icon_01_dark.svg'
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addWalletComplete.modalTop
            anchors.topMargin: 20
        }

        Label {
            id: saveSuccessLabel
            text: "Wallet saved!"
            anchors.top: saveSuccess.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: saveSuccess.horizontalCenter
            color: maincolor
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            font.bold: true
        }

        Rectangle {
            id: moreWallets
            width: moreWalletsText.implicitWidth + 20
            height: 34
            color: "transparent"
            border.color: maincolor
            border.width: 1
            anchors.top: saveSuccessLabel.bottom
            anchors.topMargin: 25
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    parent.opacity = 0.5
                    click01.play()
                    detectInteraction()
                }

                onCanceled: {
                    parent.opacity = 0.25
                }

                onReleased: {
                    parent.opacity = 0.25
                }

                onClicked: {
                    walletAdded = false
                    selectWallet = 0
                }
            }
        }
        Text {
            id: moreWalletsText
            text: "ADD ANOTHER WALLET"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: darktheme == true? "#F2F2F2" : maincolor
            anchors.horizontalCenter: moreWallets.horizontalCenter
            anchors.verticalCenter: moreWallets.verticalCenter
        }
    }

    Label {
        id: closeAddWallet
        z: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : 70
        anchors.horizontalCenter: parent.horizontalCenter
        text: selectWallet == 1? (walletAdded == true? "CLOSE" : "BACK") : "CLOSE"
        font.pixelSize: 14
        font.family: xciteMobile.name
        color: themecolor
        visible: scanQRTracker == 0


        Rectangle {
            id: backbutton
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            height: 34
            color: "transparent"
        }

        MouseArea {
            anchors.fill: backbutton

            onPressed: detectInteraction()

            onClicked: {
                if (selectWallet == 1) {
                    if (walletAdded == true) {
                        selectedPage = "home"
                        mainRoot.pop();
                        selectWallet = 0
                        walletAdded = false
                    }
                    else {
                        selectWallet = 0
                        walletAdded = false
                    }
                }
                else {
                    addWalletTracker = 0
                    walletAdded = false
                    selectWallet = 0
                    selectedPage = "home"
                    mainRoot.pop("qrc:/Controls/+mobile/AddWallet.qml");
                }
            }
        }
    }

    Controls.CreateWallet {
        z: 10
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Controls.ImportKey {
        z: 10
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Controls.AddViewOnlyWallet {
        z: 10
        anchors.left: parent.left
        anchors.top: parent.top
        coin: coin
    }

    Controls.LogOut {
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Controls.Goodbey {
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
    }
}
