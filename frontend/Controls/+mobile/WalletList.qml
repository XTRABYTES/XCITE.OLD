import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtMultimedia 5.8
import QtQuick.Window 2.2
import QtQml 2.11

Rectangle {
    id: allWalletCards
    width: Screen.width
    height: parent.height
    color: "transparent"

    Component {
        id: walletCard

        Rectangle {
            id: currencyRow
            color: "transparent"
            width: Screen.width
            height: active == 0 ? 0 : 98
            visible: active == 0 ? false : true

            Component.onCompleted: console.log("index for " + name + " is:" + index)

            Rectangle {
                id: square
                color: "#42454F"
                width: Screen.width - 55
                height: 88
                radius: 4
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 10
                visible: active == 0 ? false : true

                Image {
                    id: icon
                    source: logo
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    anchors.top: parent.top
                    anchors.topMargin: 14
                    width: 25
                    height: 25
                    visible: active == 0 ? false : true
                }

                Text {
                    id: coinName
                    anchors.left: icon.right
                    anchors.leftMargin: 7
                    anchors.verticalCenter: icon.verticalCenter
                    text: name
                    font.pixelSize: 20
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: active == 0 ? false : true
                }

                Text {
                    id: amountSizeLabel
                    anchors.right: parent.right
                    anchors.rightMargin: 14
                    anchors.verticalCenter: coinName.verticalCenter
                    text: balance.toLocaleString(Qt.locale(), "f", 4)
                    font.pixelSize: 20
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.weight: Font.Medium
                    visible: active == 0 ? false : true
                }

                Text {
                    id: totalValueLabel
                    anchors.right: square.right
                    anchors.rightMargin:10
                    anchors.verticalCenter: price2.verticalCenter
                    text: (balance * coinValue).toLocaleString(Qt.locale(), "f", 2)
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    color: "#828282"
                    font.bold: true
                    visible: active == 0 ? false : true
                }

                Text {
                    id: percentChangeLabel
                    anchors.left: price2.right
                    anchors.leftMargin: 5
                    anchors.bottom: price2.bottom
                    text: percentage >= 0? "+" + percentage + "%" : percentage + "%"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: percentage <= 0 ? "#FD2E2E" : "#5DFC36"
                    font.bold: true
                    visible: active == 0 ? false : true
                }

                Text {
                    id: price2
                    anchors.left: dollarSign1.right
                    anchors.top: icon.bottom
                    anchors.topMargin: 8
                    text: coinValue.toLocaleString(Qt.locale(), "f", 3)
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    color: "#828282"
                    font.bold: true
                    visible: active == 0 ? false : true
                }

                Label {
                    id: dollarSign1
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: price2.verticalCenter
                    text: "$"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: "#828282"
                    font.bold: true
                    visible: active == 0 ? false : true
                }

                Label {
                    id: dollarSign2
                    anchors.right: totalValueLabel.left
                    anchors.leftMargin: 0
                    anchors.verticalCenter: totalValueLabel.verticalCenter
                    text: "$"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: "#828282"
                    font.bold: true
                    visible: active == 0 ? false : true
                }

                Text {
                    id: unconfirmed
                    anchors.horizontalCenter: square.horizontalCenter
                    anchors.top: percentChangeLabel.bottom
                    anchors.topMargin: 4
                    text: "Unconfirmed " + unconfirmedCoins.toLocaleString(Qt.locale(), "f", 4) + " " + name
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: "#F2F2F2"
                    font.weight: Font.Light
                    font.italic: true
                    visible: active == 0 ? false : true
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (appsTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0) {
                            transferTracker = 1
                            currencyIndex = index
                        }
                    }
                }
            }

        }
    }
    ListView {
        anchors.fill: parent
        id: allWallets
        model: currencyList
        delegate: walletCard
        contentHeight: (totalWallets * 98)
   }
}

