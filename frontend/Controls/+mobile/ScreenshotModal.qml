/**
 * Filename: ScreenshotModal.qml
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
import Clipboard 1.0
import QZXing 2.3
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: screenShotModal
    width: Screen.width
    state: screenshotTracker == 1? "up" : "down"
    height: Screen.height
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: Screen.height

    states: [
        State {
            name: "up"
            PropertyChanges { target: screenShotModal; anchors.topMargin: 0}
            PropertyChanges { target: screenShotModal; opacity: 1}
        },
        State {
            name: "down"
            PropertyChanges { target: screenShotModal; anchors.topMargin: Screen.height}
            PropertyChanges { target: screenShotModal; opacity: 0}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: screenShotModal; properties: "anchors.topMargin, opacity"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    property string textForPopup: ""
    property string keyType: ""

    Text {
        id: screenshotModalLabel
        text: "TAKE A SCREENSHOT TO BACK UP"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 15
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Item {
        id: coinId
        height: coinLogo.height
        width: coinLogo.width + coinName.width + 7
        anchors.top: screenshotModalLabel.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: coinLogo
            source: getLogo(coinName.text)
            height: 30
            width: 30
            anchors.left: parent.left
            anchors.top: parent.top
        }

        Label {
            id: coinName
            anchors.left: coinLogo.right
            anchors.leftMargin: 7
            anchors.verticalCenter: coinLogo.verticalCenter
            text: walletList.get(walletIndex).name
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            font.letterSpacing: 2
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            font.bold: true
        }
    }

    Label {
        id: walletName
        width: doubbleButtonWidth
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: coinId.bottom
        anchors.topMargin: 5
        text: walletList.get(walletIndex).label
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        font.letterSpacing: 2
        color: darktheme == false? "#2A2C31" : "#F2F2F2"
        font.bold: true
        elide: Text.ElideRight
    }

    Label {
        id:addressTextLabel
        text: "Your wallet ADDRESS:"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: walletName.bottom
        anchors.topMargin: 10
        font.pixelSize: 18
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Rectangle {
        id: qrBorder1
        radius: 4
        width: height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: addressTextLabel.bottom
        anchors.topMargin: 5
        anchors.bottom: addressLabel.top
        anchors.bottomMargin: 10
        color: "#FFFFFF"
    }

    Item {
        id: qrPlaceholder1
        width: qrBorder1.width*0.9
        height: qrBorder1.height*0.9
        anchors.horizontalCenter: qrBorder1.horizontalCenter
        anchors.verticalCenter: qrBorder1.verticalCenter

        Image {
            anchors.fill: parent
            source: "image://QZXing/encode/" + walletList.get(walletIndex).address
            cache: false
        }
    }

    Label {
        id:addressLabel
        text: walletList.get(walletIndex).address
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: privateKeyTextLabel.top
        anchors.bottomMargin: 20
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"

        Rectangle {
            width: parent.width
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onPressAndHold: {
                    if(copy2clipboard == 0 && screenshotTracker == 1) {
                        copyText2Clipboard(addressLabel.text)
                        textForPopup = addressLabel.text
                        keyType = "address"
                        copy2clipboard = 1
                    }
                }
            }
        }
    }

    Label {
        id:privateKeyTextLabel
        text: "Your wallet PRIVATE KEY:"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        font.pixelSize: 18
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Rectangle {
        id: qrBorder2
        radius: 4
        width: height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: privateKeyLabel.top
        anchors.bottomMargin: 10
        anchors.top: privateKeyTextLabel.bottom
        anchors.topMargin: 5
        color: "#FFFFFF"
    }

    Item {
        id: qrPlaceholder2
        width: qrBorder2.width * 0.9
        height: qrBorder2.height *0.9
        anchors.horizontalCenter: qrBorder2.horizontalCenter
        anchors.verticalCenter: qrBorder2.verticalCenter

        Image {
            anchors.fill: parent
            source: "image://QZXing/encode/" + walletList.get(walletIndex).privatekey
            cache: false
        }
    }

    Label {
        id:privateKeyLabel
        width: (implicitWidth/2) + 5
        text: walletList.get(walletIndex).privatekey
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: closeScreenshotModal.top
        anchors.bottomMargin: 40
        maximumLineCount: 3
        horizontalAlignment: Text.AlignLeft
        wrapMode: Text.WrapAnywhere
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"

        Rectangle {
            width: parent.width
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onPressAndHold: {
                    if(copy2clipboard == 0 && screenshotTracker == 1) {
                        copyText2Clipboard(privateKeyLabel.text)
                        textForPopup = privateKeyLabel.text
                        keyType = "private"
                        copy2clipboard = 1
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
        visible: copy2clipboard == 1 && screenshotTracker == 1
    }

    Item {
        id: textPopup
        z: 12
        width: popupClipboard.width
        height: popupClipboardText.height + 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: copy2clipboard == 1 && screenshotTracker == 1

        Rectangle {
            id: popupClipboard
            height: popupClipboardText.height + 10
            width: popupClipboardText.width + 20
            color: "#34363D"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: popupClipboardText
            width: keyType == "address"? addressLabel.width : privateKeyLabel.width
            text: textForPopup + "<br>Copied to clipboard!"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            wrapMode: Text.WrapAnywhere
            color: "#F2F2F2"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
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

    Label {
        id: closeScreenshotModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : 70
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"

        Rectangle{
            id: closeButton
            height: 34
            width: parent.width
            radius: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

        }

        MouseArea {
            anchors.fill: closeButton

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                screenshotTracker = 0
                keyType = ""
                textForPopup = ""
            }
        }
    }
}

