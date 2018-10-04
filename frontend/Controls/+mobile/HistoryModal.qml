import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "../Controls" as Controls
/**
  * History Modal
  */
Rectangle {
    id: historyModal
    height: 450
    width: 325
    color: "#42454F"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 120
    visible: historyTracker == 1 && transferTracker != 1
    radius: 4
    z: 155

    Rectangle {
        id: historyModalTop
        height: 50
        width: historyModal.width
        anchors.top: historyModal.top
        anchors.left: historyModal.left
        color: "#34363D"
        radius: 4
        Text {
            id: historyText1
            text: "HISTORY"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: true
            font.pixelSize: 17
        }

        Image {
            id: historyModalClose
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: historyText1.verticalCenter
            anchors.right: historyModalTop.right
            anchors.rightMargin: 30
            width: historyModalClose.height
            height: historyText1.height
            ColorOverlay {
                anchors.fill: historyModalClose
                source: historyModalClose
                color: "white" // make image like it lays under grey glass
            }
            Rectangle {
                id: historyModalButtonArea
                width: historyModalClose.width
                height: historyModalClose.height
                anchors.left: historyModalClose.left
                anchors.top: historyModalClose.top
                color: "transparent"
                MouseArea {
                    anchors.fill: historyModalButtonArea
                    onClicked: historyTracker = 0
                }
            }
        }
    }
    Image {
        id: currencyIconHistory
        source: '../icons/XBY_card_logo_colored_05.svg'
        width: 25
        height: 25
        anchors.left: searchHistory.left
        anchors.top: parent.top
        anchors.topMargin: 65
        Label {
            id: currencyIconHistoryChild
            text: "XBY"
            anchors.left: currencyIconHistory.right
            anchors.leftMargin: 10
            color: "#E5E5E5"
            font.bold: true
            anchors.verticalCenter: currencyIconHistory.verticalCenter
        }
        Image {
            source: '../icons/dropdown_icon.svg'
            width: 12
            height: 12
            anchors.left: currencyIconHistoryChild.right
            anchors.leftMargin: 8
            anchors.verticalCenter: currencyIconHistoryChild.verticalCenter
        }
    }
    Label {
        id: walletChoiceHistory
        text: "MAIN"
        anchors.right: walletDropdownHistory.left
        anchors.rightMargin: 8
        anchors.verticalCenter: currencyIconHistory.verticalCenter
        color: "#E5E5E5"
        font.bold: true
    }
    Image {
        id: walletDropdownHistory
        source: '../icons/dropdown_icon.svg'
        width: 12
        height: 12
        anchors.right: searchHistory.right
        anchors.verticalCenter: walletChoiceHistory.verticalCenter
    }
    Controls.TextInput {
        id: searchHistory
        height: 34
        placeholder: "SEARCH TRANSACTION"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: currencyIconHistory.bottom
        anchors.topMargin: 15
        color: "#727272"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        mobile: 1
    }
    Text {
        id: coinHistoryDate01
        text: "06/05"
        anchors.left: searchHistory.left
        anchors.top: searchHistory.bottom
        anchors.topMargin: 15
        color: "#E5E5E5"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        visible: coinHistoryA1 == 1
    }
    Image {
        id: coinHistoryArrow01
        source: '../icons/left-arrow2.svg'
        width: 10
        height: 8
        ColorOverlay {
            anchors.fill: coinHistoryArrow01
            source: coinHistoryArrow01
            color: "#5DFC36"
        }
        anchors.left: coinHistoryDate01.right
        anchors.leftMargin: 10
        anchors.verticalCenter: coinHistoryDate01.verticalCenter
        visible: coinHistoryA1 == 1
    }
    Text {
        id: coinHistoryContact01
        text: "Golden"
        anchors.left: coinHistoryArrow01.right
        anchors.leftMargin: 10
        anchors.verticalCenter: coinHistoryDate01.verticalCenter
        color: "#E5E5E5"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        visible: coinHistoryA1 == 1
    }
    Text {
        id: coinHistoryAmount01
        text: "+ 5000.0000 XBY"
        anchors.right: coinHistoryScrollA1.left
        anchors.rightMargin: 10
        anchors.verticalCenter: coinHistoryDate01.verticalCenter
        color: "#E5E5E5"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        visible: coinHistoryA1 == 1
    }
    Image {
        id: coinHistoryScrollA1
        source: '../icons/side-arrow-right.svg'
        width: 15
        height: 15
        ColorOverlay {
            anchors.fill: coinHistoryScrollA1
            source: coinHistoryScrollA1
            color: "white"
        }
        anchors.right: searchHistory.right
        anchors.verticalCenter: coinHistoryDate01.verticalCenter
        visible: coinHistoryA1 == 1
        Rectangle {
            id: scrollA1ButtonArea
            width: 15
            height: 15
            anchors.left: coinHistoryScrollA1.left
            anchors.bottom: coinHistoryScrollA1.bottom
            color: "transparent"
            MouseArea {
                anchors.fill: scrollA1ButtonArea
                onClicked: coinHistoryA1 = 0
            }
        }
    }
    Image {
        id: coinHistoryScrollB1
        source: '../icons/side-arrow-left.svg'
        width: 15
        height: 15
        ColorOverlay {
            anchors.fill: coinHistoryScrollB1
            source: coinHistoryScrollB1
            color: "white"
        }
        anchors.left: searchHistory.left
        anchors.verticalCenter: coinHistoryDate01.verticalCenter
        visible: coinHistoryA1 == 0
        Rectangle {
            id: scrollB1ButtonArea
            width: 15
            height: 15
            anchors.left: coinHistoryScrollB1.left
            anchors.bottom: coinHistoryScrollB1.bottom
            color: "transparent"
            MouseArea {
                anchors.fill: scrollB1ButtonArea
                onClicked: coinHistoryA1 = 1
            }
        }
    }
    Text {
        id: coinHistoryToFrom01
        text: "to"
        anchors.left: coinHistoryScrollB1.right
        anchors.leftMargin: 10
        anchors.verticalCenter: coinHistoryDate01.verticalCenter
        color: "#E5E5E5"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        visible: coinHistoryA1 == 0
    }
    Text {
        id: coinHistoryWallet01
        text: "XBY MAIN"
        anchors.left: coinHistoryToFrom01.right
        anchors.leftMargin: 5
        anchors.verticalCenter: coinHistoryDate01.verticalCenter
        color: "#E5E5E5"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        font.bold: true
        visible: coinHistoryA1 == 0
    }
    Text {
        id: coinHistoryReference01
        text: "reference"
        anchors.right: coinHistoryReferenceID01.left
        anchors.rightMargin: 5
        anchors.verticalCenter: coinHistoryDate01.verticalCenter
        color: "#E5E5E5"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        visible: coinHistoryA1 == 0
    }
    Text {
        id: coinHistoryReferenceID01
        text: "Merchandise"
        anchors.right: searchHistory.right
        anchors.verticalCenter: coinHistoryDate01.verticalCenter
        color: "#E5E5E5"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        font.bold: true
        visible: coinHistoryA1 == 0
    }
    Rectangle {
        id: seperatorHistory01
        color: "#575757"
        height: 1
        width: searchHistory.width
        anchors.top: coinHistoryDate01.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Text {
        id: coinHistoryDate02
        text: "06/04"
        anchors.left: searchHistory.left
        anchors.top: seperatorHistory01.bottom
        anchors.topMargin: 15
        color: "#E5E5E5"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        visible: coinHistoryA2 == 1
    }
    Image {
        id: coinHistoryArrow02
        source: '../icons/right-arrow2.svg'
        width: 10
        height: 8
        ColorOverlay {
            anchors.fill: coinHistoryArrow02
            source: coinHistoryArrow02
            color: "#FF0000"
        }
        anchors.left: coinHistoryDate02.right
        anchors.leftMargin: 10
        anchors.verticalCenter: coinHistoryDate02.verticalCenter
        visible: coinHistoryA2 == 1
    }
    Text {
        id: coinHistoryContact02
        text: "Enervey"
        anchors.left: coinHistoryArrow02.right
        anchors.leftMargin: 10
        anchors.verticalCenter: coinHistoryDate02.verticalCenter
        color: "#E5E5E5"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        visible: coinHistoryA2 == 1
    }
    Text {
        id: coinHistoryAmount02
        text: "-259.0000 XBY"
        anchors.right: coinHistoryScrollA2.left
        anchors.rightMargin: 10
        anchors.verticalCenter: coinHistoryDate02.verticalCenter
        color: "#E5E5E5"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        visible: coinHistoryA2 == 1
    }
    Image {
        id: coinHistoryScrollA2
        source: '../icons/side-arrow-right.svg'
        width: 15
        height: 15
        ColorOverlay {
            anchors.fill: coinHistoryScrollA2
            source: coinHistoryScrollA2
            color: "white"
        }
        anchors.right: searchHistory.right
        anchors.verticalCenter: coinHistoryDate02.verticalCenter
        visible: coinHistoryA2 == 1
        Rectangle {
            id: scrollA2ButtonArea
            width: 15
            height: 15
            anchors.left: coinHistoryScrollA2.left
            anchors.bottom: coinHistoryScrollA2.bottom
            color: "transparent"
            MouseArea {
                anchors.fill: scrollA2ButtonArea
                onClicked: coinHistoryA2 = 0
            }
        }
    }
    Image {
        id: coinHistoryScrollB2
        source: '../icons/side-arrow-left.svg'
        width: 15
        height: 15
        ColorOverlay {
            anchors.fill: coinHistoryScrollB2
            source: coinHistoryScrollB2
            color: "white"
        }
        anchors.left: searchHistory.left
        anchors.verticalCenter: coinHistoryDate02.verticalCenter
        visible: coinHistoryA2 == 0
        Rectangle {
            id: scrollB2ButtonArea
            width: 15
            height: 15
            anchors.left: coinHistoryScrollB2.left
            anchors.bottom: coinHistoryScrollB2.bottom
            color: "transparent"
            MouseArea {
                anchors.fill: scrollB2ButtonArea
                onClicked: coinHistoryA2 = 1
            }
        }
    }
    Text {
        id: coinHistoryToFrom02
        text: "from"
        anchors.left: coinHistoryScrollB2.right
        anchors.leftMargin: 10
        anchors.verticalCenter: coinHistoryDate02.verticalCenter
        color: "#E5E5E5"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        visible: coinHistoryA2 == 0
    }
    Text {
        id: coinHistoryWallet02
        text: "XBY ESCROW"
        anchors.left: coinHistoryToFrom02.right
        anchors.leftMargin: 5
        anchors.verticalCenter: coinHistoryDate02.verticalCenter
        color: "#E5E5E5"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        font.bold: true
        visible: coinHistoryA2 == 0
    }
    Text {
        id: coinHistoryReference02
        text: "reference"
        anchors.right: coinHistoryReferenceID02.left
        anchors.rightMargin: 5
        anchors.verticalCenter: coinHistoryDate02.verticalCenter
        color: "#E5E5E5"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        visible: coinHistoryA2 == 0
    }
    Text {
        id: coinHistoryReferenceID02
        text: "Merchandise"
        anchors.right: searchHistory.right
        anchors.verticalCenter: coinHistoryDate02.verticalCenter
        color: "#E5E5E5"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        font.bold: true
        visible: coinHistoryA2 == 0
    }
}
