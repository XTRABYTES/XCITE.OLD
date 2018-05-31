/**
 * Filename: ChatBox.qml
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
import QtGraphicalEffects 1.0
import "../../Controls" as Controls

ColumnLayout {

    Layout.fillWidth: true
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    Layout.preferredHeight: 93

    Rectangle {
        Layout.fillWidth: true
        height: 1
        color: "#535353"
    }

    RowLayout {
        anchors.fill: parent
        Image {
            id: messageChatButton
            fillMode: Image.PreserveAspectFit
            source: "../../icons/circle-cross.svg"
            width: 25
            sourceSize.width: 29
            sourceSize.height: 29
            Layout.preferredWidth: 40
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
            }
        }
        /*Controls.ButtonIcon {
            id: messageChatButton
            width: parent.height
            imageSource: "../../icons/circle-cross.svg"
            size: 29
            Layout.preferredWidth: 40
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.verticalCenter: parent.verticalCenter
        }*/
        Controls.TextInput {
            id: chatInput
            color: "#A9AAAD"
            font.pixelSize: 18
            text: qsTr("Write something here...")
            //Layout.preferredWidth: 909
            Layout.fillWidth: true
            Layout.preferredHeight: 56
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: messageChatButton.right
            anchors.leftMargin: 15
            anchors.right: messageEmojiButton.left
            anchors.rightMargin: 15
        }

        Image {
            id: messageEmojiButton
            fillMode: Image.PreserveAspectFit
            source: "../../icons/circle-cross.svg"
            width: 25
            sourceSize.width: 29
            sourceSize.height: 29
            Layout.preferredWidth: 40
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
            }
        }

        /*Controls.IconButton {
            id: messageEmojiButton
            height: parent.height
            iconColor: "#9FA0A3"
            hoverColor: "red"
            img.source: "../../icons/circle-cross.svg"
            img.sourceSize.width: 29
            Layout.preferredWidth: 40
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
            }
        }*/
    }
}
