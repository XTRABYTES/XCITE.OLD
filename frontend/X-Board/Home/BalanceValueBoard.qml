import QtQuick 2.0
import "../../Controls" as Controls

// Balance board used on the Home/wallet page (left hand side)

Rectangle {
    width: 376
    height: 135
    color: cBoardBackground
    radius: 5

    Controls.BoardHeader {
        id: boardHeader
        text: qsTr("BALANCE VALUE")
        menuLabelText: qsTr("USD")
    }

    Controls.BalanceItem {
        id: unconfirmedBalance
        text: ""
        value: "37,621"
        valuePrefix: qsTr("$")
        anchors.top: boardHeader.bottom
    }
}
