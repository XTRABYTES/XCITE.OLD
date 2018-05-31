/**
 * Filename: Transactions.qml
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
    anchors.left: parent.left
    anchors.right: parent.right
    height: 67

    Label {
        text: qsTr("Transactions")
        color: "white"
        topPadding: 10
        font.pixelSize: 12
    }
}
