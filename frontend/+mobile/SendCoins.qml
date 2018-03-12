import QtQuick 2.7

import "../Controls" as Controls

Item {
    Column {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 15

        Controls.Header {
            text: qsTr("Send XBY")
        }
    }
}
