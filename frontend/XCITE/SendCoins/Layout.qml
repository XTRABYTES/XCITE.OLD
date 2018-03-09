import QtQuick 2.7
import QtQuick.Layouts 1.3

import "../Home" as HomeComponents
import "../../Controls" as Controls

Item {
    anchors.fill: parent

    ColumnLayout {
        anchors.fill: parent
        spacing: layoutGridSpacing

        HomeComponents.LayoutBalanceLeft {
            SendDiode {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }

        SendDiode {
            anchors.top: parent.top
            Layout.fillWidth: true
            height: childrenRect.height
        }
    }

    Controls.AddressForm {
        id: addressEditForm
    }
}
