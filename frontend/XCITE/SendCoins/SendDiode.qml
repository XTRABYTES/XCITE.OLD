/**
 * Filename: SendDiode.qml
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
import "../../Theme" 1.0

Controls.Diode {
    property int networkFee: 1
    property real balance: wallet.balance
    property real totalAmount: networkFee + (form.amount.text.length
                                             > 0 ? parseFloat(
                                                       form.amount.text) : 0)

    title: qsTr("SEND COINS")
    menuLabelText: "XBY"

    Connections {
        target: addressEditForm
        onConfirmed: {
            if (xcite.isNetworkActive) {
                network.validateAddress(newItem.address)
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

    Controls.DiodeVerticalScrollBar {
        id: verticalScrollBar
    }

    ScrollView {
        id: scrollView

        anchors.fill: parent

        anchors.topMargin: diodeHeaderHeight
        ScrollBar.vertical: verticalScrollBar
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        clip: true

        ColumnLayout {
            width: scrollView.width
            height: scrollView.height

            RowLayout {
                Layout.fillHeight: true

                Layout.alignment: Qt.AlignTop
                spacing: 10

                Form {
                    id: form
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.minimumWidth: 273
                    Layout.preferredWidth: 500

                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: diodeTopMargin
                    Layout.leftMargin: diodePadding
                    Layout.rightMargin: 10
                }

                // Divider
                Rectangle {
                    visible: parent.width > 800
                    height: parent.height - 40
                    Layout.alignment: Qt.AlignVCenter
                    Layout.leftMargin: 8
                    Layout.rightMargin: 12

                    width: 1
                    color: "#535353"
                }

                AddressBook {
                    id: addressBook

                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.minimumWidth: 197
                    Layout.preferredWidth: 300

                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: diodeTopMargin
                    Layout.bottomMargin: diodePadding
                    Layout.rightMargin: diodePadding
                }
            }

            ColumnLayout {
                Layout.fillWidth: true

                // Bottom Divider
                Rectangle {
                    Layout.fillWidth: true
                    Layout.leftMargin: 22
                    Layout.rightMargin: 22
                    Layout.topMargin: 20
                    Layout.bottomMargin: 32
                    height: 1
                    color: "#535353"
                }

                // Send Payment
                Controls.ButtonModal {
                    Layout.fillWidth: true
                    Layout.bottomMargin: 40

                    Layout.maximumWidth: 300
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                    label.font.weight: Font.Medium
                    label.font.letterSpacing: 3
                    label.text: addressBook.control.currentIndex
                                < 0 ? qsTr("SEND QUICK PAYMENT") : qsTr(
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

                            text = qsTr("Are you sure you want to send") + " " + amount + "XBY "
                                    + "to" + " " + item.name + " (" + address + ")?"
                        }

                        confirmationModal({
                                              title: qsTr("PAYMENT CONFIRMATION"),
                                              bodyText: text,
                                              confirmText: qsTr("YES, SEND"),
                                              cancelText: qsTr("NO, CANCEL")
                                          }, function () {
                                              network.sendToAddress(
                                                          address, Number(
                                                              form.amount.text))
                                          })
                    }
                }
            }
        }
    }

    function selectItem(item) {
        if (item) {
            form.address.text = item.address
        }
    }
}
