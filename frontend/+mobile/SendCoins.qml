/**
 * Filename: SendCoins.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */
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
            text: qsTr("Send XBY")
        }

        /**
        Controls.AddressBook {
        }*/
        Label {
            anchors.top: parent.top
            anchors.topMargin: 40
            text: "Scan QR Code or Manually Input Address to Send XBY"
            color: "#FFFFFF"

            font.weight: Font.Light
            Layout.leftMargin: 5
            font.pointSize: 10
        }
        Controls.MobileTextInput {
            id: sendAmount
            validator: DoubleValidator {
                bottom: 0
            }
            anchors.top: parent.top
            anchors.topMargin: 60
            text: "0.00"
            Layout.fillWidth: true
            Layout.leftMargin: 5
            Layout.rightMargin: 5
            //Layout.topMargin: 100
            Layout.preferredWidth: 80
            Label {
                Layout.leftMargin: 5
                anchors.top: parent.bottom
                anchors.topMargin: 5
                text: "Amount"
                color: "#FFFFFF"
                bottomPadding: 8
                font.weight: Font.Light
                font.pointSize: 12
            }
        }

        Controls.MobileTextInput {
            id: addressInput
            text: Camera.qrCodeString
            Layout.fillWidth: true
            Layout.leftMargin: 5
            Layout.rightMargin: 5
            //Layout.topMargin: 150
            anchors.top: parent.top
            anchors.topMargin: 135
            Layout.preferredWidth: 175
            Label {

                anchors.top: parent.bottom
                anchors.topMargin: 5
                text: "Address"
                color: "#FFFFFF"
                bottomPadding: 8
                font.weight: Font.Light
                Layout.leftMargin: 5
                font.pointSize: 12
            }
        }

        Label {
            id: orLabel
            anchors.top: addressInput.bottom
            anchors.topMargin: 25
            text: "or"
            color: "#FFFFFF"
            bottomPadding: 8
            font.weight: Font.Light
            Layout.leftMargin: 5
            font.pointSize: 12
        }
        Controls.ButtonModal {
            id: scanCode
            anchors.top: orLabel.bottom
            anchors.topMargin: 10
            width: 300
            labelText: "Scan a QR Code"
            anchors.horizontalCenter: parent.horizontalCenter
            colorTracker: 0
            isDanger: false
            isPrimary: true
            onButtonClicked: {
                mainRoot.push("Camera.qml")
            }
        }
        Controls.ButtonModal {
            id: sendButton
            anchors.top: scanCode.bottom
            anchors.topMargin: 20
            width: 300
            labelText: "Send XBY"
            anchors.horizontalCenter: parent.horizontalCenter
            colorTracker: 0
            isDanger: false
            isPrimary: true
        }
        Image {
            id: balanceCount
            anchors.top: sendButton.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 110
            source: "../logos/xby_logo.svg"
            width: 50
            height: 30
        }

        Text {
            anchors.left: balanceCount.left
            anchors.top: sendButton.bottom
            anchors.topMargin: 35
            anchors.leftMargin: 50
            text: "4739.35"
            color: "White"
            font.family: Theme.fontCondensed
            font.pointSize: 14
        }
    }
}
