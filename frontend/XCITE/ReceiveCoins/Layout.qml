import QtQuick 2.7
import QtQuick.Layouts 1.3

import "../Home" as HomeComponents
import "../../Controls" as Controls

ColumnLayout {
    anchors.fill: parent
    spacing: layoutGridSpacing

    HomeComponents.LayoutBalanceLeft {
        Layout.maximumHeight: 620

        ReceiveDiode {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    Controls.AccountCreateForm {
        id: accountCreateForm
    }
}
