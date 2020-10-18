/**
 * Filename: ProvidePin.qml
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
import QtQuick.Window 2.2
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+mobile" as Mobile

Item {

    id: modal
    width: parent.width
    height: modalHeight
    //state: unlockPin == 1? "up" : "down"

    property real modalHeight: pinOK == 1? pinCorrect.height : (pinError == 1? pinFail.height : providePin.height)
    property int passTry: 0
    property int passError1: 0
    property int passError2: 0
    property int passError3: 0
    /*
    states: [
        State {
            name: "up"
            PropertyChanges { target: modal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: modal; anchors.topMargin: modal.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: modal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]*/
    Rectangle {
        id: providePin
        height: providePinLabel.height + providePinLabel.anchors.topMargin + pin.height + pin.anchors.topMargin + appHeight/18
        width: parent.width
        color: "transparent"
        anchors.top: parent.top
        visible: pinOK == 0 && pinError == 0

        Label {
            id: providePinLabel
            text: "Type your 4-digit pincode"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: appHeight/18
            font.pixelSize: appHeight/72
            font.family: xciteMobile.name
            color: themecolor
        }

        Mobile.AmountInput {
            id: pin
            height: appHeight/18
            width: parent.width/2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: providePinLabel.bottom
            anchors.topMargin: appHeight/108
            placeholder: ""
            echoMode: TextInput.Password
            horizontalAlignment: TextInput.AlignHCenter
            color: themecolor
            textBackground: bgcolor
            font.letterSpacing: 4
            readOnly: (pin.text).length >= 4
            mobile: 1
            calculator: 0

            Timer {
                id: timer3
                interval: 1000
                repeat: false
                running: false

                onTriggered: {
                    pinOK = 0
                    unlockPin = 0
                    clearAll = 0
                    checkPinInitiated = false
                }
            }

            Timer {
                id: timer4
                interval: passError2 == 1 ? 300 : 2000
                repeat: false
                running: false

                onTriggered: {
                    if (passError2 == 1) {
                        unlockPin = 0
                        clearAll = 0
                        checkPinInitiated = false
                    }
                    else {
                        pinError = 0
                        checkPinInitiated = false
                    }
                }
            }

            onTextChanged: {
                detectInteraction()
                if ((pin.text).length === 4){
                    checkPinInitiated = true
                    passError1 = 0
                    passError2 = 0
                    passTry = passTry + 1
                    checkPincode(pin.text)
                }
            }

            Connections {
                target: UserSettings

                onPincodeCorrect: {
                    if (createPin == 0 && changePin == 0) {
                        pinOK = 1
                        pin.text = ""
                        passTry = 0
                        if (pinOK == 1 && (unlockPin == 1 || transferTracker == 1 || clearAll == 1 || backupTracker == 1)) {
                            timer3.start()
                        }
                    }
                }

                onPincodeFalse: {
                    if (createPin == 0 && changePin == 0) {
                        pinError = 1
                        pin.text = ""
                        if (passTry == 3) {
                            passError2 = 1
                            pinLogout = 1
                            logoutTracker = 1
                            timer4.start()
                        }
                        else {
                            passError1 = 1
                            timer4.start()
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: pinCorrect
        width: parent.width
        height: pinSucces.height + pinSucces.anchors.topMargin + appHeight/9
        color: "transparent"
        anchors.top: parent.top
        visible: pinOK == 1

        Label {
            id: pinSucces
            text: "Pincode CORRECT!"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: appHeight/9
            font.pixelSize: appHeight/36*0.8
            font.family: xciteMobile.name
            color: themecolor
        }
    }

    Rectangle {
        id: pinFail
        width: parent.width
        height: wrongPin1.height + wrongPin1.anchors.topMargin + wrongPin2.height + wrongPin2.anchors.topMargin + appHeight/9
        color: "transparent"
        anchors.top: parent.top
        visible: pinError == 1

        Label {
            id: wrongPin1
            text: "The pincodes you entered is incorrect!"
            color: themecolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: appHeight/9
            font.pixelSize: appHeight/36*0.8
            font.family: xciteMobile.name
        }

        Label {
            id: wrongPin2
            text: passError2 == 0? "You have " + (3 - passTry) + " attempts left before you are logged out automatically!" : ""
            color: themecolor
            width: parent.width*0.8
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: wrongPin1.bottom
            anchors.topMargin: appHeight/36*0.3
            font.pixelSize: appHeight/36*0.8
            font.family: xciteMobile.name
        }
    }
}

