/**
 * Filename: SideMenuButton.qml
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
import "../Theme" 1.0

Rectangle {
    property alias size: button.size
    property alias labelText: button.labelText
    property alias imageSource: button.imageSource
    property alias name: button.name
    property alias imageOffsetX: button.imageOffsetX

    property bool isActive: (selectedView === this.name)

    anchors.left: parent.left
    anchors.right: parent.right
    height: 74

    color: isActive ? "#2F3238" : "transparent"

    Rectangle {
        visible: isActive
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: 5
        color: Theme.secondaryHighlight
    }

    ButtonIcon {
        id: button
        property string name

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        isSelected: selectedView === this.name
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

        onButtonClicked: {
            selectView(this.name)
        }
    }
}
