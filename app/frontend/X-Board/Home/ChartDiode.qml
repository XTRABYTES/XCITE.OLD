import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../../Controls" as Controls

Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.minimumHeight: 200
    Layout.preferredHeight: 400

    color: "#3A3E47"
    radius: 5

    Controls.DiodeHeader {
        id: header
        text: qsTr("XTRABYTES CHART")
    }

    Image {
        id: placeholderImage
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 2
        horizontalAlignment: Image.AlignLeft
        source: "../../backgrounds/wallet-graph-placeholder.png"
        fillMode: Image.PreserveAspectFit
        opacity: 0.4

        Rectangle {
            anchors.left: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 1
            color: "#484A4D"
        }
    }

    Text {
        anchors.centerIn: placeholderImage
        text: qsTr("PLACEHOLDER")
        color: "#ccc"
        font.family: "Roboto"
        font.weight: Font.Bold
        font.pixelSize: 20
        opacity: 1
    }
}
