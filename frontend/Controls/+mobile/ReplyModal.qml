/**
 * Filename: ReplyModal.qml
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

Item {
    id: replyModal
    width: Screen.width
    height: Screen.height
    anchors.top: Screen.top


    property alias modalHeight: replyModalBody.height
    property alias modalTop: replyModalBody.top
    property alias modalLeft: replyModalBody.left
    property alias modalRight: replyModalBody.right

    Rectangle {
        id: replyModalBody
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        width: parent.width - 50
        color: "#1B2934"
        opacity: 0.05

        LinearGradient {
            anchors.fill: parent
            source: parent
            start: Qt.point(x, y)
            end: Qt.point(x, parent.height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 1.0; color: "#0ED8D2" }
            }
        }
    }

    Rectangle {
        anchors.horizontalCenter: replyModalBody.horizontalCenter
        anchors.bottom: replyModalBody.bottom
        width: replyModalBody.width
        height: replyModalBody.height
        color: "transparent"
        border.color: maincolor
        border.width: 1
        opacity: 0.25
    }

}
