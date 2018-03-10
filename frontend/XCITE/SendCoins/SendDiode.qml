import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import AddressBookModel 0.1

import "../../Controls" as Controls

Controls.Diode {
    property int networkFee: 1
    property real balance: wallet.balance
    property real totalAmount: networkFee + (form.amount.text.length
                                             > 0 ? parseFloat(
                                                       form.amount.text) : 0)

    title: qsTr("SEND COINS")
    menuLabelText: qsTr("XBY")

    Connections {
        target: addressEditForm
        onConfirmed: {
            if (xcite.isNetworkActive) {
                testnetValidateAddress(newItem.address)
            }

            if (newItem.isNew) {
                addressBook.control.add(newItem.name, newItem.address)
            } else {
                addressBook.control.update(newItem.name, newItem.address)
                selectItem(addressBook.control.getSelectedItem())
            }

            addressBook.control.save()
            addressEditForm.close()
        }

        onCancelled: {
            addressEditForm.close()
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: diodeHeaderHeight + 15

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0
            Layout.alignment: Qt.AlignTop

            Form {
                id: form
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumWidth: 273
                Layout.preferredWidth: 500
                Layout.leftMargin: 20
                Layout.topMargin: 20
                Layout.bottomMargin: 20
                Layout.rightMargin: 10
                Layout.alignment: Qt.AlignTop
            }

            // Divider
            Rectangle {
                visible: xcite.width > 1275
                Layout.fillHeight: true
                Layout.bottomMargin: 20
                Layout.leftMargin: 10
                Layout.rightMargin: 5

                width: 1
                color: "#535353"
            }

            AddressBook {
                id: addressBook

                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.minimumWidth: 197
                Layout.topMargin: 20
                Layout.bottomMargin: 20
                Layout.rightMargin: 20
                Layout.leftMargin: 10
                Layout.alignment: Qt.AlignTop
                Layout.maximumHeight: 504
            }
        }

        // Bottom Divider
        Rectangle {
            visible: xcite.height > 746
            Layout.fillWidth: true
            Layout.leftMargin: 22
            Layout.rightMargin: 22
            Layout.bottomMargin: 22
            height: 1
            color: "#535353"
        }

        // Send Payment
        Controls.ButtonModal {
            Layout.fillWidth: true
            Layout.bottomMargin: 35

            Layout.maximumWidth: 300
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            label.font.weight: Font.Medium
            label.font.letterSpacing: 3
            label.text: addressBook.control.currentIndex < 0 ? qsTr("SEND QUICK PAYMENT") : qsTr(
                                                                   "SEND PAYMENT")
            isPrimary: true
            isDanger: addressBook.control.currentIndex < 0
            buttonHeight: 40

            onButtonClicked: {
                if (!xcite.isNetworkActive) {
                    modalAlert({
                                   bodyText: "Connect to the testnet wallet to send coins",
                                   title: qsTr("TESTNET REQUIRED"),
                                   buttonText: qsTr("OK")
                               })
                    return
                }

                var address, text, amount = Number(form.amount.text)

                if (addressBook.control.currentIndex < 0) {
                    // Quick send
                    address = form.address.text.trim()
                    text = qsTr("This address is not in your addressbook.\n\nAre you sure you want to send")
                            + " " + amount + "XBY " + "to " + address + "?"
                } else {
                    var item = addressBook.control.currentItem.item
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
                                      testnetSendToAddress(
                                                  address,
                                                  Number(form.amount.text))
                                  })
            }
        }
    }

    function selectItem(item) {
        if (item) {
            form.address.text = item.address
        }
    }
}
