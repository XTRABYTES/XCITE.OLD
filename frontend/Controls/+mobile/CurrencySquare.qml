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
        source: currencyType
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        width: 25
        height: 25
    }

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
    }
    Label {
        anchors.left: icon.right
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 14
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
        text: amountSize
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        color: "#828282"
        font.bold: true
    }
    Label {
        id: percentChangeLabel
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: amount.bottom
        anchors.topMargin: 8
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
        text: value
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: "#828282"
        font.bold: true
    }

    /**
      *
      * PLEASE DO NOT REVIEW CODE PAST THIS POINT, WILL BE ENABLED VIA ONE LINE IN SOON TO COME PR
      *
      */
    Rectangle {
        id: dividerLine
        visible: clicked == 1 ? true : false
        width: parent.width - 20
        height: 1
        color: "#5E8BFE"
        anchors.top: percentChangeLabel.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Label {
        id: addressesList
        visible: clicked == 1 ? true : false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: dividerLine.bottom
        anchors.topMargin: 6
        text: "Main     BH132040HFALJFSJLFJ32...    18.5381 BTC"
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: "#828282"
        font.bold: true
    }
    Label {
        id: addressesList2
        visible: clicked == 1 ? true : false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: dividerLine.bottom
        anchors.topMargin: 6
        text: "Main     BH132040HFALJFSJLFJ32...    18.5381 BTC"
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: "#828282"
        font.bold: true
    }
    Label {
        id: addressesList3
        visible: clicked == 1 ? true : false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: dividerLine.bottom
        anchors.topMargin: 6
        text: "Main     BH132040HFALJFSJLFJ32...    18.5381 BTC"
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: "#828282"
        font.bold: true
    }
    Label {
        id: addressesList4
        visible: clicked == 1 ? true : false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: dividerLine.bottom
        anchors.topMargin: 6
        text: "Main     BH132040HFALJFSJLFJ32...    18.5381 BTC"
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: "#828282"
        font.bold: true
    }
    Rectangle {
        id: transferButton
        visible: clicked == 1 ? true : false
        width: 120
        height: 40
        color: "#5E8BFF"
        anchors.top: addressesList4.bottom
        anchors.left: addressesList4.left
        anchors.topMargin: 15
    }
}
