import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import AddressBookModel 0.1

import "../../Controls" as Controls

Controls.Diode {
    property int networkFee: 1
    property real balance: wallet.balance
    property real totalAmount: networkFee + (formAmount.text.length > 0 ? parseFloat(
                                                                              formAmount.text) : 0)

    title: qsTr("SEND XBY")
    menuLabelText: qsTr("XBY")

    Connections {
        target: addressEditForm
        onConfirmed: {
            if (xcite.isNetworkActive) {
                testnetValidateAddress(newItem.address)
            }

            if (newItem.isNew) {
                addressBook.add(newItem.name, newItem.address)
            } else {
                addressBook.update(newItem.name, newItem.address)
                selectItem(addressBook.getSelectedItem())
            }

            addressBook.save()
            addressEditForm.close()
        }

        onCancelled: {
            addressEditForm.close()
        }
    }

    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 60
        spacing: 0

        RowLayout {
            spacing: 20
            Layout.fillWidth: true
            Layout.topMargin: 6
            Layout.leftMargin: 22
            Layout.rightMargin: 22
            Layout.bottomMargin: 20

            // Form
            ColumnLayout {
                anchors.top: parent.top
                spacing: 5

                // Amount
                Controls.FormLabel {
                    Layout.topMargin: 10
                    Layout.bottomMargin: 25
                    text: qsTr("Amount")
                }

                Controls.TextInput {
                    id: formAmount
                    Layout.preferredWidth: 516
                    topPadding: 5
                    bottomPadding: 5
                    text: "0"

                    TextXBY {
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 12
                        anchors.bottomMargin: 5
                    }
                }

                Controls.SliderAmount {
                    Layout.preferredWidth: 516
                    Layout.bottomMargin: 10
                    Layout.topMargin: 10
                    totalAmount: balance

                    onMoved: {
                        formAmount.text = Number(value).toFixed(2)
                    }
                }

                // Pay To
                Controls.FormLabel {
                    Layout.topMargin: 20
                    Layout.bottomMargin: 25
                    text: qsTr("Pay to")
                }

                Label {
                    font.pixelSize: 12
                    font.family: "Roboto"
                    bottomPadding: 10
                    text: qsTr("Enter a XTRABYTES address in here.\nEx: BMy2BpwyJc5i7upNm5Vv8HMkwXqBR3kCxS ")
                }

                Controls.TextInput {
                    id: formAddress
                    font.pixelSize: 24
                    Layout.preferredWidth: 516
                    topPadding: 10
                    bottomPadding: 10

                    Connections {
                        onTextEdited: {
                            addressBook.currentIndex = -1
                        }
                    }
                }

                Label {
                    Layout.topMargin: 6
                    Layout.preferredWidth: 516
                    anchors.right: parent.right
                    horizontalAlignment: Text.AlignRight
                    rightPadding: 20
                    font.pixelSize: 12
                    font.family: "Roboto"
                    text: qsTr("Or add a recipient from your address book")

                    Image {
                        fillMode: Image.PreserveAspectFit
                        source: "../../icons/right-arrow2.svg"
                        width: 19
                        height: 13
                        sourceSize.width: 19
                        sourceSize.height: 13
                        anchors.right: parent.right
                    }
                }

                // Total
                Controls.FormLabel {
                    Layout.topMargin: 40
                    Layout.bottomMargin: 25
                    text: qsTr("Total")
                }

                RowLayout {
                    TextXBY {
                        Layout.alignment: Qt.AlignBottom
                        Layout.bottomMargin: 5
                    }

                    Label {
                        text: Number(totalAmount).toFixed(2)
                        font.family: "Roboto"
                        font.weight: Font.Light
                        font.pixelSize: 36
                    }
                }

                Label {
                    topPadding: 10
                    font.pixelSize: 12
                    font.family: "Roboto"
                    text: qsTr("Transaction fee:") + " " + networkFee + " " + qsTr(
                              "XBY")
                }
            }

            // Divider
            Rectangle {
                Layout.fillHeight: true
                width: 1
                color: "#535353"
            }

            // Address Book
            ColumnLayout {
                anchors.top: parent.top
                Layout.fillHeight: true
                Layout.fillWidth: true

                Controls.FormLabel {
                    Layout.topMargin: 10
                    text: qsTr("Address book")
                    Layout.bottomMargin: 25
                }

                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Rectangle {
                        id: addressBookContainer

                        anchors.fill: parent
                        anchors.bottomMargin: 60
                        radius: 4
                        color: "#2A2C31"

                        Controls.AddressBook {
                            id: addressBook

                            model: AddressBookModel {
                            }

                            Connections {
                                Component.onCompleted: {
                                    addressBook.load()
                                    addressBook.currentIndex = 0
                                }
                            }

                            onCurrentItemChanged: {
                                selectItem(addressBook.getSelectedItem())
                            }
                        }
                    }

                    RowLayout {
                        anchors.top: addressBookContainer.bottom
                        anchors.topMargin: 10

                        Controls.AddressButton {
                            Layout.leftMargin: -17
                            currentItem: addressBook.currentItem

                            Connections {
                                onAddressAdded: {
                                    addressBook.add(name, address)
                                }

                                onAddressUpdated: {
                                    addressBook.update(name, address)
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
            }
        }

        // Bottom Divider
        Rectangle {
            Layout.fillWidth: true
            Layout.leftMargin: 22
            Layout.rightMargin: 22
            height: 1
            color: "#535353"
        }

        // Send Payment
        Controls.ButtonModal {
            Layout.fillWidth: true
            Layout.topMargin: 35
            Layout.bottomMargin: 35
            Layout.leftMargin: 172
            Layout.rightMargin: 172
            label.font.family: "Roboto"
            label.font.weight: Font.Medium
            label.font.letterSpacing: 3
            label.text: addressBook.currentIndex < 0 ? qsTr("SEND QUICK PAYMENT") : qsTr(
                                                           "SEND PAYMENT")
            isPrimary: true
            isDanger: addressBook.currentIndex < 0
            buttonHeight: 60

            onButtonClicked: {
                if (!xcite.isNetworkActive) {
                    modalAlert({
                                   bodyText: "Connect to the testnet wallet to send coins",
                                   title: qsTr("TESTNET REQUIRED"),
                                   buttonText: qsTr("OK")
                               })
                    return
                }

                var address, text, amount = Number(formAmount.text)

                if (addressBook.currentIndex < 0) {
                    // Quick send
                    address = formAddress.text.trim()
                    text = qsTr("This address is not in your addressbook.\n\nAre you sure you want to send")
                            + " " + amount + "XBY " + "to " + address + "?"
                } else {
                    var item = addressBook.currentItem.item
                    address = item.address

                    text = qsTr("Are you sure you want to send") + " " + amount
                            + "XBY " + "to" + " " + item.name + " (" + address + ")?"
                }

                confirmationModal({
                                      title: qsTr("PAYMENT CONFIRMATION"),
                                      bodyText: text,
                                      confirmText: qsTr("YES, SEND"),
                                      cancelText: qsTr("NO, CANCEL")
                                  }, function () {
                                      testnetSendFrom('', address, amount)
                                  })
            }
        }
    }

    function selectItem(item) {
        if (item) {
            formAddress.text = item.address
        }
    }
}
