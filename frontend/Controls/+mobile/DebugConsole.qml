/**
 * Filename: DebugConsole.qml
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
    id: debugModal
    width: Screen.width
    state: debugTracker == 1? "up" : "down"
    height: Screen.height
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    onStateChanged: detectInteraction()

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

    states: [
        State {
            name: "up"
            PropertyChanges { target: debugModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: debugModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: debugModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    property variant deBugArray
    property int debugError: 0

    Text {
        id: debugModalLabel
        text: "DEBUG CONSOLE"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Rectangle {
        id: replyWindow
        width: Screen.width - 56
        anchors.top: debugModalLabel.bottom
        anchors.topMargin: 30
        anchors.bottom: requestText.top
        anchors.bottomMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        border.color: themecolor
        border.width: 1

        Flickable {
            id: scrollArea
            height: parent.height
            width: parent.width
            contentHeight: replyText.height
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            boundsBehavior: Flickable.DragOverBounds
            clip: true

            ScrollBar.vertical: ScrollBar {
                parent: scrollArea.parent
                anchors.top: scrollArea.top
                anchors.left: scrollArea.right
                anchors.bottom: scrollArea.bottom
                policy: ScrollBar.AsNeeded
                width: 5
            }

            Text {
                id: replyText
                y: scrollArea.y + scrollArea.height - replyText.implicitHeight
                width: parent.width
                text: ""
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                padding: 7
                wrapMode: Text.Wrap
                //anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: darktheme == true? maincolor : "#14161B"
                font.pixelSize: 14
                font.family: xciteMobile.name

                onTextChanged: {
                    y = scrollArea.y + scrollArea.height - replyText.implicitHeight
                }
            }
        }
    }

    Controls.TextInput {
        id: requestText
        height: 34
        placeholder: "TYPE YOUR COMMAND"
        text: ""
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.right: parent.right
        anchors.rightMargin: 62
        anchors.bottom: closeDebugModal.top
        anchors.bottomMargin: 25
        color: themecolor
        textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
        font.pixelSize: 14
        mobile: 1
    }

    Rectangle {
        id: executeButton
        width: 34
        height: 34
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.bottom: closeDebugModal.top
        anchors.bottomMargin: 25
        color: maincolor
        opacity: 0.25

        MouseArea {
            anchors.fill: parent

            onPressed: {
                click01.play()
                detectInteraction()
                parent.opacity = 0.5
            }

            onCanceled: {
                parent.opacity = 0.5
            }

            onReleased: {
                parent.opacity = 0.5
            }

            onClicked: {
                replyText.text = "<br>" + replyText.text + requestText.text + "<br>"
                deBugArray = (requestText.text).split(' ')
                debugError = 0
                if (deBugArray[0] === "help") {
                    helpMe()
                    requestText.text = ""
                }
                else if (deBugArray[0] === "!!xutil" && deBugArray[1] === "network") {
                    setNetwork(deBugArray[2])
                    requestText.text = ""
                }
                else if ((deBugArray[0] === "!!xutil" && deBugArray[1] === "createkeypair" && deBugArray[2] !== "")) {
                    createKeyPair(deBugArray[2])
                    requestText.text = ""
                }
                else if ((deBugArray[0] === "!!xutil" && deBugArray[1] === "privkey2address" && deBugArray[2] !== "" && deBugArray[3] !== "")) {
                    importPrivateKey(deBugArray[2], deBugArray[3])
                    requestText.text = ""
                }
                else if (deBugArray[0] === "!!staticnet" && deBugArray[1] === "sendcoin") {
                    console.log(deBugArray[2] + " " + deBugArray[3] + " " + deBugArray[4])
                    sendCoins(deBugArray[2] + " " + deBugArray[3] + " " + deBugArray[4]);

                    requestText.text = ""
                }
                else {
                    replyText.text = replyText.text + "-- Command does not exist.<br/>Use the command <b>help</b> to get a list of available commands.<br/>"
                    requestText.text = ""
                }
            }
        }

        Connections {
            target: xUtility
            onHelpReply: {
                if (debugTracker == 1) {
                    replyText.text = "<br>" + replyText.text + "<br>" +
                            "Use one of the following commands:" + "<br>" +
                            "<b>" + help1 + "</b><br>" +
                            "to know which network is active.<br>" +
                            "<b>" + help2 + "</b><br>" +
                            "to create a new wallet.<br>" +
                            "<b>" + help3 + "</b><br>" +
                            "to extract an address from a private key.<br>" +
                            "or <br>" +
                            "<b>" + help4 + "</b><br>" +
                            "to send a transaction.<br>"
                }
            }
            onKeyPairCreated: {
                if (debugTracker == 1 && debugError == 0) {
                    replyText.text = "<br>" + replyText.text + "<br>" +
                            "<b>Public key</b>:<br>" +
                            pubKey + "<br>" +
                            "<b>Private key</b>:<br>" +
                            privKey + "<br>" +
                            "<b>Address</b>:<br>" +
                            address + "<br>"
                }
            }

            onAddressExtracted: {
                if (debugTracker == 1 && debugError == 0) {
                    replyText.text = "<br>" + replyText.text + "<br>" +
                            "<b>Public key</b>:<br>" +
                            pubKey + "<br>" +
                            "<b>Private key</b>:<br>" +
                            privKey + "<br>" +
                            "<b>Address</b>:<br>" +
                            addressID + "<br>"
                }

            }
            onCreateKeypairFailed: {
                if (debugTracker == 1 && debugError == 0) {
                    replyText.text = "<br>" + replyText.text + "<br>" +
                            "We could not create a key for you.<br>"
                }

            }
            onBadKey: {
                if (debugTracker == 1 && debugError == 0) {
                    replyText.text = "<br>" + replyText.text + "<br>" +
                            "We could not extract an address from this key.<br >"
                }
            }
            onNetworkStatus: {
                if (debugTracker == 1) {
                    replyText.text ="<br>" +  replyText.text + "<br>" +
                            myNetwork + "<br>"
                }
            }
            onNewNetwork: {
                if (debugTracker == 1) {
                    replyText.text = "<br>" + replyText.text + "<br>" +
                            currentNetwork + "<br>"
                }
            }

            onBadNetwork: {
                if (debugTracker == 1) {
                    replyText.text = "<br>" + replyText.text + "<br>" +
                            noNetwork + "<br>"
                    debugError = 1
                }
            }
        }

        Connections {
            target: static_int
            onSendCoinsSuccess: {
                if (debugTracker == 1) {
                    replyText.text = "<br>" + replyText.text + "<br/>" +
                            "Send Success!:" + "<br/>" +
                            "TransactionId:" + transactionId + "<br>"
                }
            }
            onSendCoinsFailure: {
                if (debugTracker == 1) {
                    replyText.text = "<br>" + replyText.text + "<br/>" +
                            "Send Failed!:" + "<br/>" +
                            "Error:" + error + "<br>"
                }
            }
        }

    }

    Image {
        source: 'qrc:/icons/mobile/debug-icon_01_light.svg'
        height: 24
        width: 24
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: executeButton.verticalCenter
        anchors.horizontalCenter: executeButton.horizontalCenter
    }

    Rectangle {
        width: 34
        height: 34
        anchors.right: executeButton.right
        anchors.top: executeButton.top
        color: "transparent"
        border.color: maincolor
        border.width: 1
        opacity: 0.50
    }

    Label {
        id: closeDebugModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : 70
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"

        Rectangle{
            id: closeButton
            height: 34
            width: doubbleButtonWidth
            radius: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"
        }

        MouseArea {
            anchors.fill: closeButton

            Timer {
                id: timer
                interval: 300
                repeat: false
                running: false

                onTriggered: {
                    replyText.text = ""
                    requestText.text = ""
                    closeAllClipboard = true
                }
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onReleased: {
                if (debugTracker == 1) {
                    debugTracker = 0;
                    debugError = 0
                    timer.start()
                }
            }
        }
    }

    Component.onDestruction: {
        replyText.text = ""
        replyText.text = ""
        debugTracker = 0
        debugError = 0
    }
}
