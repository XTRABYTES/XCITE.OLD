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
import "qrc:/Controls/+desktop" as Desktop

Rectangle {
    id: backgroundSetup
    width: appWidth
    height: appHeight
    anchors.horizontalCenter: xcite.horizontalCenter
    anchors.verticalCenter: xcite.verticalCenter
    color: "#14161B"

    Image {
        id: largeLogo
        source: 'qrc:/icons/XBY_logo_large.svg'
        height: appHeight / 75 * 65
        fillMode: Image.PreserveAspectFit
        anchors.top: parent.top
        anchors.topMargin: appHeight/18
        anchors.horizontalCenter: parent.left
        opacity: 0.5
    }

    property int gotoWallet: 0

    Label {
        id: welcomeText
        text: userSettings.accountCreationCompleted === true? "ACCOUNT SETUP COMPLETE" : "WELCOME " + myUsername
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        color: maincolor
        font.pixelSize: appHeight/27
        font.family: xciteMobile.name
        font.bold: true
        visible: importKeyTracker == 0 && createWalletTracker == 0
    }

    Item {
        id: addWallet
        width: parent.width
        height: addWalletText.height + createAddressText.height + createAddressText.anchors.topMargin + createAddressButton.height + createAddressButton.anchors.topMargin + selectedCoin.height + selectedCoin.anchors.topMargin
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: userSettings.accountCreationCompleted === false

        Label {
            id: addWalletText
            text: "We will now add an XFUEL address."
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addWallet.top
            color: "#F2F2F2"
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
        }

        Image {
                id: selectedCoin
                source: coinList.get(0).logo
                height: appHeight/12
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: addWalletText.bottom
                anchors.topMargin: appHeight/18
        }

        Text {
            id: createAddressText
            width: appWidth/3
            maximumLineCount: 2
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            text: "You can create a new address or import and existing address."
            anchors.top: selectedCoin.bottom
            anchors.topMargin: appHeight/18
            color: "#F2F2F2"
            font.pixelSize: appHeight/45
            font.family: xciteMobile.name
        }

        Rectangle {
            id: createAddressButton
            width: appWidth*0.9/6
            height: appHeight/27
            radius: height/2
            anchors.left: parent.left
            anchors.leftMargin: appWidth/3
            anchors.top: createAddressText.bottom
            anchors.topMargin: height
            color: "transparent"
            border.color: "#f2f2f2"
            border.width: 1

            Rectangle {
                id: selectCreate
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                id: createButtonText
                text: "CREATE ADDRESS"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: createAddressButton
                hoverEnabled: true

                onEntered: {
                    selectCreate.visible = true
                }

                onExited: {
                    selectCreate.visible = false
                }

                onPressed: {
                    click01.play()
                }

                onClicked: {
                    createWalletTracker = 1
                }
            }
        }

        Rectangle {
            id: importAddressButton
            width: appWidth*0.9/6
            height: appHeight/27
            radius: height/2
            anchors.right: parent.right
            anchors.rightMargin: appWidth/3
            anchors.top: createAddressText.bottom
            anchors.topMargin: height
            color: "transparent"
            border.color: "#f2f2f2"
            border.width: 1

            Rectangle {
                id: selectImport
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                id: importButtonText
                text: "IMPORT ADDRESS"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: importAddressButton
                hoverEnabled: true

                onEntered: {
                    selectImport.visible = true
                }

                onExited: {
                    selectImport.visible = false
                }

                onPressed: {
                    click01.play()
                }

                onClicked: {
                    importKeyTracker = 1
                }
            }
        }
    }

    Item {
        id: addWalletComplete
        width: parent.width
        height: onboardCompleteText.height + completeButton.height + 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: userSettings.accountCreationCompleted === true

        Text {
            id: onboardCompleteText
            text: "You have completed the initial setup for your wallet. ENJOY!"
            width: appWidth/3
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
            width:appWidth/6
            height: appHeight/27
            radius: height/2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: onboardCompleteText.bottom
            anchors.topMargin: height*2
            color: "transparent"
            border.color: "#f2f2f2"
            border.width: 1

            Rectangle {
                id: selectComplete
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                id: qrButtonText
                text: "GO TO WALLET"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: completeButton
                hoverEnabled: true

                onEntered: {
                    selectComplete.visible = true
                }

                onExited: {
                    selectComplete.visible = false
                }

                onPressed: {
                    click01.play()
                }

                onClicked: {
                    if (gotoWallet == 0) {
                        gotoWallet = 1
                        updateToAccount();
                        mainRoot.pop()
                        mainRoot.push("qrc:/+mobile/Home.qml")
                        sessionStart = 1
                        selectedPage = "home"
                        gotoWallet = 0
                        closeAllClipboard = true
                    }
                }
            }
        }
    }

    Image {
        id: combinationMark
        width: appWidth/7.5
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: height/2
    }

    Desktop.CreateWallet {
        id: myCreateWallet
        anchors.top: parent.top
        width: appWidth
        state: createWalletTracker == 1? "up" : "down"
        coin: 0
    }

    Desktop.ImportWallet {
        id: myImportWallet
        anchors.top: parent.top
        width: appWidth
        state: importKeyTracker == 1? "up" : "down"
        coin: coinList.get(0).name
    }
}
