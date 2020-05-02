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

import "qrc:/Controls/+mobile" as Controls

Rectangle {
    id: notificationModal
    width: appWidth
    height: appHeight
    anchors.horizontalCenter: xcite.horizontalCenter
    anchors.verticalCenter: xcite.verticalCenter
    color: bgcolor

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

    Image {
        id: clearNotifications
        source: darktheme == true? 'qrc:/icons/mobile/trash-icon_01_light.svg' : 'qrc:/icons/mobile/trash-icon_01_dark.svg'
        height: 25
        fillMode: Image.PreserveAspectFit
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.bottom: notificationList.top
        anchors.bottomMargin: 5
        visible: myNotifications.filteredCount > 0

        MouseArea {
            height: 25
            width: 25
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                if (updatingWalletsNotif == false) {
                    clearAlertList();
                    checkNotifications();
                    updatingWalletsNotif = true
                    updateToAccount()
                    appsTracker = 0
                    selectedPage = "home"
                    mainRoot.pop()
                    updatingWalletsNotif = false
                }
            }
        }
    }

    Item {
        z: 3
        width: parent.width
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
        anchors.bottomMargin: myOS === "android"? 50 : (isIphoneX()? 90 : 70)
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
                if (updatingWalletsNotif == false) {
                    alert = false
                    selectedPage = "home"
                    mainRoot.pop()
                }
            }
        }
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
}
