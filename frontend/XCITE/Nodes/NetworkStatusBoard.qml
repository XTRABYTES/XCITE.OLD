import QtQuick 2.7
import QtQuick.Layouts 1.3
import "../../Controls" as Controls
//Transactions status board used on the Nodes page (bottom)

Rectangle {
    id: networkStatusBoardId
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.minimumHeight: 200
    Layout.preferredHeight: 400
    color: "#3A3E47"
    radius: 5

    Text {
        id: headerTextId
        y: 16
        color: "#e2e2e2"
        text: qsTr("NETWORK STATUS")
        anchors.left: parent.left
        anchors.leftMargin: 21
        font.family: "Roboto Condensed"
        font.pixelSize: 15
    }

    Rectangle {
        x: 0
        y: 45
        width: parent.width
        height: 1
        color: "#9fa0a3"
        opacity: 0.2
    }
}
