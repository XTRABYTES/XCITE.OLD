/**
 * Filename: ChartDiode.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */
import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import SortFilterProxyModel 0.1
import QtQuick.Dialogs 1.1

import "../Theme" 1.0

Diode {
    width: 1600
    height: 446
    radius: 5
    color: "#3A3E47"
    Layout.fillWidth: true
    DiodeHeader {
        text: "XBY/XFUEL"
    }
    Image {
        id: placeholderImage
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.topMargin: 10
        // horizontalAlignment: Image.AlignLeft
        source: "../../icons/graph5.svg"
        fillMode: Image.PreserveAspectFit
        // opacity: 0.4
        Rectangle {
            anchors.left: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 1
            color: "#484A4D"
        }
    }
}
