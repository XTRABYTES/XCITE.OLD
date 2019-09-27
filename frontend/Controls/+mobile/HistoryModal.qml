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
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    property int newHistory: 0

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

    onStateChanged: {
        switchState = 0
    }

    Text {
        id: historyModalLabel
        text: "TRANSACTIONS"
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
        anchors.left: parent.left
        anchors.leftMargin: 28
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
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.left: newCoinName.right
        anchors.leftMargin: 10
        anchors.bottom: newIcon.bottom
        anchors.bottomMargin: 1
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        font.weight: Font.Bold
        color: themecolor
        horizontalAlignment: Text.AlignRight
        elide: Text.ElideRight
    }

    Controls.TextInput {
        id: searchForTransaction
        z: 5
        placeholder: "SEARCH TRANSACTION"
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.top: newIcon.bottom
        anchors.topMargin: 20
        color: searchForTransaction.text != "" ? "#2A2C31" : "#727272"
        textBackground: "#F2F2F2"
        font.pixelSize: 14
        mobile: 1
        deleteImg: 'qrc:/icons/mobile/delete-icon_01_dark.svg'

        onTextChanged: {
            myHistory.searchCriteria = searchForTransaction.text
            myPending.searchCriteria = searchForTransaction.text
        }
    }

    Controls.Switch_mobile {
        id: transactionSwitch
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: searchForTransaction.bottom
        anchors.topMargin: 15
        state: switchState == 0 ? "off" : "on"
        onStateChanged: {
            detectInteraction()
            searchForTransaction.text = ""
        }
    }

    Text {
        id: confirmedText
        text: "CONFIRMED"
        anchors.right: transactionSwitch.left
        anchors.rightMargin: 7
        anchors.verticalCenter: transactionSwitch.verticalCenter
        font.pixelSize: 14
        font.family: xciteMobile.name
        color: transactionSwitch.on ? "#757575" : maincolor
    }

    Text {
        id: pendingText
        text: "PENDING"
        anchors.left: transactionSwitch.right
        anchors.leftMargin: 7
        anchors.verticalCenter: transactionSwitch.verticalCenter
        font.pixelSize: 14
        font.family: xciteMobile.name
        color: transactionSwitch.on ? maincolor : "#757575"
    }

    Label {
        id: historyPrevious
        text: "PREVIOUS"
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.top: transactionSwitch.bottom
        anchors.topMargin: 15
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        visible: currentPage !== 1 && transactionSwitch.state == "off"

        Rectangle {
            anchors.left: historyPrevious.left
            anchors.right: historyPrevious.right
            anchors.verticalCenter: historyPrevious.verticalCenter
            height: historyPrevious.height + 10
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    click01.play()
                    detectInteraction()
                    currentPage = currentPage - 1
                    newHistory = 1
                    updateTransactions(walletList.get(walletIndex).name, walletList.get(walletIndex).address, currentPage)
                }
            }

            Connections {
                target: explorer

                onUpdateTransactions: {
                    if (historyTracker === 1) {
                        loadTransactions(transactions);
                        newHistory = 0
                    }
                }
            }
        }
    }

    Label {
        id: pageCount
        text: "page " + currentPage + " of " + transactionPages
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: transactionSwitch.bottom
        anchors.topMargin: 15
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: transactionPages > 0 && transactionSwitch.state == "off"
    }

    Label {
        id: historyNext
        text: "NEXT"
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.top: transactionSwitch.bottom
        anchors.topMargin: 15
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        visible: currentPage < transactionPages && transactionSwitch.state == "off"

        Rectangle {
            anchors.left: historyNext.left
            anchors.right: historyNext.right
            anchors.verticalCenter: historyNext.verticalCenter
            height: historyNext.height + 10
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    click01.play()
                    detectInteraction()
                    currentPage = currentPage + 1
                    newHistory = 1
                    updateTransactions(walletList.get(walletIndex).name, walletList.get(walletIndex).address, currentPage)
                }
            }

            Connections {
                target: explorer

                onUpdateTransactions: {
                    if (historyTracker === 1) {
                        loadTransactions(transactions);
                        newHistory = 0
                    }
                }
            }
        }
    }

    Rectangle {
        id: history
        width: parent.width
        anchors.top: historyPrevious.bottom
        anchors.topMargin: 5
        anchors.bottom: closeHistoryModal.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        state: (newHistory == 0)? "down" : "up"
        clip: true
        visible: transactionSwitch.state == "off"

        states: [
            State {
                name: "up"
                PropertyChanges { target: myHistory; height: 0}
                PropertyChanges { target: myHistory; anchors.topMargin: -180}
                PropertyChanges { target: myHistory; cardSpacing: -100}
            },
            State {
                name: "down"
                PropertyChanges { target: myHistory; height: parent.height}
                PropertyChanges { target: myHistory; anchors.topMargin: 0}
                PropertyChanges { target: myHistory; cardSpacing: 0}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: myHistory; properties: "height, anchors.topMargin, cardSpacing"; duration: 500; easing.type: Easing.InOutCubic}
            }
        ]


        Controls.HistoryList {
            id: myHistory
        }
    }

    Rectangle {
        id: pending
        width: parent.width
        anchors.top: historyPrevious.bottom
        anchors.topMargin: 5
        anchors.bottom: closeHistoryModal.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        clip: true
        visible: transactionSwitch.state == "on"

        Controls.PendingList {
            id: myPending
        }
    }

    Item {
        z: 12
        width: popupExplorerBusy.width
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -100
        visible: explorerBusy == true && explorerPopup == 1

        Rectangle {
            id: popupExplorerBusy
            height: 50
            width: popupExplorerText.width + 56
            color: "#34363D"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: popupExplorerText
            text: "Explorer is busy. Try again"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: "#E55541"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Timer {
            repeat: false
            running: explorerPopup == 1
            interval: 2000

            onTriggered: explorerPopup = 0
        }
    }

    Item {
        z: 3
        width: Screen.width
        height: myOS === "android"? 125 : 145
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
        anchors.bottomMargin: myOS === "android"? 50 : 70
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
                    switchState = 0
                    transactionPages = 0
                    currentPage = 0
                    historyList.clear()
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

    Controls.TransactionDetailModal {
        id: myTransactionDetails
        z: 10
        anchors.left: parent.left
        anchors.top: parent.top
    }
}

