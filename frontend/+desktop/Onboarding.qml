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

import "qrc:/Controls/+mobile" as Mobile
import "qrc:/+desktop" as Desktop

Item {
    width: appWidth
    height: appHeight
    anchors.horizontalCenter: xcite.horizontalCenter
    anchors.verticalCenter: xcite.verticalCenter
    clip: true

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
        height: appHeight / 75 * 65
        fillMode: Image.PreserveAspectFit
        anchors.top: backgroundSplash.top
        anchors.topMargin: appHeight/18
        anchors.horizontalCenter: backgroundSplash.left
        opacity: 0.5
    }

    Rectangle {
        id: welcome
        width: welcomeText.implicitWidth
        height: welcomeText.height + version.height + version.anchors.topMargin + startButton.height + startButton.anchors.topMargin
        anchors.horizontalCenter: backgroundSplash.horizontalCenter
        anchors.verticalCenter: backgroundSplash.verticalCenter
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
            color: "#f2f2f2"
            font.pixelSize: appHeight/12
        }

        Label {
            id: version
            text: "v" + versionNR
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: welcomeText.bottom
            anchors.topMargin: font.pixelSize/5
            color: maincolor
            font.pixelSize: appHeight/36
            font.family: xciteMobile.name
        }

        Rectangle {
            id: startButton
            width: appWidth/6
            height: appHeight/27
            radius: height/2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: version.bottom
            anchors.topMargin: height
            color: "transparent"
            border.color: "#f2f2f2"
            border.width: 1

            Rectangle {
                id: selectStart
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                id: startButtonText
                text: "LET'S GO"
                font.family: xciteMobile.name
                font.pixelSize: parent.height/2
                color: "#F2F2F2"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    selectStart.visible = true
                }

                onExited: {
                    selectStart.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
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
    }

    Label {
        id: closeButtonLabel
        text: loginTracker == 0 && importTracker == 0 && restoreTracker == 0? "CLOSE" : (loginTracker == 0? "BACK" : "CLOSE")
        anchors.bottom: started == 0? combinationMark.top : backgroundSplash.bottom
        anchors.bottomMargin: started == 0? appWidth/48 : appWidth/24
        anchors.horizontalCenter: backgroundSplash.horizontalCenter
        font.pixelSize: appHeight/54
        font.family: xciteMobile.name
        color: "#f2f2f2"

        Rectangle{
            id: closeButton
            anchors.fill: parent
            color: "transparent"
        }

        MouseArea {
            anchors.fill: closeButton
            hoverEnabled: true

            onEntered: {
                parent.color = maincolor
            }

            onExited:  {
                parent.color = "#f2f2f2"
            }

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
        source: 'qrc:/icons/xby_logo_with_name.png'
        width: appWidth/7.5
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: backgroundSplash.horizontalCenter
        state: started == 0? "down" : "up"

        states: [
            State {
                name: "up"
                PropertyChanges { target: combinationMark; anchors.bottom: backgroundSplash.top}
                PropertyChanges { target: combinationMark; anchors.bottomMargin: -height*1.5}
            },
            State {
                name: "down"
                PropertyChanges { target: combinationMark; anchors.bottom: backgroundSplash.bottom}
                PropertyChanges { target: combinationMark; anchors.bottomMargin: height/2}
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

    Desktop.Login {
        id: myLogin
    }

    Desktop.ImportAccount {
        id: myImport
    }

    Desktop.RestoreAccount {
        id: myRestore
    }

    Mobile.DragBar {
        z: 100
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
