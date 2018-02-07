import QtQuick 2.0
import QtQuick.Layouts 1.3

ColumnLayout {
    readonly property color cBoardBackground: "#3a3e46"

    id: xBoardNodes
    anchors.left: parent.left
    anchors.right: parent.right
    Layout.rightMargin: layoutGridSpacing
    spacing: layoutGridSpacing
    visible:false

    RowLayout {
        spacing: layoutGridSpacing

        BalanceBoard {
        }

        TransactionsBoard {
        }
    }

    RowLayout{
        NetworkStatusBoard{}
    }
}
