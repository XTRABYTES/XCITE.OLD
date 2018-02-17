import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../../Controls" as Controls
import "../Home" as Home

ColumnLayout {
    readonly property color cDiodeBackground: "#3a3e46"
    id: xBoardHome
    Layout.fillHeight: true
    Layout.fillWidth: true
    anchors.left: parent.left
    anchors.right: parent.right

    //height:parent.height
    spacing: layoutGridSpacing

    RowLayout {
        anchors.top: parent.top
        height: parent.height
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredWidth: 257
        spacing: layoutGridSpacing

        ColumnLayout {
            anchors.top: parent.top
            height: parent.height
            spacing: layoutGridSpacing

            ChannelsDiode {
            }
        }
        ColumnLayout {
            anchors.top: parent.top
            height: parent.height
            spacing: layoutGridSpacing
            ChatDiode {
            }
        }
    }
}
