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

    Controls.ButtonIconText {
        anchors.left: parent.right
        anchors.rightMargin: 10
        textColor: "#2D3043"
        border.width: 0
        radius: 0
        label.font.letterSpacing: 0.92
        label.font.family: Theme.fontCondensed
        Layout.fillWidth: true
        Layout.fillHeight: true
        iconFile: '../icons/icon-notif.svg'
        size: 20
        // set 1 to alert this normally used desktop control that it is using mobile parameters
        mobile: 1
    }

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
        MouseArea {
             anchors.fill: square1
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
        MouseArea {
             anchors.fill: square2
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

    Controls.CurrencySquare {
        id: square3
        anchors.top: square2.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        currencyType: '../icons/XBY-color.svg'
        currencyType2: "XBY"
        percentChange: "+%.8"
        amountSize: "22.54332 XBY"
        totalValue: "$43,443.94"
        value: "$9,839.99"
        height: clickedSquare3 == 1 ? 250 : 75
        MouseArea {
             anchors.fill: square3
             onClicked: {
                 if(clickedSquare3 == 1){
                     clickedSquare3 = 0
                     return
                 }
                 if(clickedSquare3 == 0){
                     clickedSquare3 = 1
                     clickedSquare5 = 0
                     clickedSquare4 = 0
                     clickedSquare2 = 0
                     clickedSquare = 0
                     return
                 }

             }
        }
    }
    Controls.CurrencySquare {
        id: square4
        anchors.top: square3.bottom
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
        MouseArea {
             anchors.fill: square4
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

    Controls.CurrencySquare {
        id: square5
        anchors.top: square4.bottom
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
        MouseArea {
             anchors.fill: square5
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
