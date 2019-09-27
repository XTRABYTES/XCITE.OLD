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
    width: Screen.width
    height: Screen.height

    Rectangle {
        width: parent.width
        height: parent.height
        color: darktheme == false? "#F7F7F7" : "#14161B"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        LinearGradient {
                anchors.fill: parent
                source: parent
                start: Qt.point(0, 0)
                end: Qt.point(0, parent.height)
                opacity: darktheme == false? 0.05 : 0.2
                gradient: Gradient {
                    GradientStop { position: 0.0; color: darktheme == false?"#00072778" : "#FF162124" }
                    GradientStop { position: 1.0; color: darktheme == false?"#FF072778" : "#00162124" }
                }
        }

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
                else if (toCurrency == "ETH") {
                    if (((fromAmount * btcValueXBY)/btcValueETH) >= 1000000) {
                        decimals = 2
                    }
                    else if ((((fromAmount * btcValueXBY)/btcValueETH) <= 1000000) && (((fromAmount * btcValueXBY)/btcValueETH) >= 1000)) {
                        decimals = 4
                    }
                    else {
                        decimals = 8
                    }
                    newAmount = ((fromAmount * btcValueXBY)/btcValueETH).toLocaleString(Qt.locale("en_US"), "f", decimals)
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
                else if (toCurrency == "ETH") {
                    if (((fromAmount * btcValueXFUEL)/btcValueETH) >= 1000000) {
                        decimals = 2
                    }
                    else if ((((fromAmount * btcValueXFUEL)/btcValueETH) <= 1000000) && (((fromAmount * btcValueXFUEL)/btcValueETH) >= 1000)) {
                        decimals = 4
                    }
                    else {
                        decimals = 8
                    }
                    newAmount = ((fromAmount * btcValueXFUEL)/btcValueETH).toLocaleString(Qt.locale("en_US"), "f", decimals)
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
                else if (toCurrency == "ETH") {
                    if ((fromAmount / btcValueETH) >= 1000000) {
                        decimals = 2
                    }
                    else if (((fromAmount / btcValueETH) <= 1000000) && ((fromAmount / btcValueETH) >= 1000)) {
                        decimals = 4
                    }
                    else {
                        decimals = 8
                    }
                    newAmount = (fromAmount / btcValueETH).toLocaleString(Qt.locale("en_US"), "f", decimals)
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
                else if (toCurrency == "ETH") {
                    if ((fromAmount / valueETH) >= 1000000) {
                        decimals = 2
                    }
                    else if (((fromAmount / valueETH) <= 1000000) && ((fromAmount / valueETH) >= 1000)) {
                        decimals = 4
                    }
                    else {
                        decimals = 8
                    }
                    newAmount = (fromAmount / valueETH).toLocaleString(Qt.locale("en_US"), "f", decimals)
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
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
    }

    Controls.TextInput {
        id: inputAmount
        height: 34
        placeholder: "0"
        anchors.left: confirmationSendButton.left
        anchors.right: btcButton1.right
        anchors.top: calculatorModalLabel.bottom
        anchors.topMargin: 25
        color: "#0ED8D2"
        textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
        font.pixelSize: 14
        font.bold: true
        horizontalAlignment: TextInput.AlignRight
        mobile: 1
        deleteBtn: 0
        readOnly: true
    }

    Label {
        id: inputAmountTicker
        text: fromCurrency == "FIAT"? fiatCurrencies.get(userSettings.defaultCurrency).currency : fromCurrency
        rightPadding: 0
        font.family: xciteMobile.name
        font.pointSize: 20
        font.bold: true
        color: darktheme == false? "#2A2C31" : "#F2F2F2"
        anchors.right: usdButton1.right
        anchors.verticalCenter: inputAmount.verticalCenter
        anchors.verticalCenterOffset: -1
    }

    Label {
        id: outputAmount
        anchors.right: inputAmount.right
        anchors.rightMargin: 18
        anchors.top: inputAmount.bottom
        anchors.topMargin: 10
        color: darktheme == false? "#2A2C31" : "#F2F2F2"
        font.family: xciteMobile.name
        font.pixelSize: 20
        font.bold: true
        text: if (inputAmount.text == "") {
                  "0"
              }
              else {
                  convert()
              }
        onTextChanged: detectInteraction()
    }

    Label {
        id: outputAmountTicker
        text: toCurrency
        rightPadding: 0
        font.family: xciteMobile.name
        font.pointSize: 20
        font.bold: true
        color: darktheme == false? "#2A2C31" : "#F2F2F2"
        anchors.right: inputAmountTicker.right
        anchors.verticalCenter: outputAmount.verticalCenter
    }

    Rectangle {
        id: xbyButton1
        height: 34
        width: (Screen.width - 71) / 4
        anchors.top: outputAmountTicker.bottom
        anchors.topMargin: 25
        anchors.left: inputAmount.left
        color: xbyButton1State == 1 ? maincolor : "transparent"
        border.color: xbyButton1State == 0 ? maincolor : "transparent"
        border.width: 1

        Text {
            id: xbyButton1Label
            text : "XBY"
            font.family: xciteMobile.name
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
        height: 34
        width: (Screen.width - 71) / 4
        anchors.top: xbyButton1.top
        anchors.left: xbyButton1.right
        anchors.leftMargin: 5
        color: xfuelButton1State == 1 ? maincolor : "transparent"
        border.color: xfuelButton1State == 0 ? maincolor : "transparent"
        border.width: 1

        Text {
            id: xfuelButton1Label
            text : "XFUEL"
            font.family: xciteMobile.name
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
        height: 34
        width: (Screen.width - 71) / 4
        anchors.top: xbyButton1.top
        anchors.left: xfuelButton1.right
        anchors.leftMargin: 5
        color: btcButton1State == 1 ? maincolor : "transparent"
        border.color: btcButton1State == 0 ? maincolor : "transparent"
        border.width: 1

        Text {
            id: btcButton1Label
            text : "BTC"
            font.family: xciteMobile.name
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
        height: 34
        width: (Screen.width - 71) / 4
        anchors.top: xbyButton1.top
        anchors.left: btcButton1.right
        anchors.leftMargin: 5
        color: usdButton1State == 1 ? maincolor : "transparent"
        border.color: usdButton1State == 0 ? maincolor : "transparent"
        border.width: 1

        Text {
            id: usdButton1Label
            text : fiatCurrencies.get(userSettings.defaultCurrency).currency
            font.family: xciteMobile.name
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
        width: (Screen.width - 76) / 3
        anchors.top: xbyButton1.bottom
        anchors.topMargin: 20
        anchors.left: inputAmount.left
        color: "transparent"
        border.color: maincolor
        border.width: 1

        Text {
            id: button1Label
            text : "1"
            font.family: xciteMobile.name
            font.pointSize: 20
            font.bold: true
            color: maincolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button1.color = maincolor
                button1.border.color = "transparent"
                button1Label.color = "#F2F2F2"
                inputAmount.text = inputAmount.text + "1"
            }
            onReleased: {
                button1.color = "transparent"
                button1.border.color = maincolor
                button1Label.color = maincolor
            }
        }
    }

    Rectangle {
        id: button2
        height: 50
        width: (Screen.width - 76) / 3
        anchors.top: button1.top
        anchors.left: button1.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 1

        Text {
            id: button2Label
            text : "2"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: maincolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button2.color = maincolor
                button2.border.color = "transparent"
                button2Label.color = "#F2F2F2"
                inputAmount.text = inputAmount.text + "2"
            }
            onReleased: {
                button2.color = "transparent"
                button2.border.color = maincolor
                button2Label.color = maincolor
            }
        }
    }

    Rectangle {
        id: button3
        height: 50
        width: (Screen.width - 76) / 3
        anchors.top: button2.top
        anchors.left: button2.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 1

        Text {
            id: button3Label
            text : "3"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: maincolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button3.color = maincolor
                button3.border.color = "transparent"
                button3Label.color = "#F2F2F2"
                inputAmount.text = inputAmount.text + "3"
            }
            onReleased: {
                button3.color = "transparent"
                button3.border.color = maincolor
                button3Label.color = maincolor
            }
        }
    }

    Rectangle {
        id: button4
        height: 50
        width: (Screen.width - 76) / 3
        anchors.top: button1.bottom
        anchors.topMargin: 10
        anchors.left: inputAmount.left
        color: "transparent"
        border.color: maincolor
        border.width: 1

        Text {
            id: button4Label
            text : "4"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: maincolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button4.color = maincolor
                button4.border.color = "transparent"
                button4Label.color = "#F2F2F2"
                inputAmount.text = inputAmount.text + "4"
            }
            onReleased: {
                button4.color = "transparent"
                button4.border.color = maincolor
                button4Label.color = maincolor
            }
        }
    }

    Rectangle {
        id: button5
        height: 50
        width: (Screen.width - 76) / 3
        anchors.top: button4.top
        anchors.left: button4.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 1

        Text {
            id: button5Label
            text : "5"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: maincolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button5.color = maincolor
                button5.border.color = "transparent"
                button5Label.color = "#F2F2F2"
                inputAmount.text = inputAmount.text + "5"
            }
            onReleased: {
                button5.color = "transparent"
                button5.border.color = maincolor
                button5Label.color = maincolor
            }
        }
    }

    Rectangle {
        id: button6
        height: 50
        width: (Screen.width - 76) / 3
        anchors.top: button5.top
        anchors.left: button5.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 1

        Text {
            id: button6Label
            text : "6"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: maincolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button6.color = maincolor
                button6.border.color = "transparent"
                button6Label.color = "#F2F2F2"
                inputAmount.text = inputAmount.text + "6"
            }
            onReleased: {
                button6.color = "transparent"
                button6.border.color = maincolor
                button6Label.color = maincolor
            }
        }
    }

    Rectangle {
        id: button7
        height: 50
        width: (Screen.width - 76) / 3
        anchors.top: button4.bottom
        anchors.topMargin: 10
        anchors.left: inputAmount.left
        color: "transparent"
        border.color: maincolor
        border.width: 1

        Text {
            id: button7Label
            text : "7"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: maincolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button7.color = maincolor
                button7.border.color = "transparent"
                button7Label.color = "#F2F2F2"
                inputAmount.text = inputAmount.text + "7"
            }
            onReleased: {
                button7.color = "transparent"
                button7.border.color = maincolor
                button7Label.color = maincolor
            }
        }
    }

    Rectangle {
        id: button8
        height: 50
        width: (Screen.width - 76) / 3
        anchors.top: button7.top
        anchors.left: button7.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 1

        Text {
            id: button8Label
            text : "8"
            font.family: xciteMobile.name
            font.pointSize: 20
            font.bold: true
            color: maincolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button8.color = maincolor
                button8.border.color = "transparent"
                button8Label.color = "#F2F2F2"
                inputAmount.text = inputAmount.text + "8"
            }
            onReleased: {
                button8.color = "transparent"
                button8.border.color = maincolor
                button8Label.color = maincolor
            }
        }
    }

    Rectangle {
        id: button9
        height: 50
        width: (Screen.width - 76) / 3
        anchors.top: button8.top
        anchors.left: button8.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 1

        Text {
            id: button9Label
            text : "9"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: maincolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button9.color = maincolor
                button9.border.color = "transparent"
                button9Label.color = "#F2F2F2"
                inputAmount.text = inputAmount.text + "9"
            }
            onReleased: {
                button9.color = "transparent"
                button9.border.color = maincolor
                button9Label.color = maincolor
            }
        }
    }

    Rectangle {
        id: buttonC
        height: 50
        width: (Screen.width - 76) / 3
        anchors.top: button7.bottom
        anchors.topMargin: 10
        anchors.left: inputAmount.left
        color: "transparent"
        border.color: maincolor
        border.width: 1

        Text {
            id: buttonCLabel
            text : "C"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: maincolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                buttonC.color = maincolor
                buttonC.border.color = "transparent"
                buttonCLabel.color = "#F2F2F2"
                inputAmount.text = (inputAmount.text).slice(0, - 1)
            }
            onReleased: {
                buttonC.color = "transparent"
                buttonC.border.color = maincolor
                buttonCLabel.color = maincolor
            }

            onPressAndHold: {
                inputAmount.text = ""
            }
        }
    }

    Rectangle {
        id: button0
        height: 50
        width: (Screen.width - 76) / 3
        anchors.top: buttonC.top
        anchors.left: buttonC.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 1

        Text {
            id: button0Label
            text : "0"
            font.family: xciteMobile.name //"Brandon Grotesque"
            font.pointSize: 20
            font.bold: true
            color: maincolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                button0.color = maincolor
                button0.border.color = "transparent"
                button0Label.color = "#F2F2F2"
                if (inputAmount.text != "") {
                    inputAmount.text = inputAmount.text + "0"
                }
            }
            onReleased: {
                button0.color = "transparent"
                button0.border.color = maincolor
                button0Label.color = maincolor
            }
        }
    }

    Rectangle {
        id: buttonDec
        height: 50
        width: (Screen.width - 76) / 3
        anchors.top: button0.top
        anchors.left: button0.right
        anchors.leftMargin: 10
        color: "transparent"
        border.color: maincolor
        border.width: 1

        Text {
            id: buttonDecLabel
            text : "."
            font.family: xciteMobile.name
            font.pointSize: 20
            font.bold: true
            color: maincolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                if(inputAmount.text.includes(".") === false) {
                    buttonDec.color = maincolor
                    buttonDec.border.color = "transparent"
                    buttonDecLabel.color = "#F2F2F2"
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
                buttonDecLabel.color = maincolor
            }
        }
    }

    Rectangle {
        id: confirmationSendButton
        width: (doubbleButtonWidth - 10) / 2
        height: 34
        anchors.top: buttonDec.bottom
        anchors.topMargin: 20
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: 5
        color: "#4BBE2E"
        opacity: 0.5

        MouseArea {
            anchors.fill: confirmationSendButton

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onCanceled: {
            }

            onReleased: {
            }

            onClicked: {
                calculatedAmount = Number.fromLocaleString(Qt.locale("en_US"),outputAmount.text)
                calculatorTracker = 0
                inputAmount.text = ""
            }
        }
    }
    Text {
        text: "CONFIRM"
        font.family: xciteMobile.name
        font.pointSize: 14
        color: "#4BBE2E"
        font.bold: true
        opacity: 0.75
        anchors.horizontalCenter: confirmationSendButton.horizontalCenter
        anchors.verticalCenter: confirmationSendButton.verticalCenter
    }

    Rectangle {
        width: (doubbleButtonWidth - 10) / 2
        height: 34
        anchors.bottom: confirmationSendButton.bottom
        anchors.right: confirmationSendButton.right
        color: "transparent"
        border.color: "#4BBE2E"
        border.width: 1
        opacity: 0.75
    }

    Rectangle {
        id: cancelSendButton
        width: (doubbleButtonWidth - 10) / 2
        height: 34
        anchors.top: buttonDec.bottom
        anchors.topMargin: 20
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: 5
        color: "#E55541"
        opacity: darktheme == true? 0.25 : 0.5

        MouseArea {
            anchors.fill: cancelSendButton

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onCanceled: {
            }

            onReleased: {
            }

            onClicked: {
                calculatorTracker = 0
                inputAmount.text = ""
            }
        }
    }

    Text {
        text: "BACK"
        font.family: xciteMobile.name
        font.pointSize: 14
        font.bold: true
        color: "#E55541"
        opacity: darktheme == true? 0.5 : 0.75
        anchors.horizontalCenter: cancelSendButton.horizontalCenter
        anchors.verticalCenter: cancelSendButton.verticalCenter
    }

    Rectangle {
        width: (doubbleButtonWidth - 10) / 2
        height: 34
        anchors.horizontalCenter: cancelSendButton.horizontalCenter
        anchors.verticalCenter: cancelSendButton.verticalCenter
        color: "transparent"
        border.color: "#E55541"
        border.width: 1
        opacity: darktheme == true? 0.5 : 0.75
    }
}
