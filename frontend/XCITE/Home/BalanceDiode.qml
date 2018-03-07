import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import "../../Controls" as Controls
import "../../Theme" 1.0

Rectangle {
    width: 376
    height: 313
    color: cDiodeBackground
    radius: 5
    Layout.minimumHeight: 313

    Controls.DiodeHeader {
        text: qsTr("BALANCE")
        menuLabelText: qsTr("XBY")
    }

    Controls.BalanceItem {
        id: balance
        text: qsTr("Balance")
        valuePrefix: qsTr("XBY")
        value: wallet.balance.toLocaleString(Qt.locale(), 'f',
                                             8).replace(/\.?0+$/, '')
        anchors.top: parent.top
        anchors.topMargin: 63
        valueWidth: 225
    }

    Controls.BalanceItem {
        id: unconfirmedBalance
        text: qsTr("Unconfirmed")
        valuePrefix: qsTr("XBY")
        value: wallet.unconfirmed.toLocaleString(Qt.locale(), 'f',
                                                 8).replace(/\.?0+$/, '')
        anchors.top: balance.bottom
        valueWidth: 180
    }

    Controls.BalanceItem {
        id: totalBalance
        text: qsTr("Total")
        value: (wallet.balance + wallet.unconfirmed).toLocaleString(
                   Qt.locale(), 'f', 8).replace(/\.?0+$/, '')
        valueColor: Theme.primaryHighlight
        valuePrefix: qsTr("XBY")
        valueFont.family: "Roboto"
        valueFont.weight: Font.Normal
        anchors.top: unconfirmedBalance.bottom
        anchors.topMargin: 30
        valueWidth: 250
    }
}
