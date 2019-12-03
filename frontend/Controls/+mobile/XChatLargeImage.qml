/**
* Filename: XChatLargeImage.qml
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

Rectangle {
    id: xchatImageModal
    width: appWidth
    height: appHeight
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    visible: xChatLargeImageTracker == 1

    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: 0.75
    }

    MouseArea {
        anchors.fill: parent

    }

    DropShadow {
        anchors.fill: imageFrame
        source: imageFrame
        samples: 9
        radius: 4
        color: darktheme == true? "#000000" : "#727272"
        horizontalOffset:0
        verticalOffset: 0
        spread: 0
    }

    Rectangle {
        id: imageFrame
        width: largeImage.paintedWidth + 40
        height: largeImage.paintedHeight + 60
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
    }

    Image {
        id: closeImage
        source: 'qrc:/icons/mobile/close-icon_01_white.svg'
        height: 9
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: imageFrame.top
        anchors.verticalCenterOffset: 15
        anchors.right: imageFrame.right
        anchors.rightMargin: 10
    }

    Rectangle {
        id: closeImageButton
        width: 35
        height: 35
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
                xChatLargeImageTracker = 0
                xchatLargeImage = ""
            }
        }
    }

    Image {
        id: largeImage
        source: xchatLargeImage
        width: parent.width - 56
        height: parent.height - 150
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: imageFrame.horizontalCenter
        anchors.verticalCenter: imageFrame.verticalCenter

        Rectangle {
            anchors.fill: parent
            color: "transparent"

            MouseArea {
                anchors.fill:parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onPressAndHold: {
                    downloadImage(messageImage.source)
                }
            }
        }
    }
}
