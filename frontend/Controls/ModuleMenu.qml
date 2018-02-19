import QtQuick 2.0
import QtQuick.Layouts 1.3

Item {
    property var selected

    Connections {
        target: dashboard
        onSelectView: {
            var parts = path.split(".")

            selected = parts[0]
        }
    }

    Layout.fillWidth: true
    Layout.maximumWidth: parent.width
    Layout.minimumHeight: 70
    Layout.preferredHeight: 70
    Layout.maximumHeight: 70

    anchors.left: parent.left
    anchors.top: parent.top
    anchors.bottomMargin: -15

    Rectangle {
        height: 44
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        width: navRowLayout.width
        radius: 5
        color: "#3A3E47"

        RowLayout {
            id: navRowLayout
            anchors.left: parent.left
            anchors.top: parent.top
            height: parent.height
            spacing: 0

            ModuleMenuButton {
                name: "xBoard"
                target: "xBoard.home"
                text: qsTr("X-BOARD")
            }

            ModuleMenuButton {
                name: "xChange"
                target: "xChange.home"
                text: qsTr("X-CHANGE")
            }

            ModuleMenuButton {
                name: "xChat"
                target: "xChat.TBD"
                text: qsTr("X-CHAT")
            }

            ModuleMenuButton {
                name: "xVault"
                target: "xVault.TBD"
                text: qsTr("X-VAULT")
            }

            ModuleMenuButton {
                name: "xMore"
                target: "tools.TBD"
                text: qsTr("MORE")
            }
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.maximumWidth: 300
        Layout.minimumWidth: 200
        Layout.preferredWidth: 200
        anchors.right: parent.right
        height: parent.height
        spacing: 30

        SearchBox {
            id: searchBox
            placeholder: qsTr("Search...")
            anchors.right: parent.right
        }
    }
}
