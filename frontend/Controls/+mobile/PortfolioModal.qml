/**
 * Filename: portfolioModal.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

import QtQuick.Controls 2.3
import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtMultimedia 5.8
import QtCharts 2.0

import "qrc:/Controls" as Controls

Rectangle {
    id: portfolioModal
    width: Screen.width
    state: portfolioTracker == 0 ? "down" : "up"
    height: Screen.height
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 50
    onStateChanged: {
        if (portfolioTracker == 1) {
            if (!isNaN(totalXBY)) {
                pieSeries.find("XBY").value = totalXBY * valueXBY
            }
            if (!isNaN(totalXFUEL)) {
                pieSeries.find("XFUEL").value = totalXFUEL * valueXFUEL
            }
            if (!isNaN(totalBTC)) {
                pieSeries.find("BTC").value = totalBTC * valueBTC
            }
            if (!isNaN(totalETH)) {
                pieSeries.find("ETH").value = totalETH * valueETH
            }
        }
        percentage = (100 / (totalBalance / (coinConversion(totalAmountTicker.text, sumCoinTotal(totalAmountTicker.text))))).toLocaleString(Qt.locale("en_US"), "f", 2)
    }

    LinearGradient {
        anchors.fill: parent
        start: Qt.point(0, 0)
        end: Qt.point(0, parent.height)
        opacity: 0.05
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 1.0; color: maincolor }
        }
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: portfolioModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: portfolioModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: portfolioModal; property: "anchors.topMargin"; duration: 400; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    property int coin: 0
    property real percentage

    Text {
        id: walletModalLabel
        text: "PORTFOLIO"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.letterSpacing: 2
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    ChartView {
        id: chart
        anchors.top: walletModalLabel.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.right
        height: 240
        legend.visible: false
        antialiasing: true
        backgroundColor: "transparent"

        PieSeries {
            id: pieSeries
            size: 0.9
            holeSize: 0.6
            PieSlice { label: "XFUEL"; value: 0; color: "#FFAE11"; borderWidth: (coin == 0? 2 : 0); borderColor: (coin == 0? themecolor : "transparent") }
            PieSlice { label: "XBY"; value: 0; color: "#0ED8D2"; borderWidth: (coin == 1? 2 : 0); borderColor: (coin == 1? themecolor : "transparent") }
            PieSlice { label: "BTC"; value: 0; color: "#F7931A"; borderWidth: (coin == 4? 2 : 0); borderColor: (coin == 4? themecolor : "transparent") }
            PieSlice { label: "ETH"; value: 0; color: "#A690FC"; borderWidth: (coin == 5? 2 : 0); borderColor: (coin == 5? themecolor : "transparent") }
        }
    }

    Label {
        id: zeroFunds
        text: "Your wallet is empty!"
        anchors.verticalCenter: chart.verticalCenter
        anchors.horizontalCenter: chart.horizontalCenter
        font.pixelSize: 24
        font.family: xciteMobile.name
        font.letterSpacing: 2
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: totalXBY == 0 && totalXFUEL == 0
    }

    Rectangle {
        id: legendXBY
        width: 20
        height: 20
        anchors.top: chart.top
        anchors.left: parent.left
        anchors.leftMargin: 28
        color: "#0ED8D2"
        border.color: coin == 1? themecolor : "transparent"
    }

    Label {
        id: xbyLabel
        text: "XBY"
        anchors.verticalCenter: legendXBY.verticalCenter
        anchors.left: legendXBY.right
        anchors.leftMargin: 10
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.letterSpacing: 2
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Rectangle {
        width: xbyLabel.width - 10
        height: 1
        anchors.horizontalCenter: xbyLabel.horizontalCenter
        anchors.top: xbyLabel.bottom
        color: themecolor
        visible: coin == 1
    }

    MouseArea {
        anchors.top: legendXBY.top
        anchors.bottom: legendXBY.bottom
        anchors.left: legendXBY.left
        anchors.right: xbyLabel.right

        onClicked: {
            click01.play()
            detectInteraction()
            coin = 1
            percentage = (100 / (totalBalance / (coinConversion(totalAmountTicker.text, sumCoinTotal(totalAmountTicker.text))))).toLocaleString(Qt.locale("en_US"), "f", 2)
        }
    }

    Rectangle {
        id: legendXFUEL
        width: 20
        height: 20
        anchors.top: chart.top
        anchors.right: parent.right
        anchors.rightMargin: 28
        color: "#FFAE11"
        border.color: coin == 0? themecolor : "transparent"
    }

    Label {
        id: xfuelLabel
        text: "XFUEL"
        anchors.verticalCenter: legendXFUEL.verticalCenter
        anchors.right: legendXFUEL.left
        anchors.rightMargin: 10
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.letterSpacing: 2
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Rectangle {
        width: xfuelLabel.width - 10
        height: 1
        anchors.horizontalCenter: xfuelLabel.horizontalCenter
        anchors.top: xfuelLabel.bottom
        color: themecolor
        visible: coin == 0
    }

    MouseArea {
        anchors.top: legendXFUEL.top
        anchors.bottom: legendXFUEL.bottom
        anchors.left: xfuelLabel.left
        anchors.right: legendXFUEL.right

        onClicked: {
            click01.play()
            detectInteraction()
            coin = 0
            percentage = (100 / (totalBalance / (coinConversion(totalAmountTicker.text, sumCoinTotal(totalAmountTicker.text))))).toLocaleString(Qt.locale("en_US"), "f", 2)
        }
    }

    Rectangle {
        id: legendBTC
        width: 20
        height: 20
        anchors.bottom: chart.bottom
        anchors.left: parent.left
        anchors.leftMargin: 28
        color: "#F7931A"
        border.color: coin == 3? themecolor : "transparent"
    }

    Label {
        id: btcLabel
        text: "BTC"
        anchors.verticalCenter: legendBTC.verticalCenter
        anchors.left: legendBTC.right
        anchors.leftMargin: 10
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.letterSpacing: 2
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Rectangle {
        width: btcLabel.width - 10
        height: 1
        anchors.horizontalCenter: btcLabel.horizontalCenter
        anchors.top: btcLabel.bottom
        color: themecolor
        visible: coin == 3
    }

    MouseArea {
        anchors.top: legendBTC.top
        anchors.bottom: legendBTC.bottom
        anchors.left: legendBTC.left
        anchors.right: btcLabel.right

        onClicked: {
            click01.play()
            detectInteraction()
            coin = 3
            percentage = (100 / (totalBalance / (coinConversion(totalAmountTicker.text, sumCoinTotal(totalAmountTicker.text))))).toLocaleString(Qt.locale("en_US"), "f", 2)
        }
    }

    Rectangle {
        id: legendETH
        width: 20
        height: 20
        anchors.bottom: chart.bottom
        anchors.right: parent.right
        anchors.rightMargin: 28
        color: "#A690FC"
        border.color: coin == 4? themecolor : "transparent"
    }

    Label {
        id: ethLabel
        text: "ETH"
        anchors.verticalCenter: legendETH.verticalCenter
        anchors.right: legendETH.left
        anchors.rightMargin: 10
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.letterSpacing: 2
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Rectangle {
        width: ethLabel.width - 10
        height: 1
        anchors.horizontalCenter: ethLabel.horizontalCenter
        anchors.top: ethLabel.bottom
        color: themecolor
        visible: coin == 4
    }

    MouseArea {
        anchors.top: legendETH.top
        anchors.bottom: legendETH.bottom
        anchors.left: ethLabel.left
        anchors.right: legendETH.right

        onClicked: {
            click01.play()
            detectInteraction()
            coin = 4
            percentage = (100 / (totalBalance / (coinConversion(totalAmountTicker.text, sumCoinTotal(totalAmountTicker.text))))).toLocaleString(Qt.locale("en_US"), "f", 2)
        }
    }

    Rectangle {
        id: coinBar
        width: parent.width
        height: 30
        anchors.top: legendBTC.bottom
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        color: "black"

        Label {
            text: getFullName(coin)
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.verticalCenter: parent.verticalCenter
            color: "#F2F2F2"
            font.pixelSize: 20
            font.family: xciteMobile.name
            font.capitalization: Font.AllUppercase
        }

        Label {
            id: portfolioPercentage
            text: percentage  + " %"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 28
            color: "#F2F2F2"
            font.pixelSize: 20
            font.family: xciteMobile.name
        }
    }

    Flickable {
        id: scrollArea
        width: parent.width
        contentHeight: walletScrollArea.height + 125
        anchors.left: parent.left
        anchors.top: coinBar.bottom
        anchors.bottom: parent.bottom
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        Rectangle {
            id: walletScrollArea
            width: parent.width
            anchors.top: parent.top
            anchors.bottom: valueLine.bottom
            color: "transparent"
        }

        Rectangle {
            width: parent.width
            anchors.top: parent.top
            anchors.bottom: totalLine.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
        }

        Label {
            id: totalLabel
            text: "Wallet total:"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: parent.top
            anchors.topMargin: 10
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Label {
            id: totalAmountTicker
            text: getName(coin)
            anchors.right: parent.right
            anchors.rightMargin: 28
            anchors.top: totalLabel.bottom
            anchors.topMargin: 5
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Label {
            property real sumBalance: totalAmountTicker.text === "XBY"? totalXBY : (totalAmountTicker.text === "XFUEL"? totalXFUEL : (totalAmountTicker.text === "BTC"? totalBTC : (totalAmountTicker.text === "ETH"? totalETH : 0)))
            property int decimals: (totalAmountTicker.text == "BTC" || totalAmountTicker.text == "ETH")? 8 : (sumBalance >= 100000 ? 2 : 4)
            property string amount: sumBalance.toLocaleString(Qt.locale("en_US"), "f", decimals)
            id: totalAmount
            text: amount
            anchors.right: totalAmountTicker.left
            anchors.rightMargin: 7
            anchors.top: totalAmountTicker.top
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Rectangle {
            id: totalLine
            width: parent.width
            height: 1
            anchors.top: totalAmount.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
        }

        Rectangle {
            width: parent.width
            anchors.top: totalLine.bottom
            anchors.bottom: infoLine.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
        }

        Label {
            id: infoLabel
            text: "Coin value:"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: totalLine.bottom
            anchors.topMargin: 10
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Label {
            id: coinValue
            text: coin == 0? valueXFUEL.toLocaleString(Qt.locale("en_US"), "f", 4) : (coin == 1? valueXBY.toLocaleString(Qt.locale("en_US"), "f", 4) : (coin == 3? valueBTC.toLocaleString(Qt.locale("en_US"), "f", 4) : valueETH.toLocaleString(Qt.locale("en_US"), "f", 4)))
            anchors.right: parent.right
            anchors.rightMargin: 28
            anchors.top: infoLabel.bottom
            anchors.topMargin: 5
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Label {
            id: coinValueTicker
            text: fiatTicker
            anchors.right: coinValue.left
            anchors.rightMargin: 2
            anchors.top: coinValue.top
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Label {
            id: procentLabel
            text: "24 hr:"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: infoLabel.bottom
            anchors.topMargin: 5
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Label {
            id: procentValue
            text: coinList.get(coin).percentage >= 0? ("+" + coinList.get(coin).percentage + " %") : coinList.get(coin).percentage + " %"
            anchors.left: procentLabel.right
            anchors.leftMargin: 10
            anchors.top: procentLabel.top
            color: coinList.get(coin).percentage < 0 ? "#E55541" : "#4BBE2E"
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Rectangle {
            id: infoLine
            width: parent.width
            height: 1
            anchors.top: coinValue.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
        }

        Rectangle {
            width: parent.width
            anchors.top: infoLine.bottom
            anchors.bottom: valueLine.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
        }

        Label {
            id: valueLabel
            text: "Total value:"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: infoLine.bottom
            anchors.topMargin: 10
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Label {
            id: totalValue
            text: (coinConversion(totalAmountTicker.text, sumCoinTotal(totalAmountTicker.text)).toLocaleString(Qt.locale("en_US"), "f", 2))
            anchors.right: parent.right
            anchors.rightMargin: 28
            anchors.top: valueLabel.bottom
            anchors.topMargin: 5
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Label {
            id: totalValueTicker
            text: fiatTicker
            anchors.right: totalValue.left
            anchors.rightMargin: 2
            anchors.top: totalValue.top
            color: themecolor
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Rectangle {
            id: valueLine
            width: parent.width
            height: 1
            anchors.top: totalValue.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
        }

    }

    Item {
        z: 3
        width: Screen.width
        height: myOS === "android"? 125 : 145
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(x, y)
            end: Qt.point(x, y + height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.5; color: darktheme == true? "#14161B" : "#FDFDFD" }
                GradientStop { position: 1.0; color: darktheme == true? "#14161B" : "#FDFDFD" }
            }
        }
    }

    Label {
        id: closeWalletModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : 70
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"

        Rectangle{
            id: closeButton
            height: 34
            width: doubbleButtonWidth / 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"
        }

        MouseArea {
            anchors.fill: closeButton

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onReleased: {
                portfolioTracker = 0;
                coin = ""
            }
        }
    }
}
