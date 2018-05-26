/**
 * Filename: ReceiveCoins.qml
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
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import "../Controls" as Controls

Item {
    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 100

        Controls.Header {
            text: qsTr("Receive XBY")
        }
        Text {
            id: defAddress
            anchors.left: qrCode.left
            anchors.top: parent.top
            anchors.topMargin: 50
            text: "Default Address"
            color: "White"
            font.family: Theme.fontCondensed
            font.pointSize: 14
        }
        // Address placeholder
        Text {
            id: address1
            anchors.top: defAddress.bottom
            anchors.topMargin: 10
            text: "BMy2BpwyJc5i7upNm5Vv8HMkwXqBR3kCxS"
            color: "Grey"
            font.family: Theme.fontCondensed
            font.pointSize: 15
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: qrCode.left
        }
        Rectangle {
            anchors.top: address1.top
            anchors.left: address1.left
            anchors.topMargin: -6
            anchors.leftMargin: -2
            width: qrCode.width
            height: 30
            border.color: "Grey"
            color: "transparent"
        }
        Image {
            id: qrCode
            source: "../icons/placeholder-qr.svg"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 140
            width: 315
            height: 315
        }

        Image {
            id: balanceCount
            anchors.top: qrCode.bottom
            anchors.topMargin: 30
            anchors.left: qrCode.left
            anchors.leftMargin: 100
            source: "../logos/xby_logo.svg"
            width: 50
            height: 30
        }

        Text {
            anchors.left: qrCode.left
            anchors.top: qrCode.top
            anchors.topMargin: -20
            anchors.leftMargin: 0
            text: "QR Code"
            color: "White"
            font.family: Theme.fontCondensed
            font.pointSize: 14
        }
        Text {
            anchors.left: balanceCount.right
            anchors.top: qrCode.bottom
            anchors.topMargin: 35
            anchors.leftMargin: 5
            text: "4739.35"
            color: "White"
            font.family: Theme.fontCondensed
            font.pointSize: 14
        }
    }
}
