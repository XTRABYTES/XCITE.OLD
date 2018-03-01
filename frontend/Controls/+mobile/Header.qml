import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Item {
    property alias text: label.text
    property bool showBack: true

    anchors.left: parent.left
    anchors.right: parent.right
    height: 35

    Label {
        id: label
        font.family: "Roboto"
        font.pixelSize: 16
        anchors.fill: parent
        color: "white"
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
    }

    Image {
        visible: showBack
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        source: "/icons/mobile-back.svg"
        sourceSize.width: 19
        sourceSize.height: 13

        MouseArea {
            anchors.fill: parent
            onClicked: {
                mainRoot.pop()
            }
        }
    }

    Image {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        source: "/icons/mobile-menu.svg"
        sourceSize.width: 15
        sourceSize.height: 11

        MouseArea {
            anchors.fill: parent
            onClicked: {

            }
        }
    }
}
