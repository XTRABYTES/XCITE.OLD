/**
 * Filename: ReceiveDiode.qml
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

import "../../Controls" as Controls
import "../../Theme" 1.0

Controls.Diode {
    id: receiveCoinsDiode
    title: qsTr("RECEIVE COINS")
    menuLabelText: "XBY"

    Connections {
        target: accountCreateForm
        onConfirmed: {
            network.getAccountAddress(newItem.name)
            accountCreateForm.close()
        }

        onCancelled: {
            accountCreateForm.close()
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

            RowLayout {
                Layout.fillWidth: true
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

            Item {
                // spacer to stop XChat obscuring addressbook buttons
                height: 100
            }
        }
    }

    function selectItem(item) {
        if (item) {
            form.address.text = item.address
        }
    }
}
