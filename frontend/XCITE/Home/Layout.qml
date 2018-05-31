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

ColumnLayout {
    anchors.fill: parent
    spacing: layoutGridSpacing

    LayoutBalanceLeft {
        RecentTransactionsDiode {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    ChartDiode {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: 400
        Layout.maximumHeight: 750
    }
}
