import QtQuick 2.0
import QtQuick.Layouts 1.3

ColumnLayout {
    readonly property color cDiodeBackground: "#3a3e46"

    id: xCiteHome

    Layout.fillHeight: true
    Layout.fillWidth: true
    spacing: layoutGridSpacing

    RowLayout {
        spacing: layoutGridSpacing
        ColumnLayout {
            spacing: layoutGridSpacing

            BalanceDiode {
            }

            BalanceValueDiode {
            }
        }

        RecentTransactionsDiode {
            Layout.preferredHeight: 465
            Layout.preferredWidth: 928.26
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    RowLayout {
        Layout.fillHeight: true
        anchors.left: parent.left
        spacing: layoutGridSpacing

        ChartDiode {
        }
    }
}
