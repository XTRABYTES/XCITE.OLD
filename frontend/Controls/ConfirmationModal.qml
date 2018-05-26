/**
 * Filename: ConfirmationModal.qml
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
    property alias confirmText: btnConfirm.labelText
    property alias cancelText: btnCancel.labelText

    signal confirmed(string val)
    signal cancelled

    ModalHeader {
        id: header
        text: title
    }

    ColumnLayout {
        anchors.margins: modalPadding
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        ColumnLayout {
            Text {
                id: prompt
                text: bodyText
                Layout.fillWidth: true
                color: "#FFF7F7"
                font.pixelSize: 18
                wrapMode: Text.WordWrap
            }

            TextField {
                id: inputField
                visible: showInput
                color: "white"
                font.weight: Font.Light
                font.pixelSize: 36
                leftPadding: 18
                topPadding: 0
                bottomPadding: 0
                verticalAlignment: Text.AlignVCenter
                width: 350
                Layout.minimumWidth: 350
                Layout.maximumWidth: 350
                text: ""
                background: Rectangle {
                    color: "#2A2C31"
                    radius: 5
                    width: parent.width
                }
            }
        }

        RowLayout {
            spacing: 16

            ButtonModal {
                id: btnConfirm
                isPrimary: true
                onButtonClicked: {
                    confirmed(inputField.text)
                }
            }

            ButtonModal {
                id: btnCancel
                isPrimary: false
                onButtonClicked: {
                    cancelled()
                }
            }
        }
    }
}
