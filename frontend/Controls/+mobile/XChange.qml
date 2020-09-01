/**
 * Filename: xchange.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

import QtQuick 2.7
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

import "qrc:/Controls" as Controls
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: xchangeModal
    width: appWidth
    height: appHeight
    state: xchangeTracker == 1? "up" : "down"
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    clip: true

    onStateChanged: {
        coinListTracker = 0
        chartTracker = 0
        tradeTracker = 0
        buyOrderTracker = 0
        sellOrderTracker = 0
        timerCounter = 0
        exchangePageTracker = view.currentIndex
        if (xchangeTracker == 1) {
            updatingInfo = true
            tradeList.clear()
            getCoinInfo(selectedExchange, exchangePair)
        }
        else {

        }
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
            PropertyChanges { target: xchangeModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: xchangeModal; anchors.topMargin: xchangeModal.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: xchangeModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    property int favoritesTracker: 0
    property int chartTracker: 0
    property string selectedExchange: "probit"
    property string exchangePair: coinName.text.toUpperCase() + "-" + coin2Name.text.toUpperCase()
    property int myCoin: xchangeTracker == 1? newCoinPicklist : 0
    property int exchangeCoin: xchangeTracker == 1? newCoin2Picklist : 3
    property int orderTracker: 0
    property int orderType: 0
    property int tradeTracker: 0
    property int buyOrderTracker: 0
    property int sellOrderTracker: 0
    property string lastPrice: ""
    property string lowPrice: ""
    property string highPrice: ""
    property string priceChange: ""
    property var percChange: Number.fromLocaleString(Qt.locale("en_US"), priceChange)
    property string volume1: ""
    property string volume2: ""
    property bool updatingInfo: false
    property bool updatingTrades: false
    property bool updatingOrderBook: false
    property string buyVol: ""
    property string sellVol: ""
    property var bVol: Number.fromLocaleString(Qt.locale("en_US"),buyVol)
    property var sVol: Number.fromLocaleString(Qt.locale("en_US"),sellVol)
    property real sumSellVolume: 0
    property real sumBuyVolume: 0
    property real timerCounter: 0


    function loadTradeList(trades) {
        if (typeof trades !== "undefined") {
            tradeList.clear();
            var obj = JSON.parse(trades);
            for (var i in obj){
                var data = obj[i];
                tradeList.append(data);
            }
        }
    }

    function loadOrderBookList(orders) {
        if (typeof orders !== "undefined") {
            orderList.clear();
            var obj = JSON.parse(orders);
            for (var i in obj){
                var data = obj[i];
                orderList.append(data);
            }
        }
    }

    function orderListSort(listModel, compareFunction) {
            let indexes = [ ...Array(listModel.count).keys() ]
            indexes.sort( (a, b) => compareFunction( listModel.get(a).price, listModel.get(b).price) )
            let sorted = 0
            while ( sorted < indexes.length && sorted === indexes[sorted] ) sorted++
            if ( sorted === indexes.length ) return
            for ( let i = sorted; i < indexes.length; i++ ) {
                listModel.move( indexes[i], listModel.count - 1, 1 )
                listModel.insert( indexes[i], { } )
            }
            listModel.remove( sorted, indexes.length - sorted )
        }

    ListModel {
        id: tradeList
        ListElement {
            side: ""
            price: ""
            quantity: ""
            date: ""
            time: ""
        }
    }

    ListModel {
        id: chartList
        ListElement {
            timestamp: ""
            open: ""
            high: ""
            low: ""
            close: ""
            volume: ""
        }
    }

    Connections {
        target: cex

        onReceivedCoinInfo: {
            if (exchange === selectedExchange && pair === exchangePair) {
                lowPrice = low
                highPrice = high
                lastPrice = last
                priceChange = change
                volume1 = baseVolume
                volume2 = quoteVolume
                exchangeInfoDate.text = infoDate
                exchangeInfoTime.text = infoTime + " UTC"
                updatingInfo = false
            }
        }

        onReceivedRecentTrades: {
            if (exchange === selectedExchange && pair === exchangePair) {
                loadTradeList(recentTradesList)
                updatingTrades = false
            }
        }

        onReceivedOrderBook: {
            if (exchange === selectedExchange && pair === exchangePair) {
                loadOrderBookList(orderBookList)
                buyVol = buyVolume
                sellVol = sellVolume
                if (buyOrderTracker == 1 && orderList.get(0).accVolume === 0) {
                    orderListSort(orderList, (a, b) => - (a - b))
                    sumBuyVolume = 0
                    var bVol
                    for (var e = 0; e < orderList.count; e ++) {
                        if (orderList.get(e).side === "buy" && orderList.get(e).accVolume === 0) {
                        bVol = orderList.get(e).quantity
                        sumBuyVolume = sumBuyVolume + bVol
                        orderList.setProperty(e, "accVolume", sumBuyVolume)
                        }
                    }
                }
                if (sellOrderTracker == 1 && orderList.get(0).accVolume === 0) {
                    orderListSort(orderList, (a, b) => (a - b))
                    sumSellVolume = 0
                    var sVol
                    for (var o = 0; o < orderList.count; o ++) {
                        if (orderList.get(o).side === "sell" && orderList.get(o).accVolume === 0) {
                        sVol = orderList.get(o).quantity
                            sumSellVolume = sumSellVolume + sVol
                            orderList.setProperty(o, "accVolume", sumSellVolume)
                        }
                    }
                }
                updatingOrderBook = false
            }
        }
    }

    Timer {
        id: exchangeTimer
        interval: 15000
        repeat: true
        running: xchangeTracker == 1

        onTriggered: {
            if (view.currentIndex == 1) {
                updatingInfo = true
                getCoinInfo(selectedExchange, exchangePair)
            }
            if (timerCounter == 0) {
                if (tradeTracker == 1 && view.currentIndex == 1) {
                    updatingTrades = true
                    getRecentTrades(selectedExchange, exchangePair, "20")
                }
                if ((buyOrderTracker == 1 || sellOrderTracker == 1) && view.currentIndex == 1) {
                    updatingOrderBook = true
                    getOrderBook(selectedExchange, exchangePair)
                }
                if (timerCounter < 4) {
                    timerCounter = timerCounter + 1
                }
                else {
                    timerCounter = 0
                }
            }
        }
    }

    SwipeView {
        id: view
        z: 2
        currentIndex: 0
        anchors.fill: parent
        interactive: (appsTracker == 1 && balanceTracker == 1) ? false : true

        onCurrentIndexChanged: exchangePageTracker = view.currentIndex

        Item {
            id: tradesForm

            Rectangle {
                id:scrollAreaTradignForm
                z: 3
                width: xchangeModal.width
                height: xchangeModal.height - 100
                anchors.top: parent.top
                anchors.topMargin: 100
                color: "transparent"
                clip: true

                Rectangle {
                    id: openOrderArea
                    z: 3
                    width: parent.width
                    height: parent.height / 2
                    anchors.top: parent.top
                    color: "transparent"
                    clip: true

                    Label {
                        z: 3
                        text: "OPEN ORDERS"
                        font.pixelSize: 13
                        font.family: xciteMobile.name
                        color: themecolor
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Label {
                        z: 3
                        text: "no trades available for now"
                        font.pixelSize: 18
                        font.family: xciteMobile.name
                        color: themecolor
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                }

                Rectangle {
                    id: historyOrderArea
                    z: 3
                    width: parent.width
                    height: parent.height / 2
                    anchors.top: openOrderArea.bottom
                    color: "transparent"
                    clip: true

                    Label {
                        z: 3
                        text: "TRADE HISTORY"
                        font.pixelSize: 13
                        font.family: xciteMobile.name
                        color: themecolor
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Label {
                        z: 3
                        text: "no trades available for now"
                        font.pixelSize: 18
                        font.family: xciteMobile.name
                        color: themecolor
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                }
            }

            DropShadow {
                z: 3
                anchors.fill: orderHeader
                source: orderHeader
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color: "black"
                opacity: 0.5
                transparentBorder: true
            }

            Rectangle {
                id: orderHeader
                z: 4
                width: parent.width
                height: 100
                color: bgcolor
            }
        }

        Item {
            id: exchangeForm

            Rectangle {
                id: balanceScrollArea
                z: 3
                width: xchangeModal.width
                height: xchangeModal.height - 100
                anchors.top: parent.top
                anchors.topMargin: 100
                color: "transparent"
                clip: true

                DropShadow {
                    z: 4
                    anchors.fill: chartTradeBar
                    source: chartTradeBar
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color: "black"
                    opacity: 0.5
                    transparentBorder: true
                }

                DropShadow {
                    z: 4
                    anchors.fill: tradeHeader
                    source: tradeHeader
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color: "black"
                    opacity: 0.5
                    transparentBorder: true
                }

                Rectangle {
                    id: tradeHeader
                    z: 4
                    width: parent.width
                    height: 100
                    color: bgcolor
                    anchors.top: parent.top
                    anchors.topMargin: -100
                }

                Label {
                    id: exchangeInfoDate
                    z: 3
                    text: "????-??-??"
                    color: themecolor
                    font.pixelSize: 8
                    font.family: xciteMobile.name
                    anchors.left: parent.left
                    anchors.leftMargin: 28
                    anchors.top: tradeHeader.bottom
                    anchors.topMargin: 5
                }

                Label {
                    id: exchangeInfoTime
                    z: 3
                    text: "??:??:????"
                    color: themecolor
                    font.pixelSize: 8
                    font.family: xciteMobile.name
                    anchors.right: parent.right
                    anchors.rightMargin: 28
                    anchors.top: tradeHeader.bottom
                    anchors.topMargin: 5
                }

                Label {
                    id: lastLabel
                    z: 3
                    text: "Last:"
                    color: themecolor
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.left: parent.left
                    anchors.leftMargin: 28
                    anchors.top: tradeHeader.bottom
                    anchors.topMargin: 20
                }

                Label {
                    id: lastAmount
                    z: 3
                    text: lastPrice
                    color: themecolor
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.right: parent.horizontalCenter
                    anchors.rightMargin: 5
                    anchors.top: tradeHeader.bottom
                    anchors.topMargin: 20
                }

                Label {
                    id: lowLabel
                    z: 3
                    text: "Low:"
                    color: themecolor
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.left: parent.left
                    anchors.leftMargin: 28
                    anchors.top: lastLabel.bottom
                    anchors.topMargin: 5
                }

                Label {
                    id: lowAmount
                    z: 3
                    text: lowPrice
                    color: themecolor
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.right: parent.horizontalCenter
                    anchors.rightMargin: 5
                    anchors.top: lastLabel.bottom
                    anchors.topMargin: 5
                }

                Label {
                    id: changeLabel
                    z: 3
                    text: "Change:"
                    color: themecolor
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 5
                    anchors.top: tradeHeader.bottom
                    anchors.topMargin: 20
                }

                Label {
                    id: changeAmount
                    z: 3
                    text: priceChange + " %"
                    color: percChange >= 0? "#4BBE2E" : "#E55541"
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.right: parent.right
                    anchors.rightMargin: 28
                    anchors.top: tradeHeader.bottom
                    anchors.topMargin: 20
                }

                Label {
                    id: highLabel
                    z: 3
                    text: "High:"
                    color: themecolor
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 5
                    anchors.top: changeLabel.bottom
                    anchors.topMargin: 5
                }

                Label {
                    id: highAmount
                    z: 3
                    text: highPrice
                    color: themecolor
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.right: parent.right
                    anchors.rightMargin: 28
                    anchors.top: changeLabel.bottom
                    anchors.topMargin: 5
                }

                Label {
                    id: volumeLabel
                    z: 3
                    text: "Volume (24h):"
                    color: themecolor
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: highLabel.bottom
                    anchors.topMargin: 10
                }

                Label {
                    id: volumeCoin1Amount
                    z: 3
                    text: volume1
                    color: themecolor
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.right: volumeCoin1Label.left
                    anchors.rightMargin: 2
                    anchors.top: volumeLabel.bottom
                    anchors.topMargin: 5
                }

                Label {
                    id: volumeCoin1Label
                    z: 3
                    text: coinName.text
                    color: themecolor
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.right: parent.horizontalCenter
                    anchors.rightMargin: 5
                    anchors.top: volumeLabel.bottom
                    anchors.topMargin: 5
                }

                Label {
                    id: volumeCoin2Amount
                    z: 3
                    text: volume2
                    color: themecolor
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.right: volumeCoin2Label.left
                    anchors.rightMargin: 2
                    anchors.top: volumeLabel.bottom
                    anchors.topMargin: 5
                }

                Label {
                    id: volumeCoin2Label
                    z: 3
                    text: coin2Name.text
                    color: themecolor
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.right: parent.right
                    anchors.rightMargin: 28
                    anchors.top: volumeLabel.bottom
                    anchors.topMargin: 5
                }

                Rectangle {
                    id: chartTradeBar
                    z: 4
                    width: parent.width
                    height: 30
                    color: "black"
                    anchors.top: volumeCoin1Label.bottom
                    anchors.topMargin: 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label {
                        id: chartLabel
                        z: 4
                        text: "CHART"
                        font.pixelSize: 13
                        font.family: xciteMobile.name
                        color: "#F2F2F2"
                        anchors.left: parent.left
                        anchors.leftMargin:28
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: false
                        visible: tradeTracker == 0
                    }

                    Image {
                        id: chartArrow
                        z: 4
                        source: 'qrc:/icons/mobile/dropdown-icon_01_light.svg'
                        height: 18
                        width: 18
                        anchors.left: chartLabel.right
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        visible: tradeTracker == 0
                        state: chartTracker == 0? "down" : "up"

                        Rectangle{
                            id: arrowButton
                            height: 18
                            width: 18
                            radius: 10
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "transparent"
                        }

                        states: [
                            State {
                                name: "up"
                                PropertyChanges { target: chartArrow; rotation: 180}
                            },
                            State {
                                name: "down"
                                PropertyChanges { target: chartArrow; rotation: 0}
                            }
                        ]

                        transitions: [
                            Transition {
                                from: "*"
                                to: "*"
                                NumberAnimation { target: chartArrow; property: "rotation"; duration: 300; easing.type: Easing.InOutCubic}
                            }
                        ]

                        MouseArea {
                            anchors.fill: arrowButton

                            onPressed: {
                                click01.play()
                                detectInteraction()
                            }

                            onClicked: {
                                if (chartTracker == 0) {
                                    chartTracker = 1
                                }
                                else {
                                    chartTracker = 0
                                }
                            }
                        }
                    }

                    Label {
                        id: tradeLabel
                        z: 4
                        text: "RECENT TRADES"
                        font.pixelSize: 13
                        font.family: xciteMobile.name
                        color: "#F2F2F2"
                        anchors.right: tradeArrow.left
                        anchors.rightMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: false
                        visible: chartTracker == 0
                    }

                    Image {
                        id: tradeArrow
                        z: 4
                        source: 'qrc:/icons/mobile/dropdown-icon_01_light.svg'
                        height: 18
                        width: 18
                        anchors.right: parent.right
                        anchors.rightMargin: 28
                        anchors.verticalCenter: parent.verticalCenter
                        visible: chartTracker == 0
                        state: tradeTracker == 0? "down" : "up"

                        Rectangle{
                            id: tradeButton
                            height: 18
                            width: 18
                            radius: 10
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "transparent"
                        }

                        states: [
                            State {
                                name: "up"
                                PropertyChanges { target: tradeArrow; rotation: 180}
                            },
                            State {
                                name: "down"
                                PropertyChanges { target: tradeArrow; rotation: 0}
                            }
                        ]

                        transitions: [
                            Transition {
                                from: "*"
                                to: "*"
                                NumberAnimation { target: tradeArrow; property: "rotation"; duration: 300; easing.type: Easing.InOutCubic}
                            }
                        ]

                        MouseArea {
                            anchors.fill: tradeButton
                            enabled: updatingInfo == false

                            onPressed: {
                                click01.play()
                                detectInteraction()
                            }

                            onClicked: {
                                if (tradeTracker == 0) {
                                    tradeTracker = 1
                                    updatingTrades = true
                                    getRecentTrades(selectedExchange, exchangePair, "20")
                                }
                                else {
                                    tradeTracker = 0
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    id: tradeChartArea
                    z: 3
                    width: parent.width
                    color: "transparent"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: chartTradeBar.top
                    state: tradeTracker == 1 || chartTracker == 1? "down" : "up"
                    clip: true

                    states: [
                        State {
                            name: "up"
                            PropertyChanges { target: tradeChartArea; height: 30}
                        },
                        State {
                            name: "down"
                            PropertyChanges { target: tradeChartArea; height: 185}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: tradeChartArea; property: "height"; duration: 300; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Image {
                        id: chart
                        z: 3
                        source: "qrc:/icons/mobile/chart_example.svg"
                        width: parent.width - 56
                        fillMode: Image.PreserveAspectFit
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: tradeChartArea.top
                        state: chartTracker == 0? "up" : "down"

                        Label {
                            z: 3
                            text: "DEMO chart"
                            font.pixelSize: 18
                            font.family: xciteMobile.name
                            color: themecolor
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: true
                        }

                        states: [
                            State {
                                name: "up"
                                PropertyChanges { target: chart; anchors.topMargin: -(chart.height + 10)}
                            },
                            State {
                                name: "down"
                                PropertyChanges { target: chart; anchors.topMargin: 40}
                            }
                        ]

                        transitions: [
                            Transition {
                                from: "*"
                                to: "*"
                                NumberAnimation { target: chart; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
                            }
                        ]
                    }

                    Rectangle {
                        id: tradeListArea
                        z: 3
                        width: parent.width
                        height: 145
                        color: "transparent"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: tradeChartArea.top
                        state: tradeTracker == 0? "up" : "down"

                        property real listAreaTop: anchors.topMargin

                        Mobile.XChangeRecentTradeList {
                            id: myRecentTrades
                            list: tradeList
                            exchange: selectedExchange
                            coin : coinName.text
                        }

                        AnimatedImage  {
                            id: waitingDotsTrades
                            source: 'qrc:/gifs/loading-gif_01.gif'
                            width: 90
                            height: 60
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            playing: updatingTrades == true && tradeTracker == 1
                            visible: updatingTrades == true && tradeTracker == 1
                        }

                        states: [
                            State {
                                name: "up"
                                PropertyChanges { target: tradeListArea; anchors.topMargin: -(tradeListArea.height + 10)}
                            },
                            State {
                                name: "down"
                                PropertyChanges { target: tradeListArea; anchors.topMargin: 40}
                            }
                        ]

                        transitions: [
                            Transition {
                                from: "*"
                                to: "*"
                                NumberAnimation { target: tradeListArea; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
                            }
                        ]

                        Rectangle {
                            width: parent.width
                            height: 1
                            color: themecolor
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            visible: parent.listAreaTop != -(tradeListArea.height + 10)
                        }
                    }
                }

                Label {
                    id: balanceLabel
                    z: 3
                    text: "AVAILABLE BALANCE:"
                    color: themecolor
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: tradeChartArea.bottom
                    anchors.topMargin: 15
                }

                Label {
                    id: coin1Label
                    z: 3
                    text: coinName.text
                    color: themecolor
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.right: parent.horizontalCenter
                    anchors.rightMargin: 5
                    anchors.top: balanceLabel.bottom
                    anchors.topMargin: 5
                }

                Label {
                    id: coin2Label
                    z: 3
                    text: coin2Name.text
                    color: themecolor
                    font.pixelSize: 13
                    font.family: xciteMobile.name
                    anchors.right: parent.right
                    anchors.rightMargin: 28
                    anchors.top: balanceLabel.bottom
                    anchors.topMargin: 5
                }

                Rectangle {
                    id: limitButton
                    z: 3
                    width: (parent.width - 110)/2
                    height: 34
                    color: "transparent"
                    border.color: orderType == 0? maincolor : "#757575"
                    border.width: 1
                    anchors.left: parent.left
                    anchors.leftMargin: 50
                    anchors.top: coin1Label.bottom
                    anchors.topMargin: 15

                    Label {
                        id: limitBtnLabel
                        text: "LIMIT"
                        color: orderType == 0? maincolor : "#757575"
                        font.pixelSize: 16
                        font.family: xciteMobile.name
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            if (orderType == 1) {
                                orderType = 0
                            }
                        }
                    }
                }

                Rectangle {
                    id: marketButton
                    z: 3
                    width: (parent.width - 110)/2
                    height: 34
                    color: "transparent"
                    border.color: orderType == 1? maincolor : "#757575"
                    border.width: 1
                    anchors.right: parent.right
                    anchors.rightMargin: 50
                    anchors.top: coin1Label.bottom
                    anchors.topMargin: 15

                    Label {
                        id: marketBtnLabel
                        text: "MARKET"
                        color: orderType == 1? maincolor : "#757575"
                        font.pixelSize: 16
                        font.family: xciteMobile.name
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            if (orderType == 0) {
                                orderType = 1
                            }
                        }
                    }
                }

                Mobile.AmountInput {
                    id: amountField
                    z: 3
                    width: parent.width - 100
                    placeholder: "AMOUNT (" + coinName.text + ")"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: limitButton.bottom
                    anchors.topMargin: 15
                    color: darktheme == true? "#F2F2F2" : "#2A2C31"
                    textBackground: bgcolor
                    font.pixelSize: 14
                    font.capitalization: Font.AllUppercase
                    mobile: 1
                    addressBook: 1
                    calculator: 0
                }

                Mobile.AmountInput {
                    id: rateField
                    z: 3
                    width: parent.width - 100
                    placeholder: "RATE (" + coin2Name.text + ")"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: amountField.bottom
                    anchors.topMargin: 5
                    color: darktheme == true? "#F2F2F2" : "#2A2C31"
                    textBackground: bgcolor
                    font.pixelSize: 14
                    font.capitalization: Font.AllUppercase
                    mobile: 1
                    addressBook: 1
                    calculator: 0
                    visible: orderType == 0
                }

                Label {
                    id: avgRateLabel
                    text: "AVG. RATE:"
                    color: themecolor
                    font.pixelSize: 14
                    font.family: xciteMobile.name
                    anchors.verticalCenter: amountField.verticalCenter
                    anchors.verticalCenterOffset: 38
                    anchors.left: amountField.left
                    anchors.leftMargin: 18
                    visible: orderType == 1
                }

                Mobile.AmountInput {
                    id: feeField
                    z: 3
                    width: parent.width - 100
                    placeholder: "FEE (XFUEL)"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: orderType == 0? rateField.bottom : amountField.bottom
                    anchors.topMargin: orderType == 0? 5 : 41
                    color: darktheme == true? "#F2F2F2" : "#2A2C31"
                    textBackground: bgcolor
                    font.pixelSize: 14
                    font.capitalization: Font.AllUppercase
                    mobile: 1
                    addressBook: 1
                    calculator: 0
                    readOnly: true
                }

                Mobile.AmountInput {
                    id: totalField
                    z: 3
                    width: parent.width - 100
                    placeholder: "TOTAL (" + coin2Name.text + ")"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: feeField.bottom
                    anchors.topMargin: 5
                    color: darktheme == true? "#F2F2F2" : "#2A2C31"
                    textBackground: bgcolor
                    font.pixelSize: 14
                    font.capitalization: Font.AllUppercase
                    mobile: 1
                    addressBook: 1
                    calculator: 0
                    readOnly: true
                }

                Rectangle {
                    id: buyButton
                    z: 3
                    width: (parent.width - 110)/2
                    height: 34
                    color: "#4BBE2E"
                    opacity: 0.5
                    anchors.left: parent.left
                    anchors.leftMargin: 50
                    anchors.top: totalField.bottom
                    anchors.topMargin: 15

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                        }
                    }
                }

                Rectangle {
                    z: 3
                    width: (parent.width - 110)/2
                    height: 34
                    color: "transparent"
                    border.color: "#4BBE2E"
                    border.width: 1
                    anchors.left: buyButton.left
                    anchors.top: buyButton.top
                }

                Label {
                    id: buyBtnLabel
                    z: 3
                    text: "BUY"
                    color: "#4BBE2E"
                    font.pixelSize: 16
                    font.family: xciteMobile.name
                    anchors.horizontalCenter: buyButton.horizontalCenter
                    anchors.verticalCenter: buyButton.verticalCenter
                }

                Rectangle {
                    id: sellButton
                    z: 3
                    width: (parent.width - 110)/2
                    height: 34
                    color: "#E55541"
                    opacity: 0.5
                    anchors.right: parent.right
                    anchors.rightMargin: 50
                    anchors.top: totalField.bottom
                    anchors.topMargin: 15

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                        }
                    }
                }

                Rectangle {
                    z: 3
                    width: (parent.width - 110)/2
                    height: 34
                    color: "transparent"
                    opacity: 0.5
                    border.color: "#E55541"
                    border.width: 1
                    anchors.right: sellButton.right
                    anchors.top: sellButton.top
                }

                Label {
                    id: sellBtnLabel
                    z: 3
                    text: "SELL"
                    color: "#E55541"
                    font.pixelSize: 16
                    font.family: xciteMobile.name
                    anchors.horizontalCenter: sellButton.horizontalCenter
                    anchors.verticalCenter: sellButton.verticalCenter
                }

                Rectangle {
                    id: buyOrderArea
                    z:3
                    anchors.left: parent.left
                    anchors.leftMargin: -1
                    anchors.rightMargin: buyOrderTracker == 1? 0 : 10
                    anchors.top: amountField.top
                    anchors.bottom: buyButton.bottom
                    color: bgcolor
                    border.color: buyOrderTracker == 1? themecolor : "#757575"
                    border.width: 1
                    state: buyOrderTracker == 1? "open" : "close"
                    clip: true

                    states: [
                        State {
                            name: "open"
                            AnchorChanges { target: buyOrderArea; anchors.right: amountField.right}
                        },
                        State {
                            name: "close"
                            AnchorChanges { target: buyOrderArea; anchors.right: amountField.left}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            AnchorAnimation { duration: 300; easing.type: Easing.InOutCubic}
                        }
                    ]

                    MouseArea {
                        anchors.fill: parent
                    }

                    Image {
                        id: buyOrderArrow
                        z: 4
                        source: darktheme == true? 'qrc:/icons/mobile/dropdown-icon_01_light.svg' : 'qrc:/icons/mobile/dropdown-icon_01_dark.svg'
                        height: 18
                        width: 18
                        anchors.right: buyOrderArea.right
                        anchors.rightMargin: 10
                        anchors.top: buyOrderArea.top
                        anchors.topMargin: 10
                        state: buyOrderTracker == 1? "open" : "close"

                        states: [
                            State {
                                name: "open"
                                PropertyChanges { target: buyOrderArrow; rotation: 90}
                            },
                            State {
                                name: "close"
                                PropertyChanges { target: buyOrderArrow; rotation: -90}
                            }
                        ]

                        transitions: [
                            Transition {
                                from: "*"
                                to: "*"
                                NumberAnimation { target: buyOrderArrow; property: "rotation"; duration: 300; easing.type: Easing.InOutCubic}
                            }
                        ]

                        Rectangle{
                            height: 28
                            width: 28
                            radius: 10
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "transparent"

                            MouseArea {
                                anchors.fill: parent

                                onPressed: {
                                    click01.play()
                                    detectInteraction()
                                }

                                onClicked: {
                                    if (buyOrderTracker == 0) {
                                        buyOrderTracker = 1
                                        sellOrderTracker = 0
                                        updatingOrderBook = true
                                        getOrderBook(selectedExchange, exchangePair)
                                    }
                                    else {
                                        buyOrderTracker = 0

                                    }
                                }
                            }
                        }
                    }

                    Label {
                        id: buyOrderLabel
                        z: 3
                        text: "BUY ORDERS"
                        color: buyOrderTracker == 1? themecolor : "#757575"
                        font.pixelSize: 13
                        font.family: xciteMobile.name
                        anchors.horizontalCenter: buyOrderArrow.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 19
                        rotation: -90
                    }

                    Rectangle {
                        id: buyListArea
                        z:3
                        height: parent.height - 2
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left:parent.left
                        anchors.right: parent.right
                        anchors.rightMargin: 40
                        color: bgcolor
                        clip: true
                        visible: updatingOrderBook == false

                        Mobile.XChangeOrderBookList {
                            id: myBuyOrders
                            exchange: selectedExchange
                            coin : coinName.text
                            orderType: "buy"
                            volume: bVol
                        }
                    }

                    AnimatedImage  {
                        id: waitingDotsBuy
                        source: 'qrc:/gifs/loading-gif_01.gif'
                        width: 90
                        height: 60
                        anchors.horizontalCenter: buyListArea.horizontalCenter
                        anchors.verticalCenter: buyListArea.verticalCenter
                        playing: updatingOrderBook == true && buyOrderTracker == 1
                        visible: updatingOrderBook == true && buyOrderTracker == 1
                    }
                }

                Rectangle {
                    id: sellOrderArea
                    z:3
                    anchors.right: parent.right
                    anchors.rightMargin: -1
                    anchors.leftMargin: sellOrderTracker == 1? 0 : 10
                    anchors.top: amountField.top
                    anchors.bottom: buyButton.bottom
                    color: bgcolor
                    border.color: sellOrderTracker == 1? themecolor : "#757575"
                    border.width: 1
                    state: sellOrderTracker == 1? "open" : "close"
                    clip: true

                    states: [
                        State {
                            name: "open"
                            AnchorChanges { target: sellOrderArea; anchors.left: amountField.left}
                        },
                        State {
                            name: "close"
                            AnchorChanges { target: sellOrderArea; anchors.left: amountField.right}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            AnchorAnimation { duration: 300; easing.type: Easing.InOutCubic}
                        }
                    ]

                    MouseArea {
                        anchors.fill: parent
                    }

                    Image {
                        id: sellOrderArrow
                        z: 4
                        source: darktheme == true? 'qrc:/icons/mobile/dropdown-icon_01_light.svg' : 'qrc:/icons/mobile/dropdown-icon_01_dark.svg'
                        height: 18
                        width: 18
                        anchors.left: sellOrderArea.left
                        anchors.leftMargin: 10
                        anchors.top: sellOrderArea.top
                        anchors.topMargin: 10
                        state: sellOrderTracker == 1? "open" : "close"

                        states: [
                            State {
                                name: "open"
                                PropertyChanges { target: sellOrderArrow; rotation: -90}
                            },
                            State {
                                name: "close"
                                PropertyChanges { target: sellOrderArrow; rotation: 90}
                            }
                        ]

                        transitions: [
                            Transition {
                                from: "*"
                                to: "*"
                                NumberAnimation { target: sellOrderArrow; property: "rotation"; duration: 300; easing.type: Easing.InOutCubic}
                            }
                        ]

                        Rectangle{
                            height: 28
                            width: 28
                            radius: 10
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "transparent"

                            MouseArea {
                                anchors.fill: parent

                                onPressed: {
                                    click01.play()
                                    detectInteraction()
                                }

                                onClicked: {
                                    if (sellOrderTracker == 0) {
                                        sellOrderTracker = 1
                                        buyOrderTracker = 0
                                        updatingOrderBook = true
                                        getOrderBook(selectedExchange, exchangePair)
                                    }
                                    else {
                                        sellOrderTracker = 0
                                    }
                                }
                            }
                        }
                    }

                    Label {
                        id: sellOrderLabel
                        z: 3
                        text: "SELL ORDERS"
                        color: sellOrderTracker == 1? themecolor : "#757575"
                        font.pixelSize: 13
                        font.family: xciteMobile.name
                        anchors.horizontalCenter: sellOrderArrow.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 19
                        rotation: -90
                    }

                    Rectangle {
                        id: sellListArea
                        z:3
                        height: parent.height - 2
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 40
                        anchors.right: parent.right
                        color: bgcolor
                        clip: true
                        visible: updatingOrderBook == false

                        Mobile.XChangeOrderBookList {
                            id: mySellOrders
                            exchange: selectedExchange
                            coin : coinName.text
                            orderType: "sell"
                            volume: sVol
                        }
                    }
                    AnimatedImage  {
                        id: waitingDotsSell
                        source: 'qrc:/gifs/loading-gif_01.gif'
                        width: 90
                        height: 60
                        anchors.horizontalCenter: sellListArea.horizontalCenter
                        anchors.verticalCenter: sellListArea.verticalCenter
                        playing: updatingOrderBook == true && sellOrderTracker == 1
                        visible: updatingOrderBook == true && sellOrderTracker == 1
                    }
                }

                Image {
                    id: exchangeArrow1
                    z: 4
                    source: darktheme == true? 'qrc:/icons/mobile/dropdown-icon_01_light.svg' : 'qrc:/icons/mobile/dropdown-icon_01_dark.svg'
                    height: 18
                    width: 18
                    rotation: 90
                    anchors.right: exchangeView.left
                    anchors.rightMargin: 10
                    anchors.verticalCenter: exchangeView.verticalCenter
                    visible: exchangeView.currentIndex == 1

                    Rectangle{
                        height: 18
                        width: 18
                        radius: 10
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "transparent"
                    }

                    MouseArea {
                        anchors.fill: parent
                        enabled: updatingInfo == false && updatingTrades == false && updatingOrderBook == false

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            exchangeView.currentIndex = 0
                            selectedExchange = "probit"
                            updatingInfo = true
                            lowPrice = "---"
                            highPrice = "---"
                            lastPrice = "---"
                            priceChange = "---"
                            volume1 = "---"
                            volume2 = "---"
                            exchangeInfoDate.text = "????-??-??"
                            exchangeInfoTime.text = "??:??:??"
                            tradeList.clear()
                            getCoinInfo(selectedExchange, exchangePair)
                        }
                    }
                }

                Image {
                    id: exchangeArrow2
                    z: 4
                    source: darktheme == true? 'qrc:/icons/mobile/dropdown-icon_01_light.svg' : 'qrc:/icons/mobile/dropdown-icon_01_dark.svg'
                    height: 18
                    width: 18
                    rotation: -90
                    anchors.left: exchangeView.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: exchangeView.verticalCenter
                    visible: exchangeView.currentIndex == 0

                    Rectangle{
                        height: 18
                        width: 18
                        radius: 10
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "transparent"
                    }

                    MouseArea {
                        anchors.fill: parent
                        enabled: updatingInfo == false && updatingTrades == false && updatingOrderBook == false

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            exchangeView.currentIndex = 1
                            selectedExchange = "crex24"
                            updatingInfo = true
                            lowPrice = "---"
                            highPrice = "---"
                            lastPrice = "---"
                            priceChange = "---"
                            volume1 = "---"
                            volume2 = "---"
                            exchangeInfoDate.text = "????-??-??"
                            exchangeInfoTime.text = "??:??:??"
                            tradeList.clear()
                            getCoinInfo(selectedExchange, exchangePair)
                        }
                    }
                }

                SwipeView {
                    id: exchangeView
                    z: 3
                    width: totalField.width
                    height: 70
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: buyButton.bottom
                    anchors.topMargin: 5
                    currentIndex: 0
                    interactive: false
                    clip: true

                    Item {
                        id: probitForm

                        Rectangle {
                            width: parent.width
                            height: 70
                            color: "transparent"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top

                            Image {
                                id: probitImg
                                z: 3
                                source: getExchangeLogo("probit")
                                height: 50
                                fillMode: Image.PreserveAspectFit
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }

                    Item {
                        id: crex24Form

                        Rectangle {
                            width: parent.width
                            height: 70
                            color: "transparent"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top

                            Image {
                                id: crex24Img
                                z: 3
                                source: getExchangeLogo("crex24")
                                height: 50
                                fillMode: Image.PreserveAspectFit
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }

                Item {
                    z: 3
                    height: 5
                    width: 15
                    anchors.top: exchangeView.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle {
                        id: page1
                        height: exchangeView.currentIndex == 0? 7 : 5
                        width: exchangeView.currentIndex == 0? 7 : 5
                        radius: exchangeView.currentIndex == 0? 7 : 5
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        color: exchangeView.currentIndex == 0? maincolor : "#757575"
                    }

                    Rectangle {
                        id: page2
                        height: exchangeView.currentIndex == 1? 7 : 5
                        width: exchangeView.currentIndex == 1? 7 : 5
                        radius: exchangeView.currentIndex == 1? 7 : 5
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        color: exchangeView.currentIndex == 1? maincolor : "#757575"
                    }
                }
            }
        }
    }

    Rectangle {
        id: xchangeHeader
        z: 6
        width: parent.width
        height: 100
        color: "transparent"

        Image {
            id: settingsIcon
            source: 'qrc:/icons/mobile/settings-icon_01.svg'
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.verticalCenter: headingLayout.verticalCenter
            width: 25
            height: 25

            Rectangle {
                id: settingsButton
                width: 25
                height: 25
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: settingsButton

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {

                }
            }
        }

        Image {
            id: darklight
            anchors.right: parent.right
            anchors.rightMargin: 30
            anchors.verticalCenter: headingLayout.verticalCenter
            source: darktheme == true? 'qrc:/icons/mobile/theme_switch-icon_01_off.svg' : 'qrc:/icons/mobile/theme_switch-icon_01_on.svg'
            width: 25
            height: 25

            Rectangle {
                width: darklight.width
                height: darklight.height
                anchors.right: parent.right
                anchors.verticalCenter: darklight.verticalCenter
                color: "transparent"

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        if (darktheme == true) {
                            userSettings.theme = "light"
                        }
                        else if (darktheme == false) {
                            userSettings.theme = "dark"
                        }
                    }
                }
            }
        }

        RowLayout {
            id: headingLayout
            anchors.top: parent.top
            anchors.topMargin: 25
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            visible: tradingTracker != 1

            Label {
                id: myTrades
                text: "MY TRADES"
                font.pixelSize: 12
                font.family: xciteMobile.name
                color: view.currentIndex == 1 ? "#757575" : maincolor
                font.bold: true

                Rectangle {
                    id: titleLine
                    width: myTrades.width
                    height: 2
                    color: maincolor
                    anchors.top: parent.bottom
                    anchors.left: parent.left
                    anchors.topMargin: 2
                    visible: view.currentIndex == 0
                }

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        view.currentIndex = 0
                    }
                }
            }

            Label {
                id: exchange
                text: "EXCHANGE"
                font.pixelSize: 12
                font.family: xciteMobile.name
                color: view.currentIndex == 0 ? "#757575" : maincolor
                font.bold: true

                Rectangle {
                    id: titleLine2
                    width: exchange.width
                    height: 2
                    color: maincolor
                    anchors.top: parent.bottom
                    anchors.left: parent.left
                    anchors.topMargin: 2
                    visible: view.currentIndex == 1
                }

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        view.currentIndex = 1
                    }
                }
            }
        }

        Image {
            id: coinLogo
            z: 4
            source: getLogo(coinName.text)
            height: 18
            width: 18
            fillMode: Image.PreserveAspectFit
            anchors.right: coinName.left
            anchors.rightMargin: 7
            anchors.verticalCenter: coinName.verticalCenter
            visible: coin1Tracker == 0
        }

        Label {
            id: coinName
            z: 4
            text: getName(myCoin)
            color: themecolor
            font.pixelSize: 13
            font.family: xciteMobile.name
            anchors.left: parent.left
            anchors.leftMargin: 55
            anchors.bottom: xchangeHeader.bottom
            anchors.bottomMargin: 10
            visible: coin1Tracker == 0

            onTextChanged: {
                updatingInfo = true
                lowPrice = "---"
                highPrice = "---"
                lastPrice = "---"
                priceChange = "---"
                volume1 = "---"
                volume2 = "---"
                exchangeInfoDate.text = "????-??-??"
                exchangeInfoTime.text = "??:??:??"
                tradeList.clear()
                getCoinInfo(selectedExchange, exchangePair)
            }
        }

        Image {
            id: picklistArrow1
            z: 4
            source: darktheme == true? 'qrc:/icons/mobile/dropdown-icon_01_light.svg' : 'qrc:/icons/mobile/dropdown-icon_01_dark.svg'
            height: 18
            width: 18
            anchors.left: coinName.right
            anchors.leftMargin: 10
            anchors.verticalCenter: coinLogo.verticalCenter
            visible: coinListTracker == 0? (coin1Tracker == 0? true : false) : true

            Rectangle{
                id: picklistButton1
                height: 18
                width: 18
                radius: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
            }

            MouseArea {
                anchors.fill: picklistButton1
                enabled: updatingInfo == false && updatingTrades == false && updatingOrderBook == false

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    coin1Tracker = 1
                    coinListLines(false)
                    coinListTracker = 1
                }
            }
        }

        DropShadow {
            id: shadowPicklist1
            z:4
            anchors.fill: picklist1
            source: picklist1
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.3
            transparentBorder: true
            visible: coin1Tracker == 1
        }

        Rectangle {
            id: picklist1
            z: 4
            width: 100
            height: (totalLines * 35) < 175? ((totalLines * 35) + 25) : 200
            color: "#2A2C31"
            anchors.top: coinLogo.top
            anchors.topMargin: -5
            anchors.left: parent.left
            anchors.leftMargin: 28
            visible: coin1Tracker == 1
            clip: true

            onVisibleChanged: {
                if (visible == false && updatingInfo == true) {
                    getCoinInfo(selectedExchange, exchangePair)
                }
            }

            Mobile.CoinPicklist {
                id: myCoinPicklist
                onlyActive: false
            }
        }

        Rectangle {
            id: picklistClose1
            z: 4
            width: 100
            height: 25
            color: "#2A2C31"
            anchors.bottom: picklist1.bottom
            anchors.horizontalCenter: picklist1.horizontalCenter
            visible: coin1Tracker == 1

            Image {
                id: picklistCloseArrow1
                height: 12
                fillMode: Image.PreserveAspectFit
                source: 'qrc:/icons/mobile/close_picklist-icon_01.svg'
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    coin1Tracker = 0
                    coinListTracker = 0
                }
            }
        }

        Image {
            id: exchangeIcon
            z: 4
            source: darktheme == true? "qrc:/icons/mobile/exchange_icon_01_light.svg" : "qrc:/icons/mobile/exchange_icon_01_dark.svg"
            height: 20
            width: 20
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: coinName.verticalCenter
            visible: exchangePageTracker == 1 && updatingInfo == false
        }

        AnimatedImage  {
            id: waitingDots
            source: 'qrc:/gifs/loading-gif_01.gif'
            width: 90
            height: 60
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: coinName.verticalCenter
            playing: updatingInfo == true
            visible: updatingInfo == true
        }

        Image {
            id: coin2Logo
            z: 4
            source: getLogo(coin2Name.text)
            height: 18
            width: 18
            fillMode: Image.PreserveAspectFit
            anchors.right: coin2Name.left
            anchors.rightMargin: 7
            anchors.verticalCenter: coin2Name.verticalCenter
            visible: exchangePageTracker == 1 && coin2Tracker == 0
        }

        Label {
            id: coin2Name
            z: 4
            text: getName(exchangeCoin)
            color: themecolor
            font.pixelSize: 13
            font.family: xciteMobile.name
            anchors.right: parent.right
            anchors.rightMargin: 55
            anchors.bottom: xchangeHeader.bottom
            anchors.bottomMargin: 10
            visible: exchangePageTracker == 1 && coin2Tracker == 0

            onTextChanged: {
                updatingInfo = true
                lowPrice = "---"
                highPrice = "---"
                lastPrice = "---"
                priceChange = "---"
                volume1 = "---"
                volume2 = "---"
                exchangeInfoDate.text = "????-??-??"
                exchangeInfoTime.text = "??:??:??"
                tradeList.clear()
                getCoinInfo(selectedExchange, exchangePair)
            }
        }

        Image {
            id: picklistArrow2
            z: 4
            source: darktheme == true? 'qrc:/icons/mobile/dropdown-icon_01_light.svg' : 'qrc:/icons/mobile/dropdown-icon_01_dark.svg'
            height: 18
            width: 18
            anchors.right: parent.right
            anchors.rightMargin: 28
            anchors.verticalCenter: coin2Logo.verticalCenter
            visible: exchangePageTracker == 1? (coinListTracker == 0? (coin2Tracker == 0? true : false) : true) : false

            Rectangle{
                id: picklistButton2
                height: 18
                width: 18
                radius: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
            }

            MouseArea {
                anchors.fill: picklistButton2
                enabled: updatingInfo == false && updatingTrades == false && updatingOrderBook == false

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    coin2Tracker = 1
                    coinListLines(false)
                    coinListTracker = 1
                }
            }
        }

        DropShadow {
            id: shadowPicklist2
            z: 4
            anchors.fill: picklist2
            source: picklist2
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.3
            transparentBorder: true
            visible: exchangePageTracker == 1 && coin2Tracker == 1
        }

        Rectangle {
            id: picklist2
            z: 4
            width: 100
            height: (totalLines * 35) < 175? ((totalLines * 35) + 25) : 200
            color: "#2A2C31"
            anchors.top: coin2Logo.top
            anchors.topMargin: -5
            anchors.right: parent.right
            anchors.rightMargin: 28
            visible: exchangePageTracker == 1 && coin2Tracker == 1
            clip: true

            onVisibleChanged: {
                if (visible == false && updatingInfo == true) {
                    getCoinInfo(selectedExchange, exchangePair)
                }
            }

            Mobile.CoinPicklist {
                id: exchangeCoinPicklist
                onlyActive: false
            }
        }

        Rectangle {
            id: picklistClose2
            z: 4
            width: 100
            height: 25
            color: "#2A2C31"
            anchors.bottom: picklist2.bottom
            anchors.horizontalCenter: picklist2.horizontalCenter
            visible: exchangePageTracker == 1 && coin2Tracker == 1

            Image {
                id: picklistCloseArrow2
                height: 12
                fillMode: Image.PreserveAspectFit
                source: 'qrc:/icons/mobile/close_picklist-icon_01.svg'
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    coin2Tracker = 0
                    coinListTracker = 0
                }
            }
        }
    }

    Rectangle {
        id: notification
        z: 10
        width: appWidth
        height: appHeight
        state: exchangeNotifTracker == 1? "up" : "down"
        color: bgcolor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

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
                PropertyChanges { target: notification; anchors.topMargin: 0}
            },
            State {
                name: "down"
                PropertyChanges { target: notification; anchors.topMargin: xchangeModal.height}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: notification; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
            }
        ]

        MouseArea {
            anchors.fill: parent
        }

        Text {
            id: warning
            text: "This is only a preview of the user interface without any real trading functionality. You will NOT be able to execute any trades."
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            width: parent.width - 56
            color: themecolor
            font.pixelSize: 16
            font.family: xciteMobile.name
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -50
        }

        Rectangle {
            id: okButton
            z: 3
            width: (parent.width - 56)/2
            height: 34
            color: maincolor
            opacity: 0.5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: warning.bottom
            anchors.topMargin: 15

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (exchangeNotifTracker == 1) {
                        exchangeNotifTracker = 0
                    }
                }
            }
        }

        Rectangle {
            z: 3
            width: (parent.width - 56)/2
            height: 34
            color: "transparent"
            border.color: maincolor
            border.width: 1
            anchors.left: okButton.left
            anchors.top: okButton.top
        }

        Label {
            id: okBtnLabel
            z: 3
            text: "UNDERSTOOD"
            color: maincolor
            font.pixelSize: 16
            font.family: xciteMobile.name
            anchors.horizontalCenter: okButton.horizontalCenter
            anchors.verticalCenter: okButton.verticalCenter
        }
    }

    /*
    Image {
        id: underConstruction
        source: darktheme === true? 'qrc:/icons/mobile/construction-icon_01_white.svg' : 'qrc:/icons/mobile/construction-icon_01_black.svg'
        width: 100
        height: 100
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        anchors.horizontalCenter: parent.horizontalCenter
    }
    */
}
