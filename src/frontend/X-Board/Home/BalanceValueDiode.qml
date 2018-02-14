import QtQuick 2.0
import "../../Controls" as Controls

Rectangle {
    width: 376
    height: 135
    color: cDiodeBackground
    radius: 5

    Controls.DiodeHeader {
        id: diodeHeader
        text: qsTr("BALANCE VALUE")
        menuLabelText: qsTr("USD")
    }

    Controls.BalanceItem {
        id: unconfirmedBalance
        text: ""
        value: (wallet.balance * 0.2).toLocaleString(Qt.locale(), "f", 2)
        valuePrefix: qsTr("$")
        anchors.top: diodeHeader.bottom
    }
}
