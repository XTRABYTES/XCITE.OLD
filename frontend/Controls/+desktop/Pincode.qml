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
import QtQuick.Window 2.2
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop

Rectangle {
    id: pincodeModal
    width: appWidth
    height: appHeight
    state: pincodeTracker == 1? "up" : "down"
    color: "transparent"
    onStateChanged: {
        detectInteraction()
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
            PropertyChanges { target: pincodeModal; anchors.topMargin: pincodeModal.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: pincodeModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    Rectangle {
        anchors.fill: parent
        color: bgcolor
        opacity: 0.9

        MouseArea {
            anchors.fill: parent
        }
    }

    Text {
        id: pincodeModalLabel
        text: createPin == 1? "CREATE NEW PINCODE" : (changePin == 1? "CHANGE PINCODE": "ENTER PINCODE")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: pincodeArea.top
        anchors.bottomMargin: appHeight/72
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: themecolor
        font.letterSpacing: 2
    }

    Rectangle {
        id: pincodeArea
        width: parent.width/3
        height: createPin == 1? createPinModal.height : (changePin == 1? changePinModal.height: providePinModal.height)
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: darktheme == true? "#0B0B09" : "#FFFFFF"
        border.color: maincolor
        border.width: 2

        CreatePin {
            id: createPinModal
            visible: pincodeTracker == 1 && createPin == 1
            anchors.top: parent.top
        }

        ChangePin {
            id: changePinModal
            visible: pincodeTracker == 1 && changePin == 1
            anchors.top: parent.top
        }

        ProvidePin {
            id: providePinModal
            visible: pincodeTracker == 1 && createPin == 0 && changePin == 0
            anchors.top: parent.top
        }
    }

    Rectangle {
        id: cancel
        width: parent.width/6
        height: appHeight/27
        radius: height/2
        color: "transparent"
        anchors.top: pincodeArea.bottom
        anchors.topMargin: appHeight/72
        anchors.horizontalCenter: parent.horizontalCenter
        border.width: 1
        border.color: themecolor
        visible: createPinModal.newPinSaved == 0 && createPinModal.failToSave == 0
                 && changePinModal.newPinSaved == 0 && changePinModal.failToSave == 0
                 && pinOK == 0 && pinError == 0
                 && savePinInitiated == false

        Rectangle {
            id: selectCancel
            anchors.fill: parent
            radius: height/2
            color: maincolor
            opacity: 0.3
            visible: false
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                selectCancel.visible = true
            }

            onExited: {
                selectCancel.visible = false
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                createPin = 0
                changePin = 0
                unlockPin = 0
                clearAll = 0
                pincodeTracker = 0
            }
        }

        Label {
            text: "CANCEL"
            font.pixelSize: parent.height/2
            font.family: xciteMobile.name
            color: themecolor
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
