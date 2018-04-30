import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import "../Controls" as Controls

Item {
    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 100

        Controls.Header {
            text: qsTr("Settings")
        }
    }
}
