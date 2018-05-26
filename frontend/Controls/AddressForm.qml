/**
 * Filename: AddressForm.qml
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
    height: 540

    property variant item

    signal confirmed(variant newItem)
    signal cancelled

    ModalHeader {
        id: header
        text: item ? qsTr("EDIT: " + (item.name || qsTr("NEW ENTRY"))) : 'EDIT'
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
            text: item ? item.name : ''
        }

        FormLabel {
            Layout.topMargin: 0
            Layout.bottomMargin: 0
            text: qsTr("Address")
        }

        Controls.TextInput {
            id: itemAddress
            font.pixelSize: 24
            Layout.preferredWidth: parent.width
            Layout.topMargin: -20 // TODO: Hack - what's behind the spacing?
            topPadding: 10
            bottomPadding: 10
            text: item ? item.address : ''
            validator: RegExpValidator {
                regExp: /^.+/
            }
        }

        RowLayout {
            spacing: 16

            ButtonModal {
                id: btnConfirm
                labelText: qsTr("UPDATE")
                isPrimary: true
                onButtonClicked: {
                    if (itemName.acceptableInput
                            && itemAddress.acceptableInput) {
                        return confirmed({
                                             name: itemName.text.trim(),
                                             address: itemAddress.text.trim(),
                                             isNew: item.isNew
                                         })
                    }

                    modalAlert({
                                   bodyText: "Name and Address are required"
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
