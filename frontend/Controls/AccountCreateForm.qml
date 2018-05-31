/**
 * Filename: AccountCreateForm.qml
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

import "./" as Controls

ModalPopup {
    id: popup
    width: 540
    height: 300

    signal confirmed(variant newItem)
    signal cancelled

    ModalHeader {
        id: header
        text: qsTr("CREATE ADDRESS")
    }

    Connections {
        target: popup
        onAboutToShow: {
            if (itemName.text.length > 0) {
                itemName.selectAll()
            }
            itemName.forceActiveFocus()
        }
    }

    ColumnLayout {
        anchors.margins: modalPadding
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        FormLabel {
            Layout.topMargin: 0
            Layout.bottomMargin: 0
            text: qsTr("Name")
        }

        Controls.TextInput {
            id: itemName
            font.pixelSize: 24
            Layout.preferredWidth: parent.width
            topPadding: 10
            bottomPadding: 10
            Layout.topMargin: -20 // TODO: Hack - what's behind the spacing?
            anchors.topMargin: 0
            text: '' // item ? item.name : ''
        }

        RowLayout {
            spacing: 16

            ButtonModal {
                id: btnConfirm
                labelText: qsTr("CREATE")
                isPrimary: true
                onButtonClicked: {
                    if (itemName.acceptableInput) {
                        return confirmed({
                                             name: itemName.text.trim()
                                         })
                    }

                    modalAlert({
                                   bodyText: "Name is required"
                               })
                }
            }

            ButtonModal {
                id: btnCancel
                labelText: qsTr("CANCEL")
                isPrimary: false
                onButtonClicked: {
                    cancelled()
                }
            }
        }
    }
}
