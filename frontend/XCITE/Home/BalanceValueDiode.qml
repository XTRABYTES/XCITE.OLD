/**
 * Filename: BalanceValueDiode.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */
import Qt.labs.settings 1.0
import QtQuick 2.7
import QtQuick.Layouts 1.3
import "../../Controls" as Controls
import "../../Theme" 1.0

Controls.Diode {
    title: qsTr("DEMO FIAT VALUE")

    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: 200
        anchors.rightMargin: 0
        anchors.topMargin: 0

        Controls.ComboBox {
            id: currencySelection
            Layout.fillWidth: true
            defaultBackgroundColor: "transparent"

            onHoveredChanged: {
                background.radius = 1
                if (hovered)
                    background.color = "#2A2C31"
            }

            model: ["USD", "EUR", "AUD", "BRL", "CAD", "CHF", "CLP", "CNY", "CZK", "DKK", "GBP", "HKD", "HUF", "IDR", "ILS", "INR", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PKR", "PLN", "RUB", "SEK", "SGD", "THB", "TRY", "TWD", "ZAR"]

            onActivated: onMarketValueChanged(currentText)
            Component.onCompleted: currentIndex = currencySelection.find(
                                       settings.defaultCurrency)
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
