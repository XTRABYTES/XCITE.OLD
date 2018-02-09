import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../../Controls" as Controls

ColumnLayout {
    readonly property color cDiodeBackground: "#3a3e46"

    Layout.rightMargin: layoutGridSpacing
    Layout.bottomMargin: layoutGridSpacing
    spacing: layoutGridSpacing

    RowLayout {
        spacing: layoutGridSpacing
        ColumnLayout {
            spacing: layoutGridSpacing

            Controls.IconButton {
                text: "Click here to jump to x-Board Nodes"

                onClicked: {
                    selectView('xBoard.nodes');
                }
            }
        }
    }
}
