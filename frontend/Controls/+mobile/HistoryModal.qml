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
    width: 325
    state: historyTracker == 1? "up" : "down"
    height: 500
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    states: [
        State {
            name: "up"
            PropertyChanges { target: historyModal; anchors.topMargin: 50}
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
            NumberAnimation { target: historyModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.OutCubic}
        }
    ]

    Rectangle {
        id: historysTitleBar
        width: parent.width
        height: 50
        radius: 4
        anchors.top: parent.top
        anchors.left: parent.left
        color: "transparent"

        Text {
            id: historyModalLabel
            text: "TRANSACTION HISTORY"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 27
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            color: "#F2F2F2"
            font.letterSpacing: 2
        }
    }

    Rectangle {
        id: historyBodyModal
        width: parent.width
        height: parent.height - 50
        radius: 4
        color: darktheme == false? "#42454F" : "transparent"
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter


        Image {
            id: newIcon
            source: getLogo(walletList.get(walletIndex).name)
            height: 25
            width: 25
            anchors.left: searchInput.left
            anchors.top: parent.top
            anchors.topMargin: 20
        }

        Label {
            id: newCoinName
            text: walletList.get(walletIndex).name
            anchors.left: newIcon.right
            anchors.leftMargin: 7
            anchors.verticalCenter: newIcon.verticalCenter
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: "#F2F2F2"
        }

        Label {
            id: newWalletLabel
            text: walletList.get(walletIndex).label
            anchors.right: searchInput.right
            anchors.verticalCenter: newIcon.verticalCenter
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: "#F2F2F2"
        }

        Controls.TextInput {
            id: searchInput
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newIcon.bottom
            anchors.topMargin: 25
            placeholder: "SEARCH TRANSACTIONS"
            color: text != ""? "#F2F2F2" : "#727272"
            font.pixelSize: 14
            mobile: 1
        }

        Rectangle {
            id: historyList
            width: searchInput.width
            anchors.top: searchInput.bottom
            anchors.topMargin: 15
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"

            Controls.HistoryList {
                id: myHistory
                searchFilter: searchInput.text
                selectedCoin: newCoinName.text
                selectedWallet: newWalletLabel.text
            }
        }
    }

    Label {
        id: closeHistoryModal
        z: 10
        text: "CLOSE"
        anchors.top: historyBodyModal.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: historyBodyModal.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == false? "#F2F2F2" : maincolor

        Rectangle{
            id: closeButton
            height: 34
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

