import QtQuick 2.7
import QtQuick.Layouts 1.3

ColumnLayout {
    anchors.fill: parent
    spacing: layoutGridSpacing

    RowLayout {
        anchors.fill: parent
        Layout.preferredHeight: 432
        Layout.minimumHeight: 432
        spacing: layoutGridSpacing

        ColumnLayout {
            Layout.maximumWidth: 300
            Layout.alignment: Qt.AlignTop
            Layout.fillHeight: true
            spacing: layoutGridSpacing

            BalanceDiode {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            BalanceValueDiode {
                Layout.fillWidth: true
                Layout.preferredHeight: 110
            }
        }

        RecentTransactionsDiode {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    ChartDiode {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: 400
        Layout.maximumHeight: 750
    }
}
