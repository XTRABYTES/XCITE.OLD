import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Rectangle {
    id: root
    Layout.fillWidth: true
    anchors.top: parent.top
    height: 13
    color: "#505A67"
    signal buttonClicked

    Image {
        smooth: true
        source: "icons/dock.png"
        anchors.centerIn: parent
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            root.buttonClicked()
        }
        hoverEnabled: true
        onHoveredChanged: {
            if (containsMouse) {
                root.color = "#5a6470"
            }
            else {
                root.color = "#505A67"
            }
        }
    }

}
