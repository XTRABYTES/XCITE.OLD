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
    property int appsTracker: 0
    property int transferTracker: 0
    z: 2

    Rectangle{
        z: 100
        color: "#393B43"
        opacity: 0.8
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: parent.width
        height: 50
    }
    Rectangle{
        color: "black"
        opacity: .8
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height
        width: parent.width
        z: 5
        visible: appsTracker == 1 || transferTracker == 1
    }

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
        visible: transferTracker != 1
        transform: Rotation {
            origin.x: 25
            origin.y: 25
            angle: 90
        }
    }

    Label {
        id: week1
        anchors.top: switch1.top
        anchors.topMargin: 17
        text: "WEEK"
        font.pixelSize: 11
        font.bold: true
        font.family: "Brandon Grotesque"
        anchors.right: switch1.left
        anchors.rightMargin: -2
        color: switch1.checked ? "#5F5F5F" : "#5E8BFE"    }
    Label {
        id: month1
        anchors.top: week1.bottom
        anchors.topMargin: 20
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
            MouseArea {
                anchors.fill: transfer2
                onClicked: {
                    transferTracker = 1
                }
            }
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
            border.width: 2
            color: "transparent"
            anchors.top: addressesList4.bottom
            anchors.left: addressesList4.left
            anchors.topMargin: 15
            MouseArea {
                anchors.fill: transferButton
                onClicked: {
                    transferTracker = 1
                }
            }
            Text{
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
            visible: clickedSquare == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: addressesList4.bottom
            anchors.left: transferButton.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
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
            border.width: 2
            color: "transparent"
            anchors.top: addressesList4.bottom
            anchors.left: historyButton.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "TRADE"
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
            border.width: 2
            color: "transparent"
            anchors.top: addressesList4_2.bottom
            anchors.left: addressesList4_2.left
            anchors.topMargin: 15
            Text{
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
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: addressesList4_2.bottom
            anchors.left: transferButton2.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
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
            border.width: 2
            color: "transparent"
            anchors.top: addressesList4_2.bottom
            anchors.left: historyButton2.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "TRADE"
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
        currencyType: '../icons/DASH-color.svg'
        currencyType2: "DASH"
        percentChange: "+%.8"
        amountSize: "22.54332 DASH"
        totalValue: "$43,443.94"
        value: "$9,839.99"
        height: clickedSquare3 == 1 ? 250 : 75
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
                    if(clickedSquare3 == 1){
                        clickedSquare3 = 0
                        return
                    }
                    if(clickedSquare3 == 0){
                        clickedSquare4 = 0
                        clickedSquare5 = 0
                        clickedSquare3 = 1
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
            visible: clickedSquare3 == 1 ? true : false
            width: parent.width - 20
            height: 1
            color: "#575757"
            anchors.top: parent.top
            anchors.topMargin: 75
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Label {
            id: addressesList_3
            visible: clickedSquare3 == 1 ? true : false
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
            visible: clickedSquare3 == 1 ? true : false
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
            visible: clickedSquare3 == 1 ? true : false
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
            visible: clickedSquare3 == 1 ? true : false
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
            visible: clickedSquare3 == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: addressesList4_3.bottom
            anchors.left: addressesList4_3.left
            anchors.topMargin: 15
            Text{
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
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: addressesList4_3.bottom
            anchors.left: transferButton3.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: tradeButton3
            visible: clickedSquare3 == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: addressesList4_3.bottom
            anchors.left: historyButton3.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "TRADE"
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
        currencyType: '../icons/LTC-color.svg'
        currencyType2: "LTC"
        percentChange: "+%.8"
        amountSize: "22.54332 DASH"
        totalValue: "$43,443.94"
        value: "$9,839.99"
        height: clickedSquare4 == 1 ? 250 : 75
        z: 0
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
                    if(clickedSquare4 == 1){
                        clickedSquare4 = 0
                        return
                    }
                    if(clickedSquare4 == 0){
                        clickedSquare5 = 0
                        clickedSquare4 = 1
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
            visible: clickedSquare4 == 1 ? true : false
            width: parent.width - 20
            height: 1
            color: "#575757"
            anchors.top: parent.top
            anchors.topMargin: 75
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Label {
            id: addressesList_4
            visible: clickedSquare4 == 1 ? true : false
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
            visible: clickedSquare4 == 1 ? true : false
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
            visible: clickedSquare4 == 1 ? true : false
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
            visible: clickedSquare4 == 1 ? true : false
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
            visible: clickedSquare4 == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: addressesList4_4.bottom
            anchors.left: addressesList4_4.left
            anchors.topMargin: 15
            Text{
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
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: addressesList4_4.bottom
            anchors.left: transferButton4.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: tradeButton4
            visible: clickedSquare4 == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: addressesList4_4.bottom
            anchors.left: historyButton4.right
            anchors.leftMargin: 10
            anchors.topMargin: 15
            Text{
                text: "TRADE"
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
        currencyType: '../icons/LTC-color.svg'
        currencyType2: "LTC"
        percentChange: "+%.8"
        amountSize: "22.54332 LTC"
        totalValue: "$43,443.94"
        value: "$9,839.99"
        height: clickedSquare5 == 1 ? 250 : 75
        z: 0
        Item {
            id: expandButton5
            width: 18
            height: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            Image {
                id: expand5
                source: '../icons/expand_buttons.svg'
            }

            ColorOverlay {
                anchors.fill: expand5
                source: expand5
                color: "grey"
            }

            MouseArea {
                anchors.fill: expandButton5
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
            id: dividerLine5
            visible: clickedSquare5 == 1 ? true : false
            width: parent.width - 20
            height: 1
            color: "#575757"
            anchors.top: parent.top
            anchors.topMargin: 75
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Label {
            id: addressesList_5
            visible: clickedSquare5 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: dividerLine5.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Label {
            id: addressesList2_5
            visible: clickedSquare5 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressesList_5.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Label {
            id: addressesList3_5
            visible: clickedSquare5 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressesList2_5.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Label {
            id: addressesList4_5
            visible: clickedSquare5 == 1 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: addressesList3_5.bottom
            anchors.topMargin: 10
            text: "Main     BH12af040hF30Fe3029FJP0...    18.5381 BTC"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: false
        }
        Rectangle {
            id: transferButton5
            visible: clickedSquare5 == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: addressesList4_5.bottom
            anchors.left: addressesList4_5.left
            anchors.topMargin: 15
            Text{
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
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            color: "transparent"
            anchors.top: addressesList4_5.bottom
            anchors.left: transferButton5.right
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
            id: tradeButton5
            visible: clickedSquare5 == 1 ? true : false
            width: 90
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            color: "transparent"
            anchors.top: addressesList4_5.bottom
            anchors.left: historyButton5.right
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
        anchors.leftMargin: 30
        source: '../icons/icon-settings.svg'
        width: 20
        height: 20
        z: 100

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
        anchors.rightMargin: 30
        width: 20
        height: 20
        z: 100
        visible: appsTracker == 0
        MouseArea{
            anchors.fill: apps
            onClicked: appsTracker = 1
        }
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
        MouseArea{
            anchors.fill: closeApps
            onClicked: appsTracker = 0
        }
        ColorOverlay {
            anchors.fill: closeApps
            source: closeApps
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
        Text{
            text: "X-CHANGE"
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#5E8BFF"
            font.family: "Brandon Grotesque"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }
        ColorOverlay {
            anchors.fill: xchangeLink
            source: xchangeLink
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
        Text{
            text: "X-VAULT"
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#5E8BFF"
            font.family: "Brandon Grotesque"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }

        ColorOverlay {
            anchors.fill: xvaultLink
            source: xvaultLink
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
        Text{
            text: "X-CHAT"
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#5E8BFF"
            font.family: "Brandon Grotesque"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }
        ColorOverlay {
            anchors.fill: xchatLink
            source: xchatLink
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
    /**
      * Transfer Modal popup
      */
    Rectangle{
        id: modal
        height: parent.height - 400
        width: parent.width - 50
        color: "#42454F"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
        visible: transferTracker == 1
        radius: 4
        z: 100

        Rectangle {
            id: modalTop
            height: 50
            width: modal.width
            anchors.bottom: modal.top
            anchors.left: modal.left
            color: "#34363D"
            radius: 4
            Text{
                text: "TRANSFER"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#F2F2F2"
                font.family: "Brandon Grotesque"
                font.bold: false
                font.pixelSize: 14
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
                MouseArea{
                    anchors.fill: closeModal
                    onClicked: transferTracker = 0
                }
                ColorOverlay {
                    anchors.fill: closeModal
                    source: closeModal
                    color: "#5E8BFF" // make image like it lays under grey glass
                }
            }
        }
        Switch {
            id: transferSwitch
            anchors.horizontalCenter: modal.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10

            Text {
                id: receiveText
                text: qsTr("RECEIVE")
                anchors.right: transferSwitch.left
                anchors.rightMargin: 7
                anchors.verticalCenter: parent.verticalCenter
                color: transferSwitch.checked ? "#5F5F5F" : "#5E8BFE"
            }
            Text {
                id: sendText
                text: qsTr("SEND")
                anchors.left: transferSwitch.right
                anchors.leftMargin: 7
                anchors.verticalCenter: parent.verticalCenter
                color: transferSwitch.checked ? "#5E8BFE" : "#5F5F5F"
            }
        }

        /**
          * Transfer Modal both send & receive
          */
        Image{
            id: currencyIcon
            source: '../icons/BTC-color.svg'
            width: 25
            height: 25
            anchors.left: modal.left
            anchors.leftMargin: 20
            anchors.top: modal.top
            anchors.topMargin: 50
            visible: transferTracker == 1
            Label{
                id: currencyIconChild
                text: "BTC"
                anchors.left: currencyIcon.right
                anchors.leftMargin: 10
                color: "#E5E5E5"
                font.bold: true
            }
            Image{
                source: '../icons/dropdown_icon.svg'
                width: 15
                height: 15
                anchors.left: currencyIconChild.right
                anchors.leftMargin: 8
                anchors.verticalCenter: currencyIconChild.verticalCenter
                visible: transferTracker == 1
            }
        }
        Label{
            id: walletChoice
            text: "MAIN"
            anchors.right: qrPlaceholder.right
            anchors.rightMargin: 10
            anchors.top: modal.top
            anchors.topMargin: 50
            color: "#E5E5E5"
            font.bold: true
            visible: transferTracker == 1

        }
        Image{
            id: walletDropdown
            source: '../icons/dropdown_icon.svg'
            width: 15
            height: 15
            anchors.left: walletChoice.right
            anchors.leftMargin: 8
            anchors.verticalCenter: walletChoice.verticalCenter
            visible: transferTracker == 1
        }
        /**
          * Transfer modal receive state
          */
        Rectangle{
            id: qrPlaceholder
            color: "white"
            radius: 8
            width: 240
            height: 200
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: currencyIcon.bottom
            anchors.topMargin: 20
            visible: transferSwitch.checked == false && transferTracker == 1
        }

        Text{
            id: pubKey
            text: "PUBLIC KEY"
            anchors.top: qrPlaceholder.bottom
            anchors.topMargin: 25
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: true
            font.pixelSize: 11
            visible: transferSwitch.checked == false && transferTracker == 1
            Text{
                id: publicKey
                text: "BM39fjwf093JF329f39fJFSL393fa03987fja392WPF2948WQO"
                anchors.top: pubKey.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                font.family: "Brandon Grotesque"
                font.bold: false
                font.pixelSize: 9
            }
            Image{
                id: pasteIcon
                source: '../icons/paste_icon.svg'
                width: 13
                height: 13
                anchors.left: publicKey.right
                anchors.leftMargin: 5
                anchors.verticalCenter: publicKey.verticalCenter
                visible: transferSwitch.checked == false && transferTracker == 1
            }
        }

        /**
          * Transfer modal send state
          */
        Label{
            id: walletBalance
            text: "18.5359 XBY"
            anchors.right: walletDropdown.right
            anchors.rightMargin: 0
            anchors.top: walletChoice.bottom
            anchors.topMargin: 1
            color: "#E5E5E5"
            font.bold: true
            font.pixelSize: 10
            visible: transferTracker == 1 && transferSwitch.checked == true
        }
        Controls.TextInput{
            id: sendAmount
            height: 34
            //radius: 8
            text: "AMOUNT (BTC)"
            anchors.left: currencyIcon.left
            anchors.top: currencyIcon.bottom
            anchors.topMargin: 15
            visible: transferTracker == 1 && transferSwitch.checked == true
            color: "#727272"
            font.pixelSize: 10
            font.family: "Brandon Grotesque"
            font.bold: true
        }
        Controls.TextInput{
            id: keyInput
            height: 34
            //radius: 8
            text: "SEND TO (PUBLIC KEY)"
            anchors.left: currencyIcon.left
            anchors.top: sendAmount.bottom
            anchors.topMargin: 15
            color: "#727272"
            font.pixelSize: 10
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: transferTracker == 1 && transferSwitch.checked == true
        }
        Rectangle {
            id: scanQrButton
            visible: transferTracker == 1 && transferSwitch.checked == true
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

                //onClicked: {
                //  transferTracker = 1
                // }
            }
            Text{
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
            visible: transferTracker == 1 && transferSwitch.checked == true
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

                //onClicked: {
                //  transferTracker = 1
                // }
            }
            Text{
                text: "ADDRESS BOOK"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Controls.TextInput{
            id: referenceInput
            height: 34
            // radius: 8
            text: "REFERENCE"
            anchors.left: currencyIcon.left
            anchors.top: scanQrButton.bottom
            anchors.topMargin: 15
            color: "#727272"
            font.pixelSize: 10
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: transferTracker == 1 && transferSwitch.checked == true
        }
        Rectangle {
            id: sendButton
            visible: transferTracker == 1 && transferSwitch.checked == true
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
                anchors.fill: addressBookButton

                //onClicked: {
                //  transferTracker = 1
                // }
            }
            Text{
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
}
