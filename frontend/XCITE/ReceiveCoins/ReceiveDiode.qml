import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQrCode.Component 1.0

import "../../Controls" as Controls
import "../../Theme" 1.0

Controls.Diode {
    id: receiveCoinsDiode

    title: qsTr("RECEIVE COINS")
    menuLabelText: qsTr("XBY")

    Connections {
        target: accountCreateForm
        onConfirmed: {
            testnetGetAccountAddress(newItem.name)
            accountCreateForm.close()
        }

        onCancelled: {
            accountCreateForm.close()
        }
    }

    RowLayout {
        anchors.topMargin: diodeHeaderHeight + 15
        anchors.fill: parent

        Form {
            id: form
        }

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
        }
    }

    function selectItem(item) {
        form.address.text = item.address
    }
}
