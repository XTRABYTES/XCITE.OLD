/**
 * Filename: AddressBookSquares.qml
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
import QtGraphicalEffects 1.0

Rectangle {
    property string name: "Posey"
    property string numberAddresses: "5"
    id: square
    color: "#42454F"
    width: Screen.width - 55
    height: 75
    radius: 8

    Label {
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.top: parent.top
        anchors.topMargin: 22
        text: name
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        color: "#E5E5E5"
        font.bold: true
    }
    Label {
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.top: parent.top
        anchors.topMargin: 22
        text: numberAddresses + " addresses"
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        color: "#E5E5E5"
        font.bold: true
    }
}
