/**
 * Filename: DashboardForm.qml
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
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtMultimedia 5.8
import QZXing 2.3

import "./Controls" as Controls


/**
  * Main page
  */
Item {
    property int sw: -1
    property int appsTracker: 0
    property int transferTracker: 0
    property int addressBookTracker: 0
    property int scanQRCodeTracker: 0
    property int historyTracker: 0
    property int transactionSentTracker: 0
    property int transactionConfirmTracker: 0
    property int coinHistoryA1: 1
    property int coinHistoryA2:1
    property int clickedSquare: 0
    property int clickedSquare2: 0
    property int clickedSquare3: 0
    property int clickedSquare4: 0
    property int clickedSquare5: 0
    property int clickedSquare6: 0
    property string address1: "B5xiknaGNK330s9gyU4riyKuVzvIOPEVz6"
    property string address2: "B2QiknazjkA30s9gyV4riyKuVWvUMXEVss"
    property string address3: "B09iknaFAFKA30s392J4riyKuVWvUMXEV3"
    property string address4: "BxkiknaGNKA30s9gyV4riyKuVWvFJKEVq9"

    z: 2
    id: dashForm
    Rectangle {
        id: bottomRect
        z: 100
        color: "#2A2C31"
        opacity: 0.8
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: parent.width
        height: 50
    }
    Rectangle {
        color: "black"
        opacity: .8
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height
        width: parent.width
        z: 5
        visible: appsTracker == 1 || transferTracker == 1 || historyTracker == 1
    }
    Rectangle {
        color: "#34363D"
        anchors.top: transfer.bottom
        anchors.topMargin: 14
        anchors.left: parent.left
        height: parent.height
        width: parent.width
        z: 0
        visible: true
    }

    Loader {
        id: pageLoader
    }

    RowLayout {
        id: headingLayout
        anchors.top: dashForm.top
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        Label {
            id: overview
            text: "OVERVIEW"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            font.bold: true
            color: "#5E8BFE"
            Rectangle {
                id: titleLine
                width: overview.width
                height: 2
                color: "#5E8BFE"
                anchors.top: overview.bottom
                anchors.left: overview.left
                anchors.topMargin: 2
            }
        }
        Label {
            id: add5
            text: "ADDRESS BOOK"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#757575"
            font.bold: true
            MouseArea {
                anchors.fill: add5
                onClicked: mainRoot.push("MobileAddressBook.qml")
            }
        }
    }

    Image {
        id: notif
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.verticalCenter: headingLayout.verticalCenter
        source: '../icons/notification_icon_03.svg'
        width: 30
        height: 30
        ColorOverlay {
            anchors.fill: notif
            source: notif
            color: "#5E8BFF"
        }
    }

    Label {
        id: value
        anchors.top: parent.top
        anchors.topMargin: 62
        //anchors.left: transfer.left
        anchors.horizontalCenter: dashForm.horizontalCenter
        text: "$" + (wallet.balance * marketValue.marketValue).toLocaleString(
                  Qt.locale(), "f", 2)
        font.pixelSize: 40
        font.family: "Brandon Grotesque"
        color: "#E5E5E5"
    }
    /**
    Switch {
        id: switch1
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 90
        visible: transferTracker != 1
        width: 50
        height: 20

        transform: Rotation {
            origin.x: 25
            origin.y: 25
            angle: 90
        }
    }
    Label {
        id: week1
        text: "WEEK"
        font.pixelSize: 11
        font.bold: true
        font.family: "Brandon Grotesque"
        color: switch1.checked ? "#5F5F5F" : "#5E8BFE"
        anchors.right: switch1.left
        anchors.rightMargin: -5
        anchors.top: switch1.top
        anchors.topMargin: 40
    }
    Label {
        id: month1
        text: "MONTH"
        font.pixelSize: 11
        font.bold: true
        font.family: "Brandon Grotesque"
        color: switch1.checked ? "#5E8BFE" : "#5F5F5F"
        anchors.right: switch1.left
        anchors.leftMargin: 2
        anchors.bottom:switch1.bottom
    }
    */
    Label {
        id: transfer
        text: "TRANSFER"
        font.pixelSize: 13
        font.family: "Brandon Grotesque"
        color: "#C7C7C7"
        anchors.left: square1.left
        anchors.bottom: square1.top
        anchors.bottomMargin: 30
        font.bold: true
        Image {
            id: transfer2
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.right
            anchors.leftMargin: 8
            source: '../icons/transfer_icon.svg'
            width: 18
            height: 18
            ColorOverlay {
                anchors.fill: transfer2
                source: transfer2
                color: "#5E8BFF"
            }
            MouseArea {
                anchors.fill: transfer2
                onClicked: {
                    transferTracker = 1
                }
            }
        }
    }

    Label {
        id: addCoin
        text: "ADD COIN"
        font.pixelSize: 13
        font.family: "Brandon Grotesque"
        color: "#C7C7C7"
        anchors.right: square1.right
        anchors.bottom: square1.top
        anchors.bottomMargin: 30
        anchors.rightMargin: 24
        font.bold: true
        Image {
            id: plus
            anchors.verticalCenter: addCoin.verticalCenter
            anchors.left: parent.right
            anchors.leftMargin: 8
            source: '../icons/add_icon_03.svg'
            width: 18
            height: 18
            ColorOverlay {
                anchors.fill: plus
                source: plus
                color: "#5E8BFF"
            }
        }
    }
    Controls.CurrencySquare {
        id: square1
        anchors.top: parent.top
        // 210
        anchors.topMargin: 165
        anchors.left: parent.left
        anchors.leftMargin: 25
        currencyType: '../icons/XBY_card_logo_colored_05.svg'
        currencyType2: "XBY"
        percentChange: "+%.8"
        gainLossTracker: 1
        height: clickedSquare == 1 ? 166 : 75
        value: ((marketValue.marketValue*100)/100).toLocaleString(
                   Qt.locale(), "f", 4)
        // since expandbutton is very tiny and hard to click we put an invisible rectangle here to mimic the dots
        Rectangle {
            id: expandButtonArea
            width: 40
            height: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -5
            color: "transparent"

            MouseArea {
                anchors.fill: expandButtonArea
                onClicked: {
                    if (clickedSquare == 1) {
                        clickedSquare = 0
                        return
                    }
                    if (clickedSquare == 0) {
                        clickedSquare = 1
                        clickedSquare5 = 0
                        clickedSquare4 = 0
                        clickedSquare3 = 0
                        clickedSquare2 = 0
                        return
                    }
                }
            }
        }
        Image {
            id: expandButton
            width: 25
            height: 5
            anchors.horizontalCenter: expandButtonArea.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }

        /**
          * Visible when square is clicked
          */
        Rectangle {
            id: dividerLine
            visible: clickedSquare == 1 ? true : false
            width: parent.width - 20
            height: 1
            color: "#575757"
            anchors.top: parent.top
            anchors.topMargin: 75
            anchors.horizontalCenter: parent.horizontalCenter
        }
        /**
        Text {
            text: "Unconfirmed 55.42 XBY"
            font.family: "Brandon Grotesque"
            font.pointSize: 12
            font.italic: true
            color: "#919191"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: dividerLine.top
            anchors.bottomMargin: 2
            visible: clickedSquare == 1 ? true : false
        }
        */
        Rectangle {
            id: transferButton
            visible: clickedSquare == 1 && transferTracker != 1
            width: (parent.width/2) - 15
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine.bottom
            anchors.right: expandButton.horizontalCenter
            anchors.rightMargin: 5
            anchors.topMargin: 15
            MouseArea {
                anchors.fill: transferButton
                onClicked: {
                    transferTracker = 1
                }
            }
            Text {
                text: "TRANSFER"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: historyButton
            visible: clickedSquare == 1 && transferTracker != 1
            width: transferButton.width
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine.bottom
            anchors.left: expandButton.horizontalCenter
            anchors.leftMargin: 5
            anchors.topMargin: 15
            MouseArea {
                anchors.fill: historyButton
                onClicked: {
                    historyTracker = 1
                }
            }
            Text {
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
    Controls.CurrencySquare {
        id: square2
        anchors.top: square1.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        currencyType: '../icons/XFUEL_card_logo_colored_07.svg'
        currencyType2: "XFUEL"
        percentChange: "+0%"
        gainLossTracker: 0
        amountSize: "0"
        totalValue: "0"
        value: "0"
        height: clickedSquare2 == 1 ? 166 : 75
        // since expandbutton is very tiny and hard to click we put an invisible rectangle here to mimic the dots
        Rectangle {
            id: expandButtonArea2
            width: 40
            height: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -5
            color: "transparent"
            MouseArea {
                anchors.fill: expandButtonArea2
                /**
                  * disable for now while only XBY can be traded
                onClicked: {
                    if (clickedSquare2 == 1) {
                        clickedSquare2 = 0
                        return
                    }
                    if (clickedSquare2 == 0) {
                        clickedSquare = 0
                        clickedSquare5 = 0
                        clickedSquare4 = 0
                        clickedSquare3 = 0
                        clickedSquare2 = 1
                        return
                    }
                }
                */
            }
        }
        Image {
            id: expandButton2
            width: 25
            height: 5
            anchors.horizontalCenter: expandButtonArea2.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }

        /**
          * Visible when square is clicked
          */
        Rectangle {
            id: dividerLine2
            visible: clickedSquare2 == 1 ? true : false
            width: parent.width - 20
            height: 1
            color: "#575757"
            anchors.top: parent.top
            anchors.topMargin: 75
            anchors.horizontalCenter: parent.horizontalCenter
        }
        /**
        Text {
            text: "Unconfirmed 55.42 XFUEL"
            font.family: "Brandon Grotesque"
            font.pointSize: 12
            font.italic: true
            color: "#919191"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: dividerLine2.top
            visible: clickedSquare2 == 1 ? true : false
        }
        */
        Rectangle {
            id: transferButton2
            visible: clickedSquare2 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine2.bottom
            anchors.left: dividerLine2.left
            anchors.topMargin: 15
            Text {
                text: "TRANSFER"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: historyButton2
            visible: clickedSquare2 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine2.bottom
            anchors.right: dividerLine2.right
            anchors.topMargin: 15
            Text {
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Controls.CurrencySquare {
        id: square3
        anchors.top: square2.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        currencyType: '../icons/BTC-color.svg'
        currencyType2: "BTC"
        percentChange: "+0%"
        gainLossTracker: 0
        amountSize: "0"
        totalValue: "0"
        value: "0"
        height: clickedSquare3 == 1 ? 166 : 75
        Rectangle {
            id: expandButtonArea3
            width: 40
            height: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -5
            color: "transparent"

            MouseArea {
                anchors.fill: expandButtonArea3
                /**
                  * disable for now while only XBY can be traded
                onClicked: {
                    if (clickedSquare3 == 1) {
                        clickedSquare3 = 0
                        return
                    }
                    if (clickedSquare3 == 0) {
                        clickedSquare3 = 1
                        clickedSquare5 = 0
                        clickedSquare4 = 0
                        clickedSquare = 0
                        clickedSquare2 = 0
                        return
                    }
                }
                */
            }
        }
        Image {
            id: expandButton3
            width: 25
            height: 5
            anchors.horizontalCenter: expandButtonArea3.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }

        /**
          * Visible when square is clicked
          */
        Rectangle {
            id: dividerLine3
            visible: clickedSquare3 == 1 ? true : false
            width: parent.width - 20
            height: 1
            color: "#575757"
            anchors.top: parent.top
            anchors.topMargin: 75
            anchors.horizontalCenter: parent.horizontalCenter
        }
        /**
        Text {
            text: "Unconfirmed 55.42 BTC"
            font.family: "Brandon Grotesque"
            font.pointSize: 12
            font.italic: true
            color: "#919191"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: dividerLine3.top
            visible: clickedSquare3 == 1 ? true : false
        }
        */
        Rectangle {
            id: transferButton3
            visible: clickedSquare3 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine3.bottom
            anchors.left: dividerLine3.left
            anchors.topMargin: 15
            Text {
                text: "TRANSFER"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: historyButton3
            visible: clickedSquare3 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine3.bottom
            anchors.right: dividerLine3.right
            anchors.topMargin: 15
            Text {
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Controls.CurrencySquare {
        id: square4
        anchors.top: square3.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        currencyType: '../icons/ETH-color.svg'
        currencyType2: "ETH"
        percentChange: "+0%"
        gainLossTracker: 0
        amountSize: "0"
        totalValue: "0"
        value: "0"
        height: clickedSquare4 == 1 ? 166 : 75
        z: 0
        Rectangle {
            id: expandButtonArea4
            width: 40
            height: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -5
            color: "transparent"

            MouseArea {
                anchors.fill: expandButtonArea4
                /**
                  * disable for now while only XBY can be traded
                onClicked: {
                    if (clickedSquare4 == 1) {
                        clickedSquare4 = 0
                        return
                    }
                    if (clickedSquare4 == 0) {
                        clickedSquare3 = 0
                        clickedSquare5 = 0
                        clickedSquare4 = 1
                        clickedSquare = 0
                        clickedSquare2 = 0
                        return
                    }
                }
                */
            }
        }
        Image {
            id: expandButton4
            width: 25
            height: 5
            anchors.horizontalCenter: expandButtonArea4.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }

        /**
          * Visible when square is clicked
          */
        Rectangle {
            id: dividerLine4
            visible: clickedSquare4 == 1 ? true : false
            width: parent.width - 20
            height: 1
            color: "#575757"
            anchors.top: parent.top
            anchors.topMargin: 75
            anchors.horizontalCenter: parent.horizontalCenter
        }
        /**
        Text {
            text: "Unconfirmed 55.42 ETH"
            font.family: "Brandon Grotesque"
            font.pointSize: 12
            font.italic: true
            color: "#919191"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: dividerLine4.top
            visible: clickedSquare4 == 1 ? true : false
        }
        */
        Rectangle {
            id: transferButton4
            visible: clickedSquare4 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine4.bottom
            anchors.left: dividerLine4.left
            anchors.topMargin: 15
            /**
            MouseArea {
                anchors.fill: transferButton4
                onClicked: {
                    transferTracker = 1
                }
            }
            */
            Text {
                text: "TRANSFER"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: historyButton4
            visible: clickedSquare4 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine4.bottom
            anchors.right: dividerLine4.right
            anchors.topMargin: 15
            Text {
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Controls.CurrencySquare {
        id: square5
        anchors.top: square4.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        currencyType: '../icons/NEO_card_logo_colored_02.svg'
        currencyType2: "NEO"
        percentChange: "+0%"
        gainLossTracker: 0
        amountSize: "0"
        totalValue: "0"
        value: "0"
        height: clickedSquare5 == 1 ? 166 : 75
        z: 0
        Rectangle {
            id: expandButtonArea5
            width: 40
            height: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -5
            color: "transparent"

            MouseArea {
                anchors.fill: expandButtonArea5
                /**
                  * disable for now while only XBY can be traded
                onClicked: {
                    if (clickedSquare5 == 1) {
                        clickedSquare5 = 0
                        return
                    }
                    if (clickedSquare5 == 0) {
                        clickedSquare3 = 0
                        clickedSquare5 = 1
                        clickedSquare4 = 0
                        clickedSquare = 0
                        clickedSquare2 = 0
                        return
                    }
                }
                */
            }
        }

        Image {
            id: expandButton5
            width: 25
            height: 5
            anchors.horizontalCenter: expandButtonArea5.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }
        /**
          * Visible when square is clicked
          */
        Rectangle {
            id: dividerLine5
            visible: clickedSquare5 == 1 ? true : false
            width: parent.width - 20
            height: 1
            color: "#575757"
            anchors.top: parent.top
            anchors.topMargin: 75
            anchors.horizontalCenter: parent.horizontalCenter
        }
        /**
        Text {
            text: "Unconfirmed 55.42 NEO"
            font.family: "Brandon Grotesque"
            font.pointSize: 12
            font.italic: true
            color: "#919191"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: dividerLine5.top
            visible: clickedSquare5 == 1 ? true : false
        }
        */
        Rectangle {
            id: transferButton5
            visible: clickedSquare5 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine5.bottom
            anchors.left: dividerLine5.left
            anchors.topMargin: 15
            /**
            MouseArea {
                anchors.fill: transferButton5
                onClicked: {
                    transferTracker = 1
                }
            }
            */
            Text {
                text: "TRANSFER"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: historyButton5
            visible: clickedSquare5 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine5.bottom
            anchors.right: dividerLine5.right
            anchors.topMargin: 15
            Text {
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Image {
        id: settings
        anchors.verticalCenter: bottomRect.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 30
        source: '../icons/icon-settings.svg'
        width: 23
        height: 23
        z: 100
        MouseArea {
            anchors.fill: settings
            onClicked: mainRoot.push("Settings.qml")
        }
        ColorOverlay {
            anchors.fill: settings
            source: settings
            color: "#5E8BFF"
        }
    }
    Image {
        id: apps
        source: '../icons/Apps_icon_03.svg'
        anchors.verticalCenter: bottomRect.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 30
        width: 23
        height: 23
        z: 100
        visible: appsTracker == 0
        ColorOverlay {
            anchors.fill: apps
            source: apps
            color: "#5E8BFF"
        }
        MouseArea {
            anchors.fill: apps
            onClicked: appsTracker = 1
        }
    }

    Image {
        id: closeApps
        source: '../icons/CloseIcon.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 30
        width: 20
        height: 20
        z: 100
        visible: appsTracker == 1
        ColorOverlay {
            anchors.fill: closeApps
            source: closeApps
            color: "#5E8BFF" // make image like it lays under grey glass
        }
        Rectangle {
            id: closeAppsButtonArea
            width: 20
            height: 20
            anchors.left: closeApps.left
            anchors.bottom: closeApps.bottom
            color: "transparent"
            MouseArea {
                anchors.fill: closeAppsButtonArea
                onClicked: appsTracker = 0
            }
        }
    }
    Image {
        id: xchangeLink
        source: '../icons/XCHANGE_02.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 90
        anchors.right: parent.right
        anchors.rightMargin: 20
        width: 40
        height: 40
        z: 100
        visible: appsTracker == 1
        ColorOverlay {
            anchors.fill: xchangeLink
            source: xchangeLink
            color: "#5E8BFF" // make image like it lays under grey glass
        }
        Text {
            text: "X-CHANGE"
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#5E8BFF"
            font.family: "Brandon Grotesque"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }
        Rectangle {
            id: xchangeButtonArea
            width: xchangeLink.width
            height: xchangeLink.height
            anchors.left: xchangeLink.left
            anchors.bottom: xchangeLink.bottom
            color: "transparent"
            MouseArea {
                anchors.fill: xchangeButtonArea
                onClicked: mainRoot.push("xchange.qml")
            }
        }
    }

    Image {
        id: xvaultLink
        source: '../icons/XVAULT_02.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 160
        anchors.right: parent.right
        anchors.rightMargin: 20
        width: 40
        height: 40
        z: 100
        visible: appsTracker == 1
        ColorOverlay {
            anchors.fill: xvaultLink
            source: xvaultLink
            color: "#5E8BFF"
        }
        Text {
            text: "X-VAULT"
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#5E8BFF"
            font.family: "Brandon Grotesque"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }
    }

    Image {
        id: xchatLink
        source: '../icons/XCHAT_02.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 230
        anchors.right: parent.right
        anchors.rightMargin: 20
        width: 40
        height: 40
        z: 100
        visible: appsTracker == 1
        ColorOverlay {
            anchors.fill: xchatLink
            source: xchatLink
            color: "#5E8BFF"
        }
        Text {
            text: "X-CHAT"
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#5E8BFF"
            font.family: "Brandon Grotesque"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }
    }

    /**
      * Transfer Modal popup
      */
    Rectangle {
        id: modal
        // parent.height > 800 ? (parent.height - 400) :
        height: 425
        // parent.width - 50
        width: 325
        color: "#42454F"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 125
        visible: transferTracker == 1 && addressBookTracker != 1
                 && scanQRCodeTracker != 1 && transactionConfirmTracker != 1 && transactionSentTracker != 1
        radius: 4
        z: 100

        Rectangle {
            id: modalTop
            height: 50
            width: modal.width
            anchors.top: modal.top
            anchors.left: modal.left
            color: "#34363D"
            radius: 4
            Text {
                text: "TRANSFER"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#F2F2F2"
                font.family: "Brandon Grotesque"
                font.bold: true
                font.pixelSize: 15
            }
            Image {
                id: closeModal
                source: '../icons/CloseIcon.svg'
                anchors.bottom: modalTop.bottom
                anchors.bottomMargin: 15
                anchors.right: modalTop.right
                anchors.rightMargin: 30
                width: 20
                height: 20
                ColorOverlay {
                    anchors.fill: closeModal
                    source: closeModal
                    color: "white"
                }
                Rectangle {
                    id: closeModalButtonArea
                    width: 20
                    height: 20
                    anchors.left: closeModal.left
                    anchors.bottom: closeModal.bottom
                    color: "transparent"
                    MouseArea {
                        anchors.fill: closeModalButtonArea
                        onClicked:{
                            transferTracker = 0
                            sendAmount.text = ""
                            keyInput.text = ""
                            referenceInput.text = ""
                        }
                    }
                }
            }
        }
        Controls.Switch {
            id: transferSwitch
            anchors.horizontalCenter: modal.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 60

            Text {
                id: receiveText
                text: qsTr("RECEIVE")
                anchors.right: transferSwitch.left
                anchors.rightMargin: 7
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 13
                color: transferSwitch.on ? "#5F5F5F" : "#5E8BFE"
            }
            Text {
                id: sendText
                text: qsTr("SEND")
                anchors.left: transferSwitch.right
                anchors.leftMargin: 7
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 13
                color: transferSwitch.on ? "#5E8BFE" : "#5F5F5F"
            }
        }

        /**
          * Transfer Modal both send & receive
          */
        Image {
            id: currencyIcon
            source: '../icons/XBY_card_logo_colored_05.svg'
            width: 25
            height: 25
            anchors.left: sendAmount.left
            anchors.top: modal.top
            anchors.topMargin: 100
            visible: transferTracker == 1
            Label {
                id: currencyIconChild
                text: "XBY"
                anchors.left: currencyIcon.right
                anchors.leftMargin: 10
                color: "#E5E5E5"
                font.bold: true
                anchors.verticalCenter: currencyIcon.verticalCenter
            }
            Image {
                source: '../icons/dropdown_icon.svg'
                width: 15
                height: 15
                anchors.left: currencyIconChild.right
                anchors.leftMargin: 8
                anchors.verticalCenter: currencyIconChild.verticalCenter
                visible: transferTracker == 1
            }
        }
        Label {
            id: walletChoice
            text: "MAIN"
            anchors.right: walletDropdown.left
            anchors.rightMargin: 8
            anchors.verticalCenter: currencyIcon.verticalCenter
            color: "#E5E5E5"
            font.bold: true
            visible: transferTracker == 1
        }
        Image {
            id: walletDropdown
            source: '../icons/dropdown_icon.svg'
            width: 15
            height: 15
            anchors.right: sendAmount.right
            anchors.verticalCenter: walletChoice.verticalCenter
            visible: transferTracker == 1
        }
        /**
          * Transfer modal receive state
          */
        Item {
            id: qrPlaceholder
            width: 180
            height: 170
            anchors.horizontalCenter: qrBorder.horizontalCenter
            anchors.verticalCenter: qrBorder.verticalCenter
            z: 10
            visible: transferSwitch.on === false && transferTracker == 1
            Image {
                anchors.fill: parent
                source: "image://QZXing/encode/" + publicKey.text
                cache: false
            }
        }
        Rectangle {
            id: qrBorder
            radius: 8
            width: 210
            height: 200
            visible: transferSwitch.on === false && transferTracker == 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: currencyIcon.bottom
            anchors.topMargin: 20
            color: "white"
        }

        Text {
            id: pubKey
            text: "PUBLIC KEY"
            anchors.top: qrBorder.bottom
            anchors.topMargin: 21
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: true
            font.pixelSize: 13
            visible: transferSwitch.on ===  false && transferTracker == 1
        }
        Text {
            id: publicKey
            text: receivingAddress
            anchors.top: pubKey.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: pubKey.horizontalCenter
            color: "white"
            font.family: "Brandon Grotesque"
            font.pixelSize: 12
            visible: transferSwitch.on ===  false && transferTracker == 1
        }
        Image {
            id: pasteIcon
            source: '../icons/paste_icon.svg'
            width: 15
            height: 15
            anchors.left: publicKey.right
            anchors.leftMargin: 5
            anchors.verticalCenter: publicKey.verticalCenter
            visible: transferSwitch.on ===  false && transferTracker == 1
            ColorOverlay {
                anchors.fill: pasteIcon
                source: pasteIcon
                color: "white" // make image like it lays under grey glass
            }
        }

        /**
          * Transfer modal send state
          */
        Label {
            id: walletBalance
            text: wallet.balance.toLocaleString(
                      Qt.locale(), "f", 4) + " XBY"
            anchors.right: walletDropdown.right
            anchors.rightMargin: 0
            anchors.top: walletChoice.bottom
            anchors.topMargin: 1
            color: "#E5E5E5"
            font.bold: true
            font.pixelSize: 10
            visible: transferTracker == 1 && transferSwitch.on ===  true
        }
        Controls.TextInput {
            id: sendAmount
            height: 34
            placeholder: "AMOUNT (XBY)"
            validator: DoubleValidator {
                bottom: 0
            }
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: currencyIcon.bottom
            anchors.topMargin: 15
            visible: transferTracker == 1 && transferSwitch.on ===  true
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            mobile: 1
        }
        Image {
            id: textFieldEmpty3
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: sendAmount.verticalCenter
            anchors.right: sendAmount.right
            anchors.rightMargin: 10
            width: textFieldEmpty3.height
            height: 12
            visible: transferTracker == 1 && transferSwitch.on ===  true
            ColorOverlay {
                anchors.fill: textFieldEmpty3
                source: textFieldEmpty3
                color: "#727272"
            }
            Rectangle {
                id: textFieldEmpty3ButtonArea
                width: 20
                height: 20
                anchors.left: textFieldEmpty3.left
                anchors.bottom: textFieldEmpty3.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: textFieldEmpty3ButtonArea
                    onClicked: {
                        sendAmount.text = ""
                    }
                }
            }
        }
        Controls.TextInput {
            id: keyInput
            height: 34
            placeholder: "SEND TO (PUBLIC KEY)"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: sendAmount.bottom
            anchors.topMargin: 15
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: transferTracker == 1 && transferSwitch.on ===  true
            mobile: 1
        }
        Image {
            id: textFieldEmpty1
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput.verticalCenter
            anchors.right: keyInput.right
            anchors.rightMargin: 10
            width: textFieldEmpty1.height
            height: 12
            visible: transferTracker == 1 && transferSwitch.on ===  true
            ColorOverlay {
                anchors.fill: textFieldEmpty1
                source: textFieldEmpty1
                color: "#727272" // make image like it lays under grey glass
            }
            Rectangle {
                id: textFieldEmpty1ButtonArea
                width: 20
                height: 20
                anchors.left: textFieldEmpty1.left
                anchors.bottom: textFieldEmpty1.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: textFieldEmpty1ButtonArea
                    onClicked: {
                        keyInput.text = ""
                    }
                }
            }
        }
        Rectangle {
            id: scanQrButton
            visible: transferTracker == 1 && transferSwitch.on ===  true
            width: (keyInput.width / 2) - 3
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: keyInput.bottom
            anchors.topMargin: 15
            anchors.left: keyInput.left
            MouseArea {
                anchors.fill: scanQrButton
                onClicked: {
                    scanQRCodeTracker = 1
                }
            }
            Text {
                text: "SCAN QR"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#5E8BFF"
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: addressBookButton
            visible: transferTracker == 1 && transferSwitch.on ===  true
            width: (keyInput.width / 2) - 3
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: keyInput.bottom
            anchors.topMargin: 15
            anchors.right: keyInput.right
            MouseArea {
                anchors.fill: addressBookButton

                onClicked: {
                    addressBookTracker = 1
                }
            }
            Text {
                text: "ADDRESS BOOK"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Controls.TextInput {
            id: referenceInput
            height: 34
            placeholder: "REFERENCE"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: scanQrButton.bottom
            anchors.topMargin: 15
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: transferTracker == 1 && transferSwitch.on ===  true
            mobile: 1
        }
        Image {
            id: textFieldEmpty2
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: referenceInput.verticalCenter
            anchors.right: referenceInput.right
            anchors.rightMargin: 10
            width: textFieldEmpty2.height
            height: 12
            visible: transferTracker == 1 && transferSwitch.on ===  true
            ColorOverlay {
                anchors.fill: textFieldEmpty2
                source: textFieldEmpty2
                color: "#727272"
            }
            Rectangle {
                id: textFieldEmpty2ButtonArea
                width: 20
                height: 20
                anchors.left: textFieldEmpty2.left
                anchors.bottom: textFieldEmpty2.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: textFieldEmpty2ButtonArea
                    onClicked: {
                        referenceInput.text = ""
                    }
                }
            }
        }
        Rectangle {
            id: sendButton
            visible: transferTracker == 1 && transferSwitch.on ===  true
            width: keyInput.width
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: referenceInput.bottom
            anchors.topMargin: 35
            anchors.left: referenceInput.left
            MouseArea {
                anchors.fill: sendButton

                onClicked: {
                    transactionConfirmTracker = 1
                }
            }
            Text {
                text: "SEND"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    /**
      * Modal for confirming your transaction
    */
    Rectangle {
        id: transactionConfirmationModal
        // parent.height > 800 ? (parent.height - 400) :
        height: 300
        // parent.width - 50
        width: 325
        color: "#42454F"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
        visible: transactionConfirmTracker == 1
        radius: 4
        z: 300

        Rectangle {
            id: transactionConfirmationModalTop
            height: 50
            width: transactionConfirmationModal.width
            anchors.top: transactionConfirmationModal.top
            anchors.left: transactionConfirmationModal.left
            color: "#34363D"
            radius: 4

            Text {
                text: "TRANSFER"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#F2F2F2"
                font.family: "Brandon Grotesque"
                font.bold: true
                font.pixelSize: 15
            }
            Image {
                id: transactionConfirmationCloseModal
                source: '../icons/CloseIcon.svg'
                anchors.bottom: transactionConfirmationModalTop.bottom
                anchors.bottomMargin: 15
                anchors.right: transactionConfirmationModalTop.right
                anchors.rightMargin: 30
                width: 20
                height: 20
                ColorOverlay {
                    anchors.fill: transactionConfirmationCloseModal
                    source: transactionConfirmationCloseModal
                    color: "white"
                }
                Rectangle {
                    id: transactionConfirmationCloseModalButtonArea
                    width: 20
                    height: 20
                    anchors.left: transactionConfirmationCloseModal.left
                    anchors.bottom: transactionConfirmationCloseModal.bottom
                    color: "transparent"
                    MouseArea {
                        anchors.fill: transactionConfirmationCloseModalButtonArea
                        onClicked:{
                            transactionConfirmTracker = 0
                        }
                    }
                }
            }
        }
        Text {
            id: confirm
            text: "Confirm Payment"
            font.family: "Brandon Grotesque"
            font.pointSize: 15
            font.bold: false
            color: "#5E8BFF"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 65
        }
        Text {
            id: confirm2
            text: "You are about to send"
            font.family: "Brandon Grotesque"
            font.pointSize: 13
            font.bold: false
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: confirm.bottom
            anchors.topMargin: 30
        }
        Text {
            id: confirm3
            text: sendAmount.text + " XBY"
            font.family: "Brandon Grotesque"
            font.pointSize: 13
            font.bold: true
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: confirm2.bottom
            anchors.topMargin: 10
        }
        Text {
            id: confirm4
            text: "to"
            font.family: "Brandon Grotesque"
            font.pointSize: 13
            font.bold: false
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: confirm3.bottom
            anchors.topMargin: 20
        }
        Text {
            id: confirm5
            text: keyInput.text
            font.family: "Brandon Grotesque"
            font.pointSize: 13
            font.bold: true
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: confirm4.bottom
            anchors.topMargin: 20
        }
        Rectangle {
            id: confirmButton
            width: confirm5.width
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: confirm5.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: keyInput.text !== "" && keyInput.length === 34  && sendAmount.text !== "" && sendAmount.text !== "0" && sendAmount.text < wallet.balance
            MouseArea {
                anchors.fill: confirmButton

                onClicked: {
                    transactionSentTracker = 1
                    transactionConfirmTracker = 0
                }
            }
            Text {
                text: "CONFIRM"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: validationAlert
            width: 200
            height: 33
            radius: 8
            //red
            border.color: "#f45342"
            border.width: 2
            color: "transparent"
            anchors.top: confirm5.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: keyInput.text === "" || keyInput.length !== 34  || sendAmount.text === "" || sendAmount.text === "0" || sendAmount.text > wallet.balance
            MouseArea {
                anchors.fill: validationAlert

                onClicked: {
                    transactionSentTracker = 0
                    transactionConfirmTracker = 0
                }
            }
            Text {
                id: validationText
                text: "Invalid Amount or Key"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#f45342"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    /**
      * Modal for confirming transfer went through
      */
    Controls.TransactionSentModal{
        visible: transactionSentTracker == 1
        Rectangle {
            id: transactionSentClose
            width: (parent.height/4) + 40
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                anchors.fill: transactionSentClose

                onClicked: {
                    transactionSentTracker = 0
                    transferTracker = 1
                }
            }
            Text {
                text: "DONE"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    /**
      * AddressBookModal
      */
    Rectangle {
        id: addressBookModal
        height: 287
        // parent.width - 50
        width: 325
        color: "#42454F"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
        visible: addressBookTracker == 1
        radius: 4
        z: 155

        Rectangle {
            id: addressBookModalTop
            height: 50
            width: addressBookModal.width
            anchors.top: addressBookModal.top
            anchors.left: addressBookModal.left
            color: "#34363D"
            radius: 4
            Text {
                text: "ADDRESS BOOK"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#F2F2F2"
                font.family: "Brandon Grotesque"
                font.bold: true
                font.pixelSize: 15
            }
            Image {
                id: closeAddressBookModal
                source: '../icons/CloseIcon.svg'
                anchors.bottom: addressBookModalTop.bottom
                anchors.bottomMargin: 15
                anchors.right: addressBookModalTop.right
                anchors.rightMargin: 30
                width: 20
                height: 20
                ColorOverlay {
                    anchors.fill: closeAddressBookModal
                    source: closeAddressBookModal
                    color: "white" // make image like it lays under grey glass
                }
                Rectangle {
                    id: closeAddressBookModalButtonArea
                    width: 20
                    height: 20
                    anchors.left: closeAddressBookModal.left
                    anchors.bottom: closeAddressBookModal.bottom
                    color: "transparent"
                    MouseArea {
                        anchors.fill: closeAddressBookModalButtonArea
                        onClicked: addressBookTracker = 0
                    }
                }
            }
        }
        Image {
            id: addressIcon
            source: '../icons/XBY_card_logo_colored_05.svg'
            anchors.left: addressBookModal.left
            anchors.leftMargin: 30
            anchors.top: addressBookModal.top
            anchors.topMargin: 70
            width: 27
            height: 27
        }
        Text {
            id: addressIconName
            text: "XBY"
            anchors.verticalCenter: addressIcon.verticalCenter
            anchors.left: addressIcon.right
            anchors.leftMargin: 8
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: true
            font.pixelSize: 14
        }
        Image {
            source: '../icons/dropdown_icon.svg'
            width: 15
            height: 15
            anchors.left: addressIconName.right
            anchors.leftMargin: 8
            anchors.verticalCenter: addressIconName.verticalCenter
        }

        Rectangle {
            id: seperator1
            color: "#575757"
            height: 1
            width: parent.width - 50
            anchors.top: addressIcon.bottom
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: addressName1
            anchors.bottom: seperator1.top
            anchors.bottomMargin: 8
            anchors.left: seperator1.left
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Text {
            text: addressType1
            anchors.bottom: seperator1.top
            anchors.bottomMargin: 8
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Image {
            id: transferChoice1
            anchors.right: seperator1.right
            anchors.rightMargin: 10
            anchors.bottom: seperator1.top
            anchors.bottomMargin: 8
            source: '../icons/transfer_icon.svg'
            width: 14
            height: 14
            MouseArea {
                anchors.fill: transferChoice1
                onClicked: {
                    keyInput.text = receivingAddress
                    addressBookTracker = 0
                }
            }
        }
        Rectangle {
            id: seperator2
            color: "#575757"
            height: 1
            width: parent.width - 50
            anchors.top: seperator1.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: addressName2
            anchors.bottom: seperator2.top
            anchors.bottomMargin: 8
            anchors.left: seperator2.left
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Text {
            text: addressType2
            anchors.bottom: seperator2.top
            anchors.bottomMargin: 8
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Image {
            id: transferChoice2
            anchors.right: seperator2.right
            anchors.rightMargin: 10
            anchors.bottom: seperator2.top
            anchors.bottomMargin: 8
            source: '../icons/transfer_icon.svg'
            width: 14
            height: 14
            MouseArea {
                anchors.fill: transferChoice2
                onClicked: {
                    keyInput.text = receivingAddress2
                    addressBookTracker = 0
                }
            }
        }
        Rectangle {
            id: seperator3
            color: "#575757"
            height: 1
            width: parent.width - 50
            anchors.top: seperator2.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: addressName3
            anchors.bottom: seperator3.top
            anchors.bottomMargin: 8
            anchors.left: seperator3.left
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Text {
            text: addressType3
            anchors.bottom: seperator3.top
            anchors.bottomMargin: 8
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Image {
            id: transferChoice3
            anchors.right: seperator3.right
            anchors.rightMargin: 10
            anchors.bottom: seperator3.top
            anchors.bottomMargin: 8
            source: '../icons/transfer_icon.svg'
            width: 14
            height: 14
            MouseArea {
                anchors.fill: transferChoice3
                onClicked: {
                    keyInput.text = receivingAddress3
                    addressBookTracker = 0
                }
            }
        }
        Rectangle {
            id: seperator4
            color: "#575757"
            height: 1
            width: parent.width - 50
            anchors.top: seperator3.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: addressName4
            anchors.bottom: seperator4.top
            anchors.bottomMargin: 8
            anchors.left: seperator4.left
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Text {
            text: addressType4
            anchors.bottom: seperator4.top
            anchors.bottomMargin: 8
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Image {
            id: transferChoice4
            anchors.right: seperator4.right
            anchors.rightMargin: 10
            anchors.bottom: seperator4.top
            anchors.bottomMargin: 8
            source: '../icons/transfer_icon.svg'
            width: 14
            height: 14
            MouseArea {
                anchors.fill: transferChoice4
                onClicked: {
                    keyInput.text = receivingAddress4
                    addressBookTracker = 0
                }
            }
        }
        Rectangle {
            id: seperator5
            color: "#575757"
            height: 1
            width: parent.width - 50
            anchors.top: seperator4.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: addressName5
            anchors.bottom: seperator5.top
            anchors.bottomMargin: 8
            anchors.left: seperator5.left
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Text {
            text: addressType5
            anchors.bottom: seperator5.top
            anchors.bottomMargin: 8
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Image {
            id: transferChoice5
            anchors.right: seperator5.right
            anchors.rightMargin: 10
            anchors.bottom: seperator5.top
            anchors.bottomMargin: 8
            source: '../icons/transfer_icon.svg'
            width: 14
            height: 14
            MouseArea {
                anchors.fill: transferChoice5
                onClicked: {
                    keyInput.text = receivingAddress5
                    addressBookTracker = 0
                }
            }
        }
    }
    /**
      * scanQRBookModal
      */
    Rectangle {
        id: scanQRModal
        // parent.height > 800 ? (parent.height - 400) :
        height: 425
        // parent.width - 50
        width: 325
        color: "#42454F"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
        visible: scanQRCodeTracker == 1
        radius: 4
        z: 155
        Item {
            visible: scanQRCodeTracker == 1
            z: 200
            /**
              * Commenting camera out for now, we'll cover full implementation of this in a seperate PR
            Camera {
                id: camera
                imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

                exposure {
                    exposureCompensation: -1.0
                    exposureMode: Camera.ExposurePortrait
                }

                flash.mode: Camera.FlashRedEyeReduction
                imageCapture {
                    onImageCaptured: {
                        imageToDecode.source = preview
                        decoder.decodeImageQML(imageToDecode)
                    }
                }
            }
            VideoOutput {
                source: camera
                z: 200
                width: 300
                height: 300
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                focus: visible // to receive focus and capture key events when visible
            }

            Image {
                id: imageToDecode
                visible: false
            }
            */
        }

        QZXing {
            id: decoder
            enabledDecoders: QZXing.DecoderFormat_QR_CODE
            onDecodingStarted: console.log("Decoding of image started...")
            onTagFound: {

                console.log("Barcode data: " + tag)
                keyInput.text = tag
            }
            onDecodingFinished: console.log(
                                    "Decoding finished "
                                    + (succeeded == true ? "successfully" : "unsuccessfully"))
        }

        Rectangle {
            id: scanQRModalTop
            height: 50
            width: scanQRModal.width
            anchors.top: scanQRModal.top
            anchors.left: scanQRModal.left
            color: "#34363D"
            radius: 4
            Text {
                text: "SCAN QR CODE"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#F2F2F2"
                font.family: "Brandon Grotesque"
                font.bold: true
                font.pixelSize: 15
            }
            Image {
                id: scanQRBookModalClose
                source: '../icons/CloseIcon.svg'
                anchors.bottom: scanQRModalTop.bottom
                anchors.bottomMargin: 15
                anchors.right: scanQRModalTop.right
                anchors.rightMargin: 30
                width: 20
                height: 20
                ColorOverlay {
                    anchors.fill: scanQRBookModalClose
                    source: scanQRBookModalClose
                    color: "white" // make image like it lays under grey glass
                }
                Rectangle {
                    id: scanQRModalButtonArea
                    width: 20
                    height: 20
                    anchors.left: scanQRBookModalClose.left
                    anchors.bottom: scanQRBookModalClose.bottom
                    color: "transparent"
                    MouseArea {
                        anchors.fill: scanQRModalButtonArea
                        onClicked: scanQRCodeTracker = 0
                    }
                }
            }
        }
    }

   Controls.HistoryModal{

   }
}

