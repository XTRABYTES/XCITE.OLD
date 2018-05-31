/**
 * Filename: BalanceDiode.qml
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
import "../../Controls" as Controls
import "../../Theme" 1.0

Controls.Diode {
    title: qsTr("DEMO BALANCE")
    menuLabelText: "XBY"

    ColumnLayout {
        anchors.margins: 20
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: diodeHeaderHeight + 10
        height: 250

        Controls.BalanceItem {
            label.text: qsTr("Balance")
            prefix.text: "XBY"
            value.text: wallet.balance.toLocaleString(Qt.locale(), 'f',
                                                      8).replace(/\.?0+$/, '')
            Layout.preferredHeight: 29
            Layout.fillWidth: true
        }

        Controls.BalanceItem {
            label.text: qsTr("Unconf.")
            prefix.text: "XBY"
            value.text: wallet.unconfirmed.toLocaleString(Qt.locale(), 'f',
                                                          8).replace(/\.?0+$/,
                                                                     '')
            Layout.preferredHeight: 29
            Layout.fillWidth: true
        }

        Controls.BalanceItem {
            label.text: qsTr("Total")
            value.text: (wallet.balance + wallet.unconfirmed).toLocaleString(
                            Qt.locale(), 'f', 8).replace(/\.?0+$/, '')
            value.color: Theme.primaryHighlight
            prefix.text: "XBY"
            value.font.weight: Font.Normal
            Layout.fillWidth: true
            Layout.preferredHeight: 29
        }
    }
}
