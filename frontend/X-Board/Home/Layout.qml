import QtQuick 2.0
import QtQuick.Layouts 1.3

ColumnLayout {
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

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 200
            Layout.preferredHeight: 400
            color: "#3A3E47"
            radius: 5
        }
    }

    RowLayout {
        Layout.fillHeight: true
        anchors.left: parent.left
        spacing: layoutGridSpacing

        Rectangle {
            id: xtrabytesChart
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 200
            Layout.preferredHeight: 400
            color: "#3A3E47"
            radius: 5
        }
    }
}
