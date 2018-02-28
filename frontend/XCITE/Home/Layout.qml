import QtQuick 2.0
import QtQuick.Layouts 1.3

ColumnLayout {
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

            BalanceDiode {
            }

            BalanceValueDiode {
            }
        }

        RecentTransactionsDiode {
            anchors.top: parent.top
            Layout.fillWidth: true
            Layout.preferredHeight: 465
            Layout.preferredWidth: 928.26
            Layout.fillHeight: true
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
