/**
 * Filename: AddWallet.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

import QtQuick.Controls 2.3
import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtMultimedia 5.8

import "qrc:/Controls" as Controls

Rectangle {
    id: addWalletModal
    width: Screen.width
    state: addWalletTracker == 1? "up" : "down"
    height: Screen.height
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    MouseArea {
        anchors.fill: parent
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: addWalletModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: addWalletModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: addWalletModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]
}
