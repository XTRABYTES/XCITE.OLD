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
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0

import "qrc:/Controls" as Controls

Rectangle {
    id: calculatorModal
    width: 325
    height: 375
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    property int xbyButton1State: 1
    property int xfuelButton1State: 0
    property int btcButton1State: 0
    property int usdButton1State: 0
    property string fromCurrency: "XBY"
    property var fromAmount: Number.fromLocaleString(Qt.locale(),inputAmount.text)
    property int xbyButton2State: 0
    property int xfuelButton2State: 0
    property int btcButton2State: 0
    property int usdButton2State: 1
    property string toCurrency: "USD"
    property string output: ""


    Rectangle {
        id: calculatorTitleBar
        width: parent.width
        height: 50
        radius: 4
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

        Image {
            id: closeCalculator
            source: 'qrc:/icons/CloseIcon.svg'
            height: 16
            width: 16
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.verticalCenter: calculatorModalLabel.verticalCenter

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: "#F2F2F2"
            }

            MouseArea {
                anchors.fill : parent
                onClicked: {
                    mainRoot.pop("../DashboardForm.qml")
                }
            }
        }
    }

    Rectangle {
        id: calculatorBodyModal
        width: parent.width
        height: parent.height - 50
        radius: 4
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
            color: "#F2F2F2"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            font.weight: Font.Medium
            horizontalAlignment: TextInput.AlignRight
            validator: DoubleValidator {bottom: 0}

        }

        Image {
            id: resetInput
            source: 'qrc:/icons/CloseIcon.svg'
            height: 12
            width: 12
            anchors.left: inputAmount.left
            anchors.leftMargin: 11
            anchors.verticalCenter: inputAmount.verticalCenter

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

        Rectangle {
            id: xbyButton2
            height: 33
            width: (325-55)/4
            radius: 8
            anchors.top: toLabel.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            color: xbyButton2State == 1 ? "#5E8BFF" : "#2A2C31"

            Text {
                id: xbyButton2Label
                text : "XBY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: xbyButton2State == 1 ? "#F2F2F2" : "#5F5F5F"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (xbyButton2State == 0){
                        xbyButton2State = 1
                        toCurrency = "XBY"
                        xfuelButton2State = 0
                        btcButton2State = 0
                        usdButton2State = 0
                    }
                }
            }
        }

        Rectangle {
            id: xfuelButton2
            height: 33
            width: (325-55)/4
            radius: 8
            anchors.top: xbyButton2.top
            anchors.left: xbyButton2.right
            anchors.leftMargin: 5
            color: xfuelButton2State == 1 ? "#5E8BFF" : "#2A2C31"

            Text {
                id: xfuelButton2Label
                text : "XFUEL"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: xfuelButton2State == 1 ? "#F2F2F2" : "#5F5F5F"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (xfuelButton2State == 0) {
                        xfuelButton2State = 1
                        toCurrency = "XFUEL"
                        xbyButton2State = 0
                        btcButton2State = 0
                        usdButton2State = 0
                    }
                }
            }
        }

        Rectangle {
            id: btcButton2
            height: 33
            width: (325-55)/4
            radius: 8
            anchors.top: xbyButton2.top
            anchors.left: xfuelButton2.right
            anchors.leftMargin: 5
            color: btcButton2State == 1 ? "#5E8BFF" : "#2A2C31"

            Text {
                id: btcButton2Label
                text : "BTC"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: btcButton2State == 1 ? "#F2F2F2" : "#5F5F5F"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (btcButton2State == 0) {
                        btcButton2State = 1
                        toCurrency = "BTC"
                        xbyButton2State = 0
                        xfuelButton2State = 0
                        usdButton2State = 0
                    }
                }
            }
        }

        Rectangle {
            id: usdButton2
            height: 33
            width: (325-55)/4
            radius: 8
            anchors.top: xbyButton2.top
            anchors.left: btcButton2.right
            anchors.leftMargin: 5
            color: usdButton2State == 1 ? "#5E8BFF" : "#2A2C31"

            Text {
                id: usdButton2Label
                text : "USD"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: usdButton2State == 1 ? "#F2F2F2" : "#5F5F5F"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (usdButton2State == 0) {
                        usdButton2State = 1
                        toCurrency = "USD"
                        xbyButton2State = 0
                        xfuelButton2State = 0
                        btcButton2State = 0
                    }
                }
            }
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
                        if (toCurrency == "USD") {
                            (fromAmount * valueXBY).toLocaleString(Qt.locale(), "f", 2)
                        }
                        if (toCurrency == "BTC") {
                            (fromAmount * btcValueXBY).toLocaleString(Qt.locale(), "f", 8)
                        }
                        if (toCurrency == "XFUEL") {
                            ((fromAmount * btcValueXBY)/btcValueXFUEL).toLocaleString(Qt.locale(), "f", 8)
                        }
                        if (toCurrency == "XBY") {
                            (inputAmount.text)
                        }
                    }
                    if (fromCurrency == "XFUEL") {
                        if (toCurrency == "USD") {
                            (fromAmount* valueXFUEL).toLocaleString(Qt.locale(), "f", 2)
                        }
                        if (toCurrency == "BTC") {
                            (fromAmount * btcValueXFUEL).toLocaleString(Qt.locale(), "f", 8)
                        }
                        if (toCurrency == "XBY") {
                            ((fromAmount * btcValueXFUEL)/btcValueXBY).toLocaleString(Qt.locale(), "f", 8)
                        }
                        if (toCurrency == "XFUEL") {
                            (inputAmount.text)
                        }
                    }
                    if (fromCurrency == "BTC") {
                        if (toCurrency == "USD") {
                            (fromAmount / valueBTC).toLocaleString(Qt.locale(), "f", 2)
                        }
                        if (toCurrency == "XBY") {
                            (fromAmount / btcValueXBY).toLocaleString(Qt.locale(), "f", 8)
                        }
                        if (toCurrency == "XFUEL") {
                            (fromAmount / btcValueXFUEL).toLocaleString(Qt.locale(), "f", 8)
                        }
                        if (toCurrency == "BTC") {
                            (inputAmount.text)
                        }
                    }
                    if (fromCurrency == "USD") {
                        if (toCurrency == "XBY") {
                            (fromAmount / valueXBY).toLocaleString(Qt.locale(), "f", 8)
                        }
                        if (toCurrency == "XFUEL") {
                            (fromAmount / valueXFUEL).toLocaleString(Qt.locale(), "f", 8)
                        }
                        if (toCurrency == "BTC") {
                            (fromAmount / valueBTC).toLocaleString(Qt.locale(), "f", 8)
                        }
                        if (toCurrency == "USD") {
                           (inputAmount.text)
                        }
                    }
                }
                else {
                    ""
                }
            }
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: xbyButton2.bottom
            anchors.topMargin: 20
            color: "#F2F2F2"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            font.weight: Font.Medium
            readOnly: true
        }

        Label {
            id: outputAmountTicker
            text: toCurrency
            rightPadding: 0
            font.family: "Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: "#F2F2F2"
            anchors.right: usdButton2.right
            anchors.verticalCenter: outputAmount.verticalCenter
        }
    }
}
