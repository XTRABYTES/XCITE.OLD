import QtQuick 2.0
import QtQuick.Layouts 1.3

import "../Home" as HomeComponents

RowLayout {
    readonly property color cDiodeBackground: "#3a3e46"

    anchors.fill: parent
    spacing: layoutGridSpacing

    RowLayout {
        anchors.top: parent.top
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

        SendDiode {
            anchors.top: parent.top
            Layout.fillWidth: true
            height: childrenRect.height
        }
    }
}
