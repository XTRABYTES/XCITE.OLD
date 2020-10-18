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
    //state: createPin == 1? "up" : "down"

    property real modalHeight: newPinSaved == 1? pinSaved.height : (failToSave == 1? saveFailed.height : createNewPin.height)
    property int newPinSaved: 0
    property int failToSave: 0
    property int passError: 0
    property string failError: ""
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
        id: createNewPin
        height: appHeight*44/108
        width: parent.width
        color: "transparent"
        anchors.top: parent.top
        visible: newPinSaved == 0 && failToSave == 0

        Label {
            id: createPinText1
            text: "Choose a 4-digit pincode"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: appHeight/18
            font.pixelSize: appHeight/72
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
            font.pixelSize: appHeight/72
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
            color: (newPin1.text !== ""
                    && newPin1.text.length === 4
                    && newPin2.text !== ""
                    && newPin2.text.length === 4
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
                    createPin = 0
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
                    if (newPin1.text !== ""
                            && newPin1.text.length === 4
                            && newPin2.text !== ""
                            && newPin2.text.length === 4
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
                    if (pincodeTracker == 1 && selectedPage == "settings" && savePinInitiated == true) {
                        if (createPin == 1){
                            newPin1.text = "";
                            newPin2.text = "";
                            newPinSaved = 1
                            timer1.start();
                        }
                    }
                }

                onSaveFailed: {
                    if (pincodeTracker == 1 && selectedPage == "settings" && savePinInitiated == true) {
                        if (createPin == 1) {
                            userSettings.pinlock = false;
                            newPin1.text = "";
                            newPin2.text = "";
                            failToSave = 1;
                        }
                    }
                }

                onNoInternet: {
                    if (pincodeTracker == 1 && selectedPage == "settings" && savePinInitiated == true) {
                        networkError = 1
                        if (createPin == 1) {
                            userSettings.pinlock = false;
                            newPin1.text = "";
                            newPin2.text = "";
                            failToSave = 1;
                        }
                    }
                }

                onSaveFailedDBError: {
                    if (pincodeTracker == 1 && selectedPage == "settings" && savePinInitiated == true) {
                        if (createPin == 0){
                            failError = "Database ERROR"
                        }
                    }
                }

                onSaveFailedAPIError: {
                    if (pincodeTracker == 1  && selectedPage == "settings" && savePinInitiated == true) {
                        if (createPin == 0){
                            failError = "Network ERROR"
                        }
                    }
                }

                onSaveFailedInputError: {
                    if (pincodeTracker == 1  && selectedPage == "settings" && savePinInitiated == true) {
                        if (createPin == 0){
                            failError = "Input ERROR"
                        }
                    }
                }

                onSaveFailedUnknownError: {
                    if (pincodeTracker == 1  && selectedPage == "settings" && savePinInitiated == true) {
                        if (createPin == 0){
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
            text: "Pincode SET!"
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
            width: doubbleButtonWidth / 2
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
