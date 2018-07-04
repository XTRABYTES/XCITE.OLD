import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

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
    }
}
