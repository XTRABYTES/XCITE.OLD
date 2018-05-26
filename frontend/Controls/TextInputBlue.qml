/**
 * Filename: TextInputBlue.qml
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

Column {
    id: column
    width: 250
    height: 40

    property alias text: input.text
    property alias input: input
    property alias echoMode: input.echoMode
    property alias placeholder: input.placeholderText

    TextField {
        id: input
        height: 40
        width: column.width
        font.pointSize: 10
        font.family: "Roboto Thin"
        placeholderText: placeholder
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#10B9C5"
        background: Rectangle {
            color: "transparent"
        }
    }

    Rectangle {
        height: 1
        width: column.width
        color: "#10B9C5"
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
