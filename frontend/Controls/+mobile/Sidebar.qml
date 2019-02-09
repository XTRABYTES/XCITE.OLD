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
            NumberAnimation { target: sidebar; property: "anchors.leftMargin"; duration: 300; easing.type: Easing.OutCubic}
        }
    ]

    Image {
        id: settings
        anchors.bottom: sidebar.bottom
        anchors.bottomMargin: 65
        anchors.horizontalCenter: sidebar.horizontalCenter
        source: '../icons/icon-settings.svg'
        width: 40
        height: 40
        z: 100
        visible: appsTracker == 1
        ColorOverlay {
            anchors.fill: settings
            source: settings
            color: maincolor
        }
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
        Rectangle {
            id: settingsButtonArea
            width: settings.width
            height: settings.height
            anchors.left: settings.left
            anchors.bottom: settings.bottom
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (selectedPage != "settings") {
                        appsTracker = 0
                        selectedPage = "settings"
                        mainRoot.pop("../DashboardForm.qml")
                        mainRoot.push("../WalletSettings.qml")
                    }
                }
            }
        }
    }

    Image {
        id: home
        source: 'qrc:/icons/icon-home.svg'
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.horizontalCenter: sidebar.horizontalCenter
        width: 40
        height: 36
        z: 100
        visible: appsTracker == 1
        ColorOverlay {
            anchors.fill: home
            source: home
            color: maincolor // make image like it lays under grey glass
        }
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
        Rectangle {
            id: homeButtonArea
            width: home.width
            height: home.height
            anchors.left: home.left
            anchors.bottom: home.bottom
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    appsTracker = 0
                    if (selectedPage != "home") {
                        selectedPage = "home"
                        // pop current page
                        mainRoot.push("../DashboardForm.qml")
                    }
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
            }
        }
    }
}
