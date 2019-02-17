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
        contentHeight: homeSection.height + settingsSection.height + backupSection.height + appsSection.height + 100
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        visible: appsTracker == 1

        Item {
            id: homeSection
            width: sidebar.width
            height: homeText.height + 80
            anchors.top: parent.top

            Image {
                id: home
                source: 'qrc:/icons/mobile/home-icon_01.svg'
                anchors.top: parent.top
                anchors.topMargin: 25
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
                anchors.fill:homeSection
                color: "transparent"
                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        detectInteraction()
                    }

                    onClicked: {
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
            height: settingsText.height + 80
            anchors.top: homeSection.bottom

            Image {
                id: settings
                anchors.top: parent.top
                anchors.topMargin: 25
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
                anchors.fill: settingsSection
                color: "transparent"
                MouseArea {
                    anchors.fill: parent

                    onPressed: {
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
            height: backupText.height + 80
            anchors.top: settingsSection.bottom

            Image {
                id: backup
                anchors.top: parent.top
                anchors.topMargin: 25
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
                anchors.fill: backupSection
                color: "transparent"
                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        detectInteraction()
                    }

                    onClicked: {
                        if (selectedPage != "backup") {
                            appsTracker = 0
                            if (userSettings.pinlock === false) {
                                //selectedPage = "backup"
                                //mainRoot.push("../WalletBackup.qml")
                            }
                            else {
                                pincodeTracker = 1
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: appsSection
            width: sidebar.width
            height: appsText.height + 80
            anchors.top: backupSection.bottom

            Image {
                id: apps
                anchors.top: parent.top
                anchors.topMargin: 25
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
                anchors.fill: appsSection
                color: "transparent"
                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        detectInteraction()
                    }

                    onClicked: {
                        if (selectedPage != "apps") {
                            appsTracker = 0
                            //selectedPage = "apps"
                            //mainRoot.push("../Applications.qml")
                        }
                    }
                }
            }
        }

        Item {
            id: notifSection
            width: sidebar.width
            height: notifText.height + 80
            anchors.top: appsSection.bottom

            Image {
                id: notif
                anchors.top: parent.top
                anchors.topMargin: 25
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
                    color: notification == 1? "#E55541" : "transparent"
                    anchors.horizontalCenter: parent.right
                    anchors.verticalCenter: parent.top
                }

                Text {
                    id: notifText
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
                id: notifButtonArea
                anchors.fill: notifSection
                color: "transparent"
                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        detectInteraction()
                    }

                    onClicked: {
                        if (selectedPage != "notif") {
                            appsTracker = 0
                            //notification = 0
                            //selectedPage = "notif"
                            //mainRoot.push("../Notifications.qml")
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
        id: logoutSection
        width: sidebar.width
        height: homeText.height + 105
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
            anchors.fill: logoutSection
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                onClicked: {
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
}
