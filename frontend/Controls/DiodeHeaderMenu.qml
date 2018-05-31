/**
 * Filename: DiodeHeaderMenu.qml
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

RowLayout {
    id: currencyDropdownWidget

    property alias text: menuLabel.text
    property string iconSource: "../icons/dropdown-arrow.svg"
    property int iconRotation: 0
    property int iconSize: 5
    property bool iconOnly: false

    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    height: parent.height
    spacing: 0

    Text {
        id: menuLabel
        color: cHeaderText
        font.pixelSize: 12
        rightPadding: 10
    }

    Rectangle {
        color: cHeaderLine
        width: 2
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        visible: !iconOnly
    }

    ButtonIcon {
        id: icon
        width: parent.height
        anchors.verticalCenter: parent.verticalCenter
        imageSource: iconSource
        imageRotation: iconRotation
        size: iconSize
    }
}
