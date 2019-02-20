
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
            visible: addWalletTracker == 0 && createWalletTracker == 0
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
                height: addWalletText.height + createAddressText.height + createAddressButton.height + importAddressText.height + importAddressButton.height + skipButton.height + 115
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -100
                visible: userSettings.accountCreationCompleted !== true

                Label {
                    id: addWalletText
                    text: "Now let's add a wallet"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: addWallet.top
                    color: "#F2F2F2"
                    font.pixelSize: 18
                    font.family: xciteMobile.name
                }

                Text {
                    id: createAddressText
                    width: doubbleButtonWidth
                    maximumLineCount: 2
                    anchors.left: createAddressButton.left
                    horizontalAlignment: Text.AlignJustify
                    wrapMode: Text.WordWrap
                    text: "If you don’t have an <b>XFUEL</b> wallet or you wish to create a new one."
                    anchors.top: addWalletText.bottom
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
                            addWalletTracker = 1
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

                Rectangle {
                    id: skipButton
                    width: skipButtonText.implicitWidth
                    height: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: importAddressButton.bottom
                    anchors.topMargin: 25
                    color: "transparent"

                    MouseArea {
                        anchors.fill: skipButton

                        onReleased: {
                            // workaround until backend connection is provided
                            walletList.append({"name": nameXFUEL1, "label": nameXFUEL1, "address": receivingAddressXFUEL1, "balance" : balanceXFUEL1, "unconfirmedCoins": unconfirmedXFUEL1, "active": true, "favorite": true, "walletNR": walletID, "remove": false});
                            walletID = walletID +1;
                            walletList.append({"name": nameXBY1, "label": labelXBY1, "address": receivingAddressXBY1, "balance" : balanceXBY1, "unconfirmedCoins": unconfirmedXBY1, "active": true, "favorite": true, "walletNR": walletID, "remove": false});
                            walletID = walletID +1;
                            walletList.append({"name": nameXFUEL2, "label": labelXFUEL2, "address": receivingAddressXFUEL2, "balance" : balanceXFUEL2, "unconfirmedCoins": unconfirmedXFUEL2, "active": true, "favorite": false, "walletNR": walletID, "remove": false});
                            walletID = walletID +1;
                            userSettings.accountCreationCompleted = true
                            addWalletsToAddressList()
                            var datamodel = []
                            for (var i = 0; i < addressList.count; ++i)
                                datamodel.push(addressList.get(i))

                            var addressListJson = JSON.stringify(datamodel)

                            saveAddressBook(addressListJson)
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
                            GradientStop { position: 1.0; color: "#0ED8D2" }
                        }
                    }


                    MouseArea {
                        anchors.fill: completeButton

                        onReleased: {
                            mainRoot.pop()
                            mainRoot.push("../Home.qml")
                            sessionStart = 1
                            selectedPage = "home"
                        }
                    }
                }

                Text {
                    id: qrButtonText
                    text: "GO TO WALLET"
                    font.family: xciteMobile.name
                    font.pointSize: 14
                    color: themecolor
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
                    border.color: "#0ED8D2"
                }
            }
        }

        Item {
            z: 3
            width: Screen.width
            height: 125
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
            anchors.bottomMargin: 50
        }

        Rectangle {
            id: overlay
            z: 3
            width: Screen.width
            height: Screen.height
            color: "#14161B"
            opacity: (addWalletTracker == 1 || createWalletTracker == 1)? 1 : 0

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

        Controls.AddWallet {
            id: addWalletModal
            z: 3
        }

        Controls.CreateWallet {
            id: createWalletModal
            z: 3
        }
    }

    Rectangle {
        id: serverError
        z: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.top
        width: Screen.width
        height: 100
        state: networkError == 0? "up" : "down"
        color: "black"
        opacity: 0.9
        clip: true

        states: [
            State {
                name: "up"
                PropertyChanges { target: serverError; anchors.bottomMargin: 0}
                PropertyChanges { target: serverError; height: 0}
            },
            State {
                name: "down"
                PropertyChanges { target: serverError; anchors.bottomMargin: -100}
                PropertyChanges { target: serverError; height: 100}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: serverError; property: "anchors.bottomMargin"; duration: 300; easing.type: Easing.OutCubic}
            }
        ]

        Label {
            id: serverErrorText
            text: "A network error occured, please try again later."
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "#FD2E2E"
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Rectangle {
            id: okButton
            width: doubbleButtonWidth / 2
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            color: "#1B2934"
            opacity: 0.5

            LinearGradient {
                anchors.fill: parent
                source: parent
                start: Qt.point(x, y)
                end: Qt.point(x, parent.height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: "#0ED8D2" }
                }
            }


            MouseArea {
                anchors.fill: parent

                onReleased: {
                    networkError = 0
                    passError = 0
                }
            }
        }

        Text {
            id: okButtonText
            text: "OK"
            font.family: xciteMobile.name
            font.pointSize: 14
            color: "#F2F2F2"
            font.bold: true
            anchors.horizontalCenter: okButton.horizontalCenter
            anchors.verticalCenter: okButton.verticalCenter
        }

        Rectangle {
            width: doubbleButtonWidth / 2
            height: 34
            anchors.horizontalCenter: okButton.horizontalCenter
            anchors.bottom: okButton.bottom
            color: "transparent"
            opacity: 0.5
            border.width: 1
            border.color: "#0ED8D2"
        }

        Rectangle {
            width: parent.width
            height: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            color: bgcolor
        }
    }
}
