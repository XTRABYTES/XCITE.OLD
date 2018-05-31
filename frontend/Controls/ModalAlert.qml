/**
 * Filename: ModalAlert.qml
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

ModalPopup {
    property alias buttonText: btnClose.labelText

    signal cancelled

    ModalHeader {
        id: header
        text: title || qsTr("ERROR!")
    }

    ColumnLayout {
        anchors.margins: modalPadding
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Text {
            id: prompt
            text: bodyText
            Layout.fillWidth: true
            color: "#FFF7F7"
            font.pixelSize: 18
            wrapMode: Text.Wrap
        }

        RowLayout {
            spacing: 16

            ButtonModal {
                id: btnClose
                isPrimary: true
                onButtonClicked: {
                    cancelled()
                }
            }
        }
    }
}
