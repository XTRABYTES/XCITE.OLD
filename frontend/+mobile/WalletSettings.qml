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
    width: appWidth
    height: appHeight
    anchors.horizontalCenter: xcite.horizontalCenter
    anchors.verticalCenter: xcite.verticalCenter
    color: darktheme == true? "#14161B" : "#FDFDFD"

   LinearGradient {
        anchors.fill: parent
        start: Qt.point(0, 0)
        end: Qt.point(0, parent.height)
        opacity: 0.05
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 1.0; color: maincolor }
        }
    }

    property int clearFailed: 0
    property int changeVolumeFailed: 0
    property int changeSystemVolumeFailed: 0

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
                    //debugTracker = 1
                }
            }
        }
    }

    Flickable {
        id: scrollArea
        width: parent.width
        contentHeight: currencyLabel.height + pincodeLabel.height + changePinButton.height + passwordLabel.height + changePasswordButton.height + notificationLabel.height + volumeLabel.height + systemVolumeLabel.height + 360
        anchors.left: parent.left
        anchors.top: welcomeText.bottom
        anchors.topMargin: 30
        anchors.bottom: clearButton.top
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        Label {
            id: currencyLabel
            z: 1
            text: "Wallet currency:"
            font.pixelSize: 16
            font.family: xciteMobile.name
            font.bold: true
            font.capitalization: Font.SmallCaps
            color: themecolor
            anchors.top: parent.top
            anchors.topMargin: 10
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
            anchors.verticalCenter: currencyLabel.verticalCenter
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
                    if (soundTracker == 0) {
                        currencyTracker = 1
                    }
                }
            }
        }

        Label {
            id: selectedCurrency
            z: 1
            text: fiatCurrencies.get(userSettings.defaultCurrency).currency + " - " + fiatCurrencies.get(userSettings.defaultCurrency).ticker
            font.pixelSize: 16
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
                    click01.play()
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
            font.capitalization: Font.SmallCaps
            color: themecolor
            anchors.top: picklistArrow.bottom
            anchors.topMargin: 25
            anchors.left: parent.left
            anchors.leftMargin: 28
        }

        Rectangle {
            id: pincodeSwitch
            z: 1
            width: 20
            height: 20
            radius: 10
            anchors.verticalCenter: pincodeLabel.verticalCenter
            anchors.right: picklistArrow.right
            color: "transparent"
            border.color: themecolor
            border.width: 2

            Rectangle {
                id: pincodeIndicator
                z: 1
                width: 12
                height: 12
                radius: 8
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: userSettings.pinlock === true ? maincolor : "#757575"

                MouseArea {
                    id: pincodeButton
                    width: 20
                    height: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter

                    onPressed: {
                        detectInteraction()
                    }

                    onClicked: {
                        if (userSettings.pinlock === false && currencyTracker == 0 && soundTracker == 0) {
                            pincodeTracker = 1
                            createPin =1
                        }
                        else if (currencyTracker == 0 && soundTracker == 0) {
                            pincodeTracker = 1
                            unlockPin = 1
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
                            //saveAppSettings();
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
        }

        Label {
            id: pincodeSwitchLabel
            text: userSettings.pinlock === true ? "Active" : "Not active"
            anchors.right: pincodeSwitch.left
            anchors.rightMargin: 7
            anchors.verticalCenter: pincodeSwitch.verticalCenter
            anchors.verticalCenterOffset: 1
            font.pixelSize: 16
            font.family: xciteMobile.name
            font.capitalization: Font.SmallCaps
            color: userSettings.pinlock === true ? maincolor : "#757575"
        }

        Rectangle {
            id: changePinButton
            width: doubbleButtonWidth / 2
            height: 34
            color: userSettings.pinlock === true? maincolor : "#727272"
            opacity: 0.25
            anchors.top: pincodeSwitchLabel.bottom
            anchors.topMargin: 20
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
                    if (userSettings.pinlock === true && currencyTracker == 0 && soundTracker == 0) {
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

        Label {
            id: passwordLabel
            z: 1
            text: "Account password:"
            font.pixelSize: 16
            font.family: xciteMobile.name
            font.bold: true
            font.capitalization: Font.SmallCaps
            color: themecolor
            anchors.top: changePinButton.bottom
            anchors.topMargin: 25
            anchors.left: parent.left
            anchors.leftMargin: 28
        }

        Rectangle {
            id: changePasswordButton
            width: changePasswordButtonLabel.implicitWidth + 56
            height: 34
            color: maincolor
            opacity: 0.25
            anchors.top: passwordLabel.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                anchors.fill: changePasswordButton

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
                    changePasswordTracker = 1
                }
            }
        }

        Text {
            id: changePasswordButtonLabel
            text: "CHANGE PASSWORD"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: maincolor
            anchors.horizontalCenter: changePasswordButton.horizontalCenter
            anchors.verticalCenter: changePasswordButton.verticalCenter
        }

        Rectangle {
            width: changePasswordButton.width
            height: 34
            anchors.bottom: changePasswordButton.bottom
            anchors.left: changePasswordButton.left
            color: "transparent"
            opacity: 0.5
            border.color: maincolor
            border.width: 1
        }

        Label {
            id: notificationLabel
            z: 1
            text: "Notification sounds:"
            font.pixelSize: 16
            font.family: xciteMobile.name
            font.bold: true
            font.capitalization: Font.SmallCaps
            color: themecolor
            anchors.top: changePasswordButton.bottom
            anchors.topMargin: 25
            anchors.left: parent.left
            anchors.leftMargin: 28
        }

        Image {
            id: picklistArrow2
            z: 1
            source: 'qrc:/icons/dropdown_icon.svg'
            height: 20
            width: 20
            anchors.right: parent.right
            anchors.rightMargin: 28
            anchors.verticalCenter: notificationLabel.verticalCenter
            visible: soundTracker == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Rectangle{
                id: picklistButton2
                height: 20
                width: 20
                radius: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
            }

            MouseArea {
                anchors.fill: picklistButton2

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (currencyTracker == 0) {
                        soundTracker = 1
                    }
                }
            }
        }

        Label {
            id: chosenSound
            z: 1
            text: soundList.get(selectedSound).name
            font.pixelSize: 16
            font.family: xciteMobile.name
            color: themecolor
            anchors.verticalCenter: picklistArrow2.verticalCenter
            anchors.verticalCenterOffset: 1
            anchors.right: picklistArrow2.left
            anchors.rightMargin: 10
            visible: soundTracker == 0

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    notification.play()
                    detectInteraction()
                }
            }
        }

        DropShadow {
            id: shadowSoundPicklist
            z:11
            anchors.fill: soundPicklist
            source: soundPicklist
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.3
            transparentBorder: true
            visible: soundTracker == 1
        }

        Rectangle {
            id: soundPicklist
            z: 11
            width: 120
            height: 165
            color: "#2A2C31"
            anchors.top: picklistArrow2.top
            anchors.topMargin: -5
            anchors.right: picklistArrow2.right
            visible: soundTracker == 1
            clip: true

            Controls.SoundPicklist {
                id: mySoundPicklist
            }
        }

        Rectangle {
            id: picklistClose2
            z: 11
            width: 120
            height: 25
            color: "#2A2C31"
            anchors.bottom: soundPicklist.bottom
            anchors.horizontalCenter: soundPicklist.horizontalCenter
            visible:soundTracker == 1

            Image {
                id: picklistCloseArrow2
                source: 'qrc:/icons/dropdown-arrow.svg'
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                rotation: 180
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    soundTracker = 0
                }
            }
        }

        Label {
            id: volumeLabel
            z: 1
            text: "Notification volume:"
            font.pixelSize: 16
            font.family: xciteMobile.name
            font.bold: true
            font.capitalization: Font.SmallCaps
            color: themecolor
            anchors.top: picklistArrow2.bottom
            anchors.topMargin: 25
            anchors.left: parent.left
            anchors.leftMargin: 28
        }

        Image {
            id: volumeLevel0
            source: selectedVolume == 0? 'qrc:/icons/mobile/volume_level_0-icon_focus.svg' : (darktheme == true? 'qrc:/icons/mobile/volume_level_0-icon_light.svg' : 'qrc:/icons/mobile/volume_level_0-icon_dark.svg')
            height: selectedVolume == 0? 40 : 30
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.left
            anchors.horizontalCenterOffset: 48
            anchors.verticalCenter: volumeLabel.bottom
            anchors.verticalCenterOffset: 30

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (changeVolumeInitiated == false && currencyTracker == 0 && soundTracker == 0) {
                            oldVolume = userSettings.volume
                            userSettings.volume = 0
                            notification.play()
                            changeVolumeInitiated = true
                            updateToAccount()
                        }
                    }
                }
            }
        }

        Image {
            id: volumeLevel1
            source: selectedVolume == 1? 'qrc:/icons/mobile/volume_level_1-icon_focus.svg' : (darktheme == true? 'qrc:/icons/mobile/volume_level_1-icon_light.svg' : 'qrc:/icons/mobile/volume_level_1-icon_dark.svg')
            height: selectedVolume == 1? 40 : 30
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: volumeLevel0.horizontalCenter
            anchors.horizontalCenterOffset: (appWidth - 96)/3
            anchors.verticalCenter: volumeLabel.bottom
            anchors.verticalCenterOffset: 30

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (changeVolumeInitiated == false && currencyTracker == 0 && soundTracker == 0) {
                            oldVolume = userSettings.volume
                            userSettings.volume = 1
                            notification.play()
                            changeVolumeInitiated = true
                            updateToAccount()
                        }
                    }
                }
            }
        }

        Image {
            id: volumeLevel2
            source: selectedVolume == 2? 'qrc:/icons/mobile/volume_level_2-icon_focus.svg' : (darktheme == true? 'qrc:/icons/mobile/volume_level_2-icon_light.svg' : 'qrc:/icons/mobile/volume_level_2-icon_dark.svg')
            height: selectedVolume == 2? 40 : 30
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: volumeLevel3.horizontalCenter
            anchors.horizontalCenterOffset: -(appWidth - 96)/3
            anchors.verticalCenter: volumeLabel.bottom
            anchors.verticalCenterOffset: 30

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (changeVolumeInitiated == false && currencyTracker == 0 && soundTracker == 0) {
                            oldVolume = userSettings.volume
                            userSettings.volume = 2
                            notification.play()
                            changeVolumeInitiated = true
                            updateToAccount()
                        }
                    }
                }
            }
        }

        Image {
            id: volumeLevel3
            source: selectedVolume == 3? 'qrc:/icons/mobile/volume_level_3-icon_focus.svg' : (darktheme == true? 'qrc:/icons/mobile/volume_level_3-icon_light.svg' : 'qrc:/icons/mobile/volume_level_3-icon_dark.svg')
            height: selectedVolume == 3? 40 : 30
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -58
            anchors.verticalCenter: volumeLabel.bottom
            anchors.verticalCenterOffset: 30

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (changeVolumeInitiated == false && currencyTracker == 0 && soundTracker == 0) {
                            oldVolume = userSettings.volume
                            userSettings.volume = 3
                            notification.play()
                            changeVolumeInitiated = true
                            updateToAccount()
                        }
                    }
                }
            }
        }

        Label {
            id: systemVolumeLabel
            z: 1
            text: "App system volume:"
            font.pixelSize: 16
            font.family: xciteMobile.name
            font.bold: true
            font.capitalization: Font.SmallCaps
            color: themecolor
            anchors.top: volumeLabel.bottom
            anchors.topMargin: 60
            anchors.left: parent.left
            anchors.leftMargin: 28
        }

        Image {
            id: systemVolumeLevel0
            source: selectedSystemVolume == 0? 'qrc:/icons/mobile/volume_level_0-icon_focus.svg' : (darktheme == true? 'qrc:/icons/mobile/volume_level_0-icon_light.svg' : 'qrc:/icons/mobile/volume_level_0-icon_dark.svg')
            height: selectedSystemVolume == 0? 40 : 30
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: volumeLevel0.horizontalCenter
            anchors.verticalCenter: systemVolumeLabel.bottom
            anchors.verticalCenterOffset: 30

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (changeSystemVolumeInitiated == false && currencyTracker == 0 && soundTracker == 0) {
                            oldSystemVolume = userSettings.systemVolume
                            userSettings.systemVolume = 0
                            changeSystemVolumeInitiated = true
                            updateToAccount()
                        }
                    }
                }
            }
        }

        Image {
            id: systemVolumeLevel1
            source: selectedSystemVolume == 1? 'qrc:/icons/mobile/volume_level_3-icon_focus.svg' : (darktheme == true? 'qrc:/icons/mobile/volume_level_3-icon_light.svg' : 'qrc:/icons/mobile/volume_level_3-icon_dark.svg')
            height: selectedSystemVolume == 1? 40 : 30
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: volumeLevel1.horizontalCenter
            anchors.verticalCenter: systemVolumeLabel.bottom
            anchors.verticalCenterOffset: 30

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (changeSystemVolumeInitiated == false && currencyTracker == 0 && soundTracker == 0) {
                            oldSystemVolume = userSettings.systemVolume
                            userSettings.systemVolume = 1
                            changeSystemVolumeInitiated = true
                            updateToAccount()
                        }
                    }
                }
            }
        }


        Connections {
            target: UserSettings

            onSaveSucceeded: {
                if (changeVolumeInitiated == true) {
                    changeVolumeInitiated = false
                }
                if (changeSystemVolumeInitiated == true) {
                    changeSystemVolumeInitiated = false
                }
            }

            onSaveFailed: {
                if (changeVolumeInitiated == true) {
                    userSettings.volume = oldVolume
                    changeVolumeFailed = 1
                    changeVolumeInitiated = false
                }
                if (changeSystemVolumeInitiated == true) {
                    userSettings.systemVolume = oldSystemVolume
                    changeSystemVolumeFailed = 1
                    changeSystemVolumeInitiated = false
                }
            }

            onNoInternet: {
                networkError = 1
                if (changeVolumeInitiated == true) {
                    userSettings.volume = oldVolume
                    changeVolumeFailed = 1
                    changeVolumeInitiated = false
                }
                if (changeSystemVolumeInitiated == true) {
                    userSettings.systemVolume = oldSystemVolume
                    changeSystemVolumeFailed = 1
                    changeSystemVolumeInitiated = false
                }
            }
        }
    }

    Rectangle {
        z: 4
        id: clearButton
        width: doubbleButtonWidth / 2
        height: 34
        color: maincolor
        opacity: 0.25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : (isIphoneX()? 90 : 70)
        anchors.horizontalCenter: parent.horizontalCenter
        visible: clearAllInitiated == false

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
                if(userSettings.pinlock === true && currencyTracker == 0 && soundTracker == 0) {
                    pincodeTracker = 1
                    clearAll = 1
                }
                else if (currencyTracker == 0 && soundTracker == 0) {
                    clearAllInitiated = true
                    oldDefaultCurrency = userSettings.defaultCurrency
                    oldLocale = userSettings.locale
                    oldPinlock = userSettings.pinlock
                    oldTheme = userSettings.theme
                    oldLocalKeys= userSettings.localKeys
                    oldSound = userSettings.sound
                    oldVolume = userSettings.volume
                    oldSystemVolume = userSettings.systemVolume
                    clearAllSettings()
                    userSettings.locale = "en_us"
                    userSettings.defaultCurrency = 0
                    userSettings.theme = "dark"
                    userSettings.pinlock = false
                    userSettings.accountCreationCompleted = true
                    userSettings.localKeys = oldLocalKeys
                    userSettings.sound = 0
                    userSettings.volume = 1
                    userSettings.systemVolume = 1
                    saveAppSettings()
                }
            }

            Connections {
                target: UserSettings

                onPincodeCorrect: {
                    if (pinOK == 1 && clearAll == 1) {
                        clearAllInitiated = true
                        oldDefaultCurrency = userSettings.defaultCurrency
                        oldLocale = userSettings.locale
                        oldPinlock = userSettings.pinlock
                        oldTheme = userSettings.theme
                        oldLocalKeys= userSettings.localKeys
                        oldSound = userSettings.sound
                        oldVolume = userSettings.volume
                        oldSystemVolume = userSettings.systemVolume
                        clearAllSettings()
                        userSettings.locale = "en_us"
                        userSettings.defaultCurrency = 0
                        userSettings.theme = "dark"
                        userSettings.pinlock = false
                        userSettings.accountCreationCompleted = true
                        userSettings.localKeys = oldLocalKeys
                        userSettings.sound = 0
                        userSettings.volume = 1
                        userSettings.systemVolume = 1
                        saveAppSettings()
                    }
                }

                onSaveSucceeded: {
                    if (clearAllInitiated == true) {
                        clearAllInitiated = false
                    }
                }

                onSaveFailed: {
                    if (clearAllInitiated == true) {
                        userSettings.locale = oldLocale
                        userSettings.defaultCurrency = oldDefaultCurrency
                        userSettings.theme = oldTheme
                        userSettings.pinlock = oldPinlock
                        userSettings.sound = oldSound
                        userSettings.volume = oldVolume
                        userSettings.systemVolume = oldSystemVolume
                        clearAllInitiated = false
                        clearFailed = 1
                    }
                }

                onNoInternet: {
                    networkError = 1
                    if (clearAllInitiated == true) {
                        userSettings.locale = oldLocale
                        userSettings.defaultCurrency = oldDefaultCurrency
                        userSettings.theme = oldTheme
                        userSettings.pinlock = oldPinlock
                        userSettings.sound = oldSound
                        userSettings.volume = oldVolume
                        userSettings.systemVolume = oldSystemVolume
                        clearAllInitiated = false
                        clearFailed = 1
                    }
                }
            }
        }
    }
    Text {
        z: 4
        text: "RESET"
        font.family: "Brandon Grotesque"
        font.pointSize: 14
        font.bold: true
        color: maincolor
        anchors.horizontalCenter: clearButton.horizontalCenter
        anchors.verticalCenter: clearButton.verticalCenter
        visible: clearAllInitiated == false
    }

    Rectangle {
        z: 4
        width: clearButton.width
        height: 34
        anchors.bottom: clearButton.bottom
        anchors.left: clearButton.left
        color: "transparent"
        opacity: 0.5
        border.color: maincolor
        border.width: 1
        visible: clearAllInitiated == false
    }

    AnimatedImage {
        id: waitingDots2
        source: 'qrc:/gifs/loading-gif_01.gif'
        width: 90
        height: 60
        anchors.horizontalCenter: clearButton.horizontalCenter
        anchors.verticalCenter: clearButton.verticalCenter
        playing: clearAllInitiated == true
        visible: clearAllInitiated == true
    }

    Item {
        z: 12
        width: popupClearAll.width
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -100
        visible: clearFailed == 1

        Rectangle {
            id: popupClearAll
            height: 50
            width: popupClearText.width + 56
            color: "#34363D"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: popupClearText
            text: "<font color='#E55541'><b>FAILED</b></font> to reset your settings!"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Timer {
            repeat: false
            running: clearFailed == 1
            interval: 2000

            onTriggered: clearFailed = 0
        }
    }

    Item {
        z: 12
        width: popupCurrencyFail.width
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -100
        visible: currencyChangeFailed == 1

        Rectangle {
            id: popupCurrencyFail
            height: 50
            width: popupCurrencyText.width + 56
            color: "#34363D"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: popupCurrencyText
            text: "<font color='#E55541'><b>FAILED</b></font> to change your currency!"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Timer {
            repeat: false
            running: currencyChangeFailed == 1
            interval: 2000

            onTriggered: currencyChangeFailed = 0
        }
    }

    Item {
        z: 12
        width: popupSoundFail.width
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -100
        visible: soundChangeFailed == 1

        Rectangle {
            id: popupSoundFail
            height: 50
            width: popupSoundText.width + 56
            color: "#34363D"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: popupSoundText
            text: "<font color='#E55541'><b>FAILED</b></font> to change your sound!"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Timer {
            repeat: false
            running: soundChangeFailed == 1
            interval: 2000

            onTriggered: soundChangeFailed = 0
        }
    }

    Item {
        z: 12
        width: popupVolumeFail.width
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -100
        visible: volumeChangeFailed == 1

        Rectangle {
            id: popupVolumeFail
            height: 50
            width: popupVolumeText.width + 56
            color: "#34363D"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: popupVolumeText
            text: "<font color='#E55541'><b>FAILED</b></font> to change your notification volume!"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Timer {
            repeat: false
            running: volumeChangeFailed == 1
            interval: 2000

            onTriggered: volumeChangeFailed = 0
        }
    }

    Item {
        z: 12
        width: popupSystemVolumeFail.width
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -100
        visible: systemVolumeChangeFailed == 1

        Rectangle {
            id: popupSystemVolumeFail
            height: 50
            width: popupSystemVolumeText.width + 56
            color: "#34363D"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: popupSystemVolumeText
            text: "<font color='#E55541'><b>FAILED</b></font> to change your system sound volume!"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Timer {
            repeat: false
            running: systemVolumeChangeFailed == 1
            interval: 2000

            onTriggered: systemVolumeChangeFailed = 0
        }
    }

    Item {
        z: 3
        width: parent.width
        height: myOS === "android"? 215 : 235
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(x, y)
            end: Qt.point(x, y + height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.3; color: darktheme == true? "#14161B" : "#FDFDFD" }
                GradientStop { position: 1.0; color: darktheme == true? "#14161B" : "#FDFDFD" }
            }
        }
    }
    /**
    Label {
        id: closeSettings
        z: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : (isIphoneX()? 90 : 70)
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

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                currencyTracker = 0
                soundTracker = 0
                appsTracker = 0
                selectedPage = "home"
                mainRoot.pop()
            }
        }
    }
    */
    Controls.Pincode {
        id: myPincode
        z: 5
        anchors.top: parent.top
        anchors.left: parent.left
    }

    Controls.ChangePassword {
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Controls.DebugConsole {
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Controls.SwipeBack {
        z: 100
        anchors.right: parent.right
        anchors.top: parent.top
    }

    Controls.DeviceButtons {
        z: 100
        visible: myOS !== "android" && myOS !== "ios"
    }

    Controls.LogOut {
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Controls.DragBar {
        z: 100
        visible: myOS !== "android" && myOS !== "ios"
    }

    Controls.NetworkError {
        z:100
        id: myNetworkError
    }

    Controls.Goodbey {
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Component.onDestruction: {
        currencyTracker = 0
        soundTracker = 0
        appsTracker = 0
    }
}
