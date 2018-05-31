/**
 * Filename: Header.qml
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
import "../Controls" as Controls

ColumnLayout {
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    Layout.maximumHeight: 46

    signal tabChanged(string newActiveTab)

    Controls.DiodeHeader {
        text: qsTr("X-CHAT")
        cHeaderText: "#ffffff"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        iconRotation: xChatPopup.state === "minimal" ? 180 : 0
        iconOnly: true

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            width: 48
            hoverEnabled: xChatPopup.visible === false
            cursorShape: Qt.PointingHandCursor

            onClicked: xChatPopup.toggle()

            onHoveredChanged: {
                parent.color = containsMouse ? "#434751" : "#3A3E47"
            }
        }

        RowLayout {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 55
            spacing: 0

            Controls.ButtonIcon {
                imageSource: "../icons/friend-request.svg"
                size: 22
                width: 40
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                image.anchors.verticalCenter: this.verticalCenter
                isSelected: xChatPopup.activeTab === "friends"
                onButtonClicked: tabChanged('friends')
            }

            Controls.ButtonIcon {
                imageSource: "../icons/robot.svg"
                size: 25
                width: 45
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                image.anchors.verticalCenter: this.verticalCenter
                isSelected: xChatPopup.activeTab === "robot"
                onButtonClicked: tabChanged('robot')
            }
        }
    }

    /*
    Item {
        // Contact details
        visible: false
        Layout.fillWidth: true
        Layout.preferredHeight: 44.5

        RowLayout {
            anchors.fill: parent
            anchors.rightMargin: 20
            anchors.leftMargin: 5

            Controls.IconButton {
                anchors.verticalCenter: parent.verticalCenter
                img.source: "../icons/left-arrow.svg"
                img.sourceSize.height: 11
                img.sourceSize.width: 10
                height: parent.height
            }

            Label {
                Layout.fillWidth: true
                text: "John Doe"
                color: "#e6e6e6"
                font.pixelSize: 12
            }

            Controls.IconButton {
                anchors.verticalCenter: parent.verticalCenter
                img.source: "../icons/phone-call.svg"
                img.sourceSize.width: 22
                img.sourceSize.height: 22
                iconColor: "#acb6ce"
                height: parent.height
            }
        }
    }
    */
}
