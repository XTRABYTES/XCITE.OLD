/**
 * Filename: DiodeHeader.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */
import QtQuick 2.8
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "../Theme" 1.0

Rectangle {
    property color cHeaderText: "#e2e2e2"
    readonly property color cHeaderLine: "#2A2C31"

    property alias menuLabelText: menuLabel.text
    property alias text: label.text
    property alias iconRotation: menuLabel.iconRotation
    property alias iconSource: menuLabel.iconSource
    property alias iconSize: menuLabel.iconSize
    property alias iconOnly: menuLabel.iconOnly

    color: Theme.diodeHeaderBackground
    height: diodeHeaderHeight
    width: parent.width

    Text {
        id: label
        anchors.left: parent.left
        anchors.leftMargin: 20.68
        anchors.verticalCenter: parent.verticalCenter
        color: cHeaderText
        font.pixelSize: 15
    }

    DiodeHeaderMenu {
        id: menuLabel
        visible: menuLabelText.length > 0 || iconOnly == true
    }

    layer.enabled: true
    layer.effect: DropShadow {
        horizontalOffset: 0
        verticalOffset: 2
        samples: 5
        radius: 10
        cached: true
        color: "#1A000000"
    }
}
