import QtQuick 2.0
import QtQuick.Layouts 1.3

import "../Home" as HomeComponents

RowLayout {
    readonly property color cDiodeBackground: "#3a3e46"

    anchors.fill: parent

    spacing: layoutGridSpacing

    FilterTransactionsDiode {
        z: 1
        anchors.top: parent.top
        Layout.preferredWidth: 257
        Layout.preferredHeight: 561
    }

    HomeComponents.RecentTransactionsDiode {
        z: 0
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
}
