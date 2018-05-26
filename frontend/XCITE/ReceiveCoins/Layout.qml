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
import "../../Controls" as Controls

ColumnLayout {
    anchors.fill: parent
    spacing: layoutGridSpacing

    HomeComponents.LayoutBalanceLeft {
        Layout.preferredHeight: 620
        Layout.maximumHeight: 720

        ReceiveDiode {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    Controls.AccountCreateForm {
        id: accountCreateForm
    }
}
