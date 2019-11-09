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
    visible: xchatSettingsModal.anchors.topMargin < Screen.height

    property bool tagMeChangeInitiated: false
    property bool tagEveryoneChangeInitiated: false
    property bool dndChangeInitiated: false
    property bool oldTagMe: userSettings.tagMe
    property bool oldTagEveryone: userSettings.tagEveryone
    property bool oldDND: userSettings.xChatDND
    property int changeTagMeFailed: 0
    property int changeTagEveryoneFailed: 0
    property int changeDNDFailed : 0
    property int saveFailed: 0

    onChangeTagMeFailedChanged: {
        if(changeTagMeFailed == 1) {
            saveFailed = 1
        }
    }

    onChangeTagEveryoneFailedChanged: {
        if(changeTagEveryoneFailed == 1) {
            saveFailed = 1
        }
    }

    onChangeDNDFailedChanged: {
        if (changeDNDFailed == 1) {
            saveFailed = 1
        }
    }

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
        id: taggingLabel
        z: 1
        text: "Tag settings"
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.bold: true
        color: themecolor
        anchors.top: xchatSettingsModalLabel.bottom
        anchors.topMargin: 50
        anchors.left: parent.left
        anchors.leftMargin: 28
    }

    Label {
        id: tagMeLabel
        z: 1
        text: userSettings.tagMe === false ? "Mute personal tags (<font color='#0ED8D2'><b> on </b></font>)" : "Mute personal tags (<b> off </b>)"
        font.pixelSize: 16
        font.family: xciteMobile.name
        color: themecolor
        anchors.top: taggingLabel.bottom
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 28
        opacity: userSettings.tagMe === false ? 1 : 0.5
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
                    if (userSettings.tagMe === false && tagMeChangeInitiated == false && tagEveryoneChangeInitiated == false && dndChangeInitiated == false) {
                        oldTagMe = false
                        tagMeChangeInitiated = true
                        userSettings.tagMe = true
                        updateToAccount()
                    }
                    else if (tagMeChangeInitiated == false && tagEveryoneChangeInitiated == false && dndChangeInitiated == false){
                        oldTagMe = true
                        tagMeChangeInitiated = true
                        userSettings.tagMe = false
                        updateToAccount()
                    }
                }
            }
        }
    }

    Label {
        id: tagEveryoneLabel
        z: 1
        text: userSettings.tagEveryone === false ? "Mute <font color='#5E8BFF'><b>@everyone</b></font> tags (<font color='#0ED8D2'><b> on </b></font>)" : "Mute <font color='#5E8BFF'><b>@everyone</b></font> tags (<b> off </b>)"
        font.pixelSize: 16
        font.family: xciteMobile.name
        color: themecolor
        anchors.top: tagMeLabel.bottom
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 28
        opacity: userSettings.tagEveryone === false ? 1 : 0.5
    }

    Rectangle {
        id: tagEveryoneSwitch
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
                    if (userSettings.tagEveryone === false && tagMeChangeInitiated == false && tagEveryoneChangeInitiated == false && dndChangeInitiated == false) {
                        oldTagEveryone = false
                        tagEveryoneChangeInitiated = true
                        userSettings.tagEveryone = true
                        updateToAccount()
                    }
                    else if (tagMeChangeInitiated == false && tagEveryoneChangeInitiated == false && dndChangeInitiated == false){
                        oldTagEveryone = true
                        tagEveryoneChangeInitiated = true
                        userSettings.tagEveryone = false
                        updateToAccount()
                    }
                }
            }
        }
    }

    Label {
        id: dndLabel
        z: 1
        text: userSettings.xChatDND === false ? "Do not disturb (<b> off </b>)" : "Do not disturb (<font color='#0ED8D2'><b> on </b></font>)"
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.bold: true
        color: themecolor
        anchors.top: tagEveryoneLabel.bottom
        anchors.topMargin: 50
        anchors.left: parent.left
        anchors.leftMargin: 28
    }

    Label {
        id: dndInfoLabel
        z: 1
        text: "When <font color='#0ED8D2'><b>Do not disturb</b></font> is on you will not receive notifications for tags."
        font.pixelSize: 16
        font.family: xciteMobile.name
        font.italic: true
        color: themecolor
        anchors.top: dndLabel.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.right: parent.right
        anchors.rightMargin: 28
        wrapMode: Text.WordWrap
    }

    Rectangle {
        id: dndSwitch
        z: 1
        width: 20
        height: 20
        radius: 10
        anchors.verticalCenter: dndLabel.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 28
        color: "transparent"
        border.color: themecolor
        border.width: 2

        Rectangle {
            id: dndIndicator
            z: 1
            width: 12
            height: 12
            radius: 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: userSettings.xChatDND === false ? "#757575" : maincolor

            MouseArea {
                id: dndButton
                width: 30
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                onPressed: {
                    detectInteraction()
                }

                onClicked: {
                    if (userSettings.xChatDND === false && tagMeChangeInitiated == false && tagEveryoneChangeInitiated == false && dndChangeInitiated == false) {
                        oldDND = false
                        dndChangeInitiated = true
                        userSettings.xChatDND = true
                        updateToAccount()
                    }
                    else if (tagMeChangeInitiated == false && tagEveryoneChangeInitiated == false && dndChangeInitiated == false){
                        oldDND = true
                        dndChangeInitiated = true
                        userSettings.xChatDND = false
                        updateToAccount()
                    }
                    xChatTypingSignal(myUsername,"addToOnline", status)
                }
            }
        }
    }

    Connections  {
        target: UserSettings

        onSaveSucceeded: {
            if (tagMeChangeInitiated == true) {
                tagMeChangeInitiated = false
            }
            if (tagEveryoneChangeInitiated == true) {
                tagEveryoneChangeInitiated = false
            }
            if (dndChangeInitiated == true) {
                dndChangeInitiated = false
                xChatTypingSignal(myUsername,"addToOnline", status)
            }
        }

        onSaveFailed: {
            if (tagMeChangeInitiated == true) {
                userSettings.tagMe = oldTagMe
                changeTagMeFailed = 1
                tagMeChangeInitiated = false
            }
            if (tagEveryoneChangeInitiated == true) {
                userSettings.tagEveryone = oldTagEveryone
                changeTagEveryoneFailed = 1
                tagEveryoneChangeInitiated = false
            }
            if (dndChangeInitiated == true) {
                console.log("Do not disturbd setting failed to save")
                userSettings.xChatDND = oldDND
                changeDNDFailed = 1
                dndChangeInitiated = false
                xChatTypingSignal(myUsername,"addToOnline", status)
            }
        }

        onNoInternet: {
            networkError = 1
            if (tagMeChangeInitiated == true) {
                userSettings.tagMe = oldTagMe
                changeTagMeFailed = 1
                tagMeChangeInitiated = false
            }
            if (tagEveryoneChangeInitiated == true) {
                userSettings.tagEveryone = oldTagEveryone
                changeTagEveryoneFailed = 1
                tagEveryoneChangeInitiated = false
            }
            if (dndChangeInitiated == true) {
                console.log("Do not disturbd setting failed to save")
                userSettings.xChatDND = oldDND
                changeDNDFailed = 1
                dndChangeInitiated = false
                xChatTypingSignal(myUsername,"addToOnline", status)
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

    Rectangle {
        z: 10
        id: saveFaileddModal
        width: Screen.width
        height: Screen.height
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        visible: saveFailed == 1

        MouseArea {
            anchors.fill: parent
        }

        Rectangle {
            width: Screen.width
            height: Screen.height
            color: "black"
            opacity: 0.35
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
        }

        DropShadow {
            anchors.fill: notificationBox
            source: notificationBox
            samples: 9
            radius: 4
            color: darktheme == true? "#000000" : "#727272"
            horizontalOffset:0
            verticalOffset: 0
            spread: 0
        }

        Rectangle {
            id: notificationBox
            width: notification.width + 56
            height: 50
            color: darktheme == false ? "#34363D" : "#2A2C31"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -50

            Item {
                id: notification
                width: notificationText.width
                height: notificationText.height
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    id: notificationText
                    text: changeTagMeFailed == 1 ? "<font color='#E55541'><b>FAILED</b></font> to change personal tag setting!" : (changeTagEveryoneFailed == 1? "<font color='#E55541'><b>FAILED</b></font> to change <font color='#5E8BFF'><b>@everyone</b></font> tag setting!" : "<font color='#E55541'><b>FAILED</b></font> to change <font color='#0ED8D2'><b>Do not disturb</b></font> setting!")
                    font.family: "Brandon Grotesque"
                    font.pointSize: 14
                    font.bold: true
                    color: "#F2F2F2"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        Timer {
            id: saveFailedTimer
            interval: 2000
            repeat: false
            running: saveFailed == 1

            onTriggered: {
                if(changeTagMeFailed == 1) {
                    changeTagMeFailed = 0
                }
                if(changeTagEveryoneFailed == 1) {
                    changeTagEveryoneFailed = 0
                }
                if(changeDNDFailed == 1) {
                    changeDNDFailed = 0
                }
                saveFailed = 0
            }
        }
    }
}
