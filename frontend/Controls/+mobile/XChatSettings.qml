/**
* Filename: XChatSettings.qml
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
import SortFilterProxyModel 0.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.11
import QtQuick.Window 2.2

import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: xchatSettingsModal
    width: Screen.width
    state: xchatSettingsTracker == 1? "up" : "down"
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
            PropertyChanges { target: xchatSettingsModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: xchatSettingsModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: xchatSettingsModal; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    MouseArea {
        anchors.fill: parent
    }

    Text {
        id: xchatSettingsModalLabel
        text: "X-CHAT SETTINGS"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Label {
        id: tagMeLabel
        z: 1
        text: "Mute personal tags:"
        font.pixelSize: 16
        font.family: xciteMobile.name
        font.bold: true
        color: themecolor
        anchors.top: xchatSettingsModalLabel.bottom
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 28
    }

    Rectangle {
        id: tagMeswitchSwitch
        z: 1
        width: 20
        height: 20
        radius: 10
        anchors.verticalCenter: tagMeLabel.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 28
        color: "transparent"
        border.color: themecolor
        border.width: 2

        Rectangle {
            id: tagMeIndicator
            z: 1
            width: 12
            height: 12
            radius: 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: userSettings.tagMe === false ? maincolor : "#757575"

            MouseArea {
                id: tagMeButton
                width: 30
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                onPressed: {
                    detectInteraction()
                }

                onClicked: {
                    if (userSettings.tagMe === false) {
                        userSettings.tagMe = true
                    }
                    else {
                        userSettings.tagMe = false
                    }
                }
            }
        }
    }

    Label {
        id: tagEveryoneLabel
        z: 1
        text: "Mute <font color='#5E8BFF'><b>@everyone</b></font> tags:"
        font.pixelSize: 16
        font.family: xciteMobile.name
        font.bold: true
        color: themecolor
        anchors.top: tagMeLabel.bottom
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 28
    }

    Rectangle {
        id: tagEveryoneswitchSwitch
        z: 1
        width: 20
        height: 20
        radius: 10
        anchors.verticalCenter: tagEveryoneLabel.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 28
        color: "transparent"
        border.color: themecolor
        border.width: 2

        Rectangle {
            id: tagEveryoneIndicator
            z: 1
            width: 12
            height: 12
            radius: 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: userSettings.tagEveryone === false ? maincolor : "#757575"

            MouseArea {
                id: tagEveryoneButton
                width: 30
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                onPressed: {
                    detectInteraction()
                }

                onClicked: {
                    if (userSettings.tagEveryone === false) {
                        userSettings.tagEveryone = true
                    }
                    else {
                        userSettings.tagEveryone = false
                    }
                }
            }
        }
    }

    Label {
        id: closeXchatSettingsModal
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
                }
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onReleased: {
                if (xchatSettingsTracker == 1) {
                    xchatSettingsTracker = 0
                    timer.start()
                }
            }
        }
    }
}
