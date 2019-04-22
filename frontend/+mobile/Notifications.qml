/**
 * Filename: Notifications.qml
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
    id: notificationModal
    width: Screen.width
    height: Screen.height
    color: bgcolor

    property bool updatingWallets: false
    property int updateFailed: 0

    Text {
        id: notificationModalLabel
        text: "ALERTS"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Rectangle {
        id: notificationList
        width: parent.width
        anchors.top: notificationModalLabel.bottom
        anchors.topMargin: 35
        anchors.bottom: closeNotificationModal.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        clip: true

        Controls.NotificationList {
            id: myNotifications
        }
    }

    Label {
        id: clearNotifications
        text: "CLEAR ALL"
        anchors.right: parent.right
        anchors.rightMargin: 14
        anchors.bottom: notificationList.top
        anchors.bottomMargin: 5
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        visible: alertList.count > 1

        MouseArea {
            height: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                if (updatingWallets == false) {
                    alertList.clear();
                    alertList.append({"date": "", "origin": "", "message": ""});
                    checkNotifications()
                    updatingWallets = true
                    updateToAccount()
                    appsTracker = 0
                    selectedPage = "home"
                    mainRoot.pop()
                }
            }
        }

        Connections {
            target: UserSettings

            onSaveSucceeded: {
                if (selectedPage == "notif" && updatingWallets == true) {
                    updatingWallets == false
                }
            }

            onSaveFailed: {
                if (selectedPage == "notif" && updatingWallets == true) {
                    updateFailed = 1
                    updatingWallets == false
                }
            }
        }
    }

    Item {
        z: 12
        width: popupUpdateFail.width
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -100
        visible: updateFailed == 1

        Rectangle {
            id: popupUpdateFail
            height: 50
            width: popupFailText.width + 56
            color: "#34363D"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: popupFailText
            text: "FAILED update your wallets!"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: "#E55541"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Timer {
            repeat: false
            running: updateFailed == 1
            interval: 2000

            onTriggered: updateFailed = 0
        }
    }

    Item {
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
        id: closeNotificationModal
        z: 10
        text: "CLOSE"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : 70
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"

        Rectangle{
            id: closeButton
            height: 34
            width: parent.width
            radius: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

        }

        MouseArea {
            anchors.fill: closeButton

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                appsTracker = 0
                selectedPage = "home"
                mainRoot.pop()
            }
        }
    }
}
