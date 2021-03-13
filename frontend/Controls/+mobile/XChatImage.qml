/**
* Filename: XChatImage.qml
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
import SortFilterProxyModel 0.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.11
import QtQuick.Window 2.2

import "qrc:/Controls/+mobile" as Mobile
import "qrc:/Controls" as Controls

Rectangle {
    id: xchatImageModal
    width: appWidth
    height: appHeight
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    visible: xChatImageTracker == 1
    property bool formatError: false
    property alias urlText: imageText.text
    property alias imageSource: image.source

    function checkImageFormat(url) {
        var urlArray = url.split('.')
        var i = urlArray.length
        if ((urlArray[i-1] === "jpg") || (urlArray[i-1] === "jpeg") || (urlArray[i-1] === "svg") || (urlArray[i-1] === "png")) {
            formatError = false
            image.source = url
        }
        else {
            formatError = true
            image.source = 'qrc:/icons/mobile/image_large-icon_01_grey.svg'
        }
    }

    MouseArea {
        anchors.fill: parent
    }

    Rectangle {
        width: parent.width
        height: parent.height
        color: "black"
        opacity: 0.5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
    }

    DropShadow {
        anchors.fill: imageBox
        source: imageBox
        samples: 9
        radius: 4
        color: darktheme == true? "#000000" : "#727272"
        horizontalOffset:0
        verticalOffset: 0
        spread: 0
    }

    Rectangle {
        id: imageBox
        width: parent.width - 56
        height: imageBoxLabel.height + imageText.height + image.height + deleteImage.height + 65
        color: darktheme == true? "#2A2C31" : "#F2F2F2"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50

        Label {
            id: imageBoxLabel
            text: "IMAGE"
            anchors.left: imageBox.left
            anchors.leftMargin: 10
            anchors.top: imageBox.top
            anchors.topMargin: 5
            horizontalAlignment: Text.AlignLeft
            font.family: xciteMobile.name
            wrapMode: Text.Wrap
            font.pixelSize: 16
            font.bold: true
            color: darktheme == false? "#14161B" : "#F2F2F2"
        }

        Label{
            id: closeImage
            text: image.source == 'qrc:/icons/mobile/image_large-icon_01_grey.svg' || imageText.text == ""? "Close" : "Add image"
            font.family: xciteMobile.name
            font.pixelSize: 16
            font.capitalization: Font.SmallCaps
            color: darktheme == false? "#14161B" : "#F2F2F2"
            anchors.verticalCenter: imageBoxLabel.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
        }

        Rectangle {
            id: closeImageButton
            width: closeImage.width
            height: closeImage.height
            anchors.horizontalCenter: closeImage.horizontalCenter
            anchors.verticalCenter: closeImage.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (image.source == 'qrc:/icons/mobile/image_large-icon_01_grey.svg' || imageText.text === "") {
                        xchatImage = ""
                        imageAdded = false
                        xChatImageTracker = 0
                    }
                    else {
                        checkImageFormat(imageText.text)
                        if (formatError == false) {
                            xchatImage = imageText.text
                            imageAdded = true
                            xChatImageTracker = 0
                        }
                    }
                }
            }
        }

        Controls.TextInput {
            id: imageText
            height: 34
            placeholder: "Type your image URL."
            text: ""
            anchors.left: imageBox.left
            anchors.leftMargin: 10
            anchors.right: previewIcon.left
            anchors.rightMargin: 10
            anchors.top: imageBoxLabel.bottom
            anchors.topMargin: 10
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            mobile: 1
            deleteBtn: 0

            onTextChanged: {
                if (imageAdded == true) {
                    image.source = 'qrc:/icons/mobile/image_large-icon_01_grey.svg'
                    xchatImage = ""
                    imageAdded = false
                }
            }
        }

        Image {
            id: previewIcon
            source: darktheme == true? 'qrc:/icons/mobile/eye-icon_01_white.svg' : 'qrc:/icons/mobile/eye-icon_01_black.svg'
            width: 20
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: imageText.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10

            Rectangle {
                id: previewBtn
                height: 20
                width: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
            }

            MouseArea {
                anchors.fill: previewBtn

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (imageText.text != "") {
                        checkImageFormat(imageText.text)
                    }
                }
            }
        }

        Image {
            id: image
            source: 'qrc:/icons/mobile/image_large-icon_01_grey.svg'
            height: 120
            width: parent.width - 20
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: imageText.bottom
            anchors.topMargin: 20
        }

        Image {
            id: deleteImage
            source: darktheme == true? 'qrc:/icons/mobile/trash-icon_01_light.svg' : 'qrc:/icons/mobile/trash-icon_01_dark.svg'
            height: 20
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: image.bottom
            anchors.topMargin: 10

            Rectangle {
                id: deleteButton
                height: 20
                width: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
            }

            MouseArea {
                anchors.fill: deleteButton

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    imageText.text = ""
                    image.source = 'qrc:/icons/mobile/image_large-icon_01_grey.svg'
                    //xchatImage = ""
                    //imageAdded = false
                }
            }
        }
    }

    DropShadow {
        anchors.fill: notificationBox
        source: notificationBox
        samples: 9
        radius: 4
        color: darktheme == true? "#000000" : "#727272"
        horizontalOffset:0
        verticalOffset: 0
        spread: 0
        visible: formatError == true
    }

    Rectangle {
        id: notificationBox
        width: notification.width + 40
        height: 50
        color: darktheme == true? "#2A2C31" : "#F2F2F2"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        visible: formatError == true

        Item {
            id: notification
            width: notificationIcon.width + notificationText.width + 15
            height: notificationIcon.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: notificationIcon
                source: 'qrc:/icons/mobile/warning-icon_01_yellow.svg'
                height: 30
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: notification.verticalCenter
                anchors.left: notification.left
            }

            Label {
                id: notificationText
                text: "URL does not contain a valid image"
                color: "#F2F2F2"
                font.pixelSize: 12
                font.family: xciteMobile.name
                anchors.verticalCenter: notification.verticalCenter
                anchors.right: notification.right
            }
        }
    }

    Timer {
        id: errorTimer
        interval: 2000
        repeat: false
        running: formatError == true

        onTriggered: {
            formatError = false
        }
    }
}

