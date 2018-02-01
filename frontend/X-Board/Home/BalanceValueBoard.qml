import QtQuick 2.0
import "../../Controls" as Controls

// Balance board used on the Home/wallet page (left hand side)

Rectangle {
    width: 376
    height: 135
    color: "#3a3e46"
    radius: 5

    Controls.BoardHeader {
        id: boardHeader
        text: qsTr("BALANCE VALUE")
    }

    Controls.BalanceItem {
        id: unconfirmedBalance
        text: ""
        value: "5,446"
        valuePrefix: qsTr("$")
        anchors.top: boardHeader.bottom
    }
}
