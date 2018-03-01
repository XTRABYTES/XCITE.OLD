import QtQuick 2.0

import "../Controls" as Controls

Item {
    Column {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 15

        Controls.Header {
            text: qsTr("Receive XBY")
        }
    }
}
