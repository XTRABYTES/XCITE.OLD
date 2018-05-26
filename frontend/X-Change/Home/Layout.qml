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
import "../../Controls" as Controls

Item {
    readonly property color cBoardBackground: "#3a3e46"

    id: xChange
    anchors.fill: parent

    visible: false
    height: parent.height - 100
    ColumnLayout {
        anchors.left: markets.right
        anchors.right: parent.right
        anchors.leftMargin: 10
        Controls.ChartDiode {
        }
        RowLayout {
            BuySellDiode {
            }
            OrderBookDiode {
            }
        }
    }

    MarketsDiode {
        id: markets
        anchors.left: parent.left
    }
}
