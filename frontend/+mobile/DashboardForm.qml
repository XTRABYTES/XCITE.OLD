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

import "./Controls" as Controls
import "./Theme" 1.0

Item {
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
        }
        Label {
            id: add
            text: "ADDRESS BOOK"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#757575"
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
        iconFile: '/icons/icon-notif.svg'
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
        font.bold: false
        Label {
            anchors.top: value.bottom
            anchors.topMargin: 6
            text: "+$6,000.00 (24h)"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#0CB8B3"
            font.bold: false
            Label {
                id: walletHistory
                anchors.top: parent.bottom
                anchors.topMargin: 18
                text: "WALLET HISTORY"
                font.pixelSize: 11
                font.family: "Brandon Grotesque"
                color: "#696969"
                anchors.left: parent.left
            }
        }
    }
    Switch {
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

    Controls.CurrencySquare {
        id: square1
        anchors.top: parent.top
        anchors.topMargin: 210
        anchors.left: parent.left
        anchors.leftMargin: 25
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
    }
    Image {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        source: '../icons/icon-settings.svg'
        width: 20
        height: 20
    }
    Image {
        id: apps
        source: '../icons/icon-apps.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 2
        anchors.right: parent.right
        anchors.rightMargin: 10
        width: 20
        height: 20
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
