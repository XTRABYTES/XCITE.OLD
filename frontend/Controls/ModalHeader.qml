/**
 * Filename: ModalHeader.qml
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
import QtQuick.Layouts 1.3

Item {
    property alias text: title.text

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 48.61

    RowLayout {
        id: header
        anchors.fill: parent
        anchors.leftMargin: modalPadding
        anchors.rightMargin: modalPadding

        Text {
            id: title
            Layout.fillWidth: true
            verticalAlignment: Text.AlignVCenter
            color: "#E2E2E2"
            font.pixelSize: 15
        }

        IconButton {
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height
            Layout.preferredWidth: 20

            iconColor: "#fff"
            img.source: "../icons/cross.svg"
            img.sourceSize.width: 10

            onClicked: {
                cancelled()
            }
        }
    }

    Rectangle {
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#535353"
        height: 1
    }
}
