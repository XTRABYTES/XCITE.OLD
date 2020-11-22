/**
 * Filename: LogOut.qml
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
    id: logoutScreen
    width: appWidth
    height: appHeight
    state: (logoutTracker == 1 && goodbey == 0)? "up" : "down"
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    Shortcut {
        sequence: "Y"
        onActivated: {
            if (manualLogout == 1) {
                goodbey = 1
                manualLogout = 0
                logoutTracker = 0
            }
            else if (sessionClosed == 1) {
                sessionClosed = 0
                sessionStart = 1
                logoutTracker = 0
            }
        }
    }

    Shortcut {
        sequence: "N"
        onActivated: {
            if (manualLogout == 1) {
                manualLogout = 0
                logoutTracker = 0
                sessionStart = 1
            }
            else if (sessionClosed == 1) {
                goodbey = 1
                sessionClosed = 0
                logoutTracker = 0
            }
        }
    }

    Shortcut {
        sequence: "N"
        onActivated: {
            if (autoLogout == 1) {
                logoutTimeout = 0
                autoLogout = 0
                logoutTracker = 0
            }
        }
    }

    MouseArea {
        anchors.fill: parent
    }

    property int logoutTimeout: 0
    property int myTracker: logoutTracker

    onMyTrackerChanged: {
        if (myTracker == 0 && goodbey == 0) {

        }
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: logoutScreen; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: logoutScreen; anchors.topMargin: logoutScreen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: logoutScreen; property: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    Timer {
        id: logoutTimer
        interval: 1000
        repeat: true
        running: (autoLogout == 1 || sessionClosed == 1) && logoutTracker == 1 && manualLogout == 0 && goodbey == 0

        onTriggered: {
            logoutTimeout = logoutTimeout + 1
            if (logoutTimeout == 15) {
                goodbey = 1
                logoutTimeout = 0
                logoutTracker = 0
            }
        }
    }

    Timer {
        id: pinTimer
        interval: 1000
        repeat: true
        running: pinLogout == 1 && logoutTracker == 1 && manualLogout == 0 && goodbey == 0

        onTriggered: {
            logoutTimeout = logoutTimeout + 1
            if (logoutTimeout == 5) {
                goodbey = 1
                logoutTimeout = 0
                logoutTracker = 0
            }
        }
    }

    Timer {
        id: networkLogoutTimer
        interval: 10000
        repeat : false
        running: (networkLogout == 1) && logoutTracker == 1 && manualLogout == 0 && goodbey == 0

        onTriggered: {
            goodbey = 1
            logoutTracker = 0
        }
    }

    Rectangle {
        width: appWidth
        height: appHeight
        color: bgcolor
        opacity: 0.9
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
    }

    Rectangle {
        id: logoutModal
        width: appWidth/3
        height: appHeight/3
        color: darktheme == true? "#0B0B09" : "#FFFFFF"
        border.color: themecolor
        border.width: 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Text {
            id: logoutModalLabel
            text: "LOG OUT"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            font.pixelSize: logoutModal.height/12
            font.family: "Brandon Grotesque"
            color: themecolor
            font.letterSpacing: 2
        }

        Item {
            width: parent.width
            height: (pinLogout == 1 && autoLogout == 0 && sessionClosed == 0 && networkLogout == 0 && manualLogout == 0)? (logoutLabel.height + logoutLabel2.height + 25) : (logoutLabel.height + 84)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Label {
                id: logoutLabel
                width: parent.width - 56
                text: manualLogout == 1? ("Are you sure you want to log out?") :
                                         (networkLogout == 1? ("Your session ID could not be verified . You will be logged out automatically.") :
                                                              (sessionClosed == 1? ("Your session was closed by the server. You will be logged out automatically after " + (15 - logoutTimeout) + " second(s). Do you wish to reconnect?") :
                                                                                   (autoLogout == 1? ("You have not interacted for 5 minutes. You will be logged out automatically after " + (15 - logoutTimeout) + " second(s)") :
                                                                                                     (pinLogout == 1? ("Your gave 3 wrong pin numbers.") : ""))))
                maximumLineCount: 3
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: themecolor
                font.pixelSize: logoutModal.height/12 * 0.9
                font.family: xciteMobile.name
            }

            Label {
                id: logoutLabel2
                width: parent.width - 56
                text:"You will be logged out automatically after " + (5 - logoutTimeout) + " second(s)."
                maximumLineCount: 3
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: themecolor
                font.pixelSize: logoutModal.height/12 * 0.9
                font.family: xciteMobile.name
                visible: pinLogout == 1 && autoLogout == 0 && sessionClosed == 0 && networkLogout == 0 && manualLogout == 0
            }

            Item {
                id: buttons
                width: parent.width/2
                height: logoutModal.height/6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: logoutLabel.bottom
                anchors.topMargin: 30

                Item {
                    id: cancelAutoLogout
                    width: parent.width/2 * 0.9
                    height: parent.height
                    visible: autoLogout == 1 && manualLogout == 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top

                    Rectangle {
                        id: cancelLogoutButton
                        width: logoutModal.width/4
                        height: parent.height
                        color: maincolor
                        opacity: 0.25
                        anchors.top: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter

                        MouseArea {
                            anchors.fill: cancelLogoutButton

                            onPressed: {
                                parent.opacity = 1
                                click01.play()
                                detectInteraction()
                            }

                            onCanceled: {
                                parent.opacity = 0.25
                            }

                            onReleased: {
                                parent.opacity = 0.25
                                logoutTimeout = 0
                                autoLogout = 0
                                logoutTracker = 0
                            }
                        }
                    }

                    Text {
                        text: "CANCEL"
                        font.family: "Brandon Grotesque"
                        font.pointSize: logoutModal.height/12 * 0.7
                        font.bold: true
                        color: (darktheme == true? "#F2F2F2" : maincolor)
                        anchors.horizontalCenter: cancelLogoutButton.horizontalCenter
                        anchors.verticalCenter: cancelLogoutButton.verticalCenter
                    }

                    Rectangle {
                        width: cancelLogoutButton.width
                        height: 34
                        anchors.bottom: cancelLogoutButton.bottom
                        anchors.left: cancelLogoutButton.left
                        color: "transparent"
                        opacity: 0.5
                        border.color: maincolor
                        border.width: 1
                    }
                }

                Item {
                    id: manualLogoutButtons
                    width: parent.width
                    height: parent.height
                    visible: manualLogout == 1? true : ((sessionClosed == 1 && networkLogout == 0)? true : false)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top

                    Rectangle {
                        id: yes
                        width: parent.width/2 * 0.9
                        height: parent.height
                        radius: height/2
                        color: "#4BBE2E"
                        opacity: 0.5
                        anchors.top: parent.bottom
                        anchors.left: parent.left

                        MouseArea {
                            anchors.fill: parent

                            onPressed: {
                                parent.opacity = 1
                                click01.play()
                            }

                            onCanceled: {
                                parent.opacity = 0.5
                            }

                            onReleased: {
                                parent.opacity = 0.5
                                if (manualLogout == 1) {
                                    goodbey = 1
                                    manualLogout = 0
                                    logoutTracker = 0
                                }
                                else if (sessionClosed == 1) {
                                    // function to start new session on server
                                    sessionClosed = 0
                                    sessionStart = 1
                                    logoutTracker = 0
                                }
                            }
                        }
                    }

                    Text {
                        id: yesText
                        text: "YES"
                        font.family: "Brandon Grotesque"
                        font.pointSize: logoutModal.height/12 * 0.7
                        color: "#4BBE2E"
                        opacity: 0.75
                        anchors.horizontalCenter: yes.horizontalCenter
                        anchors.verticalCenter: yes.verticalCenter
                    }

                    Rectangle {
                        width: yes.width
                        height: parent.height
                        radius: height/2
                        anchors.bottom: yes.bottom
                        anchors.left: yes.left
                        color: "transparent"
                        opacity: 0.75
                        border.color: "#4BBE2E"
                        border.width: 1
                    }

                    Rectangle {
                        id: no
                        width: parent.width/2 * 0.9
                        height: 34
                        radius: height/2
                        color: "#E55541"
                        opacity: 0.5
                        anchors.top: parent.bottom
                        anchors.right: parent.right

                        MouseArea {
                            anchors.fill: parent

                            onPressed: {
                                parent.opacity = 1
                                click01.play()
                                detectInteraction
                            }

                            onCanceled: {
                                parent.opacity = 0.5
                            }

                            onReleased: {
                                parent.opacity = 0.5
                                logoutTracker = 0
                                if (manualLogout == 1) {
                                    manualLogout = 0
                                    logoutTracker = 0
                                    sessionStart = 1
                                }
                                else if (sessionClosed == 1) {
                                    goodbey = 1
                                    sessionClosed = 0
                                    logoutTracker = 0
                                }
                            }
                        }
                    }

                    Text {
                        text: "NO"
                        font.family: "Brandon Grotesque"
                        font.pointSize: logoutModal.height/12 * 0.7
                        color: "#E55541"
                        opacity: 0.75
                        anchors.horizontalCenter: no.horizontalCenter
                        anchors.verticalCenter: no.verticalCenter
                    }

                    Rectangle {
                        width: no.width
                        height: 34
                        radius: height/2
                        anchors.bottom: no.bottom
                        anchors.left: no.left
                        color: "transparent"
                        opacity: 0.75
                        border.color: "#E55541"
                        border.width: 1
                    }
                }
            }
        }
    }
}
