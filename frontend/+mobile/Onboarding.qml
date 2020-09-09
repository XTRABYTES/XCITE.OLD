/**
 * Filename: Onboarding.qml
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
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

import "qrc:/Controls" as Controls
import "qrc:/Controls/+mobile" as Mobile

Item {
    width: appWidth
    height: appHeight
    anchors.horizontalCenter: xcite.horizontalCenter
    anchors.verticalCenter: xcite.verticalCenter
    clip: true

    property string versionNR: "1.2.4"

    Component.onCompleted: {
        selectedPage = "login"
    }

    Image {
        id: pictureBG
        source: "qrc:/backgrounds/stars.jpg"
        height: parent.height
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Rectangle {
        id: backgroundSplash
        width: parent.width
        height: parent.height
        color: "#14161B"
        state: started == 1? "inView" : "hidden"

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, 0)
            end: Qt.point(0, parent.height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#00162124" }
                GradientStop { position: 1.0; color: "#FF162124" }
            }
        }

        states: [
            State {
                name: "hidden"
                PropertyChanges { target: backgroundSplash; opacity: 0}
            },
            State {
                name: "inView"
                PropertyChanges { target: backgroundSplash; opacity: 1}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: backgroundSplash; property: "opacity"; duration: 300; easing.type: Easing.OutCubic}
            }
        ]
    }

    Image {
        id: largeLogo
        source: 'qrc:/icons/XBY_logo_large.svg'
        width: backgroundSplash.width * 2
        height: (largeLogo.width / 75) * 65
        anchors.top: backgroundSplash.top
        anchors.topMargin: 63
        anchors.right: backgroundSplash.right
        opacity: 0.5
    }

    Rectangle {
        id: welcome
        width: welcomeText.implicitWidth
        height: 180
        anchors.horizontalCenter: backgroundSplash.horizontalCenter
        anchors.verticalCenter: backgroundSplash.verticalCenter
        anchors.verticalCenterOffset: -50
        color: "transparent"

        state: started == 0? "inView" : "hidden"

        states: [
            State {
                name: "inView"
                PropertyChanges { target: welcome; opacity: 1}
            },
            State {
                name: "hidden"
                PropertyChanges { target: welcome; opacity: 0}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: welcome; property: "opacity"; duration: 300}
            }
        ]

        Label {
            id: welcomeText
            text: "XCITE"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            color: "#F2F2F2"
            font.pixelSize: 64
            font.family: xciteMobile.name
        }

        Label {
            id: version
            text: "V" + versionNR
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: welcomeText.bottom
            anchors.topMargin: -16
            color: maincolor
            font.pixelSize: 24
            font.family: xciteMobile.name
        }

        Rectangle {
            id: startButton
            width: doubbleButtonWidth / 2
            height: 34
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            color: "transparent"
            opacity: 0.5

            LinearGradient {
                anchors.fill: parent
                start: Qt.point(x, y)
                end: Qt.point(x, parent.height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: "#0ED8D2" }
                }
            }


            MouseArea {
                anchors.fill: startButton

                onReleased: {
                    checkCamera();
                }
            }

            Connections {
                target: UserSettings

                onCameraCheckPassed: {
                    checkWriteAccess();
                }

                onCameraCheckFailed: {
                    checkWriteAccess();
                }

                onWriteCheckPassed: {
                    started = 1
                    loginTracker = 1
                    clearAllSettings();
                }
            }
        }

        Text {
            id: startButtonText
            text: "LET'S GO"
            font.family: xciteMobile.name
            font.pointSize: 14
            color: "#F2F2F2"
            font.bold: true
            anchors.horizontalCenter: startButton.horizontalCenter
            anchors.verticalCenter: startButton.verticalCenter
            anchors.verticalCenterOffset: 1
        }

        Rectangle {
            width: doubbleButtonWidth / 2
            height: 33
            anchors.horizontalCenter: startButton.horizontalCenter
            anchors.bottom: startButton.bottom
            color: "transparent"
            opacity: 0.5
            border.width: 1
            border.color: "#0ED8D2"
        }
    }

    Label {
        id: closeButtonLabel
        text: loginTracker == 0 && importTracker == 0 && restoreTracker == 0? "CLOSE" : (loginTracker == 0? "BACK" : "CLOSE")
        anchors.bottom: started == 0? combinationMark.top : backgroundSplash.bottom
        anchors.bottomMargin: started == 0? 25 : myOS === "android"? 50 : (isIphoneX()? 90 : 70)
        anchors.horizontalCenter: backgroundSplash.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: "#F2F2F2"

        Rectangle{
            id: closeButton
            height: 34
            width: closeButtonLabel.width + 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"
        }

        MouseArea {
            anchors.fill: closeButton

            onClicked: {
                if (loginTracker == 1 || (loginTracker == 0 && importTracker == 0 && restoreTracker == 0)) {
                Qt.quit()
                }
                if (importTracker == 1) {
                    importTracker = 0
                    loginTracker = 1
                }
                if (restoreTracker == 1) {
                    restoreTracker = 0
                    loginTracker = 1
                }
            }
        }
    }

    Image {
        id: combinationMark
        source: 'qrc:/icons/xby_logo_TM.svg'
        height: 23.4
        width: 150
        anchors.horizontalCenter: backgroundSplash.horizontalCenter
        //anchors.bottom: backgroundSplash.bottom
        //anchors.bottomMargin: myOS === "android"? 50 : (isIphoneX()? 90 : 70)
        state: started == 0? "down" : "up"

        states: [
            State {
                name: "up"
                PropertyChanges { target: combinationMark; anchors.bottom: backgroundSplash.top}
                PropertyChanges { target: combinationMark; anchors.bottomMargin: -50}
            },
            State {
                name: "down"
                PropertyChanges { target: combinationMark; anchors.bottom: backgroundSplash.bottom}
                PropertyChanges { target: combinationMark; anchors.bottomMargin: myOS === "android"? 50 : (isIphoneX()? 90 : 70)}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: combinationMark; property: "anchors.bottom"; duration: 300; easing.type: Easing.OutCubic}
                NumberAnimation { target: combinationMark; property: "anchors.bottomMargin"; duration: 300; easing.type: Easing.OutCubic}
            }
        ]
    }

    Login {
        id: myLogin
    }

    ImportAccount {
        id: myImport
    }

    RestoreAccount {
        id: myRestore
    }

    Mobile.SwipeBack {
        z: 100
        anchors.right: parent.right
        anchors.top: parent.top
    }

    Mobile.DeviceButtons {
        z: 100
        visible: myOS !== "android" && myOS !== "ios"
    }

    Mobile.LogOut {
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Mobile.DragBar {
        z: 100
        visible: myOS !== "android" && myOS !== "ios"
    }

    Mobile.NetworkError {
        z:100
        id: myNetworkError
    }

    Mobile.Goodbey {
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
    }
}
