import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import "../../Controls" as Controls
import "../../Theme" 1.0

Controls.Diode {
    title: qsTr("Open Orders")
    menuLabelText: qsTr("XBY")

    Controls.TransactionTable {
        id: transactionTable
    }
}
