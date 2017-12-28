import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Rectangle {
    Layout.fillWidth: true
    Layout.maximumWidth: 250
    Layout.preferredWidth: 250
    Layout.minimumWidth: 250
    height: 40
    color: "#3A3E47"

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: xchatpopup.visible == false
        onClicked: {
            if (xchatpopup.visible == false) {
                xchatpopup.visible = true
            }
        }
        onHoveredChanged: {
            if (containsMouse) {
                parent.color = "#434751"
            }
            else {
                parent.color = "#3A3E47"
            }
        }
    }

    Label {
        text: qsTr("X-CHAT")
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        font.family: "Roboto Thin"
        font.pixelSize: 15
        color: "#FFFFFF"
        anchors.leftMargin: 10
    }

    RowLayout {
        anchors.right: parent.right
        anchors.rightMargin: 10
        height: parent.height

        Image {
            smooth: true
            source: "icons/friend-request.svg"
            mipmap: true
            Layout.maximumHeight: Math.min(parent.height, 25)
            Layout.alignment: Qt.AlignRight | Qt.AlignCenter
            verticalAlignment: Qt.AlignCenter
            sourceSize: Qt.size(width, height) //important
        }

        Image {
            smooth: true
            source: "icons/robot.svg"
            mipmap: true
            Layout.maximumHeight: Math.min(parent.height, 25)
            Layout.alignment: Qt.AlignRight | Qt.AlignCenter
            verticalAlignment: Qt.AlignCenter
            sourceSize: Qt.size(width, height) //important
        }
    }
}
