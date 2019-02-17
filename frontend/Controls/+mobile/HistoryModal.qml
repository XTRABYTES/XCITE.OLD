/**
 * Filename: AddAddressModal.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

import QtQuick.Controls 2.3
import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtMultimedia 5.8

import "qrc:/Controls" as Controls

Rectangle {
    id: historyModal
    width: Screen.width
    state: historyTracker == 1? "up" : "down"
    height: Screen.height
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    states: [
        State {
            name: "up"
            PropertyChanges { target: historyModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: historyModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: historyModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    Text {
        id: historyModalLabel
        text: "TRANSACTION HISTORY"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Image {
        id: newIcon
        source: getLogo(walletList.get(walletIndex).name)
        height: 30
        width: 30
        anchors.left: searchInput.left
        anchors.top: historyModalLabel.bottom
        anchors.topMargin: 30
    }

    Label {
        id: newCoinName
        text: walletList.get(walletIndex).name
        anchors.left: newIcon.right
        anchors.leftMargin: 7
        anchors.verticalCenter: newIcon.verticalCenter
        font.pixelSize: 24
        font.family: "Brandon Grotesque"
        font.weight: Font.Bold
        font.letterSpacing: 2
        color: themecolor
    }

    Label {
        id: newWalletLabel
        text: walletList.get(walletIndex).label
        anchors.right: searchInput.right
        anchors.bottom: newIcon.bottom
        anchors.bottomMargin: 1
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        font.weight: Font.Bold
        color: themecolor
    }

    Controls.TextInput {
        id: searchInput
        height: 34
        width: parent.width - 56
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: newIcon.bottom
        anchors.topMargin: 25
        placeholder: "SEARCH TRANSACTIONS"
        color: text != ""? "#F2F2F2" : "#727272"
        textBackground: "#0B0B09"
        font.pixelSize: 14
        mobile: 1
    }

    Rectangle {
        id: historyList
        width: searchInput.width
        anchors.top: searchInput.bottom
        anchors.topMargin: 15
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"

        Controls.HistoryList {
            id: myHistory
            searchFilter: searchInput.text
            selectedCoin: newCoinName.text
            selectedWallet: newWalletLabel.text
        }
    }

    Item {
        z: 3
        width: Screen.width
        height: 125
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(x, y)
            end: Qt.point(x, y + height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.5; color: darktheme == true? "#14161B" : "#FDFDFD" }
                GradientStop { position: 1.0; color: darktheme == true? "#14161B" : "#FDFDFD" }
            }
        }
    }

    Label {
        id: closeHistoryModal
        z: 10
        text: "CLOSE"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"

        Rectangle{
            id: closeButton
            height: 34
            width: closeHistoryModal.width
            radius: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

        }

        MouseArea {
            anchors.fill: closeButton

            Timer {
                id: timer
                interval: 300
                repeat: false
                running: false

                onTriggered: {
                }
            }

            onPressed: {
                parent.anchors.topMargin = 14
                click01.play()
                detectInteraction()
            }

            onClicked: {
                parent.anchors.topMargin = 10
                if (historyTracker == 1) {
                    historyTracker = 0;
                    timer.start()
                }
            }
        }
    }
}

