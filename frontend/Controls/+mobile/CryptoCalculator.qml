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
import QtQuick.Window 2.2
import QtMultimedia 5.8

import "qrc:/Controls" as Controls

Item {
    id: calculatorModal
    width: 325
    height: 560
    anchors.horizontalCenter: Screen.horizontalCenter
    anchors.verticalCenter: Screen.verticalCenter

    Rectangle {
        width: parent.width
        height: parent.height
        radius: darktheme == false? 5 : 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: darktheme == false? "#42454F" : "transparent"
    }

    property int xbyButton1State: 0
    property int xfuelButton1State: 0
    property int btcButton1State: 0
    property int usdButton1State: 1
    property string fromCurrency: "FIAT"
    property var fromAmount: Number.fromLocaleString(Qt.locale("en_US"),inputAmount.text)
    property string toCurrency: "XFUEL"
    property string output: ""
    property int decimals: 0

    function convert() {
        var newAmount = ""
        if (inputAmount.text !== ""){
            if (fromCurrency == "XBY") {
                if (toCurrency == "XFUEL") {
                    if (((fromAmount * btcValueXBY)/btcValueXFUEL) >= 1000000) {
                        decimals = 2
                    }
                    else if ((((fromAmount * btcValueXBY)/btcValueXFUEL) <= 1000000) && (((fromAmount * btcValueXBY)/btcValueXFUEL) >= 1000)) {
                        decimals = 4
                    }
                    else {
                        decimals = 8
                    }
                    newAmount = ((fromAmount * btcValueXBY)/btcValueXFUEL).toLocaleString(Qt.locale("en_US"), "f", decimals)
                }
                else if (toCurrency == "XBY") {
                    if ((fromAmount) >= 1000000) {
                        decimals = 2
                    }
                    else if (((fromAmount) <= 1000000) && ((fromAmount) >= 1000)) {
                        decimals = 4
                    }
                    else {
                        decimals = 8
                    }
                    newAmount = (fromAmount).toLocaleString(Qt.locale("en_US"), "f", decimals)
                }
            }
            else if (fromCurrency == "XFUEL") {
                if (toCurrency == "XBY") {
                    if (((fromAmount * btcValueXFUEL)/btcValueXBY) >= 1000000) {
                        decimals = 2
                    }
                    else if ((((fromAmount * btcValueXFUEL)/btcValueXBY) <= 1000000) && (((fromAmount * btcValueXFUEL)/btcValueXBY) >= 1000)) {
                        decimals = 4
                    }
                    else {
                        decimals = 8
                    }
                    newAmount = ((fromAmount * btcValueXFUEL)/btcValueXBY).toLocaleString(Qt.locale("en_US"), "f", decimals)
                }
                else if (toCurrency == "XFUEL") {
                    if ((fromAmount) >= 1000000) {
                        decimals = 2
                    }
                    else if (((fromAmount) <= 1000000) && ((fromAmount) >= 1000)) {
                        decimals = 4
                    }
                    else {
                        decimals = 8
                    }
                    newAmount = (fromAmount).toLocaleString(Qt.locale("en_US"), "f", decimals)
                }
            }
            else if (fromCurrency == "BTC") {
                if (toCurrency == "XBY") {
                    if ((fromAmount / btcValueXBY) >= 1000000) {
                        decimals = 2
                    }
                    else if (((fromAmount / btcValueXBY) <= 1000000) && ((fromAmount / btcValueXBY) >= 1000)) {
                        decimals = 4
                    }
                    else {
                        decimals = 8
                    }
                    newAmount = (fromAmount / btcValueXBY).toLocaleString(Qt.locale("en_US"), "f", decimals)
                }
                else if (toCurrency == "XFUEL") {
                    if ((fromAmount / btcValueXFUEL) >= 1000000) {
                        decimals = 2
                    }
                    else if (((fromAmount / btcValueXFUEL) <= 1000000) && ((fromAmount / btcValueXFUEL) >= 1000)) {
                        decimals = 4
                    }
                    else {
                        decimals = 8
                    }
                    newAmount = (fromAmount / btcValueXFUEL).toLocaleString(Qt.locale("en_US"), "f", decimals)
                }
            }
            else if (fromCurrency == "FIAT") {
                if (toCurrency == "XBY") {
                    if ((fromAmount / valueXBY) >= 1000000) {
                        decimals = 2
                    }
                    else if (((fromAmount / valueXBY) <= 1000000) && ((fromAmount / valueXBY) >= 1000)) {
                        decimals = 4
                    }
                    else {
                        decimals = 8
                    }
                    newAmount = (fromAmount / valueXBY).toLocaleString(Qt.locale("en_US"), "f", decimals)
                }
                else if (toCurrency == "XFUEL") {
                    if ((fromAmount / valueXFUEL) >= 1000000) {
                        decimals = 2
                    }
                    else if (((fromAmount / valueXFUEL) <= 1000000) && ((fromAmount / valueXFUEL) >= 1000)) {
                        decimals = 4
                    }
                    else {
                        decimals = 8
                    }
                    newAmount = (fromAmount / valueXFUEL).toLocaleString(Qt.locale("en_US"), "f", decimals)
                }
            }
        }
        else {
            newAmount = ""
        }
        return newAmount
    }


    Text {
        id: calculatorModalLabel
        text: "CONVERTER"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.top
        anchors.verticalCenterOffset: 25
        font.pixelSize: 18
        font.family: xciteMobile.name //"Brandon Grotesque"
        color: "#F2F2F2"
    }

    Controls.TextInput {
        id: inputAmount
        height: 34
        width: 205
        placeholder: "0"
        anchors.left: parent.left
        anchors.leftMargin: 25
        anchors.top: calculatorModalLabel.bottom
        anchors.topMargin: 25
        color: "#0ED8D2"
        font.pixelSize: 14
        font.bold: true
        horizontalAlignment: TextInput.AlignRight
        mobile: 1
        deleteBtn: 0
        readOnly: true
    }

    Label {
        id: inputAmountTicker
        text: fromCurrency
        rightPadding: 0
        font.family: xciteMobile.name //"Brandon Grotesque"
        font.pointSize: 20
        font.bold: true
        color: "#F2F2F2"
        anchors.right: parent.right
        anchors.rightMargin: 25
        anchors.verticalCenter: inputAmount.verticalCenter
        anchors.verticalCenterOffset: -1
    }

    Label {
        id: outputAmount
        anchors.right: inputAmount.right
        anchors.rightMargin: 18
        anchors.top: inputAmount.bottom
        anchors.topMargin: 10
        color: "#F2F2F2"
        font.family: xciteMobile.name
        font.pixelSize: 20
        font.bold: true
        text: if (inputAmount.text == "") {
                  "0"
              }
              else {
                  convert()
              }
    }

    Label {
        id: outputAmountTicker
        text: toCurrency
        rightPadding: 0
        font.family: xciteMobile.name //"Brandon Grotesque"
        font.pointSize: 20
        font.bold: true
        color: "#F2F2F2"
        anchors.right: inputAmountTicker.right
        anchors.verticalCenter: outputAmount.verticalCenter
    }

    Rectangle {
        id: xbyButton1
        height: 33
        width: 65
        radius: 5
        anchors.top: outputAmountTicker.bottom
        anchors.topMargin: 25
        anchors.left: parent.left
        anchors.leftMargin: 25
        color: xbyButton1State == 1 ? maincolor : "transparent"
        border.color: xbyButton1State == 0 ? maincolor : "transparent"
        border.width: 2

        Text {
            id: xbyButton1Label
            text : "XBY"
            font.family: xciteMobile.name //"Brandon Grotesque"
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
        width: 65
        radius: 5
        anchors.top: xbyButton1.top
        anchors.left: xbyButton1.right
        anchors.leftMargin: 5
        color: xfuelButton1State == 1 ? maincolor : "transparent"
        border.color: xfuelButton1State == 0 ? maincolor : "transparent"
        border.width: 2

        Text {
            id: xfuelButton1Label
            text : "XFUEL"
            font.family: xciteMobile.name //"Brandon Grotesque"
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
        width: 65
        radius: 5
        anchors.top: xbyButton1.top
        anchors.left: xfuelButton1.right
        anchors.leftMargin: 5
        color: btcButton1State == 1 ? maincolor : "transparent"
        border.color: btcButton1State == 0 ? maincolor : "transparent"
        border.width: 2

        Text {
            id: btcButton1Label
            text : "BTC"
            font.family: xciteMobile.name //"Brandon Grotesque"
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
        width: 65
        radius: 5
        anchors.top: xbyButton1.top
        anchors.left: btcButton1.right
        anchors.leftMargin: 5
        color: usdButton1State == 1 ? maincolor : "transparent"
        border.color: usdButton1State == 0 ? maincolor : "transparent"
        border.width: 2

        Text {
            id: usdButton1Label
            text : settings.defaultCurrency
            font.family: xciteMobile.name //"Brandon Grotesque"
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
                    fromCurrency = "FIAT"
                    xbyButton1State = 0
                    xfuelButton1State = 0
                    btcButton1State = 0
                }
            }
        }
    }

    Rectangle {
        id: button1
        height: 50
        width: 85
        radius: 5
        anchors.top: xbyButton1.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 25
        color: "transparent"
        border.color: maincolor
        border.width: 2

        Text {
            id: button1Label
            text : "1"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button1.color = maincolor
                button1.border.color = "transparent"
                inputAmount.text = inputAmount.text + "1"
            }
            onReleased: {
                button1.color = "transparent"
                button1.border.color = maincolor
            }
        }
    }

    Rectangle {
        id: button2
        height: 50
        width: 85
        radius: 5
        anchors.top: button1.top
        anchors.left: button1.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 2

        Text {
            id: button2Label
            text : "2"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button2.color = maincolor
                button2.border.color = "transparent"
                inputAmount.text = inputAmount.text + "2"
            }
            onReleased: {
                button2.color = "transparent"
                button2.border.color = maincolor
            }
        }
    }

    Rectangle {
        id: button3
        height: 50
        width: 85
        radius: 5
        anchors.top: button2.top
        anchors.left: button2.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 2

        Text {
            id: button3Label
            text : "3"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button3.color = maincolor
                button3.border.color = "transparent"
                inputAmount.text = inputAmount.text + "3"
            }
            onReleased: {
                button3.color = "transparent"
                button3.border.color = maincolor
            }
        }
    }

    Rectangle {
        id: button4
        height: 50
        width: 85
        radius: 5
        anchors.top: button1.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 25
        color: "transparent"
        border.color: maincolor
        border.width: 2

        Text {
            id: button4Label
            text : "4"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button4.color = maincolor
                button4.border.color = "transparent"
                inputAmount.text = inputAmount.text + "4"
            }
            onReleased: {
                button4.color = "transparent"
                button4.border.color = maincolor
            }
        }
    }

    Rectangle {
        id: button5
        height: 50
        width: 85
        radius: 5
        anchors.top: button4.top
        anchors.left: button4.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 2

        Text {
            id: button5Label
            text : "5"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button5.color = maincolor
                button5.border.color = "transparent"
                inputAmount.text = inputAmount.text + "5"
            }
            onReleased: {
                button5.color = "transparent"
                button5.border.color = maincolor
            }
        }
    }

    Rectangle {
        id: button6
        height: 50
        width: 85
        radius: 5
        anchors.top: button5.top
        anchors.left: button5.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 2

        Text {
            id: button6Label
            text : "6"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button6.color = maincolor
                button6.border.color = "transparent"
                inputAmount.text = inputAmount.text + "6"
            }
            onReleased: {
                button6.color = "transparent"
                button6.border.color = maincolor
            }
        }
    }

    Rectangle {
        id: button7
        height: 50
        width: 85
        radius: 5
        anchors.top: button4.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 25
        color: "transparent"
        border.color: maincolor
        border.width: 2

        Text {
            id: button7Label
            text : "7"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button7.color = maincolor
                button7.border.color = "transparent"
                inputAmount.text = inputAmount.text + "7"
            }
            onReleased: {
                button7.color = "transparent"
                button7.border.color = maincolor
            }
        }
    }

    Rectangle {
        id: button8
        height: 50
        width: 85
        radius: 5
        anchors.top: button7.top
        anchors.left: button7.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 2

        Text {
            id: button8Label
            text : "8"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button8.color = maincolor
                button8.border.color = "transparent"
                inputAmount.text = inputAmount.text + "8"
            }
            onReleased: {
                button8.color = "transparent"
                button8.border.color = maincolor
            }
        }
    }

    Rectangle {
        id: button9
        height: 50
        width: 85
        radius: 5
        anchors.top: button8.top
        anchors.left: button8.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 2

        Text {
            id: button9Label
            text : "9"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button9.color = maincolor
                button9.border.color = "transparent"
                inputAmount.text = inputAmount.text + "9"
            }
            onReleased: {
                button9.color = "transparent"
                button9.border.color = maincolor
            }
        }
    }

    Rectangle {
        id: buttonC
        height: 50
        width: 85
        radius: 5
        anchors.top: button7.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 25
        color: "transparent"
        border.color: maincolor
        border.width: 2

        Text {
            id: buttonCLabel
            text : "C"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                buttonC.color = maincolor
                buttonC.border.color = "transparent"
                inputAmount.text = (inputAmount.text).slice(0, - 1)
            }
            onReleased: {
                buttonC.color = "transparent"
                buttonC.border.color = maincolor
            }

            onPressAndHold: {
                inputAmount.text = ""
            }
        }
    }

    Rectangle {
        id: button0
        height: 50
        width: 85
        radius: 5
        anchors.top: buttonC.top
        anchors.left: buttonC.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 2

        Text {
            id: button0Label
            text : "0"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button0.color = maincolor
                button0.border.color = "transparent"
                if (inputAmount.text != "") {
                    inputAmount.text = inputAmount.text + "0"
                }
            }
            onReleased: {
                button0.color = "transparent"
                button0.border.color = maincolor
            }
        }
    }

    Rectangle {
        id: buttonDec
        height: 50
        width: 85
        radius: 5
        anchors.top: button0.top
        anchors.left: button0.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 2

        Text {
            id: buttonDecLabel
            text : "."
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                if(inputAmount.text.includes(".") === false) {
                    buttonDec.color = maincolor
                    buttonDec.border.color = "transparent"
                    if (inputAmount.text != "") {
                        inputAmount.text = inputAmount.text + "."
                    }
                    else {
                        inputAmount.text = "0."
                    }
                }
            }
            onReleased: {
                buttonDec.color = "transparent"
                buttonDec.border.color = maincolor
            }
        }
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

            onPressed: { click01.play() }

            onClicked: {
                calculatedAmount = Number.fromLocaleString(Qt.locale("en_US"),outputAmount.text)
                calculatorTracker = 0
                inputAmount.text = ""
            }
        }

        Text {
            text: "CONFIRM"
            font.family: xciteMobile.name //"Brandon Grotesque"
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

            onPressed: { click01.play() }

            onClicked: {
                calculatorTracker = 0
                inputAmount.text = ""
            }
        }

        Text {
            text: "CANCEL"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
