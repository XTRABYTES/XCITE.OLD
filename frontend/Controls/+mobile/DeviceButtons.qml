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

    property int previousX: 0
    property int previousY: 0

    MouseArea {
        anchors.fill: parent
    }

    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: 0.35
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
        anchors.horizontalCenter: parent.horizontalCenter

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

                onClicked: backButtonPressed()
            }
        }
    }
}
