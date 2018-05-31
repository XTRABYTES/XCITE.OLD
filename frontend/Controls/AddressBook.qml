/**
 * Filename: AddressBook.qml
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
import "../Theme" 1.0

ListView {
    property int leftMargin: 3
    property int rightMargin: 3
    property double delegateLineHeight: 1.5

    id: addressBook
    anchors.fill: parent
    anchors.topMargin: 10
    anchors.bottomMargin: 10
    anchors.leftMargin: leftMargin
    anchors.rightMargin: rightMargin

    highlightMoveDuration: 0
    highlightResizeDuration: 0

    clip: true

    currentIndex: 0

    delegate: Label {
        property variant item: model

        verticalAlignment: Text.AlignVCenter
        width: parent.width

        leftPadding: 20
        rightPadding: 20
        text: name || "Default"
        font.weight: Font.Light
        font.pixelSize: 16
        color: addressBook.currentIndex == index ? "black" : "white"
        lineHeight: 1.5

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: addressBook.currentIndex = index
        }
    }

    highlight: Rectangle {
        color: Theme.primaryHighlight
    }

    function load() {
        model.load()
    }

    function save() {
        model.save()
    }

    function add(name, address) {
        currentIndex = model.append(name, address)
    }

    function update(name, address) {
        if (currentItem) {
            model.update(currentIndex, name, address)
        }
    }

    function getSelectedItem() {
        return model.get(currentIndex)
    }

    function removeSelected() {
        if (currentItem) {
            var idxToRemove = currentIndex

            // Prevent highlight flicker
            currentIndex--

            model.remove(idxToRemove)
        }
    }
}
