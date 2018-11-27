/**
 * Filename: CryptoCalculator.qml
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

import "qrc:/Controls" as Controls

Rectangle {
    id: calculatorModal
    width: 325
    height: 375
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 50

    property int xbyButton1State: 0
    property int xfuelButton1State: 0
    property int btcButton1State: 0
    property int usdButton1State: 1
    property string fromCurrency: "USD"
    property var fromAmount: Number.fromLocaleString(Qt.locale("en_US"),inputAmount.text)
    property string toCurrency: "XBY"
    property string output: ""


    Rectangle {
        id: calculatorTitleBar
        width: parent.width
        height: 50
        anchors.top: parent.top
        anchors.left: parent.left
        color: "#34363D"

        Text {
            id: calculatorModalLabel
            text: "CRYPTO CONVERTER"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -3
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            color: "#F2F2F2"
        }
    }

    Rectangle {
        id: calculatorBodyModal
        width: parent.width
        height: parent.height - 50
        color: "#42454F"
        anchors.top: parent.top
        anchors.topMargin: 46

        Label {
            id: fromLabel
            text: "from:"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: "#F2F2F2"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20

        }

        Rectangle {
            id: xbyButton1
            height: 33
            width: (325-55)/4
            radius: 8
            anchors.top: fromLabel.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            color: xbyButton1State == 1 ? "#5E8BFF" : "#2A2C31"

            Text {
                id: xbyButton1Label
                text : "XBY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: xbyButton1State == 1 ? "#F2F2F2" : "#5F5F5F"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (xbyButton1State == 0){
                        xbyButton1State = 1
                        fromCurrency = "XBY"
                        xfuelButton1State = 0
                        btcButton1State = 0
                        usdButton1State = 0
                    }
                }
            }
        }

        Rectangle {
            id: xfuelButton1
            height: 33
            width: (325-55)/4
            radius: 8
            anchors.top: xbyButton1.top
            anchors.left: xbyButton1.right
            anchors.leftMargin: 5
            color: xfuelButton1State == 1 ? "#5E8BFF" : "#2A2C31"

            Text {
                id: xfuelButton1Label
                text : "XFUEL"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: xfuelButton1State == 1 ? "#F2F2F2" : "#5F5F5F"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (xfuelButton1State == 0) {
                        xfuelButton1State = 1
                        fromCurrency = "XFUEL"
                        xbyButton1State = 0
                        btcButton1State = 0
                        usdButton1State = 0
                    }
                }
            }
        }

        Rectangle {
            id: btcButton1
            height: 33
            width: (325-55)/4
            radius: 8
            anchors.top: xbyButton1.top
            anchors.left: xfuelButton1.right
            anchors.leftMargin: 5
            color: btcButton1State == 1 ? "#5E8BFF" : "#2A2C31"

            Text {
                id: btcButton1Label
                text : "BTC"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: btcButton1State == 1 ? "#F2F2F2" : "#5F5F5F"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (btcButton1State == 0) {
                        btcButton1State = 1
                        fromCurrency = "BTC"
                        xbyButton1State = 0
                        xfuelButton1State = 0
                        usdButton1State = 0
                    }
                }
            }
        }

        Rectangle {
            id: usdButton1
            height: 33
            width: (325-55)/4
            radius: 8
            anchors.top: xbyButton1.top
            anchors.left: btcButton1.right
            anchors.leftMargin: 5
            color: usdButton1State == 1 ? "#5E8BFF" : "#2A2C31"

            Text {
                id: usdButton1Label
                text : "USD"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: usdButton1State == 1 ? "#F2F2F2" : "#5F5F5F"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (usdButton1State == 0) {
                        usdButton1State = 1
                        fromCurrency = "USD"
                        xbyButton1State = 0
                        xfuelButton1State = 0
                        btcButton1State = 0
                    }
                }
            }
        }

        Controls.TextInput {
            id: inputAmount
            height: 34
            width: 210
            placeholder: "0"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: xbyButton1.bottom
            anchors.topMargin: 20
            leftPadding: 42
            color: "#F2F2F2"
            font.pixelSize: 14
            horizontalAlignment: TextInput.AlignRight
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            validator: DoubleValidator {bottom: 0}
            mobile: 1
            deleteBtn: 0

        }

        Image {
            id: resetInput
            source: 'qrc:/icons/CloseIcon.svg'
            height: 12
            width: 12
            anchors.left: inputAmount.left
            anchors.leftMargin: 11
            anchors.verticalCenter: inputAmount.verticalCenter
            visible: inputAmount.text != ""

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: "#F2F2F2"
            }

            MouseArea {
                anchors.fill : parent
                onClicked: {
                    inputAmount.text = ""
                }
            }
        }

        Label {
            id: inputAmountTicker
            text: fromCurrency
            rightPadding: 0
            font.family: "Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: "#F2F2F2"
            anchors.right: usdButton1.right
            anchors.verticalCenter: inputAmount.verticalCenter
        }

        Label {
            id: toLabel
            text: "to:"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: "#F2F2F2"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: inputAmount.bottom
            anchors.topMargin: 30

        }

        Controls.TextInput {
            id: outputAmount
            height: 34
            width: 210
            placeholder: "0"
            horizontalAlignment: TextInput.AlignRight
            text:{
                if (inputAmount.acceptableInput === true && inputAmount.text !== ""){
                    if (fromCurrency == "XBY") {
                        if (toCurrency == "BTC") {
                            (fromAmount * btcValueXBY).toLocaleString(Qt.locale("en_US"), "f", 8)
                        }
                        else if (toCurrency == "XFUEL") {
                            ((fromAmount * btcValueXBY)/btcValueXFUEL).toLocaleString(Qt.locale("en_US"), "f", 8)
                        }
                        else if (toCurrency == "XBY") {
                            (inputAmount.text)
                        }
                        else if (toCurrency == "ETH") {
                            ((fromAmount * btcValueXBY)/btcValueETH).toLocaleString(Qt.locale("en_US"), "f", 8)
                        }
                    }
                    else if (fromCurrency == "XFUEL") {
                        if (toCurrency == "BTC") {
                            (fromAmount * btcValueXFUEL).toLocaleString(Qt.locale("en_US"), "f", 8)
                        }
                        else if (toCurrency == "XBY") {
                            ((fromAmount * btcValueXFUEL)/btcValueXBY).toLocaleString(Qt.locale("en_US"), "f", 8)
                        }
                        else if (toCurrency == "XFUEL") {
                            (inputAmount.text)
                        }
                        else if (toCurrency == "ETH") {
                            ((fromAmount * btcValueXBY)/btcValueETH).toLocaleString(Qt.locale("en_US"), "f", 8)
                        }
                    }
                    else if (fromCurrency == "BTC") {
                        if (toCurrency == "XBY") {
                            (fromAmount / btcValueXBY).toLocaleString(Qt.locale("en_US"), "f", 8)
                        }
                        else if (toCurrency == "XFUEL") {
                            (fromAmount / btcValueXFUEL).toLocaleString(Qt.locale("en_US"), "f", 8)
                        }
                        else if (toCurrency == "BTC") {
                            (inputAmount.text)
                        }
                        else if (toCurrency == "ETH") {
                            (fromAmount / btcValueETH).toLocaleString(Qt.locale("en_US"), "f", 8)
                        }
                    }
                    else if (fromCurrency == "USD") {
                        if (toCurrency == "XBY") {
                            (fromAmount / valueXBY).toLocaleString(Qt.locale("en_US"), "f", 8)
                        }
                        else if (toCurrency == "XFUEL") {
                            (fromAmount / valueXFUEL).toLocaleString(Qt.locale("en_US"), "f", 8)
                        }
                        else if (toCurrency == "BTC") {
                            (fromAmount / valueBTC).toLocaleString(Qt.locale("en_US"), "f", 8)
                        }
                        else if (toCurrency == "ETH") {
                            (fromAmount / valueETH).toLocaleString(Qt.locale("en_US"), "f", 8)
                        }
                    }
                }
                else {
                    ""
                }
            }
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: toLabel.bottom
            anchors.topMargin: 20
            color: "#F2F2F2"
            font.pixelSize: 14
            readOnly: true
            mobile: 1
            deleteBtn: 0
        }

        Label {
            id: outputAmountTicker
            text: toCurrency
            rightPadding: 0
            font.family: "Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: "#F2F2F2"
            anchors.right: usdButton1.right
            anchors.verticalCenter: outputAmount.verticalCenter
        }

        Rectangle {
            id: confirmationSendButton
            width: (doubbleButtonWidth - 10) / 2
            height: 33
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 5
            radius: 5
            color: "#4BBE2E"

            MouseArea {
                anchors.fill: confirmationSendButton
                onClicked: {
                    calculatedAmount = Number.fromLocaleString(Qt.locale("en_US"),outputAmount.text)
                    calculatorTracker = 0
                    inputAmount.text = ""
                }
            }

            Text {
                text: "CONFIRM"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#F2F2F2"
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Rectangle {
            id: cancelSendButton
            width: (doubbleButtonWidth - 10) / 2
            height: 33
            radius: 5
            color: "#E55541"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 5

            MouseArea {
                anchors.fill: cancelSendButton

                onClicked: {
                    calculatorTracker = 0
                }
            }

            Text {
                text: "CANCEL"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#F2F2F2"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
