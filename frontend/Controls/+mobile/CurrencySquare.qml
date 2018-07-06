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
    property string amountSize: "22.54332 BTC"
    property string totalValue: "$43,443.94"
    property string value: "$9,839.99"

    id: square
    color: "#42454F"
    width: Screen.width - 55
    height: 75
    radius: 8

    Image {
        id: icon
        // source: '../icons/BTC-color.svg'
        source: currencyType
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        width: 25
        height: 25
    }

    Item {
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
    }
    Label {
        anchors.left: icon.right
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 14
        //text: "BTC"
        text: currencyType2
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        color: "#E5E5E5"
        font.bold: true
    }

    Label {
        id: price
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        //  text: "$43,443.94"
        text: totalValue
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        color: "#E5E5E5"
        font.bold: true
    }
    Label {
        id: amount
        anchors.right: square.right
        anchors.rightMargin: 5
        anchors.top: price.bottom
        anchors.topMargin: 5
        // text: "22.54332 BTC"
        text: amountSize
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        color: "#828282"
        font.bold: true
    }
    Label {
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: amount.bottom
        anchors.topMargin: 8
        // text: "+%.8"
        text: percentChange
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        color: "#0CB8B3"
        font.bold: true
    }
    Label {
        id: price2
        anchors.left: icon.left
        anchors.leftMargin: 0
        anchors.top: icon.bottom
        anchors.topMargin: 6
        // text: "$9,839.99"
        text: value
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: "#828282"
        font.bold: true
    }
}
