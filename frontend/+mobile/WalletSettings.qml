/**
 * Filename: UserSettings.qml
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
import QtGraphicalEffects 1.0
import QtMultimedia 5.8
import QtQuick.Window 2.2

import "../Controls" as Controls

Rectangle {
    id: backgroundSettings
    z: 1
    width: Screen.width
    height: Screen.height
    color: darktheme == true? "#14161B" : "#FDFDFD"

    MouseArea {
        anchors.fill: parent
    }

    Label {
        id: welcomeText
        z: 1
        text: "SETTINGS"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        color: themecolor
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.bold: true
        font.letterSpacing: 2

        Rectangle {
            width: parent.width
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onDoubleClicked: {
                    debugTracker = 1
                }
            }
        }
    }

    Label {
        id: currencyLabel
        z: 1
        text: "Default wallet currency:"
        font.pixelSize: 16
        font.family: xciteMobile.name
        font.bold: true
        color: themecolor
        anchors.top: welcomeText.bottom
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 28
    }

    Image {
        id: picklistArrow
        z: 1
        source: 'qrc:/icons/dropdown_icon.svg'
        height: 20
        width: 20
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.top: currencyLabel.bottom
        anchors.topMargin: 10
        visible: currencyTracker == 0

        ColorOverlay {
            anchors.fill: parent
            source: parent
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
        }

        Rectangle{
            id: picklistButton
            height: 20
            width: 20
            radius: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
        }

        MouseArea {
            anchors.fill: picklistButton

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                currencyTracker = 1
            }
        }
    }

    Label {
        id: selectedCurrency
        z: 1
        text: fiatCurrencies.get(userSettings.defaultCurrency).currency + " - " + fiatCurrencies.get(userSettings.defaultCurrency).ticker
        font.pixelSize: 20
        font.family: xciteMobile.name
        color: themecolor
        anchors.verticalCenter: picklistArrow.verticalCenter
        anchors.verticalCenterOffset: 1
        anchors.right: picklistArrow.left
        anchors.rightMargin: 10
        visible: currencyTracker == 0
    }

    DropShadow {
        id: shadowCurrencyPicklist
        z:11
        anchors.fill: currencyPicklist
        source: currencyPicklist
        horizontalOffset: 0
        verticalOffset: 4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.3
        transparentBorder: true
        visible: currencyTracker == 1
    }

    Rectangle {
        id: currencyPicklist
        z: 11
        width: 120
        height: fiatCurrencies.count >= 5? 165 : ((fiatCurrencies.count + 1) * 35) -10
        color: "#2A2C31"
        anchors.top: picklistArrow.top
        anchors.topMargin: -5
        anchors.right: picklistArrow.right
        visible: currencyTracker == 1
        clip: true

        Controls.CurrencyPicklist {
            id: myCurrencyPicklist
        }
    }

    Rectangle {
        id: picklistClose
        z: 11
        width: 120
        height: 25
        color: "#2A2C31"
        anchors.bottom: currencyPicklist.bottom
        anchors.horizontalCenter: currencyPicklist.horizontalCenter
        visible: currencyTracker == 1

        Image {
            id: picklistCloseArrow
            source: 'qrc:/icons/dropdown-arrow.svg'
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            rotation: 180
        }

        MouseArea {
            anchors.fill: parent

            onPressed: {
                detectInteraction()
            }

            onClicked: {
                currencyTracker = 0
            }
        }
    }

    Label {
        id: pincodeLabel
        z: 1
        text: "Pinlock active:"
        font.pixelSize: 16
        font.family: xciteMobile.name
        font.bold: true
        color: themecolor
        anchors.top: picklistArrow.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 28
    }

    Rectangle {
        id: currencySwitch
        z: 1
        width: 20
        height: 20
        radius: 10
        anchors.top: pincodeLabel.bottom
        anchors.topMargin: 10
        anchors.right: picklistArrow.right
        color: "transparent"
        border.color: themecolor
        border.width: 2

        Rectangle {
            id: currencyIndicator
            z: 1
            width: 12
            height: 12
            radius: 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: userSettings.pinlock === true ? maincolor : "#757575"

            MouseArea {
                id: currencyButton
                width: 20
                height: 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                onPressed: {
                    detectInteraction()
                }

                onClicked: {
                    if (userSettings.pinlock === false) {
                        pincodeTracker = 1
                        createPin =1
                    }
                    else {
                        pincodeTracker = 1
                        unlockPin = 1
                    }
                }
            }
        }
    }

    Label {
        id: currencySwitchLabel
        text: userSettings.pinlock === true ? "ACTIVE" : "NOT ACTIVE"
        anchors.right: currencySwitch.left
        anchors.rightMargin: 7
        anchors.verticalCenter: currencySwitch.verticalCenter
        anchors.verticalCenterOffset: 1
        font.pixelSize: 20
        font.family: xciteMobile.name
        color: userSettings.pinlock === true ? maincolor : "#757575"
    }

    Rectangle {
        id: changePinButton
        width: doubbleButtonWidth / 2
        height: 34
        color: userSettings.pinlock === true? maincolor : "#727272"
        opacity: 0.25
        anchors.top: currencySwitchLabel.bottom
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter

        MouseArea {
            anchors.fill: changePinButton

            onPressed: {
                parent.opacity = 0.5
                click01.play()
                detectInteraction()
            }

            onCanceled: {
                parent.opacity = 0.25
            }

            onReleased: {
                parent.opacity = 0.25
            }

            onClicked: {
                if (userSettings.pinlock === true) {
                    pincodeTracker = 1
                    changePin =1
                }
            }
        }
    }
    Text {
        text: "CHANGE PIN"
        font.family: "Brandon Grotesque"
        font.pointSize: 14
        font.bold: true
        color: userSettings.pinlock === true? (darktheme == true? "#F2F2F2" : maincolor) : "#979797"
        anchors.horizontalCenter: changePinButton.horizontalCenter
        anchors.verticalCenter: changePinButton.verticalCenter
    }

    Rectangle {
        width: changePinButton.width
        height: 34
        anchors.bottom: changePinButton.bottom
        anchors.left: changePinButton.left
        color: "transparent"
        opacity: 0.5
        border.color: userSettings.pinlock === true? maincolor : "#979797"
        border.width: 1
    }

    Rectangle {
        id: clearButton
        width: doubbleButtonWidth / 2
        height: 34
        color: maincolor
        opacity: 0.25
        anchors.bottom: closeSettings.top
        anchors.bottomMargin: 35
        anchors.horizontalCenter: parent.horizontalCenter

        MouseArea {
            anchors.fill: clearButton

            onPressed: {
                parent.opacity = 0.5
                click01.play()
                detectInteraction()
            }

            onCanceled: {
                parent.opacity = 0.25
            }

            onReleased: {
                parent.opacity = 0.25
            }

            onClicked: {
                if(userSettings.pinlock === true) {
                    pincodeTracker = 1
                    clearAll = 1
                }
                else {
                    clearAllSettings()
                    userSettings.locale = "en_us"
                    userSettings.defaultCurrency = 0
                    userSettings.theme = "dark"
                    userSettings.pinlock = false
                    userSettings.accountCreationComplete = true
                    savePincode("0000")
                }
            }
        }
    }
    Text {
        text: "RESET"
        font.family: "Brandon Grotesque"
        font.pointSize: 14
        font.bold: true
        color: maincolor
        anchors.horizontalCenter: clearButton.horizontalCenter
        anchors.verticalCenter: clearButton.verticalCenter
    }

    Rectangle {
        width: clearButton.width
        height: 34
        anchors.bottom: clearButton.bottom
        anchors.left: clearButton.left
        color: "transparent"
        opacity: 0.5
        border.color: maincolor
        border.width: 1
    }

    // Network error

    Rectangle {
        id: serverError
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.top
        width: Screen.width
        state: networkError == 0? "up" : "down"
        color: "black"
        opacity: 0.9
        clip: true
        visible: pincodeTracker == 0
        onStateChanged: detectInteraction()

        states: [
            State {
                name: "up"
                PropertyChanges { target: serverError; anchors.bottomMargin: 0}
                PropertyChanges { target: serverError; height: 0}
            },
            State {
                name: "down"
                PropertyChanges { target: serverError; anchors.bottomMargin: -100}
                PropertyChanges { target: serverError; height: 100}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: serverError; property: "anchors.bottomMargin"; duration: 300; easing.type: Easing.OutCubic}
            }
        ]

        Label {
            id: serverErrorText
            text: "A network error occured, please try again later."
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "#FD2E2E"
            font.pixelSize: 18
            font.family: xciteMobile.name
        }

        Rectangle {
            id: okButton
            width: doubbleButtonWidth / 2
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            color: "#1B2934"
            opacity: 0.5

            LinearGradient {
                anchors.fill: parent
                source: parent
                start: Qt.point(x, y)
                end: Qt.point(x, parent.height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: "#0ED8D2" }
                }
            }


            MouseArea {
                anchors.fill: parent

                onPressed: detectInteraction()

                onReleased: {
                    networkError = 0
                }
            }
        }

        Text {
            id: okButtonText
            text: "OK"
            font.family: xciteMobile.name
            font.pointSize: 14
            color: "#F2F2F2"
            font.bold: true
            anchors.horizontalCenter: okButton.horizontalCenter
            anchors.verticalCenter: okButton.verticalCenter
        }

        Rectangle {
            width: doubbleButtonWidth / 2
            height: 34
            anchors.horizontalCenter: okButton.horizontalCenter
            anchors.bottom: okButton.bottom
            color: "transparent"
            opacity: 0.5
            border.width: 1
            border.color: "#0ED8D2"
        }

        Rectangle {
            width: parent.width
            height: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            color: bgcolor
        }
    }

    Controls.Pincode {
        id: myPincode
        z: 5
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
        id: closeSettings
        z: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        text: "BACK"
        font.pixelSize: 14
        font.family: xciteMobile.name
        color: themecolor

        Rectangle {
            id: backbutton
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            height: 34
            color: "transparent"
        }

        MouseArea {
            anchors.fill: backbutton

            onPressed: detectInteraction()

            onClicked: {
                appsTracker = 0
                selectedPage = "home"
                mainRoot.pop("../WalletSettings.qml")
            }
        }
    }

    Controls.DebugConsole {
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Controls.LogOut {
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Controls.Goodbey {
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
    }
}
