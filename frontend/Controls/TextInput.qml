/**
 * Filename: TextInput.qml
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
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.11

import "../Theme" 1.0

TextField {
    property int mobile: 0
    property int addressBook: 0
    property int deleteBtn: 1
    property alias deleteImg: deleteInput.source
    property alias textBackground: inputBackground.color
    property int textboxHeight: textInputComponent.height
    property int clipBoard: 0
    property int textCopied: 0
    property bool closeLocalClipboard: closeAllClipboard



    onCloseLocalClipboardChanged: {
        if (closeLocalClipboard == true) {
            clipBoard = 0
        }
    }

    id: textInputComponent
    color: "white"
    font.family: xciteMobile.name
    font.pixelSize: 26
    leftPadding: 18
    rightPadding: deleteBtn == 0 ? 18 : textboxHeight
    topPadding: 6
    bottomPadding: 4
    verticalAlignment: Text.AlignVCenter
    selectByMouse: true
    background: Rectangle {
        id: inputBackground
        color: if(mobile == 0 && addressBook == 0)
                   "#2A2C31"
               else
                   "#34363D"
        radius: mobile == 0? 4 : 0
        border.width: parent.activeFocus ? 2 : 0.5
        border.color: if(mobile == 0)
                          Theme.secondaryHighlight
                      else
                          parent.activeFocus ? maincolor : "#979797"

        width: parent.width
    }

    onActiveFocusChanged: {
        if (textInputComponent.focus) {
            EventFilter.focus(this)
        }
    }

    onPressAndHold: {
        if (textInputComponent.focus) {
            EventFilter.focus(this)
        }
        if (myOS === "ios" || myOS === "android") {
            closeAllClipboard = true
            clipBoard = 1
            closeAllClipboard = false
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        propagateComposedEvents: true
        visible: myOS !== "ios" && myOS !== "android"

        onClicked: {
            if (mouse.button === Qt.RightButton) {
                closeAllClipboard = true
                clipBoard = 1
                closeAllClipboard = false
            }
        }
    }

    property alias placeholder: placeholderTextComponent.text

    Text {
        id: placeholderTextComponent
        anchors.fill: textInputComponent
        font: textInputComponent.font
        horizontalAlignment: textInputComponent.horizontalAlignment
        verticalAlignment: textInputComponent.verticalAlignment
        leftPadding: textInputComponent.leftPadding
        rightPadding: textInputComponent.rightPadding
        topPadding: textInputComponent.topPadding
        bottomPadding: textInputComponent.bottomPadding
        opacity: !textInputComponent.displayText
                 && (!textInputComponent.activeFocus
                     || textInputComponent.horizontalAlignment !== Qt.AlignHCenter) ? 1.0 : 0.0
        color: "#727272"
        clip: contentWidth > width
        elide: Text.ElideRight
    }

    Image {
        id: deleteInput
        source: darktheme == true? 'qrc:/icons/mobile/delete-icon_01_light.svg' : 'qrc:/icons/mobile/delete-icon_01_dark.svg'
        height: 12
        width: 12
        anchors.right: textInputComponent.right
        anchors.rightMargin: 11
        anchors.verticalCenter: textInputComponent.verticalCenter
        visible: mobile == 1 && deleteBtn == 1 && textInputComponent.text != ""

        MouseArea {
            width: textboxHeight
            height: textboxHeight
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                textInputComponent.text = ""
                selectedAddress = ""
            }
        }
    }

    DropShadow {
        z: 12
        anchors.fill: clipBoardPopup
        source: clipBoardPopup
        horizontalOffset: 0
        verticalOffset: 4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.4
        transparentBorder: true
        visible: clipBoard == 1
    }

    Item {
        id: clipBoardPopup
        z: 12
        width: (myOS === "ios" || myOS === "android")? 190 : appWidth/6
        height: (myOS === "ios" || myOS === "android")? 40 : appHeight/18
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -height/4
        visible: clipBoard == 1

        MouseArea {
            height: Screen.height
            width: Screen.width
            anchors.verticalCenter: Screen.verticalCenter
            anchors.horizontalCenter: Screen.horizontalCenter

            onClicked: clipBoard = 0
        }

        Rectangle {
            id: copyToClipboard
            height: parent.height
            width: (parent.width - parent.height)/2
            color: "#34363D"
            anchors.left: parent.left
            anchors.verticalCenter: clipBoardPopup.verticalCenter

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if(textInputComponent.text == "") {
                        copyText2Clipboard(placeholderTextComponent.text)
                    }

                    else {
                        copyText2Clipboard(textInputComponent.text)
                    }
                    clipBoard = 0
                    textCopied = 1
                }
            }
        }

        Label {
            id: toClipboardText
            text: "Copy"
            font.family: xciteMobile.name
            font.pixelSize: parent.height/2.5
            font.bold: myOS === "ios" || myOS === "android"
            color: "#F2F2F2"
            anchors.horizontalCenter: copyToClipboard.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: copyFromClipboard
            height: parent.height
            width: (parent.width - parent.height)/2
            color: "#34363D"
            anchors.left: copyToClipboard.right
            anchors.verticalCenter: clipBoardPopup.verticalCenter

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    textInputComponent.text = clipboard.text
                    clipBoard = 0
                }
            }
        }

        Label {
            id: fromClipboardText
            text: "Paste"
            font.family: xciteMobile.name
            font.pixelSize: parent.height/2.5
            font.bold: myOS === "ios" || myOS === "android"
            color: "#F2F2F2"
            anchors.horizontalCenter: copyFromClipboard.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }



        Rectangle {
            id: closeClipboard
            height: parent.height
            width: height
            color: "#34363D"
            anchors.left: copyFromClipboard.right
            anchors.verticalCenter: parent.verticalCenter

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    clipBoard = 0
                }
            }
        }

        Image {
            id: closeClipboardImage
            source:'qrc:/icons/mobile/delete-icon_01_light.svg'
            height: parent.height/2
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: closeClipboard.horizontalCenter
            anchors.verticalCenter: closeClipboard.verticalCenter
        }
    }

    DropShadow {
        z: 12
        anchors.fill: copiedPopup
        source: copiedPopup
        horizontalOffset: 0
        verticalOffset: 4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.4
        transparentBorder: true
        visible: textCopied == 1
    }

    Item {
        id: copiedPopup
        z: 12
        width: popupCopied.width
        height: (myOS === "ios" || myOS === "android")? 40 : appHeight/18
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -height/4
        visible: textCopied == 1

        Rectangle {
            id: popupCopied
            height: parent.height
            width: popupCopiedText.width + height
            color: "#34363D"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: popupCopiedText
            text: "Copied to clipboard!"
            font.family: xciteMobile.name
            font.pointSize: parent.height/2
            font.bold: myOS === "ios" || myOS === "android"
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Timer {
            repeat: false
            running: textCopied == 1
            interval: 2000

            onTriggered: textCopied = 0
        }
    }
}
