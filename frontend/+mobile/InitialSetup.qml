
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

    property int gotoWallet: 0

    Rectangle {
        id: backgroundSetup
        z: 1
        width: Screen.width
        height: Screen.height
        color: "#14161B"

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, 0)
            end: Qt.point(0, parent.height)
            opacity: darktheme == false? 0.05 : 0.2
            gradient: Gradient {
                GradientStop { position: 0.0; color: darktheme == false?"#00072778" : "#FF162124" }
                GradientStop { position: 1.0; color: darktheme == false?"#FF072778" : "#00162124" }
            }
        }

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
            text: userSettings.accountCreationCompleted === true? "ACCOUNT SETUP COMPLETE" : "WELCOME " + username
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: maincolor
            font.pixelSize: 20
            font.family: xciteMobile.name
            font.bold: true
            visible: importKeyTracker == 0 && createWalletTracker == 0
        }



        Flickable {
            id: scrollArea
            width: parent.width
            contentHeight: addWalletScrollArea.height > scrollArea.height? addWalletScrollArea.height + 125 : scrollArea.height + 125
            anchors.left: parent.left
            anchors.top: welcomeText.bottom
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            boundsBehavior: Flickable.StopAtBounds
            clip: true
            visible: scanQRTracker == 0

            Rectangle {
                id: addWalletScrollArea
                width: parent.width
                height: userSettings.accountCreationCompleted === true? addWalletComplete.height : addWallet.height
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
            }

            Item {
                id: addWallet
                width: parent.width
                height: addWalletText.height + createAddressText.height + createAddressButton.height + importAddressText.height + importAddressButton.height + selectedCoin.height + 120
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 90
                visible: userSettings.accountCreationCompleted === false

                Label {
                    id: addWalletText
                    text: "Now let's add a wallet"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: addWallet.top
                    color: "#F2F2F2"
                    font.pixelSize: 18
                    font.family: xciteMobile.name
                }

                Item {
                    id: selectedCoin
                    width: newIcon.width + newCoinName.width + 7
                    height: newIcon.height
                    anchors.top: addWalletText.bottom
                    anchors.topMargin: 30
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: newIcon
                        source: coinList.get(0).logo
                        height: 30
                        width: 30
                        anchors.left: parent.left
                        anchors.top: parent.top
                    }

                    Label {
                        id: newCoinName
                        text: coinList.get(0).name
                        anchors.left: newIcon.right
                        anchors.leftMargin: 7
                        anchors.verticalCenter: newIcon.verticalCenter
                        font.pixelSize: 24
                        font.family: "Brandon Grotesque"
                        font.letterSpacing: 2
                        font.bold: true
                        color: darktheme == true? "#F2F2F2" : "#2A2C31"
                    }
                }

                Text {
                    id: createAddressText
                    width: doubbleButtonWidth
                    maximumLineCount: 2
                    anchors.left: createAddressButton.left
                    horizontalAlignment: Text.AlignJustify
                    wrapMode: Text.WordWrap
                    text: "If you don’t have an <b>XFUEL</b> wallet or you wish to create a new one."
                    anchors.top: selectedCoin.bottom
                    anchors.topMargin: 30
                    color: "#F2F2F2"
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
                    text: "If you already have an <b>XFUEL</b> wallet."
                    anchors.top: createAddressButton.bottom
                    anchors.topMargin: 30
                    color: "#F2F2F2"
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
                id: addWalletComplete
                width: parent.width
                height: onboardCompleteText.height + completeButton.height + 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -100
                visible: userSettings.accountCreationCompleted === true

                Text {
                    id: onboardCompleteText
                    text: "You have completed the initial setup for your wallet. ENJOY!"
                    width: doubbleButtonWidth
                    maximumLineCount: 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    anchors.top: parent.top
                    color: themecolor
                    font.pixelSize: 16
                    font.family: xciteMobile.name
                }

                Rectangle {
                    id: completeButton
                    width: doubbleButtonWidth / 2
                    height: 34
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: onboardCompleteText.bottom
                    anchors.topMargin: 50
                    color: "transparent"
                    opacity: 0.5

                    LinearGradient {
                        anchors.fill: parent
                        start: Qt.point(x, y)
                        end: Qt.point(x, parent.height)
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "transparent" }
                            GradientStop { position: 1.0; color: gotoWallet === 0? "#0ED8D2" : "#979797" }
                        }
                    }


                    MouseArea {
                        anchors.fill: completeButton

                        onClicked: {
                            if (gotoWallet == 0) {
                                gotoWallet = 1
                                updateToAccount();
                                mainRoot.pop()
                                mainRoot.push("../Home.qml")
                                sessionStart = 1
                                selectedPage = "home"
                                gotoWallet = 0
                                closeAllClipboard = true
                            }
                        }
                    }
                }

                Text {
                    id: qrButtonText
                    text: "GO TO WALLET"
                    font.family: xciteMobile.name
                    font.pointSize: 14
                    color: gotoWallet == 0? themecolor : "#979797"
                    font.bold: true
                    anchors.horizontalCenter: completeButton.horizontalCenter
                    anchors.verticalCenter: completeButton.verticalCenter
                    anchors.verticalCenterOffset: 1
                }

                Rectangle {
                    width: doubbleButtonWidth / 2
                    height: 33
                    anchors.horizontalCenter: completeButton.horizontalCenter
                    anchors.bottom: completeButton.bottom
                    color: "transparent"
                    opacity: 0.5
                    border.width: 1
                    border.color: gotoWallet === 0? "#0ED8D2" : "#979797"
                }
            }
        }

        Item {
            z: 3
            width: Screen.width
            height: myOS === "android"? 125 : 145
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            LinearGradient {
                anchors.fill: parent
                start: Qt.point(x, y)
                end: Qt.point(x, y + height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 0.5; color: darktheme == true? "#14161B" : "#FDFDFD" }
                    GradientStop { position: 1.0; color: darktheme == true? "#14161B" : "#FDFDFD" }
                }
            }
        }

        Image {
            id: combinationMark
            z: 3
            source: 'qrc:/icons/xby_logo_TM.svg'
            height: 23.4
            width: 150
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: myOS === "android"? 50 : 70
        }

        Rectangle {
            id: overlay
            z: 3
            width: Screen.width
            height: Screen.height
            color: "#14161B"
            opacity: (importKeyTracker == 1 || createWalletTracker == 1)? 1 : 0

            LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(0, parent.height)
                opacity: darktheme == false? 0.05 : 0.2
                gradient: Gradient {
                    GradientStop { position: 0.0; color: darktheme == false?"#00072778" : "#FF162124" }
                    GradientStop { position: 1.0; color: darktheme == false?"#FF072778" : "#00162124" }
                }
            }
        }

        Controls.ImportKey {
            id: addWalletModal
            z: 3
        }

        Controls.CreateWallet {
            id: createWalletModal
            z: 3
        }
    }
}
