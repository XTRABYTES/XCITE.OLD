/**
 * Filename: CurrencySquare.qml
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
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0

Rectangle {
    property url currencyType: '../icons/BTC-color.svg'
    property string currencyType2: "BTC"
    property string percentChange: "+%.8"
    property string amountSize: wallet.balance.toLocaleString(
                                    Qt.locale(), "f", 4)
    property string totalValue: (wallet.balance * marketValue.marketValue).toLocaleString(
                                    Qt.locale(), "f", 2)
    property string value: (marketValue.marketValue).toLocaleString(
                               Qt.locale(), "f", 2)
    property int gainLossTracker: 0
    id: square
    color: "#42454F"
    width: Screen.width - 55
    height: 75
    radius: 4

    Image {
        id: icon
        source: currencyType
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        width: 25
        height: 25
    }
    Label {
        anchors.left: icon.right
        anchors.leftMargin: 5
        anchors.verticalCenter: icon.verticalCenter
        text: currencyType2
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        color: "#E5E5E5"
        font.bold: true
    }

    Text {
        id: amountSizeLabel
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: icon.verticalCenter
        text: amountSize
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        color: "#E5E5E5"
        font.weight: Font.Medium
    }

    Label {
        id: totalValueLabel
        anchors.right: square.right
        anchors.rightMargin: 10
        anchors.verticalCenter: price2.verticalCenter
        text: totalValue
        font.pixelSize: 13
        font.family: "Brandon Grotesque"
        color: "#828282"
        font.bold: true
    }

    Label {
        id: percentChangeLabel
        anchors.left: price2.right
        anchors.leftMargin: 5
        anchors.top: price2.top
        text: percentChange
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        color: gainLossTracker === 0 ? "#FD2E2E" : "#5DFC36"
        font.bold: true
    }
    Label {
        id: price2
        anchors.left: dollarSign1.right
        anchors.top: icon.bottom
        anchors.topMargin: 10
        text: value
        font.pixelSize: 13
        font.family: "Brandon Grotesque"
        color: "#828282"
        font.bold: true
    }
    Label {
        id: dollarSign1
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: price2.verticalCenter
        text: "$"
        font.pixelSize: 13
        font.family: "Brandon Grotesque"
        color: "#828282"
        font.bold: true
    }
    Label {
        id: dollarSign2
        anchors.right: totalValueLabel.left
        anchors.leftMargin: 0
        anchors.verticalCenter: totalValueLabel.verticalCenter
        text: "$"
        font.pixelSize: 13
        font.family: "Brandon Grotesque"
        color: "#828282"
        font.bold: true
    }
}
