/**
* Filename: WalletSettings.qml
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
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: backgroundWalletSettings
    z: 1
    width: appWidth/6 * 5
    height: appHeight
    anchors.right: xcite.right
    anchors.top: xcite.top
    color: bgcolor

    property int clearFailed: 0
    property int changeVolumeFailed: 0
    property int changeSystemVolumeFailed: 0
    property int changeBalanceVisibleFailed: 0
    property int checkCreatePin: createPin
    property int checkChangePin: changePin
    property int checkUnlockPin: unlockPin
    property bool screenComplete: false

    onCheckCreatePinChanged: {
        if (sessionStart == 1 && pincodeTracker == 1) {
            if (userSettings.pinlock) {
                pinSwitch.state = "on"
                pincodeTracker = 0
            }
            else {
                pinSwitch.state = "off"
                pincodeTracker = 0
            }
        }
    }

    onCheckChangePinChanged: {
        if (sessionStart == 1 && pincodeTracker == 1) {
            if (userSettings.pinlock) {
                pinSwitch.state = "on"
                pincodeTracker = 0
            }
            else {
                pinSwitch.state = "off"
                pincodeTracker = 0
            }
        }
    }

    onCheckUnlockPinChanged: {
        if (sessionStart == 1 && pincodeTracker == 1) {
            if (userSettings.pinlock) {
                pinSwitch.state = "on"
                pincodeTracker = 0
            }
            else {
                pinSwitch.state = "off"
                pincodeTracker = 0
            }
        }
    }

    Component.onCompleted: {
        balanceSwitch.switchOn = userSettings.showBalance
        pinSwitch.switchOn = userSettings.pinlock
        screenComplete = true
    }

    Label {
        id: walletSettingsLabel
        text: "SETTINGS"
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        color: themecolor
        font.letterSpacing: 2
    }

    Label {
        id: currencyLabel
        text: "Wallet currency"
        anchors.top: walletSettingsLabel.bottom
        anchors.left: parent.left
        anchors.leftMargin: appWidth/36
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: themecolor
    }

    Label {
        id: dollarLabel
        text: "USD $"
        anchors.top: currencyLabel.top
        anchors.left: parent.left
        anchors.leftMargin: appWidth/6*1.5
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: userSettings.defaultCurrency === 0? maincolor : themecolor

        Rectangle {
            width: parent.width
            height: 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            anchors.topMargin: appHeight/108
            color: maincolor
            visible: parent.color == maincolor
        }

        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    userSettings.defaultCurrency = 0
                }
            }
        }
    }

    Label {
        id: euroLabel
        text: "EUR €"
        anchors.top: currencyLabel.top
        anchors.left: parent.left
        anchors.leftMargin: appWidth/6*2
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: userSettings.defaultCurrency === 1? maincolor : themecolor

        Rectangle {
            width: parent.width
            height: 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            anchors.topMargin: appHeight/108
            color: maincolor
            visible: parent.color == maincolor
        }

        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    userSettings.defaultCurrency = 1
                }
            }
        }
    }

    Label {
        id: poundLabel
        text: "GBP £"
        anchors.top: currencyLabel.top
        anchors.left: parent.left
        anchors.leftMargin: appWidth/6*2.5
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: userSettings.defaultCurrency === 2? maincolor : themecolor

        Rectangle {
            width: parent.width
            height: 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            anchors.topMargin: appHeight/108
            color: maincolor
            visible: parent.color == maincolor
        }

        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    userSettings.defaultCurrency = 2
                }
            }
        }
    }

    Label {
        id: balanceLabel
        text: "Show balance"
        anchors.top: currencyLabel.bottom
        anchors.topMargin: appWidth/24
        anchors.left: parent.left
        anchors.leftMargin: appWidth/36
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: themecolor
    }

    Label {
        id: balanceNoLabel
        text: "NO"
        anchors.top: balanceLabel.top
        anchors.left: parent.left
        anchors.leftMargin: appWidth/6*1.5
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: !userSettings.showBalance? maincolor : themecolor
    }

    Controls.Switch {
        id: balanceSwitch
        anchors.verticalCenter: balanceLabel.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: appWidth/6*1.75
        switchOn: userSettings.showBalance

        onSwitchOnChanged: {
            if (switchOn == true) {
                userSettings.showBalance = true
            }

            else {
                userSettings.showBalance = false
            }
        }
    }

    Label {
        id: balanceYesLabel
        text: "YES"
        anchors.top: balanceLabel.top
        anchors.left: parent.left
        anchors.leftMargin: appWidth/6*2.25
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: userSettings.showBalance? maincolor : themecolor
    }

    Label {
        id: pinlockLabel
        text: "Pinlock active"
        anchors.top: balanceLabel.bottom
        anchors.topMargin: appWidth/24
        anchors.left: parent.left
        anchors.leftMargin: appWidth/36
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: themecolor
    }

    Label {
        id: pinNoLabel
        text: "NO"
        anchors.top: pinlockLabel.top
        anchors.left: parent.left
        anchors.leftMargin: appWidth/6*1.5
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: !userSettings.pinlock? maincolor : themecolor
    }

    Controls.Switch {
        id: pinSwitch
        anchors.verticalCenter: pinlockLabel.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: appWidth/6*1.75
        switchOn: userSettings.pinlock

        onStateChanged: {
            if (pincodeTracker == 0 && sessionStart == 1 && selectedPage == "settings" && screenComplete == true) {
                if (state == "on") {
                    createPin =1
                    pincodeTracker = 1
                }

                else if (state == "off") {
                    unlockPin = 1
                    pincodeTracker = 1
                }
            }
        }

        Connections {
            target: UserSettings

            onPincodeCorrect: {
                if (pinOK == 1 && unlockPin == 1) {
                    clearPinInitiated = true
                    oldPinlock = userSettings.pinlock
                    userSettings.pinlock = false
                    savePincode("0000")
                }
            }

            onSaveSucceeded: {
                if (clearPinInitiated == true) {
                    clearPinInitiated = false
                }
            }

            onSaveFailed: {
                if (clearPinInitiated == true) {
                    clearPinInitiated = false
                    userSettings.pinlock = oldPinlock
                }
            }

            onNoInternet: {
                networkError = 1
                if (clearPinInitiated == true) {
                    clearPinInitiated = false
                    userSettings.pinlock = oldPinlock
                }
            }
        }
    }

    Label {
        id: pinYesLabel
        text: "Yes"
        anchors.top: pinlockLabel.top
        anchors.left: parent.left
        anchors.leftMargin: appWidth/6*2.25
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: userSettings.pinlock? maincolor : themecolor
    }

    Rectangle {
        id: changePinButton
        height: appHeight/36*1.5
        width: appWidth/6
        color: "transparent"
        border.width: 1
        border.color: themecolor
        anchors.verticalCenter: pinYesLabel.verticalCenter
        anchors.left: pinYesLabel.right
        anchors.leftMargin: appWidth/24

        Rectangle {
            id: pinSelector
            anchors.fill: parent
            color: maincolor
            opacity: 0.5
            visible: false
        }

        Label {
            text: "CHANGE PIN"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: themecolor
            font.pixelSize: parent.height/2
            font.family: xciteMobile.name
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                pinSelector.visible = true
            }

            onExited: {
                pinSelector.visible = false
            }

            onCanceled: {
                pinSelector.visible = false
            }

            onClicked: {
                if (userSettings.pinlock === true) {
                    changePin =1
                    pincodeTracker = 1
                }
            }
        }
    }

    Label {
        id: passwordLabel
        text: "Account password"
        anchors.top: pinlockLabel.bottom
        anchors.topMargin: appWidth/24
        anchors.left: parent.left
        anchors.leftMargin: appWidth/36
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: themecolor
    }

    Rectangle {
        id: changePasButton
        height: appHeight/36*1.5
        width: appWidth/6
        color: "transparent"
        border.width: 1
        border.color: themecolor
        anchors.verticalCenter: passwordLabel.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: appWidth/6*1.5

        Rectangle {
            id: pasSelector
            anchors.fill: parent
            color: maincolor
            opacity: 0.5
            visible: false
        }

        Label {
            text: "CHANGE PASSWORD"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: themecolor
            font.pixelSize: parent.height/2
            font.family: xciteMobile.name
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                pasSelector.visible = true
            }

            onExited: {
                pasSelector.visible = false
            }

            onCanceled: {
                pasSelector.visible = false
            }

            onClicked: {
            }
        }
    }

    Label {
        id: soundLabel
        text: "Notification sound"
        anchors.top: passwordLabel.bottom
        anchors.topMargin: appWidth/24
        anchors.left: parent.left
        anchors.leftMargin: appWidth/36
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: themecolor
    }

    Label {
        id: bonjourLabel
        text: "Bonjour"
        anchors.top: soundLabel.top
        anchors.left: parent.left
        anchors.leftMargin: appWidth/6*1.5
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: userSettings.sound === 0? maincolor : themecolor

        Rectangle {
            width: parent.width
            height: 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            anchors.topMargin: appHeight/108
            color: maincolor
            visible: parent.color == maincolor
        }

        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    userSettings.sound = 0
                    notification.play()
                }
            }
        }
    }

    Label {
        id: helloLabel
        text: "Hello"
        anchors.top: soundLabel.top
        anchors.left: bonjourLabel.right
        anchors.leftMargin: appWidth/24
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: userSettings.sound === 1? maincolor : themecolor

        Rectangle {
            width: parent.width
            height: 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            anchors.topMargin: appHeight/108
            color: maincolor
            visible: parent.color == maincolor
        }

        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    userSettings.sound = 1
                    notification.play()
                }
            }
        }
    }

    Label {
        id: holaLabel
        text: "Hola"
        anchors.top: soundLabel.top
        anchors.left: helloLabel.right
        anchors.leftMargin: appWidth/24
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: userSettings.sound === 2? maincolor : themecolor

        Rectangle {
            width: parent.width
            height: 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            anchors.topMargin: appHeight/108
            color: maincolor
            visible: parent.color == maincolor
        }

        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    userSettings.sound = 2
                    notification.play()
                }
            }
        }
    }

    Label {
        id: servusLabel
        text: "Servus"
        anchors.top: soundLabel.top
        anchors.left: holaLabel.right
        anchors.leftMargin: appWidth/24
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: userSettings.sound === 3? maincolor : themecolor

        Rectangle {
            width: parent.width
            height: 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            anchors.topMargin: appHeight/108
            color: maincolor
            visible: parent.color == maincolor
        }

        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    userSettings.sound = 3
                    notification.play()
                }
            }
        }
    }

    Label {
        id: sziaLabel
        text: "Szia"
        anchors.top: soundLabel.top
        anchors.left: servusLabel.right
        anchors.leftMargin: appWidth/24
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: userSettings.sound === 4? maincolor : themecolor

        Rectangle {
            width: parent.width
            height: 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            anchors.topMargin: appHeight/108
            color: maincolor
            visible: parent.color == maincolor
        }

        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    userSettings.sound = 4
                    notification.play()
                }
            }
        }
    }

    Label {
        id: volumeLabel
        text: "Notification volume"
        anchors.top: soundLabel.bottom
        anchors.topMargin: appWidth/24
        anchors.left: parent.left
        anchors.leftMargin: appWidth/36
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: themecolor
    }

    Controls.VolumeSlider {
        id: notificationVolume
        width: appWidth/6*2
        anchors.left: parent.left
        anchors.leftMargin: appWidth/6*1.5
        anchors.verticalCenter: volumeLabel.verticalCenter
        volumeValue: (selectedVolume > 0 && selectedVolume < 1)?selectedVolume : (selectedVolume == 0? 0 : (selectedVolume == 1? 0.15 : (selectedVolume == 2? 0.4 : 0.75)))

        onMovePressedChanged: {
            if (movePressed == false && sessionStart == 1) {
                userSettings.volume = notificationVolume.sliderPosition
                selectedVolume = userSettings.volume
                notification.play()
            }
        }
    }

    Label {
        id: maxVolumeLabel
        text: "Max"
        anchors.verticalCenter: notificationVolume.verticalCenter
        anchors.left: notificationVolume.right
        anchors.leftMargin: appWidth/48
        color: themecolor
        font.pixelSize: volumeLabel.font.pixelSize*3/4
        font.family: xciteMobile.name

        Rectangle {
            anchors.fill: parent
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    userSettings.volume = 0.999
                    selectedVolume = userSettings.volume
                    notification.play()
                }
            }
        }
    }

    Label {
        id: sysvolumeLabel
        text: "App system sounds"
        anchors.top: volumeLabel.bottom
        anchors.topMargin: appWidth/24
        anchors.left: parent.left
        anchors.leftMargin: appWidth/36
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: themecolor
    }

    Label {
        id: soundsOffLabel
        text: "OFF"
        anchors.top: sysvolumeLabel.top
        anchors.left: parent.left
        anchors.leftMargin: appWidth/6*1.5
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: userSettings.systemVolume === 0? maincolor : themecolor
    }

    Controls.Switch {
        id: soundSwitch
        anchors.verticalCenter: sysvolumeLabel.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: appWidth/6*1.75
        switchOn: userSettings.systemVolume === 1

        onSwitchOnChanged: {
            if (switchOn == true) {
                userSettings.systemVolume = 1
            }

            else {
                userSettings.systemVolume = 0
            }
        }
    }

    Label {
        id: soundsOnLabel
        text: "ON"
        anchors.top: sysvolumeLabel.top
        anchors.left: parent.left
        anchors.leftMargin: appWidth/6*2.25
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: userSettings.systemVolume === 1? maincolor : themecolor
    }
}
