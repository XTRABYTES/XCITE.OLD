/**
 * Filename: FormLabel.qml
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

Text {
    font.pixelSize: 16
    font.weight: Font.Light
    text: qsTr("Amount")
    color: "#E3E3E3"

    Rectangle {
        x: 0
        y: 30.29
        height: 1
        width: parent.width
        color: "#24B9C3"
    }
}
