import QtQuick 2.7
import QtQuick.Layouts 1.3

import "../Home" as HomeComponents
import "../../Controls" as Controls

ColumnLayout {
    anchors.fill: parent
    spacing: layoutGridSpacing

    RowLayout {
        anchors.fill: parent
        spacing: layoutGridSpacing

        ColumnLayout {
            anchors.top: parent.top
            Layout.preferredWidth: 376

            spacing: layoutGridSpacing

            HomeComponents.BalanceDiode {
            }

            HomeComponents.BalanceValueDiode {
            }
        }

        ReceiveCoinsDiode {
            anchors.top: parent.top
            Layout.fillWidth: true
            height: childrenRect.height
        }
    }

    Controls.AccountCreateForm {
        id: accountCreateForm
    }
}
