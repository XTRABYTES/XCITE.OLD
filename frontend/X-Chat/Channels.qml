/**
 * Filename: Channels.qml
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
import QtQuick.Layouts 1.3

ColumnLayout {

    spacing: layoutGridSpacing

    Rectangle {

        readonly property color cDiodeBackground: "#3a3e46"
        color: CDiodeBackground
        width: 257
        height: parent.fill
    }
}
