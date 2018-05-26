/**
 * Filename: TextInput.qml
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

import "../Theme" 1.0

TextField {
    id: component
    color: "white"
    font.weight: Font.Light
    font.pixelSize: 24
    leftPadding: 18
    rightPadding: 18
    topPadding: 10
    bottomPadding: 10
    verticalAlignment: Text.AlignVCenter
    selectByMouse: true

    background: Rectangle {
        color: "#2A2C31"
        radius: 4
        border.width: parent.activeFocus ? 2 : 0
        border.color: Theme.secondaryHighlight
        implicitWidth: 273
    }

    onActiveFocusChanged: {
        if (component.focus) {
            EventFilter.focus(this)
        }
    }
}
