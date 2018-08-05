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

import "./Controls" as Controls
/**
  * Main page
  */
Item {
    property int sw: -1
    property int clickedSquare: 0
    property int clickedSquare2: 0
    property int clickedSquare3: 0
    property int clickedSquare4: 0
    property int clickedSquare5: 0
    property int clickedSquare6: 0

    Loader {
        id: pageLoader
    }

    Controls.Header {
        id: heading
        text: qsTr("POSEY")
        showBack: false
        Layout.topMargin: 14
    }
    RowLayout {
        anchors.top: heading.bottom
        anchors.topMargin: 10
        anchors.left: heading.left
        anchors.leftMargin: 100
        spacing: 20
        Label {
            id: overview
            text: "OVERVIEW"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#5E8BFE"
            Rectangle {
                id: titleLine
                width: overview.width
                height: 1
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

            MouseArea {
                anchors.fill: add5
                //onClicked: pageLoader.source = "MobileAddressBook.qml"
                onClicked: mainRoot.push("MobileAddressBook.qml")
            }
        }
    }

    /**
      * Waiting on updated SVG, commented out
    Image {
        id: notif
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        source: '../icons/icon-notif.svg'
        width: 16
        height: 25
        ColorOverlay {
            anchors.fill: transfer2
            source: transfer2
            color: "grey" // make image like it lays under grey glass
        }

    }
    */

    Label {
        id: value
        anchors.top: parent.top
        anchors.topMargin: 90
        anchors.left: parent.left
        anchors.leftMargin: 20
        text: "$511,000.00"
        font.pixelSize: 36
        font.family: "Brandon Grotesque"
        color: "#E5E5E5"
        // font.weight: Font.DemiBold
        Label {
            anchors.top: value.bottom
            anchors.topMargin: 6
            text: "+$6,000.00 (24h)"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#0CB8B3"
            font.bold: true
            Label {
                id: walletHistory
                anchors.top: parent.bottom
                anchors.topMargin: 18
                text: "WALLET HISTORY"
                font.pixelSize: 11
                font.family: "Brandon Grotesque"
                color: "#696969"
                anchors.left: parent.left
                Label {
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    text: "$464,358.25"
                    font.pixelSize: 13
                    font.bold: true
                    font.family: "Brandon Grotesque"
                    color: "#5E8BFE"
                    anchors.left: parent.right
                    anchors.leftMargin: 8
                }
            }
        }
    }

    Switch {
        id: switch1
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 80
        transform: Rotation {
            origin.x: 25
            origin.y: 25
            angle: 90
        }
    }

    Label {
        id: week1
        anchors.top: switch1.top
        anchors.topMargin: 10
        text: "WEEK"
        font.pixelSize: 11
        font.bold: true
        font.family: "Brandon Grotesque"
        anchors.right: switch1.left
        anchors.rightMargin: -2
        color: switch1.checked ? "#5F5F5F" : "#5E8BFE"    }
    Label {
        id: month1
        anchors.top: switch1.bottom
        anchors.topMargin: 0
        text: "MONTH"
        font.pixelSize: 11
        font.bold: true
        font.family: "Brandon Grotesque"
        anchors.right: switch1.left
        anchors.rightMargin: -2
        color: switch1.checked ? "#5E8BFE" : "#5F5F5F"
    }

    Label {
        id: transfer
        text: "TRANSFER"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        color: "#C7C7C7"
        anchors.left: square1.left
        anchors.bottom: square1.top
        anchors.bottomMargin: 8
        font.bold: true
        /**
        MouseArea {
            anchors.fill: add
            onClicked: mainRoot.push("MobileAddressBook.qml")
        }
        */
        Image {
            id: transfer2
            anchors.top: parent.top
            anchors.topMargin: -2
            anchors.left: parent.right
            anchors.leftMargin: 8
            source: '../icons/icon-transfer.svg'
            width: 16
            height: 16
            ColorOverlay {
                anchors.fill: transfer2
                source: transfer2
                color: "grey" // make image like it lays under grey glass
            }
        }
    }

    Label {
        id: addCoin
        text: "ADD COIN"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        color: "#C7C7C7"
        anchors.right: square1.right
        anchors.bottom: square1.top
        anchors.bottomMargin: 8
        anchors.rightMargin: 24
        font.bold: true
        /**
        MouseArea {
            anchors.fill: add
            onClicked: mainRoot.push("MobileAddressBook.qml")
        }
        */
        Image {
            id: plus
            anchors.top: parent.top
            anchors.topMargin: -2
            anchors.left: parent.right
            anchors.leftMargin: 8
            source: '../icons/plus-button.svg'
            width: 16
            height: 16
            ColorOverlay {
                anchors.fill: plus
                source: plus
                color: "grey" // make image like it lays under grey glass
            }
        }
    }

    Controls.CurrencySquare {
        id: square1
        anchors.top: parent.top
        anchors.topMargin: 230
        anchors.left: parent.left
        anchors.leftMargin: 25
        height: clickedSquare == 1 ? 250 : 75
        Item {
            id: expandButton
            width: 18
            height: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            Image {
                id: expand
                source: '../icons/expand_buttons.svg'
            }

            ColorOverlay {
                anchors.fill: expand
                source: expand
                color: "grey"
            }

            MouseArea {
                anchors.fill: expandButton
                onClicked: {
                    if(clickedSquare == 1){
                        clickedSquare = 0
                        return
                    }
                    if(clickedSquare == 0){
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
        Label {
            id: addressesList
            visible: clickedSquare == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: dividerLine.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Label {
            id: addressesList2
            visible: clickedSquare == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressesList.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Label {
            id: addressesList3
            visible: clickedSquare == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressesList2.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Label {
            id: addressesList4
            visible: clickedSquare == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressesList3.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Rectangle {
            id: transferButton
            visible: clickedSquare == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            color: "transparent"
            anchors.top: addressesList4.bottom
            anchors.left: addressesList4.left
            anchors.topMargin: 15
            Text{
                text: "TRANSFER"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: historyButton
            visible: clickedSquare == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            color: "transparent"
            anchors.top: addressesList4.bottom
            anchors.left: transferButton.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: tradeButton
            visible: clickedSquare == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            color: "transparent"
            anchors.top: addressesList4.bottom
            anchors.left: historyButton.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "TRADE"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
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
        currencyType: '../icons/ETH-color.svg'
        currencyType2: "ETH"
        percentChange: "+%.8"
        amountSize: "22.54332 ETH"
        totalValue: "$43,443.94"
        value: "$9,839.99"
        height: clickedSquare2 == 1 ? 250 : 75
        Item {
            id: expandButton2
            width: 18
            height: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            Image {
                id: expand2
                source: '../icons/expand_buttons.svg'
            }

            ColorOverlay {
                anchors.fill: expand2
                source: expand2
                color: "grey"
            }

            MouseArea {
                anchors.fill: expandButton2
                onClicked: {
                    if(clickedSquare2 == 1){
                        clickedSquare2 = 0
                        return
                    }
                    if(clickedSquare2 == 0){
                        clickedSquare2 = 1
                        clickedSquare5 = 0
                        clickedSquare4 = 0
                        clickedSquare3 = 0
                        clickedSquare = 0
                        return
                    }
                }
            }
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
        Label {
            id: addressesList_2
            visible: clickedSquare2 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: dividerLine2.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Label {
            id: addressesList2_2
            visible: clickedSquare2 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressesList_2.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Label {
            id: addressesList3_2
            visible: clickedSquare2 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressesList2_2.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Label {
            id: addressesList4_2
            visible: clickedSquare2 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressesList3_2.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Rectangle {
            id: transferButton2
            visible: clickedSquare2 == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            color: "transparent"
            anchors.top: addressesList4_2.bottom
            anchors.left: addressesList4_2.left
            anchors.topMargin: 15
            Text{
                text: "TRANSFER"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: historyButton2
            visible: clickedSquare2 == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            color: "transparent"
            anchors.top: addressesList4_2.bottom
            anchors.left: transferButton2.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: tradeButton2
            visible: clickedSquare2 == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            color: "transparent"
            anchors.top: addressesList4_2.bottom
            anchors.left: historyButton2.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "TRADE"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
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
        currencyType: '../icons/DASH-color.svg'
        currencyType2: "DASH"
        percentChange: "+%.8"
        amountSize: "22.54332 DASH"
        totalValue: "$43,443.94"
        value: "$9,839.99"
        height: clickedSquare4 == 1 ? 250 : 75
        Item {
            id: expandButton3
            width: 18
            height: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            Image {
                id: expand3
                source: '../icons/expand_buttons.svg'
            }

            ColorOverlay {
                anchors.fill: expand3
                source: expand3
                color: "grey"
            }

            MouseArea {
                anchors.fill: expandButton3
                onClicked: {
                    if(clickedSquare4 == 1){
                        clickedSquare4 = 0
                        return
                    }
                    if(clickedSquare4 == 0){
                        clickedSquare4 = 1
                        clickedSquare5 = 0
                        clickedSquare3 = 0
                        clickedSquare2 = 0
                        clickedSquare = 0
                        return
                    }
                }
            }
        }
        /**
          * Visible when square is clicked
          */
        Rectangle {
            id: dividerLine3
            visible: clickedSquare4 == 1 ? true : false
            width: parent.width - 20
            height: 1
            color: "#575757"
            anchors.top: parent.top
            anchors.topMargin: 75
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Label {
            id: addressesList_3
            visible: clickedSquare4 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: dividerLine3.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Label {
            id: addressesList2_3
            visible: clickedSquare4 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressesList_3.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Label {
            id: addressesList3_3
            visible: clickedSquare4 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressesList2_3.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Label {
            id: addressesList4_3
            visible: clickedSquare4 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressesList3_3.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Rectangle {
            id: transferButton3
            visible: clickedSquare4 == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            color: "transparent"
            anchors.top: addressesList4_3.bottom
            anchors.left: addressesList4_3.left
            anchors.topMargin: 15
            Text{
                text: "TRANSFER"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: historyButton3
            visible: clickedSquare4 == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            color: "transparent"
            anchors.top: addressesList4_3.bottom
            anchors.left: transferButton3.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: tradeButton3
            visible: clickedSquare4 == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            color: "transparent"
            anchors.top: addressesList4_3.bottom
            anchors.left: historyButton3.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "TRADE"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
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
        currencyType: '../icons/LTC-color.svg'
        currencyType2: "LTC"
        percentChange: "+%.8"
        amountSize: "22.54332 DASH"
        totalValue: "$43,443.94"
        value: "$9,839.99"
        height: clickedSquare5 == 1 ? 250 : 75
        Item {
            id: expandButton4
            width: 18
            height: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            Image {
                id: expand4
                source: '../icons/expand_buttons.svg'
            }

            ColorOverlay {
                anchors.fill: expand4
                source: expand4
                color: "grey"
            }

            MouseArea {
                anchors.fill: expandButton4
                onClicked: {
                    if(clickedSquare5 == 1){
                        clickedSquare5 = 0
                        return
                    }
                    if(clickedSquare5 == 0){
                        clickedSquare5 = 1
                        clickedSquare4 = 0
                        clickedSquare3 = 0
                        clickedSquare2 = 0
                        clickedSquare = 0
                        return
                    }
                }
            }
        }
        /**
          * Visible when square is clicked
          */
        Rectangle {
            id: dividerLine4
            visible: clickedSquare5 == 1 ? true : false
            width: parent.width - 20
            height: 1
            color: "#575757"
            anchors.top: parent.top
            anchors.topMargin: 75
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Label {
            id: addressesList_4
            visible: clickedSquare5 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: dividerLine4.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Label {
            id: addressesList2_4
            visible: clickedSquare5 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressesList_4.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Label {
            id: addressesList3_4
            visible: clickedSquare5 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressesList2_4.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Label {
            id: addressesList4_4
            visible: clickedSquare5 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressesList3_4.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Rectangle {
            id: transferButton4
            visible: clickedSquare5 == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            color: "transparent"
            anchors.top: addressesList4_4.bottom
            anchors.left: addressesList4_4.left
            anchors.topMargin: 15
            Text{
                text: "TRANSFER"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: historyButton4
            visible: clickedSquare5 == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            color: "transparent"
            anchors.top: addressesList4_4.bottom
            anchors.left: transferButton4.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: tradeButton4
            visible: clickedSquare5 == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            color: "transparent"
            anchors.top: addressesList4_4.bottom
            anchors.left: historyButton4.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "TRADE"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Image {
        id: settings
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 15
        source: '../icons/icon-settings.svg'
        width: 20
        height: 20
        ColorOverlay {
            anchors.fill: settings
            source: settings
            color: "#5E8BFF" // make image like it lays under grey glass
        }
        MouseArea {
            anchors.fill: settings
            //onClicked: pageLoader.source = "MobileAddressBook.qml"
            onClicked: mainRoot.push("Settings.qml")
        }
    }
    Image {
        id: apps
        source: '../icons/icon-apps.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 15
        width: 20
        height: 20
        ColorOverlay {
            anchors.fill: apps
            source: apps
            color: "#5E8BFF" // make image like it lays under grey glass
        }
        /**
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    clipboard.text = regString.text
                }
            }
            */
    }
}
