/**
 * Filename: Header.qml
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

Item {
    property alias text: label.text
    property bool showBack: true

    anchors.left: parent.left
    anchors.right: parent.right
    height: 35

    Label {
        id: label
        font.pixelSize: 16
        anchors.fill: parent
        color: "white"
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        font.bold: true
    }
}
