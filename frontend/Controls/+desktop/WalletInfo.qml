/**
* Filename: WalletInfo.qml
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
    id: backgroundBackup
    z: 1
    width: appWidth/6 * 5
    height: appHeight
    anchors.right: parent.right
    anchors.top: parent.top
    color: "transparent"


    property bool myTheme: darktheme
    property string coin: walletList.get(walletIndex).name
    property bool creatingPaperWallet: false
    property string fileLocation: ""
    property int fileSaved: 0
    property int fileFailed: 0

    onMyThemeChanged: {
        if (darktheme) {
            clipBoard1.source= "qrc:/icons/clipboard_icon_light01.png"
            clipBoard2.source= "qrc:/icons/clipboard_icon_light01.png"
        }
        else {
            clipBoard1.source= "qrc:/icons/clipboard_icon_dark01.png"
            clipBoard2.source= "qrc:/icons/clipboard_icon_dark01.png"
        }
    }

    Label {
        id: walletInfoLabel
        text: "BACKUP - " + walletList.get(walletIndex).name + " " + walletList.get(walletIndex).label
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        color: themecolor
        font.letterSpacing: 2
        horizontalAlignment: Text.AlignRight
        elide: Text.ElideRight
    }

    Rectangle {
        id: createButton
        width: appWidth/6
        height: appHeight/27
        anchors.verticalCenter: addressInfo.verticalCenter
        anchors.right: walletInfoLabel.right
        border.color: themecolor
        border.width: 1
        color: "transparent"
        visible: !creatingPaperWallet

        Rectangle {
            id: selectCreate
            anchors.fill: parent
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
                paperWalletTracker = 1
            }
        }

        Text {
            id: createButtonText
            text: "CREATE PAPER WALLET"
            font.family: xciteMobile.name
            font.pointSize: parent.height/2
            color: themecolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: addressInfo
        width: seperatortop.width
        anchors.left: seperatortop.left
        anchors.right: seperatortop.right
        anchors.top: seperatortop.bottom
        anchors.bottom: seperatorBottom.top
        color: "transparent"

        Image {
            id: icon
            source: getLogo(coinName.text)
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height*2/3
            fillMode: Image.PreserveAspectFit
        }

        Label {
            id: coinName
            anchors.left: icon.right
            anchors.leftMargin: appWidth/96
            anchors.top: parent.top
            anchors.topMargin: parent.height/6
            text: walletList.get(walletIndex).name
            font.pixelSize: parent.height/3
            font.family: xciteMobile.name
            font.bold: true
            color: themecolor
        }

        Label {
            id: walletName
            anchors.right: parent.right
            anchors.rightMargin: appWidth/96
            anchors.left: coinName.right
            anchors.leftMargin: appWidth/96
            anchors.top: parent.top
            anchors.topMargin: parent.height/6
            text: walletList.get(walletIndex).label
            font.pixelSize: parent.height/3
            font.family: xciteMobile.name
            font.bold: true
            color: themecolor
            elide: Text.ElideRight
        }

        Label {
            id: addressLabel
            anchors.right: parent.right
            anchors.rightMargin: appWidth/96
            anchors.left: coinName.left
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height/6
            text: walletList.get(walletIndex).address
            font.pixelSize: parent.height/3 *0.8
            font.family: xciteMobile.name
            color: themecolor
            elide: Text.ElideRight
        }
    }

    Rectangle {
        id: seperatortop
        height: 0.5
        anchors.top: walletInfoLabel.bottom
        anchors.topMargin: appWidth/12
        anchors.right: walletInfoLabel.right
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        color: themecolor
        opacity: 0.1
    }

    Rectangle {
        id: seperatorBottom
        height: 0.5
        anchors.top: seperatortop.bottom
        anchors.topMargin: appHeight/12
        anchors.right: walletInfoLabel.right
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        color: themecolor
        opacity: 0.1
    }

    Rectangle {
        id: qrBackground
        width: seperatorBottom.width
        anchors.top: seperatorBottom.bottom
        anchors.bottom: bottomBar.top
        anchors.left: seperatorBottom.left
        color: "transparent"

        Rectangle {
            id: addressArea
            height: parent.height*2/3
            width: height
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: appWidth/12
            color: "transparent"
            border.width: 0.5
            border.color: themecolor

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: appHeight/72
                text: "Your wallet ADDRESS"
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                color: themecolor
            }

            Rectangle {
                id: qrPlaceholder1
                width: addressArea.width/2
                height: width
                anchors.horizontalCenter: addressArea.horizontalCenter
                anchors.top: addressArea.top
                anchors.topMargin: appWidth/24
                color: "white"
                border.color: themecolor
                border.width: 1

                Image {
                    width: parent.width*0.95
                    height: parent.height*0.95
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    source: "image://QZXing/encode/" + walletList.get(walletIndex).address
                    cache: false
                }
            }

            Item {
                width: parent.width*0.8
                height: addressHashLabel.height
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: appHeight/36

                Label {
                    id: addressHashLabel
                    width: parent.width - clipBoard1.width
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    text: walletList.get(walletIndex).address
                    maximumLineCount: 2
                    wrapMode: Text.WrapAnywhere
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    color: themecolor
                    rightPadding: appHeight/36
                }

                Image {
                    id: clipBoard1
                    source: darktheme == true? "qrc:/icons/clipboard_icon_light01.png" : "qrc:/icons/clipboard_icon_dark01.png"
                    height: appHeight/27
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: addressHashLabel.verticalCenter
                    anchors.left: addressHashLabel.right

                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"

                        MouseArea {
                            anchors.fill: parent

                            onPressed: {
                                click01.play()
                                detectInteraction()
                            }

                            onClicked: {
                                if (copy2clipboard == 0 && screenshotTracker == 1) {
                                    copyText2Clipboard(addressHashLabel.text)
                                    copy2clipboard = 1
                                    addressCopied = 1
                                    timer.start()
                                }
                            }
                        }
                    }
                }

                DropShadow {
                    z: 12
                    anchors.fill: textPopup
                    source: textPopup
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color: "black"
                    opacity: 0.4
                    transparentBorder: true
                    visible: textPopup.visible
                }

                Item {
                    id: textPopup
                    z: 12
                    width: popupClipboard.width
                    height: popupClipboardText.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    visible: copy2clipboard == 1 && addressCopied == 1 &&screenshotTracker == 1

                    Rectangle {
                        id: popupClipboard
                        height: appHeight/27
                        width: popupClipboardText.width + appHeight/18
                        color: "#42454F"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Label {
                        id: popupClipboardText
                        text: "Address copied!"
                        font.family: xciteMobile.name
                        font.pointSize: popupClipboard.height/2
                        color: "#F2F2F2"
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }

        Rectangle {
            id: privateArea
            height: parent.height*2/3
            width: height
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: appWidth/12
            color: "transparent"
            border.width: 0.5
            border.color: themecolor

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: appHeight/72
                text: "Your wallet PRIVATE KEY"
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                color: themecolor
            }

            Rectangle {
                id: qrPlaceholder2
                width: privateArea.width/2
                height: width
                anchors.horizontalCenter: privateArea.horizontalCenter
                anchors.top: privateArea.top
                anchors.topMargin: appWidth/24
                color: "white"
                border.color: themecolor
                border.width: 1

                Image {
                    width: parent.width*0.95
                    height: parent.height*0.95
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    source: "image://QZXing/encode/" + walletList.get(walletIndex).privatekey
                    cache: false
                }
            }

            Item {
                width: parent.width*0.8
                height: privateKeyLabel.height
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: appHeight/36

                Label {
                    id: privateKeyLabel
                    text:walletList.get(walletIndex).privatekey
                    width: parent.width - clipBoard2.width
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    maximumLineCount: 3
                    wrapMode: Text.WrapAnywhere
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    color: themecolor
                    rightPadding: appHeight/36
                }
                Image {
                    id: clipBoard2
                    source: darktheme == true? "qrc:/icons/clipboard_icon_light01.png" : "qrc:/icons/clipboard_icon_dark01.png"
                    height: appHeight/27
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: privateKeyLabel.verticalCenter
                    anchors.left: privateKeyLabel.right

                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"

                        MouseArea {
                            anchors.fill: parent

                            onPressed: {
                                click01.play()
                                detectInteraction()
                            }

                            onClicked: {
                                if (copy2clipboard == 0 && screenshotTracker == 1) {
                                    copyText2Clipboard(privateKeyLabel.text)
                                    copy2clipboard = 1
                                    privateKeyCopied = 1
                                    timer.start()
                                }
                            }
                        }
                    }
                }

                DropShadow {
                    z: 12
                    anchors.fill: textPopup2
                    source: textPopup2
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color: "black"
                    opacity: 0.4
                    transparentBorder: true
                    visible: textPopup2.visible
                }

                Item {
                    id: textPopup2
                    z: 12
                    width: popupClipboard2.width
                    height: popupClipboardText2.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    visible: copy2clipboard == 1 && privateKeyCopied == 1 &&screenshotTracker == 1

                    Rectangle {
                        id: popupClipboard2
                        height: appHeight/27
                        width: popupClipboardText2.width + appHeight/18
                        color: "#42454F"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Label {
                        id: popupClipboardText2
                        text: "Private key copied!"
                        font.family: xciteMobile.name
                        font.pointSize: popupClipboard2.height/2
                        color: "#F2F2F2"
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }

    Rectangle {
        id: paperWalletModal
        width: parent.width
        height: parent.height
        color: "transparent"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        state: paperWalletTracker == 1? "up" : "down"

        MouseArea {
            anchors.fill: parent
        }

        states: [
            State {
                name: "up"
                PropertyChanges { target: paperWalletModal; anchors.topMargin: 0}
            },
            State {
                name: "down"
                PropertyChanges { target: paperWalletModal; anchors.topMargin: paperWalletModal.height}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: paperWalletModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
            }
        ]

        Rectangle {
            anchors.fill: parent
            color: bgcolor
            opacity: 0.9
        }

        Rectangle {
            id: closePaperWallet
            width: appWidth/48
            height: width
            radius: height/2
            color: "transparent"
            border.width: 1
            border.color: themecolor
            anchors.right: parent.right
            anchors.rightMargin: appWidth/12
            anchors.bottom: myPaperWallet.top
            anchors.bottomMargin: height/2
            visible: !creatingPaperWallet

            Item {
                width: parent.width*0.6
                height: width
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                rotation: 45

                Rectangle {
                    width: parent.width
                    height: 1
                    color: themecolor
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Rectangle {
                    height: parent.height
                    width: 1
                    color: themecolor
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle {
                id: closeSelect
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
                    closeSelect.visible = true
                }

                onExited: {
                    closeSelect.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    paperWalletTracker = 0
                }
            }
        }

        Rectangle {
            id: createFileButton
            width: appWidth/6
            height: appHeight/27
            anchors.top: myPaperWallet.bottom
            anchors.topMargin: height
            anchors.horizontalCenter: myPaperWallet.horizontalCenter
            border.color: themecolor
            border.width: 1
            color: "transparent"
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
                    pdfprinter.createPaperWalletImage(coin, myPaperWallet.address, mySavedPaperWallet)
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
                font.pointSize: parent.height/2
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
            width: parent.width*0.996 * 0.8
            height: parent.width*0.562 * 0.8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            coin : walletList.get(walletIndex).name
            address: walletList.get(walletIndex).address
            publicKey: walletList.get(walletIndex).publickey
            privateKey: walletList.get(walletIndex).privatekey
            walletLabel: walletList.get(walletIndex).label
            walletAmount: walletList.get(walletIndex).balance

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
                width: saveSuccessLabel.implicitWidth
                height: saveSuccessLabel.font.pixelSize*4
                color: "#34363D"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                visible: fileSaved == 1

                Label {
                    id: saveSuccessLabel
                    text: "File save to: <br><b>" + fileLocation + "</b>"
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    textFormat: Text.RichText
                    horizontalAlignment: Text.AlignHCenter
                    leftPadding: font.pixelSize*5
                    rightPadding: font.pixelSize*5
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

            coin : walletList.get(walletIndex).name
            address: walletList.get(walletIndex).address
            publicKey: walletList.get(walletIndex).publickey
            privateKey: walletList.get(walletIndex).privatekey
            walletLabel: walletList.get(walletIndex).label
            walletAmount: walletList.get(walletIndex).balance
        }

        Rectangle {
            anchors.fill: myPaperWallet
            color: "transparent"
            border.width: 1
            border.color: themecolor
        }
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

    Timer {
        id: timer
        interval: 2000
        repeat: false
        running: false

        onTriggered: {
            addressCopied = 0
            privateKeyCopied = 0
            copy2clipboard = 0
            closeAllClipboard = true
            creatingPaperWallet = false
        }
    }

    Rectangle {
        id: bottomBar
        height: appWidth/24
        width: parent.width
        anchors.bottom: parent.bottom
        color: darktheme == true? "#14161B" : "#FDFDFD"
    }
}
