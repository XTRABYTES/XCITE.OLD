/**
 * Filename: Layout.qml
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

import "../Home" as HomeComponents

RowLayout {
    readonly property color cDiodeBackground: "#3a3e46"

    anchors.fill: parent

    spacing: layoutGridSpacing

    FilterTransactionsDiode {
        z: 1
        anchors.top: parent.top
        Layout.preferredWidth: 257
        Layout.preferredHeight: 561
    }

    HomeComponents.RecentTransactionsDiode {
        z: 0
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
}
