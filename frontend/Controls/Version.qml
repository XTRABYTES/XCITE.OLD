/**
 * Filename: Version.qml
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
    text: "v" + AppVersion
    color: "white"
    font.pixelSize: 12
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    anchors.bottomMargin: 10
    anchors.rightMargin: 10
}
