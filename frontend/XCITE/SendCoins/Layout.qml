import QtQuick 2.7
import QtQuick.Layouts 1.3

import "../Home" as HomeComponents
import "../../Controls" as Controls

ColumnLayout {
    anchors.fill: parent
    spacing: layoutGridSpacing

    HomeComponents.LayoutBalanceLeft {
        Layout.preferredHeight: 600
        Layout.maximumHeight: 750

        SendDiode {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    Controls.AddressForm {
        id: addressEditForm
    }
}
