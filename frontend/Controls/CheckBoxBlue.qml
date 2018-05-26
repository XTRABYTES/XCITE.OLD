/**
 * Filename: CheckBoxBlue.qml
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
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

CheckBox {
    id: control

    indicator: Rectangle {
        implicitWidth: 16
        implicitHeight: 16
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 2
        color: "black"
        border.color: "#10B9C5"
        border.width: 1

        Rectangle {
            visible: control.checked
            color: "#10B9C5"
            border.color: "#10B9C5"
            radius: 2
            anchors.margins: 3
            anchors.fill: parent
        }
    }

    contentItem: Text {
        color: "#10B9C5"
        text: control.text
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}
