/**
 * Filename: AddressBook.qml
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
import AddressBookModel 0.1

import "../../Controls" as Controls
import "../../AddressBook" as AddressBook

ColumnLayout {
    property alias control: addressBook

    Controls.FormLabel {
        text: qsTr("Address book")
        Layout.bottomMargin: 25
    }

    Rectangle {
        id: addressBookContainer

        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.minimumHeight: 250

        radius: 4
        color: "#2A2C31"

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            Controls.AddressBook {
                id: addressBook
                Layout.fillHeight: true

                model: AddressBookModel {
                }

                Component.onCompleted: {
                    addressBook.load()
                    addressBook.currentIndex = 0
                }

                onCurrentItemChanged: {
                    if (currentIndex >= 0) {
                        selectItem(addressBook.getSelectedItem())
                    }
                }
            }

            AddressBook.ButtonBar {
                RowLayout {
                    anchors.fill: parent
                    spacing: 0

                    AddressBook.Button {
                        Layout.fillWidth: true
                        Layout.maximumWidth: parent.width / 3
                        text: "Add Recipient"

                        icon.source: "../../icons/circle-cross.svg"
                        icon.sourceSize.width: 17
                        icon.sourceSize.height: 17

                        onButtonClicked: {
                            var newItem = {
                                name: '',
                                address: '',
                                isNew: true
                            }

                            addressEditForm.item = newItem
                            addressEditForm.open()
                        }
                    }

                    AddressBook.ButtonDivider {
                    }

                    AddressBook.Button {
                        Layout.fillWidth: true
                        Layout.maximumWidth: parent.width / 3
                        text: "Edit Recipient"

                        enabled: addressBook.currentItem ? true : false

                        icon.source: "../../icons/pencil.svg"
                        icon.sourceSize.width: 15
                        icon.sourceSize.height: 15

                        onButtonClicked: {
                            if (!addressBook.currentItem) {
                                return
                            }

                            addressEditForm.item = addressBook.getSelectedItem()
                            addressEditForm.open()
                        }
                    }

                    AddressBook.ButtonDivider {
                    }

                    AddressBook.Button {
                        Layout.fillWidth: true
                        Layout.maximumWidth: parent.width / 3
                        text: "Remove Recipient"

                        enabled: addressBook.currentItem ? true : false

                        icon.source: "../../icons/trash.svg"
                        icon.sourceSize.width: 13
                        icon.sourceSize.height: 17

                        onButtonClicked: {
                            if (!addressBook.currentItem) {
                                return
                            }

                            var item = addressBook.currentItem.item

                            var text = qsTr(
                                        "Are you sure you want to remove this address?")

                            confirmationModal({
                                                  title: qsTr("REMOVE ADDRESS CONFIRMATION"),
                                                  bodyText: text,
                                                  confirmText: qsTr("CONFIRM"),
                                                  cancelText: qsTr("CANCEL")
                                              }, function (modal) {
                                                  if (addressBook.currentItem !== null) {
                                                      addressBook.removeSelected()
                                                      addressBook.save()
                                                  }
                                              })
                        }
                    }
                }
            }
        }
    }
}
