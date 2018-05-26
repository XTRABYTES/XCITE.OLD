/**
 * Filename: FilterTransactionsDiode.qml
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
import Qt.labs.calendar 1.0

import "../../Controls" as Controls

Controls.Diode {
    title: qsTr("FILTER TRANSACTIONS")

    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: 75
        anchors.leftMargin: 15
        anchors.rightMargin: 15

        Label {
            font.weight: Font.Light
            font.pixelSize: 16
            color: "#d5d5d5"
            text: qsTr("Type")
        }

        Controls.ComboBox {
            Layout.fillWidth: true
            model: ["Please select", "Foo", "Bar", "Baz"]
        }

        Label {
            topPadding: 15
            bottomPadding: 5
            font.weight: Font.Light
            font.pixelSize: 16
            color: "#d5d5d5"
            text: qsTr("Dates between")
        }

        Controls.DatePicker {
            z: 3
        }

        Label {
            topPadding: 5
            bottomPadding: 5
            font.weight: Font.Light
            font.pixelSize: 16
            color: "#d5d5d5"
            text: qsTr("and")
        }

        Controls.DatePicker {
            z: 2
        }

        Label {
            topPadding: 15
            font.weight: Font.Light
            font.pixelSize: 16
            color: "#d5d5d5"
            text: qsTr("To")
        }

        Controls.ComboBox {
            z: 1
            Layout.fillWidth: true
            model: ["Select address"]
        }

        Label {
            topPadding: 20
            font.weight: Font.Light
            font.pixelSize: 16
            color: "#d5d5d5"
            text: qsTr("Transaction value")
        }

        RangeSlider {
            first.value: 0
            second.value: 60000
        }
    }
}
