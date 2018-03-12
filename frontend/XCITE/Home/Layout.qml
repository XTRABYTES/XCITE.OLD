import QtQuick 2.7
import QtQuick.Layouts 1.3

ColumnLayout {
    anchors.fill: parent
    spacing: layoutGridSpacing

    LayoutBalanceLeft {
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
