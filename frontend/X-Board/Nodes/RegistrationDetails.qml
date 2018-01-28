import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../../Controls" as Controls

Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.minimumHeight: 100
    color: "#3A3E47"
    radius: 5

    Text {
        text: qsTr("Details Placeholder")
        anchors.centerIn: parent
        font.family: "Roboto"
        font.weight: Font.Bold
        font.pixelSize: 12
        color: "#62DED6"
    }
}
