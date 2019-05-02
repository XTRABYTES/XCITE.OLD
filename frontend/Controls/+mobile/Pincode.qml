/**
 * Filename: Pincode.qml
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

Rectangle {
    id: pincodeModal
    width: Screen.width
    state: pincodeTracker == 1? "up" : "down"
    height: Screen.height
    color: darktheme == false? "#F7F7F7" : "#14161B"
    onStateChanged: detectInteraction()

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

    MouseArea {
        anchors.fill: parent
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: pincodeModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: pincodeModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: pincodeModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    Text {
        id: pincodeModalLabel
        text: createPin == 1? "CREATE NEW PINCODE" : (changePin == 1? "CHANGE PINCODE": "ENTER PINCODE")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        visible: newPinSaved == 0
    }

    property int newPinSaved: 0
    property string coin: ""
    property string walletHash: ""
    property real amount: 0
    property string partnerHash: ""
    property real fee: 0

    property int passTry: 0
    property int passError1: 0
    property int passError2: 0
    property int passError3: 0
    property int failToSave: 0

    property int currentPinCorrect: 0

    property string failError: ""

    Flickable {
        id: scrollArea
        width: parent.width
        contentHeight: pincodeScrollArea.height > scrollArea.height? pincodeScrollArea.height + 125 : scrollArea.height + 125
        anchors.left: parent.left
        anchors.top: pincodeModalLabel.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        boundsBehavior: Flickable.StopAtBounds
        interactive: (pincodeScrollArea.y + pincodeScrollArea.height) >= bottomGradient.y
        clip: true

        Rectangle {
            id: pincodeScrollArea
            width: parent.width
            height: createPin == 1? (newPinSaved == 1 ? pinSaved.height : (failToSave == 1? saveFailed.height : createPinModal.height)) : (changePin == 1? (newPinSaved == 1 ? pinChanged.height : (failToSave == 1? saveFailed.height : changePinModal.height)): pinOK == 1? pinCorrect.height : pinError == 1? pinFail.height : providePinModal.height)
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
        }

        Item {
            id: createPinModal
            width: parent.width
            height: createPinText1.height + newPin1.height + createPinText2.height + newPin2.height + noMatch.height + savePin.height + 96
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            visible: createPin == 1
                     && newPinSaved == 0
                     && failToSave == 0

            Label {
                id: createPinText1
                text: "Choose a 4-digit pincode"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Controls.AmountInput {
                id: newPin1
                height: 70
                anchors.right: parent.right
                anchors.rightMargin: 28
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.top: createPinText1.bottom
                anchors.topMargin: 20
                placeholder: ""
                echoMode: TextInput.Password
                horizontalAlignment: TextInput.AlignHCenter
                color: themecolor
                textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
                font.pixelSize: 28
                font.letterSpacing: 4
                readOnly: (newPin1.text).length >= 4
                mobile: 1
                calculator: 0
                onTextChanged: detectInteraction()

                Image {
                    id: createPinOK
                    source: 'qrc:/icons/icon-ok_01.svg'
                    height: 20
                    width: 20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 35
                    visible: (changePin1.text).length === 4
                }
            }

            Label {
                id: createPinText2
                text: "Retype your 4-digit pincode"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: newPin1.bottom
                anchors.topMargin: 30
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Controls.AmountInput {
                id: newPin2
                height: 70
                anchors.right: parent.right
                anchors.rightMargin: 28
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.top: createPinText2.bottom
                anchors.topMargin: 20
                placeholder: ""
                echoMode: TextInput.Password
                horizontalAlignment: TextInput.AlignHCenter
                color: themecolor
                textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
                font.pixelSize: 28
                font.letterSpacing: 4
                readOnly: (newPin2.text).length >= 4
                mobile: 1
                calculator: 0

                onTextChanged: {
                    detectInteraction()
                    passError3 = 0
                    if ((newPin2.text).length === 4){
                        if (newPin2.text !== newPin1.text) {
                            passError3 = 1
                            newPin2.text = ""
                        }
                    }
                }
                Image {
                    id: createPinRepeateOK
                    source: 'qrc:/icons/icon-ok_01.svg'
                    height: 20
                    width: 20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 35
                    visible: newPin2.text === newPin1.text
                }
            }

            Label {
                id: noMatch
                text: "The pincodes you entered don't match!"
                color: "#FD2E2E"
                anchors.left: newPin2.left
                anchors.leftMargin: 5
                anchors.top: newPin2.bottom
                anchors.topMargin: 1
                font.pixelSize: 11
                font.family: "Brandon Grotesque"
                font.weight: Font.Normal
                visible: passError3 == 1
            }

            Rectangle {
                id: savePin
                width: doubbleButtonWidth / 2
                height: 34
                color: (newPin1.text !== ""
                        && newPin1.text.length === 4
                        && newPin2.text !== ""
                        && newPin2.text.length === 4
                        && passError3 == 0)? maincolor : "#727272"
                opacity: 0.25
                anchors.top: newPin2.bottom
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter

                Timer {
                    id: timer1
                    interval: 2000
                    repeat: false
                    running: false

                    onTriggered: {
                        pincodeTracker = 0
                        createPin = 0
                        newPinSaved = 0
                    }
                }

                MouseArea {
                    anchors.fill: parent

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
                        if (newPin1.text !== ""
                                && newPin1.text.length === 4
                                && newPin2.text !== ""
                                && newPin2.text.length === 4
                                && passError3 == 0) {
                            console.log("attempting to save pincode");
                            newPinSaved = 0;
                            userSettings.pinlock = true;
                            savePincode(newPin1.text);
                        }
                    }
                }

                Connections {
                    target: UserSettings

                    onSaveSucceeded: {
                        if (pincodeTracker == 1 && selectedPage == "settings") {
                            if (createPin == 1){
                                console.log("save succeeded");
                                console.log("locale: " + userSettings.locale + ", default currency: " + userSettings.defaultCurrency + ", theme: " + userSettings.theme + ", pinlock: " + userSettings.pinlock + ", account complete: " + userSettings.accountCreationCompleted + ", local keys: " + userSettings.localKeys)
                                newPin1.text = "";
                                newPin2.text = "";
                                newPinSaved = 1
                                timer1.start();
                            }
                        }
                    }

                    onSaveFailed: {
                        if (pincodeTracker == 1 && selectedPage == "settings") {
                            if (createPin == 1) {
                                console.log("save failed");
                                userSettings.pinlock = true;
                                newPin1.text = "";
                                newPin2.text = "";
                                failToSave = 1;
                            }
                        }
                    }

                    onSaveFailedDBError: {
                        if (pincodeTracker == 1 && selectedPage == "settings") {
                            if (changePin == 0){
                                failError = "Database ERROR"
                            }
                        }
                    }

                    onSaveFailedAPIError: {
                        if (pincodeTracker == 1  && selectedPage == "settings") {
                            if (changePin == 0){
                                failError = "Network ERROR"
                            }
                        }
                    }

                    onSaveFailedInputError: {
                        if (pincodeTracker == 1  && selectedPage == "settings") {
                            if (changePin == 0){
                                failError = "Input ERROR"
                            }
                        }
                    }

                    onSaveFailedUnknownError: {
                        if (pincodeTracker == 1  && selectedPage == "settings") {
                            if (changePin == 0){
                                failError = "Unknown ERROR"
                            }
                        }
                    }
                }
            }
            Text {
                text: "SAVE"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: (newPin1.text !== ""
                        && newPin1.text.length === 4
                        && newPin2.text !== ""
                        && newPin2.text.length === 4
                        && passError3 == 0)? (darktheme == true? "#F2F2F2" : maincolor) : "#979797"
                anchors.horizontalCenter: savePin.horizontalCenter
                anchors.verticalCenter: savePin.verticalCenter
            }

            Rectangle {
                width: savePin.width
                height: 34
                anchors.bottom: savePin.bottom
                anchors.left: savePin.left
                color: "transparent"
                opacity: 0.5
                border.color: (newPin1.text !== ""
                               && newPin1.text.length === 4
                               && newPin2.text !== ""
                               && newPin2.text.length === 4
                               && passError3 == 0)? maincolor : "#979797"
                border.width: 1
            }
        }

        Item {
            id: changePinModal
            width: parent.width
            height: currentPinText.height + currentPin.height + newPinText1.height + changePin1.height + newPinText2.height + changePin2.height +noMatch2.height + editPin.height + 146
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            visible: changePin == 1
                     && newPinSaved == 0
                     && failToSave == 0

            Label {
                id: currentPinText
                text: "Enter your current pincode"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Controls.AmountInput {
                id: currentPin
                height: 70
                anchors.right: parent.right
                anchors.rightMargin: 28
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.top: currentPinText.bottom
                anchors.topMargin: 20
                placeholder: ""
                echoMode: TextInput.Password
                horizontalAlignment: TextInput.AlignHCenter
                color: themecolor
                textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
                font.pixelSize: 28
                font.letterSpacing: 4
                readOnly: (currentPin.text).length >= 4 && passError2 == 0
                mobile: 1
                calculator: 0

                Image {
                    id: currentPinOK
                    source: 'qrc:/icons/icon-ok_01.svg'
                    height: 20
                    width: 20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 35
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
                id: newPinText1
                text: "Choose a new 4-digit pincode"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: currentPin.bottom
                anchors.topMargin: 30
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Controls.AmountInput {
                id: changePin1
                height: 70
                anchors.right: parent.right
                anchors.rightMargin: 28
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.top: newPinText1.bottom
                anchors.topMargin: 20
                placeholder: ""
                echoMode: TextInput.Password
                horizontalAlignment: TextInput.AlignHCenter
                color: themecolor
                textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
                font.pixelSize: 28
                font.letterSpacing: 4
                readOnly: (changePin1.text).length >= 4
                mobile: 1
                calculator: 0
                onTextChanged: detectInteraction()

                Image {
                    id: newPinOK
                    source: 'qrc:/icons/icon-ok_01.svg'
                    height: 20
                    width: 20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 35
                    visible: (changePin1.text).length === 4
                }
            }

            Label {
                id: newPinText2
                text: "Choose a new 4-digit pincode"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: changePin1.bottom
                anchors.topMargin: 30
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Controls.AmountInput {
                id: changePin2
                height: 70
                anchors.right: parent.right
                anchors.rightMargin: 28
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.top: newPinText2.bottom
                anchors.topMargin: 20
                placeholder: ""
                echoMode: TextInput.Password
                horizontalAlignment: TextInput.AlignHCenter
                color: themecolor
                textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
                font.pixelSize: 28
                font.letterSpacing: 4
                readOnly: (changePin2.text).length >= 4
                mobile: 1
                calculator: 0

                onTextChanged: {
                    detectInteraction()
                    passError3 = 0
                    if ((changePin2.text).length === 4){
                        if (changePin2.text !== changePin1.text) {
                            passError3 = 1
                            changePin2.text = ""
                        }
                    }
                }
                Image {
                    id: newPinRepeatOK
                    source: 'qrc:/icons/icon-ok_01.svg'
                    height: 20
                    width: 20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 35
                    visible: changePin2.text === changePin1.text && (changePin2.text).length === 4
                }
            }

            Label {
                id: noMatch2
                text: "The new pincodes you entered don't match!"
                color: "#FD2E2E"
                anchors.left: changePin2.left
                anchors.leftMargin: 5
                anchors.top: changePin2.bottom
                anchors.topMargin: 1
                font.pixelSize: 11
                font.family: "Brandon Grotesque"
                font.weight: Font.Normal
                visible: passError3 == 1
            }

            Rectangle {
                id: editPin
                width: doubbleButtonWidth / 2
                height: 34
                color: (currentPin.text !== ""
                        && currentPin.text.length === 4
                        && changePin1.text !== ""
                        && changePin1.text.length === 4
                        && changePin2.text !== ""
                        && changePin2.text.length === 4
                        && passError3 == 0
                        && passError1 == 0)? maincolor : "#727272"
                opacity: 0.25
                anchors.top: changePin2.bottom
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter

                Timer {
                    id: timer5
                    interval: 2000
                    repeat: false
                    running: false

                    onTriggered: {
                        pincodeTracker = 0
                        changePin = 0
                        newPinSaved = 0
                    }
                }

                MouseArea {
                    anchors.fill: parent

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
                        if (currentPin.text !== ""
                                && currentPin.text.length === 4
                                && changePin1.text !== ""
                                && changePin1.text.length === 4
                                && changePin2.text !== ""
                                && changePin2.text.length === 4
                                && passError3 == 0
                                && passError1 == 0) {
                            savePincode(changePin1.text)
                        }
                    }
                }

                Connections {
                    target: UserSettings

                    onSaveSucceeded: {
                        if (pincodeTracker == 1 && selectedPage == "settings"){
                            if (changePin == 1) {
                                if (newPinSaved == 0) {
                                    newPinSaved = 1
                                    passTry = 0
                                    currentPin.text = ""
                                    changePin1.text = ""
                                    changePin2.text = ""
                                    timer5.start()
                                }
                            }
                        }
                    }

                    onSaveFailed: {
                        if (pincodeTracker == 1 && selectedPage == "settings") {
                            if (changePin == 1){
                                currentPin.text = ""
                                changePin1.text = ""
                                changePin2.text = ""
                                failToSave = 1
                            }
                        }
                    }
                    onSaveFailedDBError: {
                        if (pincodeTracker == 1 && selectedPage == "settings") {
                            if (changePin == 1){
                                failError = "Database ERROR"
                            }
                        }
                    }

                    onSaveFailedAPIError: {
                        if (pincodeTracker == 1 && selectedPage == "settings") {
                            if (changePin == 1){
                                failError = "Network ERROR"
                            }
                        }
                    }

                    onSaveFailedInputError: {
                        if (pincodeTracker == 1 && selectedPage == "settings") {
                            if (changePin == 1){
                                failError = "Input ERROR"
                            }
                        }
                    }

                    onSaveFailedUnknownError: {
                        if (pincodeTracker == 1 && selectedPage == "settings") {
                            if (changePin == 1){
                                failError = "Unknown ERROR"
                            }
                        }
                    }
                }
            }

            Text {
                text: "SAVE"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: (currentPin.text !== ""
                        && currentPin.text.length === 4
                        && changePin1.text !== ""
                        && changePin1.text.length === 4
                        && changePin2.text !== ""
                        && changePin2.text.length === 4
                        && passError3 == 0
                        && passError1 == 0)? (darktheme == true? "#F2F2F2" : maincolor) : "#979797"
                anchors.horizontalCenter: editPin.horizontalCenter
                anchors.verticalCenter: editPin.verticalCenter
            }

            Rectangle {
                width: editPin.width
                height: 34
                anchors.bottom: editPin.bottom
                anchors.left: editPin.left
                color: "transparent"
                opacity: 0.5
                border.color: (currentPin.text !== ""
                               && currentPin.text.length === 4
                               && changePin1.text !== ""
                               && changePin1.text.length === 4
                               && changePin2.text !== ""
                               && changePin2.text.length === 4
                               && passError3 == 0
                               && passError1 == 0)? maincolor : "#979797"
                border.width: 1
            }
        }

        Item {
            id: providePinModal
            width: parent.width
            height: providePinText.height + pin.height + 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            visible: createPin == 0
                     && changePin == 0
                     && pinOK == 0
                     && pinError == 0
            Label {
                id: providePinText
                text: unlockPin == 1? "To unlock your wallet please enter your pincode" : "To continue please enter your pincode"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Controls.AmountInput {
                id: pin
                height: 70
                anchors.right: parent.right
                anchors.rightMargin: 28
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.top: providePinText.bottom
                anchors.topMargin: 20
                placeholder: ""
                echoMode: TextInput.Password
                horizontalAlignment: TextInput.AlignHCenter
                color: themecolor
                textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
                font.pixelSize: 28
                font.letterSpacing: 4
                readOnly: (pin.text).length >= 4
                mobile: 1
                deleteBtn: 0
                calculator: 0

                Timer {
                    id: timer3
                    interval: 1000
                    repeat: false
                    running: false

                    onTriggered: {
                        pinOK = 0
                        pincodeTracker = 0
                        unlockPin = 0
                        clearAll = 0
                    }
                }

                Timer {
                    id: timer4
                    interval: passError2 == 1 ? 300 : 2000
                    repeat: false
                    running: false

                    onTriggered: {
                        if (passError2 == 1) {
                            pincodeTracker = 0
                            unlockPin = 0
                            clearAll = 0
                        }
                        else {
                            pinError = 0
                        }
                    }
                }

                onTextChanged: {
                    detectInteraction()
                    if ((pin.text).length === 4){
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

        Item {
            id: saveFailed
            width: parent.width
            height: saveFailedIcon.height + saveFailedLabel.height + closeFailed.height + 60
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            visible: (createPin == 1 || changePin == 1)
                     && failToSave == 1

            Image {
                id: saveFailedIcon
                source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
                height: 100
                width: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: saveFailed.top
            }

            Label {
                id: saveFailedLabel
                text: createPin == 1? "Unable to set new pincode" : changePin == 1? "Unable to change your pincode" : ""
                anchors.top: saveFailedIcon.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: saveFailedIcon.horizontalCenter
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                font.pixelSize: 14
                font.family: xciteMobile.name
                font.bold: true
            }

            Label {
                id: saveFailedError
                text: failError
                anchors.top: saveFailedLabel.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: saveFailed.horizontalCenter
                color: maincolor
                font.pixelSize: 14
                font.family: "Brandon Grotesque"
                font.bold: true
            }

            Rectangle {
                id: closeFailed
                width: doubbleButtonWidth / 2
                height: 34
                color: maincolor
                opacity: 0.25
                anchors.top: saveFailedError.bottom
                anchors.topMargin: 50
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: closeFailed

                    onPressed: {
                        closeDelete.opacity = 0.5
                        click01.play()
                        detectInteraction()
                    }

                    onCanceled: {
                        closeDelete.opacity = 0.25
                    }

                    onReleased: {
                        closeDelete.opacity = 0.25
                    }

                    onClicked: {
                        failToSave = 0;
                    }
                }
            }

            Text {
                text: "TRY AGAIN"
                font.family: xciteMobile.name
                font.pointSize: 14
                font.bold: true
                color: darktheme == true? "#F2F2F2" : maincolor
                anchors.horizontalCenter: closeFailed.horizontalCenter
                anchors.verticalCenter: closeFailed.verticalCenter
            }

            Rectangle {
                width: doubbleButtonWidth / 2
                height: 34
                anchors.bottom: closeFailed.bottom
                anchors.horizontalCenter: closeFailed.horizontalCenter
                color: "transparent"
                border.color: maincolor
                border.width: 1
                opacity: 0.5
            }
        }

        Item {
            id: pinSaved
            width: parent.width
            height: pinSavedText.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            visible: createPin == 1
                     && newPinSaved == 1

            Label {
                id: pinSavedText
                text: "Pincode SET!"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                font.bold: true
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }
        }

        Item {
            id: pinChanged
            width: parent.width
            height: pinChangedText.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            visible: changePin == 1
                     && newPinSaved == 1

            Label {
                id: pinChangedText
                text: "New pincode SET!"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                font.bold: true
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }
        }

        Item {
            id: pinCorrect
            width: parent.width
            height: pinSucces.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            visible: createPin == 0
                     && changePin == 0
                     && pinOK == 1
                     && pinError == 0

            Label {
                id: pinSucces
                text: "Pincode CORRECT!"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                font.bold: true
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }
        }

        Item {
            id: pinFail
            width: parent.width
            height: wrongPin1.height + wrongPin2.height + 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            visible: createPin == 0
                     && changePin == 0
                     && pinOK == 0
                     && pinError == 1

            Label {
                id: wrongPin1
                text: "The pincodes you entered is incorrect!"
                color: themecolor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                font.weight: Font.Normal
            }

            Label {
                id: wrongPin2
                text: passError2 == 0? "You have " + (3 - passTry) + " attempts left before you are logged out automatically!" : ""
                color: themecolor
                width: doubbleButtonWidth
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: wrongPin1.bottom
                anchors.topMargin: 5
                font.pixelSize: 14
                font.family: "Brandon Grotesque"
                font.weight: Font.Normal
            }
        }
    }

    Rectangle {
        id: serverError
        z: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.top
        width: Screen.width
        state: networkError == 0? "up" : "down"
        color: "black"
        opacity: 0.9
        clip: true
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

                onPressed: {
                    detectInteraction()
                }

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

    Item {
        id: bottomGradient
        z: 3
        width: Screen.width
        height: myOS === "android"? 125 : 145
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
        id: closePincode
        z: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : 70
        anchors.horizontalCenter: parent.horizontalCenter
        text: "BACK"
        font.pixelSize: 14
        font.family: xciteMobile.name
        color: themecolor
        //visible: pinOK == 0
        //         && pinError == 0

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
                detectInteraction()
            }

            onClicked: {
                pincodeTracker = 0
                createPin = 0
                changePin = 0
                unlockPin = 0
                passError1 = 0
                passError2 = 0
                passError3 = 0
                pin.text = ""
                newPin1.text = ""
                newPin2.text = ""
                currentPin.text = ""
                changePin1.text = ""
                changePin2.text = ""
            }
        }
    }
}
