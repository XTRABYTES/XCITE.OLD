/**
 * Filename: X-CHANGE.qml
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
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

import "qrc:/Controls" as Controls

Rectangle {
    id: xchangeModal
    width: appWidth*5/6
    height: appHeight
    state: xchangeTracker == 1? "up" : "down"
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    clip: true

    states: [
        State {
            name: "up"
            PropertyChanges { target: xchangeModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: xchangeModal; anchors.topMargin: xchangeModal.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: xchangeModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    Label {
        id: addressbookLabel
        text: "X-CHANGE"
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Image {
        id: underConstruction
        source: darktheme === true? 'qrc:/icons/mobile/construction-icon_01_white.svg' : 'qrc:/icons/mobile/construction-icon_01_black.svg'
        height: appHeight/12
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
