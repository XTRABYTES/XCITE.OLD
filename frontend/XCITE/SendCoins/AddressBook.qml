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

                    AddressBook.ButtonAdd {
                        Layout.maximumWidth: parent.width / 3
                        text: "Add Recipient"

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

                    AddressBook.ButtonEdit {
                        Layout.maximumWidth: parent.width / 3
                        text: "Edit Recipient"

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

                    AddressBook.ButtonRemove {
                        Layout.maximumWidth: parent.width / 3
                        text: "Remove Recipient"

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
