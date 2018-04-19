import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.1

import "../../Controls" as Controls
import "../../Theme" 1.0

Controls.Diode {
    title: qsTr("DEMO RECENT TRANSACTIONS")
    menuLabelText: qsTr("Complete View")

    TransactionTable {
        id: transactionTable
    }

    // TODO: This will be replaced by a bespoke dialog
    MessageDialog {
        id: popup
        title: "Test"
        text: "Item clicked"
    }
}
