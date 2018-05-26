/**
 * Filename: Form.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */
import QtQuick 2.0
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQrCode.Component 1.0

import "../../Controls" as Controls
import "../../Theme" 1.0

ColumnLayout {
    property alias address: formAddress

    Layout.fillWidth: true

    Controls.FormLabel {
        Layout.bottomMargin: 25
        text: qsTr("Address")
    }

    Controls.TextInput {
        id: formAddress
        Layout.fillWidth: true
        readOnly: true
    }

    RowLayout {
        Layout.topMargin: 6
        Layout.maximumWidth: parent.width

        Label {
            id: copyPasteButton

            readonly property string defaultText: qsTr("Copy to clipboard")
            readonly property string altText: qsTr("Address copied!")
            readonly property string defaultIcon: "../../icons/copy-clipboard.svg"
            readonly property string altIcon: "../../icons/circle-cross.svg"
            property bool isActive: false

            font.pixelSize: 12
            font.weight: isActive ? Font.Bold : Font.Normal
            text: isActive ? altText : defaultText
            color: isActive ? "#ffffff" : "#E3E3E3"
            leftPadding: 24

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    copyTextTimer.start()
                    clipboard.text = formAddress.text
                    parent.isActive = true
                }
            }

            Image {
                id: copyImage
                fillMode: Image.PreserveAspectFit
                source: parent.isActive ? parent.altIcon : parent.defaultIcon
                width: 25
                sourceSize.width: 15
                sourceSize.height: 13
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: parent.Center
                anchors.rightMargin: 5

                Timer {
                    id: copyTextTimer
                    interval: 1500
                    running: false
                    repeat: false
                    onTriggered: copyPasteButton.isActive = false
                }
            }
        }

        Label {
            id: chooseFromAddressBookLabel
            font.weight: Font.Light
            visible: xcite.width > 1100
            color: "#E3E3E3"
            horizontalAlignment: Text.AlignRight
            anchors.right: parent.right
            rightPadding: 20
            font.pixelSize: 12

            text: qsTr("Or choose another address from your list")

            Image {
                fillMode: Image.PreserveAspectFit
                source: "../../icons/right-arrow2.svg"
                width: 19
                height: 13
                sourceSize.width: 19
                sourceSize.height: 13
                anchors.right: parent.right
            }
        }
    }

    Controls.FormLabel {
        Layout.topMargin: 40 - (xcite.width > 1100 ? chooseFromAddressBookLabel.height + 1 : 0)
        Layout.bottomMargin: 25
        text: qsTr("QR Code")
    }

    Label {
        font.pixelSize: 12
        text: qsTr("Send money to this address by scanning QR code")
        color: "#E3E3E3"
    }

    Item {
        width: 240
        height: 240
        Layout.topMargin: 25
        Layout.bottomMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter

        QtQrCode {
            anchors.fill: parent
            data: formAddress.text
            background: "transparent"
            foreground: Theme.primaryHighlight
        }
    }
}
