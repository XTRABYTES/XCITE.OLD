import QtQuick 2.0
import QtQuick.Layouts 1.3

ColumnLayout {
    readonly property color cBoardBackground: "#3a3e46"

    id: xBoardHome
    anchors.left: parent.left
    anchors.right: parent.right
    Layout.rightMargin: layoutGridSpacing
    spacing: layoutGridSpacing

    RowLayout {
        spacing: layoutGridSpacing
        ColumnLayout {
            spacing: layoutGridSpacing

            BalanceBoard {
            }

            BalanceValueBoard {
            }
        }

        RecentTransactionsBoard {
        }
    }

    RowLayout {
        Layout.fillHeight: true
        anchors.left: parent.left
        spacing: layoutGridSpacing

        ChartDiode {
        }
    }
}
