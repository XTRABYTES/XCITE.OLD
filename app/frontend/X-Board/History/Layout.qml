import QtQuick 2.0
import QtQuick.Layouts 1.3

import '../Home' as HomeComponents

RowLayout {
    readonly property color cDiodeBackground: "#3a3e46"

    anchors.fill: parent

    spacing: layoutGridSpacing

    FilterTransactionsDiode {
        anchors.top: parent.top
        Layout.preferredWidth: 257
        Layout.preferredHeight: 561
    }

    HomeComponents.RecentTransactionsDiode {
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
}
