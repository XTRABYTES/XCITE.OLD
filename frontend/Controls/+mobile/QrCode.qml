import QtQuick 2.0
import QtQuick.Window 2.2
import QZXing 2.3
import QtQuick.Controls 2.3

Item {

    Flickable {
        width: parent.width
        height: parent.height
        contentHeight: qrID.height + qrBorder.height + pubKey.height + publicKey.height + 207.5
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: Screen.bottom
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        Rectangle {
            id: qrModal
            width: parent.width
            height: parent.height
            color: darktheme == false? "#FDFDFD" : "#14161B"
            radius: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top

            MouseArea {
                anchors.fill: parent
            }
        }

        Text {
            id: qrID
            width: doubbleButtonWidth
            text:  addressList.get(addressIndex).coin + " (" + addressList.get(addressIndex).label + ")"
            anchors.top: qrModal.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            horizontalAlignment: Text.AlignHCenter
            font.family: xciteMobile.name
            font.bold: true
            font.pixelSize: 20
            font.letterSpacing: 1
            elide: Text.ElideRight
        }

        Rectangle {
            id: qrBorder
            radius: 4
            width: 210
            height: 210
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: qrModal.top
            anchors.topMargin: 47.5
            color: "#FFFFFF"
        }

        Item {
            id: qrPlaceholder
            width: 180
            height: (qrBorder.height / 7) * 6
            anchors.horizontalCenter: qrBorder.horizontalCenter
            anchors.verticalCenter: qrBorder.verticalCenter

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
            anchors.horizontalCenter: parent.horizontalCenter
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            font.family: xciteMobile.name
            font.bold: true
            font.pixelSize: 14
            font.letterSpacing: 1
        }

        Text {
            id: publicKey
            text: addressList.get(addressIndex).address
            anchors.top: pubKey.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: pubKey.horizontalCenter
            color: darktheme == false? "#2A2C31" : "#F2F2F2"
            font.family: xciteMobile.name
            font.pixelSize: 12
        }
    }
}
