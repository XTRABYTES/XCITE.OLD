import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import SortFilterProxyModel 0.1
import QtQuick.Dialogs 1.1
import "../../Controls" as Controls
import "../../Theme" 1.0

Rectangle {
    id: nodeTransactionsBoardId
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.minimumHeight: 100
    Layout.minimumWidth: 800

    anchors.rightMargin: 15
    anchors.topMargin: 50
    radius: 5
    color: cBoardBackground

    Controls.DiodeHeader {
        id: diodeHeader
        text: qsTr("TRANSACTIONS")
        menuLabelText: qsTr("Complete View")
    }
}
