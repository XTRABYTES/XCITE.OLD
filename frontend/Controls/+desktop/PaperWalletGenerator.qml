/**
* Filename: Notifications.qml
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
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop

Rectangle {
    id: backgroundGenerator
    z: 1
    width: appWidth/6 * 5
    height: appHeight
    anchors.right: xcite.right
    anchors.top: xcite.top
    color: bgcolor
    state: paperWalletGeneratorTracker == 1? "up" : "down"
    clip: true

    states: [
        State {
            name: "up"
            PropertyChanges { target: backgroundGenerator; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: backgroundGenerator; anchors.topMargin: appHeight}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: backgroundGenerator; properties: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    onStateChanged: {
        if (state === "down") {
            walletCoin = "XBY"
            walletCoinNr = 1
            myPaperWallet.privateKey = ""
            myPaperWallet.publicKey = ""
            myPaperWallet.address = ""
            createFailed = 0
            createInitiated = false
            creatingPaperWallet = false
            fileLocation = ""
            fileSaved = 0
            fileFailed = 0
            walletLabel.text = ""
        }
    }

    property bool myTheme: darktheme
    property string walletCoin: "XBY"
    property int walletCoinNr: 1
    property int createFailed: 0
    property bool createInitiated: false
    property bool creatingPaperWallet: false
    property string fileLocation: ""
    property int fileSaved: 0
    property int fileFailed: 0

    onMyThemeChanged: {
        if (myTheme) {

        }
        else {

        }
    }

    Label {
        id: generatorLabel
        text: "PAPER WALLET GENERATOR"
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Item {
        id: inputArea
        width: (parent.width - (appWidth*3/24))
        anchors.bottom: parent.bottom
        anchors.top: generatorLabel.bottom
        anchors.topMargin: appWidth/12
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24

        Rectangle {
            id: xbyButton
            width: appWidth/9
            height: appHeight/18
            anchors.top: parent.top
            anchors.left: parent.left
            border.color: walletCoin == "XBY"? maincolor : themecolor
            border.width: 1
            color: "transparent"
            opacity: walletCoin == "XBY"? 1 : 0.3

            Rectangle {
                id: selectXby
                anchors.fill: parent
                color: maincolor
                opacity: 0.3
                visible: false
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                enabled: createInitiated == false

                onEntered: {
                    selectXby.visible = true
                }

                onExited: {
                    selectXby.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (walletCoinNr != 1) {
                        walletCoin = "XBY"
                        walletCoinNr = 1
                        myPaperWallet.privateKey = ""
                        myPaperWallet.publicKey = ""
                        myPaperWallet.address = ""
                    }
                }
            }

            Text {
                id: xbyButtonText
                text: "XBY"
                font.family: xciteMobile.name
                font.pixelSize: parent.height/2
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Rectangle {
            id: xfuelButton
            width: appWidth/9
            height: appHeight/18
            anchors.top: parent.top
            anchors.left: xbyButton.right
            anchors.leftMargin: appHeight/54
            border.color: walletCoin == "XFUEL"? maincolor : themecolor
            border.width: 1
            color: "transparent"
            opacity: walletCoin == "XFUEL"? 1 : 0.3

            Rectangle {
                id: selectXfuel
                anchors.fill: parent
                color: maincolor
                opacity: 0.3
                visible: false
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                enabled: createInitiated == false

                onEntered: {
                    selectXfuel.visible = true
                }

                onExited: {
                    selectXfuel.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (walletCoinNr != 0) {
                        walletCoin = "XFUEL"
                        walletCoinNr = 0
                        myPaperWallet.privateKey = ""
                        myPaperWallet.publicKey = ""
                        myPaperWallet.address = ""
                    }
                }
            }

            Text {
                id: xfuelButtonText
                text: "XFUEL"
                font.family: xciteMobile.name
                font.pixelSize: parent.height/2
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Controls.TextInput {
            id: walletLabel
            height: appHeight/18
            anchors.left: xbyButton.left
            anchors.right: xfuelButton.right
            placeholder: "WALLET LABEL"
            anchors.top: xbyButton.bottom
            anchors.topMargin: appHeight/27
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            mobile: 1
            validator: RegExpValidator { regExp: /[0-9A-Za-z\s]+/ }
            onTextChanged: detectInteraction()
        }

        Rectangle {
            id: generateButton
            width: appWidth/6
            height: appHeight/18
            anchors.top: parent.top
            anchors.left: xfuelButton.right
            anchors.leftMargin: appWidth/24
            border.color: themecolor
            border.width: 1
            color: "transparent"
            opacity: walletLabel.text != ""? 1 : 0.3
            visible: !createInitiated

            Rectangle {
                id: selectGenerate
                anchors.fill: parent
                color: maincolor
                opacity: 0.3
                visible: false
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                enabled: walletLabel.text != ""

                onEntered: {
                    selectGenerate.visible = true
                }

                onExited: {
                    selectGenerate.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (walletLabel.text != "") {
                        if (walletCoin == "XFUEL" || walletCoin == "XBY") {
                            createInitiated = true
                            createKeyPair(coinList.get(walletCoinNr).fullname)
                        }
                    }
                }

                Connections {
                    target: xUtility

                    onKeyPairCreated: {
                        if (paperWalletGeneratorTracker == 1 && createInitiated == true) {
                            myPaperWallet.privateKey = priv
                            myPaperWallet.publicKey = pub
                            myPaperWallet.address = addr
                            createInitiated = false
                        }
                    }

                    onCreateKeypairFailed: {
                        failSound.play()
                        createFailed = 1
                    }
                }
            }

            AnimatedImage {
                id: waitingDots
                source: 'qrc:/gifs/loading-gif_01.gif'
                width: 90
                height: 60
                anchors.horizontalCenter: generateButton.horizontalCenter
                anchors.verticalCenter: generateButton.verticalCenter
                playing: createInitiated == true
                visible: createInitiated == true
            }

            Text {
                id: generateButtonText
                text: "GENERATE WALLET"
                font.family: xciteMobile.name
                font.pixelSize: appHeight/54
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Rectangle {
            id: createFileButton
            width: appWidth/6
            height: appHeight/18
            anchors.top: generateButton.bottom
            anchors.topMargin: appHeight/27
            anchors.left: generateButton.left
            border.color: themecolor
            border.width: 1
            color: "transparent"
            opacity: (myPaperWallet.privateKey != "" && myPaperWallet.publicKey != "" && myPaperWallet.address != "" && walletLabel.text != "")? 1 : 0.3
            visible: !creatingPaperWallet

            Rectangle {
                id: selectCreateFile
                anchors.fill: parent
                color: maincolor
                opacity: 0.3
                visible: false
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                enabled: myPaperWallet.privateKey != "" && myPaperWallet.publicKey != "" && myPaperWallet.address != ""

                onEntered: {
                    selectCreateFile.visible = true
                }

                onExited: {
                    selectCreateFile.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    creatingPaperWallet = true
                    var find = ' ';
                    var re = new RegExp(find, 'g');
                    var fileName = walletLabel.text.replace(re, "_")
                    pdfprinter.createPaperWalletImage(walletCoin, myPaperWallet.address, mySavedPaperWallet, fileName)
                }
            }

            Connections {
                target: pdfprinter

                onPaperWalletCreated: {
                    creatingPaperWallet = false
                    fileSaved = 1
                    fileLocation = fileName
                    saveTimer.start()
                }

                onPaperWalletFailed: {
                    creatingPaperWallet = false
                    fileFailed = 1
                    saveTimer.start()
                }
            }

            Text {
                id: createFileButtonText
                text: "SAVE TO DEVICE"
                font.family: xciteMobile.name
                font.pixelSize: appHeight/54
                color: themecolor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        AnimatedImage {
            id: waitingDots2
            source: 'qrc:/gifs/loading-gif_01.gif'
            width: 90
            height: 60
            anchors.horizontalCenter: createFileButton.horizontalCenter
            anchors.verticalCenter: createFileButton.verticalCenter
            playing: creatingPaperWallet == true
            visible: creatingPaperWallet == true
        }

        Desktop.PaperWallet {
            id: myPaperWallet
            width: parent.width*0.996 * 0.5
            height: parent.width*0.562 * 0.5
            anchors.top: walletLabel.bottom
            anchors.topMargin: appWidth/24
            anchors.horizontalCenter: parent.horizontalCenter

            coin : walletCoin
            walletLabel: walletLabel.text
            walletAmount: 0

            DropShadow {
                z: 4
                anchors.fill: saveSuccess
                source: saveSuccess
                horizontalOffset: 4
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color: "black"
                opacity: 0.3
                transparentBorder: true
                visible: saveSuccess.visible
            }

            Rectangle {
                id: saveSuccess
                z:4
                width: parent.width * 0.95
                height: saveSuccessLabel.font.pixelSize*4
                color: "#34363D"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                visible: fileSaved == 1

                Label {
                    id: saveSuccessLabel
                    width: parent.width
                    text: "File save to: <br><b>" + fileLocation + "</b>"
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/72
                    textFormat: Text.RichText
                    horizontalAlignment: Text.AlignHCenter
                    leftPadding: font.pixelSize*5
                    rightPadding: font.pixelSize*5
                    elide: Text.ElideRight
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            DropShadow {
                z: 4
                anchors.fill: saveFailed
                source: saveFailed
                horizontalOffset: 4
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color: "black"
                opacity: 0.3
                transparentBorder: true
                visible: saveFailed.visible
            }

            Rectangle {
                id: saveFailed
                z: 4
                width: saveFailLabel.implicitWidth
                height: saveFailLabel.font.pixelSize*2
                color: "#34363D"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                visible: fileFailed == 1

                Label {
                    id: saveFailLabel
                    text: "Failed to save you paper wallet file to you device"
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    horizontalAlignment: Text.AlignHCenter
                    leftPadding: font.pixelSize*5
                    rightPadding: font.pixelSize*5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        Desktop.PaperWallet {
            id: mySavedPaperWallet
            width: 996
            height: 562
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            visible: false

            coin : myPaperWallet.coin
            privateKey: myPaperWallet.privateKey
            publicKey: myPaperWallet.publicKey
            address: myPaperWallet.address
            walletLabel: myPaperWallet.walletLabel
            walletAmount: myPaperWallet.walletAmount
        }

        Rectangle {
            id: resetButton
            width: appWidth/9
            height: appHeight/27
            anchors.bottom: myPaperWallet.bottom
            anchors.right: parent.right
            border.color: themecolor
            border.width: 1
            color: "transparent"
            opacity: (!creatingPaperWallet && !createInitiated && myPaperWallet.privateKey != "" && myPaperWallet.publicKey != "" && myPaperWallet.address != "")? 1 : 0.3


            Rectangle {
                id: selectReset
                anchors.fill: parent
                color: maincolor
                opacity: 0.3
                visible: false
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                enabled: !creatingPaperWallet && !createInitiated && myPaperWallet.privateKey != "" && myPaperWallet.publicKey != "" && myPaperWallet.address != ""

                onEntered: {
                    selectReset.visible = true
                }

                onExited: {
                    selectReset.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    myPaperWallet.privateKey = ""
                    myPaperWallet.publicKey = ""
                    myPaperWallet.address = ""
                    walletLabel.text = ""
                    selectReset.visible = false
                }
            }

            Text {
                id: resetButtonText
                text: "RESET"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: themecolor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Rectangle {
        height: appWidth/24
        width: parent.width
        anchors.bottom: parent.bottom
        color: darktheme == true? "#14161B" : "#FDFDFD"
    }

    Timer {
        id: saveTimer
        interval: fileSaved == 1? 5000 : 2000
        repeat: false
        running: false

        onTriggered: {
            fileSaved = 0
            fileFailed = 0
        }
    }
}
