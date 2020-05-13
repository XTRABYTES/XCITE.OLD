/**
 * Filename: DeviceButtons.qml
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


Rectangle {
    id: deviceButtonsBar
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    width: appWidth
    height: 50
    color: "transparent"
    clip: true

    MouseArea {
        anchors.fill: parent
    }

    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: miniatureTracker == 0? 0.35 : 1
    }

    Image {
        id: moveButton
        source: 'qrc:/icons/mobile/move-icon_01_blue.svg'
        height: 30
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 28

        Rectangle {
            width: 30
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    previousX = mouseX
                    previousY = mouseY
                }
                onMouseXChanged: {
                    var dx = mouseX - previousX
                    moveWindowX(dx)
                }
                onMouseYChanged: {
                    var dy = mouseY - previousY
                    moveWindowY(dy)
                }
            }
        }
    }

    Image {
        id: minimizeButton
        source: 'qrc:/icons/mobile/minimize-icon_01_blue.svg'
        height: 30
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: moveButton.horizontalCenter
        anchors.horizontalCenterOffset: (appWidth - 86)/3

        Rectangle {
            width: 30
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onClicked: minimizeApp()
            }
        }
    }

    Image {
        id: miniatureButton
        source: miniatureTracker == 0? 'qrc:/icons/mobile/miniature-icon_01.svg' : 'qrc:/icons/mobile/miniature-icon_02.svg'
        height: 30
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: backButton.horizontalCenter
        anchors.horizontalCenterOffset: -(appWidth - 86)/3

        Rectangle {
            width: 30
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if (miniatureTracker == 1) {
                        miniatureTracker = 0
                    }
                    else {
                        miniatureTracker = 1
                    }
                }
            }
        }
    }

    Image {
        id: backButton
        source: 'qrc:/icons/mobile/return-icon_01.svg'
        height: 20
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 28

        Rectangle {
            width: 30
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if (miniatureTracker == 0) {
                        backButtonPressed()
                    }
                }
            }
        }
    }
}