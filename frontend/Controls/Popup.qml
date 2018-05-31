/**
 * Filename: Popup.qml
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
import QtQuick.Layouts 1.3
import "../Theme" 1.0

RowLayout {
    id: popup
    property string title: "Pop-up!"
    property string message: "Warnings, messages and other stuff here!"

    height: 56.28
    spacing: 20

    Rectangle {
        anchors.fill: parent
        color: Theme.primaryHighlight
        radius: 2
    }

    Text {
        text: title
        font.weight: Font.Bold
        font.pixelSize: 20
    }

    Text {
        font.pixelSize: 16
        text: message
    }

    IconButton {
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        Layout.preferredWidth: 40

        img.source: "../icons/cross.svg"
        img.sourceSize.width: 10

        onClicked: {
            popup.visible = false
        }
    }
}
