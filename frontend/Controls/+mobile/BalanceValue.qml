/**
 * Filename: BalanceValue.qml
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

    Column {
        anchors.fill: parent

        Label {
            text: qsTr("Balance Value")
            topPadding: 10
            color: "white"
            font.pixelSize: 12
            bottomPadding: 10
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: -1 // Avoid double width divider
            height: 47

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "transparent"
                border.width: 1
                border.color: "#484B62"
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"
                border.width: 1
                border.color: "#484B62"
            }
        }
    }
}
