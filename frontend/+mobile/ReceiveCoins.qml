import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import "../Controls" as Controls

Item {
    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 100

        Controls.Header {
            text: qsTr("Receive XBY")
        }
        Image {
            id: qrCode
            source: "../icons/placeholder-qr.svg"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 50
            width: 300
            height: 300
        }

        Image {
            id: balanceCount
            anchors.top: qrCode.bottom
            anchors.topMargin: 30
            anchors.left: qrCode.left
            anchors.leftMargin: 100
            source: "../logos/xby_logo.svg"
            width: 50
            height: 30
        }

        Text {
            anchors.left: balanceCount.right
            anchors.top: qrCode.bottom
            anchors.topMargin: 35
            anchors.leftMargin: 5
            text: "4739.35"
            color: "White"
            font.family: Theme.fontCondensed
            font.pointSize: 14
        }

        // Address placeholder
        Text {
            anchors.top: balanceCount.bottom
            anchors.topMargin: 20
            text: "Address: BMy2BpwyJc5i7upNm5Vv8HMkwXqBR3kCxS"
            color: "White"
            font.family: Theme.fontCondensed
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
