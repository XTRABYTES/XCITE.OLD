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
        newCoinPicklist = 0
        newCoin2Picklist = 3
        xchangePageTracker = 0
        if (xchangeTracker == 1) {

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
    property int myCoin: xchangeTracker == 1? newCoinPicklist : 0
    property int exchangeCoin: xchangeTracker == 1? newCoin2Picklist : 3
    property int orderTracker: 0
    property int orderType: 0
    property int tradeTracker: 0

    Text {
        id: xchangeModalLabel
        text: "X-CHANGE"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }
    /*
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
            }

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

            Rectangle {
                id: tradeHeader
                z: 4
                width: parent.width
                height: 100
                color: bgcolor
            }

            Rectangle {
                id: chartTradeBar
                z: 4
                width: parent.width
                height: 30
                color: "black"
                anchors.top: tradeHeader.bottom
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

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            if (tradeTracker == 0) {
                                tradeTracker = 1
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
                height: 145
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: chartTradeBar.bottom
                state: tradeTracker == 1 || chartTracker == 1? "down" : "up"

                states: [
                    State {
                        name: "up"
                        PropertyChanges { target: tradeChartArea; anchors.topMargin: -(tradeChartArea.height)}
                    },
                    State {
                        name: "down"
                        PropertyChanges { target: tradeChartArea; anchors.topMargin: 10}
                    }
                ]

                transitions: [
                    Transition {
                        from: "*"
                        to: "*"
                        NumberAnimation { target: tradeChartArea; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
                    }
                ]
            }

            Image {
                id: chart
                z: 3
                source: "qrc:/icons/mobile/chart_example.svg"
                width: parent.width - 56
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: chartTradeBar.bottom
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
                        PropertyChanges { target: chart; anchors.topMargin: 10}
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
                id: tradeList
                z: 3
                width: parent.width
                height: 145
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: chartTradeBar.bottom
                state: tradeTracker == 0? "up" : "down"

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

                states: [
                    State {
                        name: "up"
                        PropertyChanges { target: tradeList; anchors.topMargin: -(tradeList.height + 10)}
                    },
                    State {
                        name: "down"
                        PropertyChanges { target: tradeList; anchors.topMargin: 10}
                    }
                ]

                transitions: [
                    Transition {
                        from: "*"
                        to: "*"
                        NumberAnimation { target: tradeList; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
                    }
                ]
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
                anchors.top: tradeChartArea.bottom
                anchors.topMargin: 15
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
                anchors.topMargin: 15
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
                anchors.top: tradeChartArea.bottom
                anchors.topMargin: 15
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
                anchors.topMargin: 10
            }

            Label {
                id: balanceLabel
                z: 3
                text: "AVAILABLE BALANCE:"
                color: themecolor
                font.pixelSize: 13
                font.family: xciteMobile.name
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: highLabel.bottom
                anchors.topMargin: 15
            }

            Label {
                id: coin1Label
                z: 3
                text: coinName.text + ":"
                color: themecolor
                font.pixelSize: 13
                font.family: xciteMobile.name
                anchors.left: lowLabel.left
                anchors.top: balanceLabel.bottom
                anchors.topMargin: 10
            }

            Label {
                id: coin2Label
                z: 3
                text: coin2Name.text + ":"
                color: themecolor
                font.pixelSize: 13
                font.family: xciteMobile.name
                anchors.left: highLabel.left
                anchors.top: balanceLabel.bottom
                anchors.topMargin: 10
            }

            Rectangle {
                id: limitButton
                z: 3
                width: (parent.width - 110)/2
                height: 34
                color: "transparent"
                border.color: orderType == 0? themecolor : "#757575"
                border.width: 1
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.top: balanceLabel.bottom
                anchors.topMargin: 38

                Label {
                    id: limitBtnLabel
                    text: "LIMIT"
                    color: orderType == 0? themecolor : "#757575"
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
                border.color: orderType == 1? themecolor : "#757575"
                border.width: 1
                anchors.right: parent.right
                anchors.rightMargin: 50
                anchors.top: balanceLabel.bottom
                anchors.topMargin: 38

                Label {
                    id: marketBtnLabel
                    text: "MARKET"
                    color: orderType == 1? themecolor : "#757575"
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
                readOnly: orderType == 0? true : false
            }

            Mobile.AmountInput {
                id: feeField
                z: 3
                width: parent.width - 100
                placeholder: "FEE (XFUEL)"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rateField.bottom
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
        }
    }

    Rectangle {
        id: xchangeHeader
        z: 6
        width: parent.width
        height: 100
        color: "transparent"

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
                id: trading
                text: "TRADES"
                font.pixelSize: 12
                font.family: xciteMobile.name
                color: view.currentIndex == 1 ? "#757575" : maincolor
                font.bold: true

                Rectangle {
                    id: titleLine
                    width: trading.width
                    height: 2
                    color: maincolor
                    anchors.top: trading.bottom
                    anchors.left: trading.left
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
                id: balances
                text: "BUY/SELL"
                font.pixelSize: 12
                font.family: xciteMobile.name
                color: view.currentIndex == 0 ? "#757575" : maincolor
                font.bold: true

                Rectangle {
                    id: titleLine2
                    width: balances.width
                    height: 2
                    color: maincolor
                    anchors.top: balances.bottom
                    anchors.left: balances.left
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
            anchors.bottomMargin: 5
            visible: coin1Tracker == 0
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

        Label {
            id: orders
            z: 4
            text: orderTracker == 0? "OPEN ORDERS" : "HISTORY"
            font.pixelSize: 13
            font.family: xciteMobile.name
            color: themecolor
            anchors.right: parent.right
            anchors.rightMargin:28
            anchors.bottom: xchangeHeader.bottom
            anchors.bottomMargin: 5
            font.bold: false
            visible: exchangePageTracker == 0
        }

        Rectangle {
            id: ordersButton
            z: 4
            anchors.left: orders.left
            anchors.right: orders.right
            height: orders.height
            anchors.verticalCenter: orders.verticalCenter
            color: "transparent"
            visible: exchangePageTracker == 0

            MouseArea {
                anchors.fill: ordersButton

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (orderTracker == 1) {
                        orderTracker = 0
                    }
                    else {
                        orderTracker = 1
                    }
                }
            }
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
            anchors.bottomMargin: 5
            visible: exchangePageTracker == 1 && coin2Tracker == 0
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
    */
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
}
