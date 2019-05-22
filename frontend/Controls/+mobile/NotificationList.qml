/**
* Filename: Notificationlist.qml
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
import QtGraphicalEffects 1.0
import QtMultimedia 5.8
import QtQuick.Window 2.2

import "qrc:/Controls" as Controls

Rectangle {
    width: parent.width
    height: parent.height
    color: "transparent"

    Component {
        id: notificationLine

        Rectangle {
            id: notificationRow
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            height: date == ""? 0 : 130
            color:"transparent"
            clip: true

            Controls.CardBody {

            }

            Label {
                id: notificationDate
                text: date
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.top: parent.top
                anchors.topMargin: 14
                font.family: xciteMobile.name
                font.pixelSize: 16
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Label {
                id: notificationOrigin
                text: origin
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.right: parent.right
                anchors.rightMargin: 28
                anchors.top: notificationDate.bottom
                anchors.topMargin: 1
                font.family: xciteMobile.name
                font.pixelSize: 18
                font.bold: true
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                elide: Text.ElideRight
            }

            Label {
                id: notificationMessage
                maximumLineCount: 2
                wrapMode: Text.Wrap
                text: message
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.top: notificationOrigin.bottom
                anchors.topMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 28
                font.family: xciteMobile.name
                font.pixelSize: 14
                font.capitalization: Font.SmallCaps
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                elide: Text.ElideRight
            }
        }
    }

    ListView {
        anchors.fill: parent
        id: notificationlist
        model: alertList
        delegate: notificationLine
        contentHeight: ((alertList.count - 1) * 130) + 125
        onDraggingChanged: detectInteraction()
    }
}
