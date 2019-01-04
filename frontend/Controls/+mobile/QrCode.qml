import QtQuick 2.0
import QtQuick.Window 2.2
import QZXing 2.3
import QtQuick.Controls 2.3

Item {

    Rectangle {
        id: background
        width: parent.width
        height: parent.height
        color: "black"
        opacity: 0.95
        anchors.horizontalCenter: Screen.horizontalCenter
        anchors.top: parent.top
        //visible: addressQRTracker == 1

        MouseArea {
            anchors.fill: parent
        }
    }

    Rectangle {
        id: qrModal
        width: 325
        height: 340
        color: darktheme == false? "#42454F" : "transparent"
        radius: 4
        anchors.horizontalCenter: background.horizontalCenter
        anchors.top: background.top
        anchors.topMargin: 10
        //visible: addressQRTracker == 1
    }

    Text {
        text:  addressList.get(addressIndex).coin + " (" + addressList.get(addressIndex).label + ")"
        anchors.top: qrModal.top
        anchors.topMargin: 10
        anchors.horizontalCenter: background.horizontalCenter
        color: "white"
        font.family: xciteMobile.name
        font.bold: true
        font.pixelSize: 20
        font.letterSpacing: 1
        //visible: addressQRTracker == 1
    }

    Rectangle {
        id: qrBorder
        radius: 8
        width: 210
        height: 210
        anchors.horizontalCenter: background.horizontalCenter
        anchors.top: qrModal.top
        anchors.topMargin: 47.5
        color: "#FFFFFF"
        //visible: addressQRTracker == 1
    }

    Item {
        id: qrPlaceholder
        width: 180
        height: (qrBorder.height / 7) * 6
        anchors.horizontalCenter: qrBorder.horizontalCenter
        anchors.verticalCenter: qrBorder.verticalCenter
        //visible: addressQRTracker == 1

        Image {
            anchors.fill: parent
            source: "image://QZXing/encode/" + publicKey.text
            cache: false
        }
    }

    Text {
        id: pubKey
        text: "PUBLIC KEY"
        anchors.top: qrBorder.bottom
        anchors.topMargin: 15
        anchors.horizontalCenter: background.horizontalCenter
        color: "white"
        font.family: xciteMobile.name
        font.bold: true
        font.pixelSize: 14
        font.letterSpacing: 1
        //visible: addressQRTracker == 1
    }

    Text {
        id: publicKey
        text: addressList.get(addressIndex).address
        anchors.top: pubKey.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: pubKey.horizontalCenter
        color: "white"
        font.family: xciteMobile.name
        font.pixelSize: 12
        //visible: addressQRTracker == 1
    }
}
