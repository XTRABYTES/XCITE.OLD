import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import AddressBookModel 0.1

import "../../Controls" as Controls

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

        Controls.AddressBook {
            id: addressBook

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
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.topMargin: 4
        Layout.maximumHeight: 29
        Layout.minimumHeight: 29
        Layout.alignment: Qt.AlignLeft

        Controls.AddressButton {
            currentItem: addressBook.currentItem

            Connections {
                onAddressAdded: {
                    addressBook.add(name, address)
                }

                onAddressUpdated: {
                    selectItem(addressBook.getSelectedItem())
                }

                onAddressRemoved: {
                    addressBook.removeSelected()
                }

                onBtnAddClicked: {
                    var newItem = {
                        name: '',
                        address: '',
                        isNew: true
                    }

                    addressEditForm.item = newItem
                    addressEditForm.open()
                }

                onBtnEditClicked: {
                    addressEditForm.item = addressBook.getSelectedItem()
                    addressEditForm.open()
                }
            }
        }
    }
}
