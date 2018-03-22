import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import SortFilterProxyModel 0.1
import QtQuick.Dialogs 1.1

import "../../Controls" as Controls
import "../../Theme" 1.0

Controls.Diode {
    property real sellTotal: parseFloat(sellPrice.text) * parseFloat(
                                 sellAmount.text)
    property real buyTotal: parseFloat(buyPrice.text) * parseFloat(
                                buyAmount.text)
    property int vis: 0
    property alias amount: sellAmount

    id: cont
    width: 652
    height: 459
    Layout.fillWidth: true
    radius: 5
    color: "#3A3E47"
    Controls.DiodeHeader {
        text: "BUY XBY"
    }

    ColumnLayout {
        //limit/market order
        anchors.top: parent.top
        anchors.topMargin: 65
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        RowLayout {
            id: lay1

            Controls.ButtonModal {

                Layout.minimumWidth: 175
                Layout.preferredWidth: 400

                buttonHeight: 50
                labelText: "LIMIT ORDER"
                colorTracker: 2
                onButtonClicked: {
                    buyPrice.text = "0"
                    sellPrice.text = "0"
                    vis = 1
                }
                Rectangle {
                    anchors.top: parent.bottom
                    height: 2
                    width: parent.width
                    color: "#13D6D0"
                    visible: vis == 1
                    anchors.topMargin: 10
                }

                Label {
                    anchors.top: parent.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    text: "Available: 0 XFUEL"
                    color: "#8592A5"
                    topPadding: 15
                    font.weight: Font.Medium
                }
                Label {
                    anchors.top: parent.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    text: "Deposit"
                    color: "#1AF1EB"
                    topPadding: 15
                    font.weight: Font.Medium
                }
            }
            Controls.ButtonModal {

                Layout.minimumWidth: 175
                Layout.preferredWidth: 400

                buttonHeight: 50
                labelText: "MARKET ORDER"
                colorTracker: 2
                onButtonClicked: {
                    buyPrice.text = "Market Price"
                    sellPrice.text = "Market Price"
                    vis = 2
                }
                Rectangle {
                    anchors.top: parent.bottom
                    anchors.topMargin: 10
                    height: 2
                    width: parent.width
                    color: "#13D6D0"
                    visible: vis == 2
                }
                Label {
                    anchors.top: parent.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    text: "Available: " + wallet.balance.toLocaleString(
                              Qt.locale(), 'f', 8).replace(/\.?0+$/,
                                                           '') + " XBY"
                    color: "#8592A5"
                    topPadding: 15
                    font.weight: Font.Medium
                }
                Label {
                    anchors.top: parent.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    text: "Deposit"
                    color: "#1AF1EB"
                    topPadding: 15
                    font.weight: Font.Medium
                }
            }
        }
        //price input
        RowLayout {
            id: lay2

            Controls.TextInput {
                id: buyPrice
                validator: DoubleValidator {
                    bottom: 0
                }
                Layout.fillWidth: true
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                Layout.topMargin: 60
                Layout.preferredWidth: 175
                text: "0.00"
                Label {

                    anchors.bottom: parent.top
                    text: "Price"
                    color: "#FFFFFF"
                    bottomPadding: 8
                    font.weight: Font.Medium
                }
            }
            Controls.TextInput {
                id: sellPrice
                validator: DoubleValidator {
                    bottom: 0
                }
                text: "0.00"
                Layout.fillWidth: true
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                Layout.topMargin: 60
                Layout.preferredWidth: 175

                Label {

                    anchors.bottom: parent.top
                    text: "Price"
                    color: "#FFFFFF"
                    bottomPadding: 8
                    font.weight: Font.Medium
                }
            }
        }
        //amount input
        RowLayout {
            id: lay3

            Controls.TextInput {
                id: buyAmount
                validator: DoubleValidator {
                    bottom: 0
                }
                text: "0.00"
                Layout.fillWidth: true
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                Layout.topMargin: 30
                Layout.preferredWidth: 175

                Label {

                    anchors.bottom: parent.top
                    text: "Amount"
                    color: "#FFFFFF"
                    bottomPadding: 8
                    font.weight: Font.Light
                }
            }
            Controls.TextInput {
                id: sellAmount
                validator: DoubleValidator {
                    bottom: 0
                }
                text: "0.00"
                Layout.fillWidth: true
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                Layout.topMargin: 30
                Layout.preferredWidth: 175
                Label {

                    anchors.bottom: parent.top
                    text: "Amount"
                    color: "#FFFFFF"
                    bottomPadding: 8
                    font.weight: Font.Light
                }
            }
        }
        //percentage slider
        RowLayout {
            id: lay4
            Controls.SliderAmount {
                Layout.fillWidth: true

                Layout.leftMargin: 5
                Layout.rightMargin: 5
                Layout.topMargin: 7

                onMoved: {


                    // formAmount.text = Number(value).toFixed(2)
                }
            }
            Controls.SliderAmount {
                Layout.fillWidth: true

                Layout.leftMargin: 5
                Layout.rightMargin: 5
                Layout.topMargin: 7
                totalAmount: wallet.balance
                onMoved: {
                    sellAmount.text = Number(value).toFixed(2)
                }
            }
        }
        //buy/sell buttons
        RowLayout {
            id: lay5

            Controls.ButtonModal {
                Layout.minimumWidth: 275
                Layout.preferredWidth: 300

                buttonHeight: 38
                spacing: 20
                Layout.topMargin: 35
                labelText: "BUY XBY"
                isPrimary: true
                Label {
                    anchors.bottom: parent.top
                    text: "Total: " + Number(buyTotal).toFixed(2)
                    color: "#FFFFFF"
                    bottomPadding: 10
                    font.bold: true
                    font.pixelSize: 12
                }
            }
            Controls.ButtonModal {
                Layout.minimumWidth: 275
                Layout.preferredWidth: 300

                buttonHeight: 38
                spacing: 20
                Layout.topMargin: 35
                labelText: "SELL XBY"
                isPrimary: true
                colorTracker: 1
                Label {
                    anchors.bottom: parent.top
                    text: "Total: " + Number(sellTotal).toFixed(2)
                    color: "#FFFFFF"
                    bottomPadding: 10
                    font.bold: true
                    font.pixelSize: 12
                }
            }
        }
    }
}



