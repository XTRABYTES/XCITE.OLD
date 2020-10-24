/**
 * Filename: CreatePin.qml
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

    property real modalHeight: newPinSaved == 1? pinSaved.height : (failToSave == 1? saveFailed.height : (pinError == 1? pinFail.height : createNewPin.height))
    property int newPinSaved: 0
    property int failToSave: 0
    property int passError: 0
    property string failError: ""
    property int passTry: 0
    property int passError1: 0
    property int passError2: 0
    property int passError3: 0
    property int currentPinCorrect: 0
    property int myTracker: pincodeTracker

    onMyTrackerChanged: {
        currentPin.text = ""
        newPin1.text = ""
        newPin2.text = ""
        newPinSaved = 0
        failToSave = 0
        failError = ""
    }

    Rectangle {
        id: createNewPin
        height: currentPinText.height + currentPinText.anchors.topMargin +
                currentPin.height + currentPin.anchors.topMargin +
                ((createPinText1.height + createPinText1.anchors.topMargin +
                 newPin1.height + newPin1.anchors.topMargin)*2) +
                (savePin.height*2) + savePin.anchors.topMargin
        width: parent.width
        color: "transparent"
        anchors.top: parent.top
        visible: newPinSaved == 0 && failToSave == 0 && pinError == 0

        Label {
            id: currentPinText
            text: "Enter your current pincode"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: appHeight/18
            font.pixelSize: appHeight/60
            font.family: xciteMobile.name
            color: themecolor
        }

        Mobile.AmountInput {
            id: currentPin
            height: appHeight/18
            width: parent.width/2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: currentPinText.bottom
            anchors.topMargin: appHeight/108
            placeholder: ""
            inputMethodHints: Qt.ImhDigitsOnly
            validator: IntValidator {bottom: 0; top: 9999;}
            echoMode: TextInput.Password
            horizontalAlignment: TextInput.AlignHCenter
            color: themecolor
            textBackground: bgcolor
            font.letterSpacing: 4
            readOnly: (currentPin.text).length >= 4
            mobile: 1
            calculator: 0

            Image {
                id: currentPinOK
                source: 'qrc:/icons/icon-ok_01.svg'
                height: parent.height/2
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.height/2
                visible: currentPinCorrect == 1
            }

            Timer {
                id: timer6
                interval: passError2 == 1 ? 300 : 2000
                repeat: false
                running: false

                onTriggered: {
                    if (passError2 == 1) {
                        pincodeTracker = 0
                        changePin = 0
                    }
                    else {
                        pinError = 0
                    }
                }
            }

            onTextChanged: {
                detectInteraction()
                currentPinCorrect = 0
                if ((currentPin.text).length === 4){
                    passError1 = 0
                    passError2 = 0
                    passTry = passTry + 1
                    checkPincode(currentPin.text)
                }
            }

            Connections {
                target: UserSettings

                onPincodeCorrect: {
                    if (changePin == 1) {
                        passTry = 0
                        currentPinCorrect = 1
                    }
                }

                onPincodeFalse: {
                    if (changePin ==1) {
                        pinError = 1
                        currentPin.text = ""
                        if (passTry == 3) {
                            passError2 = 1
                            pinLogout = 1
                            logoutTracker = 1
                            timer6.start()
                        }
                        else {
                            passError1 = 1
                            timer6.start()
                        }
                    }
                }
            }
        }

        Label {
            id: createPinText1
            text: "Choose a 4-digit pincode"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: currentPin.bottom
            anchors.topMargin: appHeight/36
            font.pixelSize: appHeight/60
            font.family: xciteMobile.name
            color: themecolor
        }

        Mobile.AmountInput {
            id: newPin1
            height: appHeight/18
            width: parent.width/2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: createPinText1.bottom
            anchors.topMargin: appHeight/108
            placeholder: ""
            inputMethodHints: Qt.ImhDigitsOnly
            validator: IntValidator {bottom: 0; top: 9999;}
            echoMode: TextInput.Password
            horizontalAlignment: TextInput.AlignHCenter
            color: themecolor
            textBackground: bgcolor
            font.letterSpacing: 4
            readOnly: (newPin1.text).length >= 4
            mobile: 1
            calculator: 0
            onTextChanged: detectInteraction()

            Image {
                id: createPinOK
                source: 'qrc:/icons/icon-ok_01.svg'
                height: parent.height/2
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.height/2
                visible: (newPin1.text).length === 4 && newPin1.acceptableInput == true
            }
        }

        Label {
            id: createPinText2
            text: "Type your 4-digit pincode again"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: newPin1.bottom
            anchors.topMargin: appHeight/36
            font.pixelSize: appHeight/60
            font.family: xciteMobile.name
            color: themecolor
        }

        Mobile.AmountInput {
            id: newPin2
            height: appHeight/18
            width: parent.width/2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: createPinText2.bottom
            anchors.topMargin: appHeight/108
            placeholder: ""
            echoMode: TextInput.Password
            inputMethodHints: Qt.ImhDigitsOnly
            validator: IntValidator {bottom: 0; top: 9999;}
            horizontalAlignment: TextInput.AlignHCenter
            color: themecolor
            textBackground: bgcolor
            font.pixelSize: height/2
            font.letterSpacing: 4
            readOnly: (newPin2.text).length >= 4
            mobile: 1
            calculator: 0

            onTextChanged: {
                detectInteraction()
                passError = 0
                if ((newPin2.text).length === 4){
                    if (newPin2.text !== newPin1.text) {
                        passError = 1
                        newPin2.text = ""
                    }
                }
            }
            Image {
                id: createPinRepeateOK
                source: 'qrc:/icons/icon-ok_01.svg'
                height: parent.height/2
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.height/2
                visible: newPin2.text === newPin1.text && newPin2.text !== "" && newPin2.acceptableInput == true
            }
        }

        Label {
            id: noMatch
            text: "The pincodes you entered don't match!"
            color: "#FD2E2E"
            anchors.left: newPin2.left
            anchors.leftMargin: appHeight/36*0.3
            anchors.top: newPin2.bottom
            anchors.topMargin: 1
            font.pixelSize: appHeight/36*0.6
            font.family: xciteMobile.name
            visible: passError == 1
        }

        Rectangle {
            id: savePin
            width: parent.width/2
            height: appHeight/18
            color: (currentPin.text !== ""
                    && currentPin.text.length === 4
                    && newPin1.text !== ""
                    && newPin1.text.length === 4
                    && newPin2.text !== ""
                    && newPin2.text.length === 4
                    && currentPin.acceptableInput == true
                    && newPin1.acceptableInput == true
                    && newPin2.acceptableInput == true
                    && passError == 0)? maincolor : "#727272"
            anchors.top: newPin2.bottom
            anchors.topMargin: appHeight/18
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: "SAVE"
                font.pixelSize: parent.height/2
                font.family: xciteMobile.name
                color: themecolor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Timer {
                id: timer1
                interval: 2000
                repeat: false
                running: false

                onTriggered: {
                    changePin = 0
                    newPinSaved = 0
                    savePinInitiated = false
                }
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (currentPin.text !== ""
                            && currentPin.text.length === 4
                            && newPin1.text !== ""
                            && newPin1.text.length === 4
                            && newPin2.text !== ""
                            && newPin2.text.length === 4
                            && currentPin.acceptableInput == true
                            && newPin1.acceptableInput == true
                            && newPin2.acceptableInput == true
                            && passError == 0) {
                        savePinInitiated = true
                        newPinSaved = 0;
                        userSettings.pinlock = true;
                        savePincode(newPin1.text);
                    }
                }
            }

            Connections {
                target: UserSettings

                onSaveSucceeded: {
                    if (pincodeTracker == 1 && selectedPage == "settings" && savePinInitiated == true){
                        if (changePin == 1) {
                            if (newPinSaved == 0) {
                                newPinSaved = 1
                                passTry = 0
                                currentPin.text = ""
                                newPin1.text = ""
                                newPin2.text = ""
                                timer1.start()
                            }
                        }
                    }
                }

                onSaveFailed: {
                    if (pincodeTracker == 1 && selectedPage == "settings" && savePinInitiated == true) {
                        if (changePin == 1){
                            savePinInitiated = false
                            currentPin.text = ""
                            newPin1.text = ""
                            newPin2.text = ""
                            failToSave = 1
                        }
                    }
                }

                onNoInternet: {
                    if (pincodeTracker == 1 && selectedPage == "settings" && savePinInitiated == true) {
                        networkError = 1
                        if (changePin == 1){
                            currentPin.text = ""
                            newPin1.text = ""
                            newPin2.text = ""
                            failToSave = 1
                        }
                    }
                }

                onSaveFailedDBError: {
                    if (pincodeTracker == 1 && selectedPage == "settings" && savePinInitiated == true) {
                        if (changePin == 1){
                            failError = "Database ERROR"
                        }
                    }
                }

                onSaveFailedAPIError: {
                    if (pincodeTracker == 1 && selectedPage == "settings" && savePinInitiated == true) {
                        if (changePin == 1){
                            failError = "Network ERROR"
                        }
                    }
                }

                onSaveFailedInputError: {
                    if (pincodeTracker == 1 && selectedPage == "settings" && savePinInitiated == true) {
                        if (changePin == 1){
                            failError = "Input ERROR"
                        }
                    }
                }

                onSaveFailedUnknownError: {
                    if (pincodeTracker == 1 && selectedPage == "settings" && savePinInitiated == true) {
                        if (changePin == 1){
                            failError = "Unknown ERROR"
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: pinSaved
        width: parent.width
        height: appHeight*9/36
        color: "transparent"
        anchors.top: parent.top
        visible: newPinSaved == 1

        Label {
            id: pinSavedText
            text: "New pincode SET!"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: appHeight/9
            font.pixelSize: appHeight/36*0.8
            font.family: xciteMobile.name
            color: themecolor
        }
    }

    Rectangle {
        id: saveFailed
        width: parent.width
        height: appHeight*16/72
        color: "transparent"
        anchors.top: parent.top
        visible: failToSave == 1

        Label {
            id: saveFailedLabel
            text: "Unable to set new pincode"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: appHeight/9
            font.pixelSize: appHeight/36*0.8
            font.family: xciteMobile.name
            color: themecolor
        }

        Label {
            id: saveFailedError
            text: failError
            anchors.top: saveFailedLabel.bottom
            anchors.topMargin: appHeight/72
            anchors.horizontalCenter: saveFailed.horizontalCenter
            font.pixelSize: appHeight/36*0.6
            font.family: xciteMobile.name
            color: themecolor
        }

        Rectangle {
            id: closeFailed
            width: appWidth/6
            height: appHeight/18
            color: "transparent"
            anchors.top: saveFailedError.bottom
            anchors.topMargin: appHeight/18
            anchors.horizontalCenter: parent.horizontalCenter
            border.width: 1
            border.color: maincolor

            MouseArea {
                anchors.fill: closeFailed

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    failToSave = 0;
                }
            }

            Text {
                text: "TRY AGAIN"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: maincolor
                anchors.horizontalCenter: closeFailed.horizontalCenter
                anchors.verticalCenter: closeFailed.verticalCenter
            }
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

