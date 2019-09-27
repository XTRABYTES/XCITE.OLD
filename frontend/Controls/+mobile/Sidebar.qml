/**
 * Filename: Sidebar.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2

import "qrc:/Controls" as Controls

Rectangle {
    id: sidebar
    height: Screen.height
    width: 100
    state: appsTracker == 1? "up" : "down"
    color: "#2A2C31"
    anchors.left: parent.left
    z: 100

    onStateChanged: detectInteraction()

    states: [
        State {
            name: "up"
            PropertyChanges { target: sidebar; anchors.leftMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: sidebar; anchors.leftMargin: -100}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: sidebar; property: "anchors.leftMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    Flickable {
        id: sections
        width: sidebar.width
        anchors.top: sidebar.top
        anchors.bottom: logoutSection.top
        contentHeight: homeSection.height + settingsSection.height + backupSection.height + appsSection.height + notifSection.height + 125
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        visible: appsTracker == 1

        Item {
            id: homeSection
            width: sidebar.width
            height: homeText.height + 70
            anchors.top: parent.top

            Image {
                id: home
                source: 'qrc:/icons/mobile/home-icon_01.svg'
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                width: 40
                height: 40
                fillMode: Image.PreserveAspectFit
                z: 100

                Text {
                    id: homeText
                    text: "HOME"
                    anchors.top: parent.bottom
                    anchors.topMargin: 5
                    color: maincolor
                    font.family: xciteMobile.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                }
            }

            Rectangle {
                id: homeButtonArea
                width: parent.width
                height: home.height + homeText.height + 5
                anchors.top: parent.top
                color: "transparent"
                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        coinTracker = 0
                        contactTracker = 0
                        appsTracker = 0
                        if (selectedPage != "home") {
                            //push of current page
                            selectedPage = "home"
                            mainRoot.push("../DashboardForm.qml")
                        }
                    }
                }
            }
        }

        Item {
            id: settingsSection
            width: sidebar.width
            height: settingsText.height + 70
            anchors.top: homeSection.bottom

            Image {
                id: settings
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                source: 'qrc:/icons/mobile/settings-icon_01.svg'
                width: 40
                height: 40
                fillMode: Image.PreserveAspectFit
                z: 100

                Text {
                    id: settingsText
                    text: "SETTINGS"
                    anchors.top: parent.bottom
                    anchors.topMargin: 5
                    color: maincolor
                    font.family: xciteMobile.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                }
            }

            Rectangle {
                id: settingsButtonArea
                width: parent.width
                height: settings.height + settingsText.height + 5
                anchors.top: parent.top
                color: "transparent"
                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        if (selectedPage != "settings") {
                            appsTracker = 0
                            selectedPage = "settings"
                            mainRoot.push("../WalletSettings.qml")
                        }
                    }
                }
            }
        }

        Item {
            id: backupSection
            width: sidebar.width
            height: backupText.height + 70
            anchors.top: settingsSection.bottom

            Image {
                id: backup
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                source: 'qrc:/icons/mobile/wallet-icon_01.svg'
                width: 40
                height: 40
                fillMode: Image.PreserveAspectFit
                z: 100

                Text {
                    id: backupText
                    text: "BACK UP"
                    anchors.top: parent.bottom
                    anchors.topMargin: 5
                    color: maincolor
                    font.family: xciteMobile.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                }
            }

            Rectangle {
                id: backupButtonArea
                width: parent.width
                height: backup.height + backupText.height + 5
                anchors.top: parent.top
                color: "transparent"
                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        if (selectedPage != "backup") {
                            if (userSettings.pinlock === true) {
                                backupTracker = 1
                                pincodeTracker = 1
                            }
                            else {
                                appsTracker = 0
                                selectedPage = "backup"
                                mainRoot.push("qrc:/+mobile/WalletBackup.qml")
                            }
                        }
                    }
                }

                Timer {
                    id: timer3
                    interval: 1000
                    repeat: false
                    running: false

                    onTriggered: {
                        appsTracker = 0
                        selectedPage = "backup"
                        mainRoot.push("qrc:/+mobile/WalletBackup.qml");
                    }
                }

                Connections {
                    target: UserSettings
                    onPincodeCorrect: {
                        if (pincodeTracker == 1 && backupTracker == 1) {
                            timer3.start()
                        }
                    }
                }
            }
        }

        Item {
            id: appsSection
            width: sidebar.width
            height: appsText.height + 70
            anchors.top: backupSection.bottom

            Image {
                id: apps
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                source: 'qrc:/icons/mobile/dapps-icon_01.svg'
                width: 40
                height: 40
                fillMode: Image.PreserveAspectFit
                z: 100

                Text {
                    id: appsText
                    text: "APPS"
                    anchors.top: parent.bottom
                    anchors.topMargin: 5
                    color: maincolor
                    font.family: xciteMobile.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                }
            }

            Rectangle {
                id: appsButtonArea
                width: parent.width
                height: apps.height + appsText.height + 5
                anchors.top: parent.top
                color: "transparent"
                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        if (selectedPage != "apps") {
                            appsTracker = 0
                            selectedPage = "apps"
                            mainRoot.push("../Applications.qml")
                        }
                    }
                }
            }
        }

        Item {
            id: notifSection
            width: sidebar.width
            height: notifText.height + 70
            anchors.top: appsSection.bottom

            Image {
                id: notif
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                source: 'qrc:/icons/mobile/notification-icon_01.svg'
                width: 40
                height: 40
                fillMode: Image.PreserveAspectFit
                z: 100

                Rectangle {
                    id: notifIndicator
                    width: 8
                    height: 8
                    radius: 4
                    color: "#E55541"
                    anchors.horizontalCenter: parent.right
                    anchors.verticalCenter: parent.top
                    visible: alertList.count > 1
                }

                Text {
                    id: notifText
                    text: "ALERTS"
                    anchors.top: parent.bottom
                    anchors.topMargin: 5
                    color: maincolor
                    font.family: xciteMobile.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                }
            }

            Rectangle {
                id: notifButtonArea
                width: parent.width
                height: notif.height + notifText.height + 5
                anchors.top: parent.top
                color: "transparent"
                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        if (selectedPage != "notif") {
                            appsTracker = 0
                            selectedPage = "notif"
                            mainRoot.push("../Notifications.qml")
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: fadeOut
        width: sidebar.width
        height: 100
        anchors.bottom: sections.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(x, y)
            end: Qt.point(x, y + height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.5; color: "#2A2C31" }
                GradientStop { position: 1.0; color: "#2A2C31" }
            }
        }
    }

    Item {
        id: standbySection
        width: sidebar.width
        height: standbyText.height + 70
        anchors.bottom: logoutSection.top
        visible: false //appsTracker == 1

        Image {
            id: standby
            anchors.bottom: standbyText.top
            anchors.bottomMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            source: 'qrc:/icons/mobile/standby-icon_01.svg'
            width: 40
            height: 40
            fillMode: Image.PreserveAspectFit
            z: 100
        }

        Text {
            id: standbyText
            text: "STAND BY"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            color: maincolor
            font.family: xciteMobile.name
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }

        Rectangle {
            id: standbyButtonArea
            width: parent.width
            height: standby.height + standbyText.height + 5
            anchors.top: parent.top
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    click01.play()
                    detectInteraction()
                    standBy = 1
                    screenSaver = 0
                    timer.start()
                    mainRoot.push("../StandBy.qml")
                    appsTracker = 0
                }
            }
        }
    }

    Item {
        id: logoutSection
        width: sidebar.width
        height: logoutText.height + 70
        anchors.bottom: parent.bottom
        visible: appsTracker == 1

        Image {
            id: logout
            anchors.bottom: logoutText.top
            anchors.bottomMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            source: 'qrc:/icons/mobile/logout-icon_01.svg'
            width: 40
            height: 40
            fillMode: Image.PreserveAspectFit
            z: 100
        }

        Text {
            id: logoutText
            text: "LOG OUT"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            color: maincolor
            font.family: xciteMobile.name
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }

        Rectangle {
            id: logoutButtonArea
            width: parent.width
            height: logout.height + logoutText.height + 5
            anchors.top: parent.top
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    click01.play()
                    detectInteraction()
                    sessionStart = 0
                    sessionTime = 0
                    manualLogout = 1
                    logoutTracker = 1
                }
            }
        }
    }

    Rectangle {
        anchors.left: parent.right
        width: appsTracker == 1 ? (Screen.width - parent.width) : 0
        height: parent.height
        color: "black"
        opacity: 0.5

        MouseArea {
            anchors.fill: parent

            onPressed: {
                appsTracker = 0
                detectInteraction()
            }
        }
    }

    Controls.Pincode {
        id: myPincode
        z: 100
        anchors.top: parent.top
        anchors.left: parent.left
        visible: appsTracker == 1
    }
}
