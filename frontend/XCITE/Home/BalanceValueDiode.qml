import QtQuick 2.7
import QtQuick.Layouts 1.3
import "../../Controls" as Controls
import "../../Theme" 1.0

Controls.Diode {
    title: qsTr("FIAT VALUE")

    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: 0
        anchors.leftMargin: 200
        anchors.rightMargin: 0

        Controls.ComboBox {
            id: currencySelection
            Layout.fillWidth: true
            font.pixelSize: 10
            model: ["USD", "EUR", "AUD", "BRL", "CAD", "CHF", "CLP", "CNY", "CZK", "DKK", "GBP", "HKD", "HUF", "IDR", "ILS", "INR", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PKR", "PLN", "RUB", "SEK", "SGD", "THB", "TRY", "TWD", "ZAR"]
            onCurrentTextChanged: {
                onMarketValueChanged(currentText)
            }
        }
    }

    function onMarketValueChanged(currency) {
        marketValueChangedSignal(currency)
    }

    Controls.BalanceItem {
        anchors.fill: parent
        anchors.topMargin: diodeHeaderHeight
        anchors.leftMargin: 20
        anchors.rightMargin: 20

        value.text: (wallet.balance * marketValue.marketValue).toLocaleString(
                        Qt.locale(), "f", 2)
        value.font.pixelSize: 36
        prefix.font.pixelSize: 36
    }
}
