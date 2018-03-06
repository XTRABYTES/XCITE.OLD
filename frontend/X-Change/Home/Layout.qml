import QtQuick 2.7
import QtQuick.Layouts 1.3
import "../../Controls" as Controls

ColumnLayout {
    readonly property color cDiodeBackground: "#3a3e46"

    anchors.left: parent.left
    anchors.right: parent.right
    Layout.rightMargin: layoutGridSpacing
    Layout.bottomMargin: layoutGridSpacing
    spacing: layoutGridSpacing

    RowLayout {
        spacing: layoutGridSpacing
        ColumnLayout {
            spacing: layoutGridSpacing

            Controls.IconButton {
                text: "Click here to jump to XCITE Nodes"

                onClicked: {
                    selectView('xCite.nodes');
                }
            }
        }
    }
}
