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
        value: "37,621"
        valuePrefix: qsTr("$")
        anchors.top: diodeHeader.bottom
        valueWidth: 340
    }
}
