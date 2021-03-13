/**
 * Filename: DragBar.qml
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


Rectangle {
    id: deviceButtonsBar
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    width: appWidth
    height: 50
    color: "transparent"

    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true

        onPressed: {
            previousX = mouseX
            previousY = mouseY
        }
        onMouseXChanged: {
            var dx = mouseX - previousX
            moveWindowX(dx)
        }
        onMouseYChanged: {
            var dy = mouseY - previousY
            moveWindowY(dy)
        }
    }
}
