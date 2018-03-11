import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQrCode.Component 1.0

import "../../Controls" as Controls
import "../../Theme" 1.0

ColumnLayout {
    Controls.FormLabel {
        text: qsTr("Address Book")
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
            model: wallet.accounts

            Component.onCompleted: {
                addressBook.add("", "BMy2BpwyJc5i7upNm5Vv8HMkwXqBR3kCxS")
                addressBook.add("Main", "Jc5i7upNmBMy2Bpwy5Vv8HMkwXqBR3kCxS")
                addressBook.add("Secondary",
                                "upNm5Vv8HMkBMy2BpwyJc5i7wXqBR3kCxS")
                addressBook.currentIndex = 0
            }

            Connections {
                target: wallet.accounts
                onSetCurrentIndex: {
                    addressBook.currentIndex = idx
                }
            }

            Connections {
                target: addressBook.model
                onDataChanged: {
                    selectItem(addressBook.getSelectedItem())
                }
            }

            onCurrentItemChanged: {
                var item = addressBook.getSelectedItem()

                if (item.address === '') {
                    testnetGetAccountAddress(item.name)
                    item = addressBook.getSelectedItem()
                }

                selectItem(item)
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
            btnEditEnabled: false
            type: "ADDRESS"
            currentItem: addressBook.currentItem

            Connections {
                onAddressAdded: {

                }

                onAddressUpdated: {
                    addressBook.update(name, address)
                    selectItem(addressBook.getSelectedItem())
                }

                onAddressRemoved: {
                    addressBook.removeSelected()
                }

                onBtnAddClicked: {
                    if (!xcite.isNetworkActive) {
                        modalAlert({
                                       bodyText: "Connect to the testnet wallet to create new addresses",
                                       title: qsTr("TESTNET REQUIRED"),
                                       buttonText: qsTr("OK")
                                   })
                        return
                    }

                    accountCreateForm.open()
                }
            }
        }
    }
}
