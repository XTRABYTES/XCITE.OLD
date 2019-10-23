/**
* Filename: XChatList.qml
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
import SortFilterProxyModel 0.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.11
import QtQuick.Window 2.2

import "qrc:/Controls" as Controls

Rectangle {
    width: parent.width
    height: parent.height
    anchors.top: parent.top
    color: "transparent"
    clip :true

    property bool xChatFocus: true
    property alias xChatList: msgList

    Component {
        id: msgLine

        Rectangle {
            id: msgRow
            width: parent.width
            height: message != ""? senderID.height + messageText.height + messageDate.height + 24 : 0
            color: "transparent"
            visible: message != ""
            clip: true

            Rectangle {
                id: msgBox
                width: messageText.width < (senderID.width + deviceID.width)? (senderID.width + deviceID.width > messageDate.width? (senderID.width + deviceID.width + 20): (messageDate.width + 20)) : messageText.width + 20
                anchors.top: parent.top
                anchors.bottom: messageText.bottom
                anchors.left: author==(username)? undefined : parent.left
                anchors.right: author==(username)? parent.right : undefined
                color: "transparent"
            }

            Label {
                id: senderID
                text: author
                font.family: xciteMobile.name
                font.pixelSize: 12
                font.bold: true
                horizontalAlignment: Text.AlignLeft
                color: darktheme == true? "#F2F2F2" : "#0ED8D2"
                anchors.left:msgBox.left
                anchors.leftMargin: 10
                anchors.top: msgBox.top
                anchors.topMargin: 5
            }

            Rectangle {
                id: deviceID
                height: 5
                width: 5
                radius: 5
                anchors.left: senderID.right
                anchors.leftMargin: 5
                anchors.verticalCenter: senderID.verticalCenter
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Text {
                id: messageText
                text: message
                anchors.left: msgBox.left
                anchors.leftMargin: 10
                anchors.top: senderID.bottom
                anchors.topMargin: 7
                width:  messageText.implicitWidth < 0.8 * (Screen.width - 56)? messageText.implicitWidth : (0.7 * (Screen.width - 56))
                horizontalAlignment: author==(username)? Text.AlignRight : Text.AlignLeft
                font.family: xciteMobile.name
                wrapMode: Text.Wrap
                font.pixelSize: 16
                color: darktheme == true? "#0ED8D2" : "#2A2C31"
            }

            Label {
                id: messageDate
                text: date
                anchors.right: msgBox.right
                anchors.rightMargin: 10
                anchors.top: msgBox.bottom
                anchors.topMargin: -10

                font.family: xciteMobile.name
                font.pixelSize: 10
                font.italic: true
                horizontalAlignment: Text.AlignRight
                color: darktheme == true? "#F2F2F2" : "#0ED8D2"
            }
        }
    }

    SortFilterProxyModel {
        id: arrangedMsg
        sourceModel: xChatTread
        sorters: [
            RoleSorter { roleName: "ID" ; sortOrder: Qt.DecendingOrder }
        ]
    }

    ListView {
        anchors.fill: parent
        id: msgList
        model: arrangedMsg
        delegate: msgLine
        spacing: 4
        onDraggingChanged: {
            xChatFocus = false
            detectInteraction()
        }
    }
}
