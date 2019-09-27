/**
 * Filename: TransactionDetailModal.qml
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
    id: transactionDetailModal
    width: Screen.width
    state: transactionDetailTracker == 1? "up" : "down"
    height: Screen.height
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    states: [
        State {
            name: "up"
            PropertyChanges { target: transactionDetailModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: transactionDetailModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: transactionDetailModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    onStateChanged: {
        selectedAddressList = "input"
        myTransactionAdresses.transactionAddresses = "input"
    }

    MouseArea {
        anchors.fill: parent
    }

    property string selectedAddressList: "input"

    Label {
        id: detailModalLabel
        text: "TRANSACTION DETAILS"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Label {
        id: txidLabel
        text: "Transaction ID:"
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.top: detailModalLabel.bottom
        anchors.topMargin: 30
        font.pixelSize: 18
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Label {
        id: txid
        text: transactionNR
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.right: parent.right
        anchors.rightMargin: 28
        maximumLineCount: 2
        wrapMode: Text.WrapAnywhere
        anchors.top: txidLabel.bottom
        anchors.topMargin: 10
        font.pixelSize: 16
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Label {
        id: timestampLabel
        text: "Date & Time:"
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.top: txid.bottom
        anchors.topMargin: 20
        font.pixelSize: 18
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Label {
        id: timestamp
        text: transactionTimestamp
        anchors.left: timestampLabel.left
        anchors.top: timestampLabel.bottom
        anchors.topMargin: 10
        font.family: xciteMobile.name
        font.pixelSize: 16
        font.bold: true
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Label {
        id: confirmationLabel
        text: "Confirmations"
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.top: timestamp.bottom
        anchors.topMargin: 20
        font.pixelSize: 18
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Label {
        id: confirmationAmount
        text: transactionConfirmations
        anchors.left: confirmationLabel.left
        anchors.top: confirmationLabel.bottom
        anchors.topMargin: 10
        font.family: xciteMobile.name
        font.pixelSize: 18
        font.bold: true
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Label {
        id: amountLabel
        text: "Amount"
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.top: timestamp.bottom
        anchors.topMargin: 20
        font.pixelSize: 18
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Label {
        id: amountTicker
        text: walletList.get(walletIndex).name
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.top: amountLabel.bottom
        anchors.topMargin: 10
        font.family: xciteMobile.name
        font.pixelSize: 18
        font.bold: true
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Label {
        property int decimals: transactionAmount == 0? 2 : (transactionAmount <= 1000 ? 8 : (transactionAmount <= 1000000 ? 4 : 2))
        property var amountArray: (transactionAmount.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
        id: amountValue1
        text: "." + amountArray[1]
        anchors.right: amountTicker.left
        anchors.rightMargin: 3
        anchors.bottom: amountTicker.bottom
        anchors.bottomMargin: 1
        font.family: xciteMobile.name
        font.pixelSize: 14
        font.bold: true
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Label {
        property int decimals: transactionAmount == 0? 2 : (transactionAmount <= 1000 ? 8 : (transactionAmount <= 1000000 ? 4 : 2))
        property var amountArray: (transactionAmount.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
        id: amountValue2
        text: amountArray[0]
        anchors.right: amountValue1.left
        anchors.bottom: amountTicker.bottom
        font.family: xciteMobile.name
        font.pixelSize: 18
        font.bold: true
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Timer {
        id: timer
        interval: 500
        repeat: false
        running: false
        onTriggered:  {
            if (selectedAddressList == "input") {
                myTransactionAdresses.transactionAddresses = "input"
            }
            else if (selectedAddressList == "output") {
                myTransactionAdresses.transactionAddresses = "output"
            }
            addressArea.state = "down"
        }
    }

    Label {
        id: inputLabel
        text: "Paying Addresses"
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.top: confirmationAmount.bottom
        anchors.topMargin: 20
        rightPadding: 5
        horizontalAlignment: Text.AlignLeft
        width: selectedAddressList == "input"? inputLabel.implicitWidth : ((parent.width - 56) - receiveLabel.width)
        font.family: xciteMobile.name
        font.pixelSize: 18
        font.bold: selectedAddressList == "input"
        color: selectedAddressList == "input"? (darktheme == true? "#F2F2F2" : "#2A2C31") : "#979797"
        elide: Text.ElideRight

        Rectangle {
            height: 25
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    addressArea.state = "up"
                    selectedAddressList = "input"
                    timer.start()
                }
            }
        }
    }

    Label {
        id: receiveLabel
        text: "Receiving Addresses"
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.top: confirmationAmount.bottom
        anchors.topMargin: 20
        leftPadding: 5
        horizontalAlignment: Text.AlignRight
        width: selectedAddressList == "output"? receiveLabel.implicitWidth : ((parent.width - 56) - inputLabel.width)
        font.family: xciteMobile.name
        font.pixelSize: 18
        font.bold: selectedAddressList == "output"
        color: selectedAddressList == "output"? (darktheme == true? "#F2F2F2" : "#2A2C31") : "#979797"
        elide: Text.ElideRight

        Rectangle {
            height: 25
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    addressArea.state = "up"
                    selectedAddressList = "output"
                    timer.start()
                }
            }
        }
    }

    Rectangle {
        id: addressArea
        width: parent.width
        anchors.top: inputLabel.bottom
        anchors.topMargin: 10
        anchors.bottom: closeDetailModal.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        state: "down"
        clip: true

        states: [
            State {
                name: "up"
                PropertyChanges { target: myTransactionAdresses; height: 0}
                PropertyChanges { target: myTransactionAdresses; anchors.topMargin: -180}
                PropertyChanges { target: myTransactionAdresses; cardSpacing: -100}
            },
            State {
                name: "down"
                PropertyChanges { target: myTransactionAdresses; height: parent.height}
                PropertyChanges { target: myTransactionAdresses; anchors.topMargin: 0}
                PropertyChanges { target: myTransactionAdresses; cardSpacing: 0}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: myTransactionAdresses; properties: "height, anchors.topMargin, cardSpacing"; duration: 500; easing.type: Easing.InOutCubic}
            }
        ]

        Controls.TransactionAddressList {
            id: myTransactionAdresses
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
        id: closeDetailModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : 70
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"

        Rectangle{
            id: closeButton
            height: 34
            width: doubbleButtonWidth / 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"
        }

        MouseArea {
            anchors.fill: closeButton

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                transactionDetailTracker = 0;
                selectedAddressList = "input"
                myTransactionAdresses.transactionAddresses = "input"
                address2Copy = ""
            }
        }
    }
}
