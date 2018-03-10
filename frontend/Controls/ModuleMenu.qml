import QtQuick 2.7
import QtQuick.Layouts 1.3
import "../Theme" 1.0

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
    height: moduleMenuHeight

    z: 50

    RowLayout {
        anchors.fill: parent

        RowLayout {
            spacing: 2

            ModuleMenuButton {
                name: "xCite"
                target: "xCite.home"
                text: qsTr("XCITE")
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
                visible: xcite.width > 1065
                target: "tools.TBD"
                text: qsTr("MORE")
            }
        }

        SearchBox {
            placeholder: qsTr("Search...")
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            Layout.fillWidth: true
            Layout.maximumWidth: 340
        }
    }
}
