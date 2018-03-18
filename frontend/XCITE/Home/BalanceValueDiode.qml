import QtQuick 2.7
import "../../Controls" as Controls
import "../../Theme" 1.0

Controls.Diode {
    title: qsTr("FIAT VALUE")
    menuLabelText: "USD"

    Controls.BalanceItem {
        anchors.fill: parent
        anchors.topMargin: diodeHeaderHeight
        anchors.leftMargin: 20
        anchors.rightMargin: 20

        value.text: (wallet.balance * marketValue.marketValue).toLocaleString(
                        Qt.locale(), "f", 2)
        value.font.pixelSize: 36
        prefix.font.pixelSize: 36
        prefix.text: "$"
    }
}
