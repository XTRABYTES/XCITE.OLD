/**
 * Filename: TransactionsBoard.qml
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
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import SortFilterProxyModel 0.1
import QtQuick.Dialogs 1.1
import "../../Controls" as Controls
import "../../Theme" 1.0
import QtQuick.Controls 1.4
import "../Home" as Home

Rectangle {
    id: nodeTransactionsBoardId
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.minimumHeight: 100
    Layout.minimumWidth: 200

    anchors.rightMargin: 15
    anchors.topMargin: 50
    radius: 5
    color: cBoardBackground

    Controls.DiodeHeader {
        id: diodeHeader
        text: qsTr("NODE TRANSACTIONS")
        menuLabelText: qsTr("Complete View")
    }
    Controls.TransactionTable {
    }
}
