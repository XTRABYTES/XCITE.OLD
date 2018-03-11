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
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.topMargin: diodeTopMargin
                    Layout.minimumWidth: 273
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
                    Layout.topMargin: diodeTopMargin
                    Layout.bottomMargin: diodePadding
                    Layout.rightMargin: diodePadding
                    Layout.alignment: Qt.AlignTop
                    Layout.maximumHeight: 504
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
