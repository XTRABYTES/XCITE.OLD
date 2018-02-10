import QtQuick 2.4
import QtQuick.Controls 2.2

ListView {
    id: addressBook
    anchors.fill: parent
    anchors.topMargin: 10
    anchors.bottomMargin: 10
    anchors.leftMargin: 3
    anchors.rightMargin: 3

    highlightMoveDuration: 0
    highlightResizeDuration: 0

    clip: true

    model: model
    currentIndex: 0

    delegate: Label {
        property variant item: model

        verticalAlignment: Text.AlignVCenter
        width: parent.width
        leftPadding: 20
        rightPadding: 20
        text: name
        font.family: "Roboto"
        font.weight: Font.Light
        font.pixelSize: 16
        color: "white"
        lineHeight: 1.5

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: addressBook.currentIndex = index
        }
    }

    highlight: Rectangle {
        color: "#42454D"
    }

    ListModel {
        id: model

        ListElement {
            name: "Lachelle Hamblin"
            address: "BMy2BpwyJc5i7upNm5Vv8HMkwXqBR3kCxS"
        }

        ListElement {
            name: "Marg Apolinar"
            address: "Jc5i7upNmBMy2Bpwy5Vv8HMkwXqBR3kCxS"
        }

        ListElement {
            name: "Shanell Sanderfur"
            address: "upNm5Vv8HMkBMy2BpwyJc5i7wXqBR3kCxS"
        }

        ListElement {
            name: "Mickie Dehne"
            address: "BpwyJc5i7uBMy2pNm5Vv8HMkwXqBR3kCxS"
        }
    }
}
