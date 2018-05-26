/**
 * Filename: BalanceItem.qml
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
import "../Controls" as Controls
import "../Theme" 1.0

Item {
    readonly property color cBalanceValue: "#d5d5d5"

    property alias label: label
    property alias value: value
    property alias prefix: prefix

    RowLayout {
        anchors.fill: parent

        Controls.LabelUnderlined {
            id: label
            visible: text !== ''
            pixelSize: 19
            width: 90
            Layout.fillHeight: true
        }

        Label {
            id: value

            Layout.fillWidth: true
            verticalAlignment: Text.AlignVCenter

            color: cBalanceValue
            font.family: Theme.fontCondensed
            font.weight: Font.Light
            font.pixelSize: 24
            minimumPixelSize: 10
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignRight
            leftPadding: 60

            Label {
                id: prefix
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                color: "#bfbfbf"
                font.pixelSize: 18
                font.weight: Font.Light
            }
        }
    }
}
