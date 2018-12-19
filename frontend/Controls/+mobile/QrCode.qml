import QtQuick 2.0
import QtQuick.Window 2.2
import QZXing 2.3
import QtQuick.Controls 2.3

Item {

    Rectangle {
        id: background
        width: Screen.width
        height: Screen.height
        color: "black"
        opacity: 0.95
        anchors.horizontalCenter: Screen.horizontalCenter
        anchors.verticalCenter: Screen.verticalCenter
        visible: addressQRTracker == 1

        MouseArea {
            anchors.fill: parent
        }
    }

    Rectangle {
        id: qrModal
        width: 325
        height: 350
        color: darktheme == false? "#42454F" : "transparent"
        radius: 4
        anchors.horizontalCenter: background.horizontalCenter
        anchors.top: background.top
        anchors.topMargin: 75
        visible: addressQRTracker == 1
    }

    Text {
        text: addressbookName
        anchors.top: qrModal.top
        anchors.topMargin: 10
        anchors.horizontalCenter: background.horizontalCenter
        color: "white"
        font.family: xciteMobile.name
        font.bold: true
        font.pixelSize: 20
        font.letterSpacing: 1
        visible: addressQRTracker == 1
    }

    Rectangle {
        id: qrBorder
        radius: 8
        width: 210
        height: 210
        anchors.horizontalCenter: background.horizontalCenter
        anchors.top: qrModal.top
        anchors.topMargin: 57.5
        color: "#FFFFFF"
        visible: addressQRTracker == 1
    }

    Item {
        id: qrPlaceholder
        width: 180
        height: 180
        anchors.horizontalCenter: qrBorder.horizontalCenter
        anchors.verticalCenter: qrBorder.verticalCenter
        visible: addressQRTracker == 1

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
        visible: addressQRTracker == 1
    }

    Text {
        id: publicKey
        text: addressbookHash
        anchors.top: pubKey.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: pubKey.horizontalCenter
        color: "white"
        font.family: xciteMobile.name
        font.pixelSize: 12
        visible: addressQRTracker == 1
    }

    Label {
        text: "CLOSE"
        id: closeTransferModal
        anchors.top: qrModal.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: qrModal.horizontalCenter
        font.pixelSize: 14
        font.family: xciteMobile.name
        color: darktheme == false? "#F2F2F2" : maincolor
        visible: addressQRTracker == 1

        Rectangle{
            id: closeButton
            height: 30
            width: doubbleButtonWidth
            radius: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"
            border.width: 2
            border.color: darktheme == false? "transparent" : maincolor
        }

        MouseArea {
            anchors.fill: closeButton

            onClicked: {
                addressbookName = ""
                addressbookHash = ""
                addressQRTracker = 0
            }
        }
    }
}
