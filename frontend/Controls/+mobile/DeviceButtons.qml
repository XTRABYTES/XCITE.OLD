/**
 * Filename: DeviceButtons.qml
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


Rectangle {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.bottom
    width: controlTracker == 0? 75 : 125
    height: controlTracker == 0? 75 : 125
    radius: controlTracker == 0? 38 : 63
    color: "transparent"

    property real controlTracker: 0
    property bool movePressed: false
    property int showMinimize: 0
    property int showDrag: 0
    property int showBack: 0

    Image {
        z: 2
        id: moveButton
        source: 'qrc:/icons/move_01.png'
        height: 20
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        state: controlTracker == 0? "down" : "up"

        DropShadow {
            anchors.fill: dragInfo
            source: dragInfo
            horizontalOffset: 0
            verticalOffset: 1
            radius: 12
            samples: 25
            spread: 0
            color: darktheme == true? "#727272" : "black"
            opacity: 0.4
            transparentBorder: true
            visible: dragInfo.visible
        }

        Rectangle {
            id: dragInfo
            height: appHeight/36
            width: dragLabel.implicitWidth + height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: height/2
            color: "#34363D"
            visible: showDrag == 1 && controlTracker == 1

            Label {
                id: dragLabel
                text: "Drag window"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: xciteMobile.name
                font.pixelSize: parent.height/2
                color: "#f2f2f2"
            }
        }

        states: [
            State {
                name: "up"
                PropertyChanges { target: moveButton; anchors.verticalCenterOffset: -53}
            },
            State {
                name: "down"
                PropertyChanges { target: moveButton; anchors.verticalCenterOffset: 0}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: moveButton; property: "anchors.verticalCenterOffset"; duration: 300; easing.type: Easing.InOutCubic}
            }
        ]

        Rectangle {
            width: 30
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                enabled: controlTracker == 1
                hoverEnabled: true

                onEntered: {
                    controlTimer.restart()
                    dragTimer.start()
                    showDrag = 1
                }

                onExited: {
                    showDrag = 0
                }

                onPressed: {
                    movePressed = true
                    previousX = mouseX
                    previousY = mouseY
                }
                onReleased: {
                    movePressed = false
                }
                onMouseXChanged: {
                    if (movePressed) {
                    controlTimer.restart()
                    var dx = mouseX - previousX
                    moveWindowX(dx)}
                }
                onMouseYChanged: {
                    if (movePressed) {
                    controlTimer.restart()
                    var dy = mouseY - previousY
                    moveWindowY(dy)
                    }
                }
            }
        }
    }

    Image {
        z: 2
        id: minimizeButton
        source: 'qrc:/icons/minimize-tab_01.png'
        height: 20
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        state: controlTracker == 0? "down" : "up"

        DropShadow {
            anchors.fill: minimizeInfo
            source: minimizeInfo
            horizontalOffset: 0
            verticalOffset: 1
            radius: 12
            samples: 25
            spread: 0
            color: darktheme == true? "#727272" : "black"
            opacity: 0.4
            transparentBorder: true
            visible: minimizeInfo.visible
        }

        Rectangle {
            id: minimizeInfo
            height: appHeight/36
            width: minimizeLabel.implicitWidth + height
            anchors.left: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: height/2
            color: "#34363D"
            visible: showMinimize == 1 && controlTracker == 1

            Label {
                id: minimizeLabel
                text: "Minimize"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: xciteMobile.name
                font.pixelSize: parent.height/2
                color: "#f2f2f2"
            }
        }

        states: [
            State {
                name: "up"
                PropertyChanges { target: minimizeButton; anchors.verticalCenterOffset: -(53*0.75)}
                PropertyChanges { target: minimizeButton; anchors.horizontalCenterOffset: 53*0.75}
            },
            State {
                name: "down"
                PropertyChanges { target: minimizeButton; anchors.verticalCenterOffset: 0}
                PropertyChanges { target: minimizeButton; anchors.horizontalCenterOffset: 0}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: minimizeButton; property: "anchors.verticalCenterOffset"; duration: 300; easing.type: Easing.InOutCubic}
                NumberAnimation { target: minimizeButton; property: "anchors.horizontalCenterOffset"; duration: 300; easing.type: Easing.InOutCubic}
            }
        ]

        Rectangle {
            width: 30
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                enabled: controlTracker == 1
                hoverEnabled: true

                onEntered: {
                    controlTimer.restart()
                    minimizeTimer.start()
                    showMinimize = 1
                }

                onExited: {
                    showMinimize = 0
                }

                onClicked:{
                    controlTracker = 0
                    minimizeApp()
                }
            }
        }
    }

    Image {
        z: 2
        id: backButton
        source: 'qrc:/icons/go-back-arrow_01.png'
        height: 20
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        state: controlTracker == 0? "down" : "up"

        DropShadow {
            anchors.fill: backInfo
            source: backInfo
            horizontalOffset: 0
            verticalOffset: 1
            radius: 12
            samples: 25
            spread: 0
            color: darktheme == true? "#727272" : "black"
            opacity: 0.4
            transparentBorder: true
            visible: backInfo.visible
        }

        Rectangle {
            id: backInfo
            height: appHeight/36
            width: backLabel.implicitWidth + height
            anchors.right: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: height/2
            color: "#34363D"
            visible: showBack == 1 && controlTracker == 1

            Label {
                id: backLabel
                text: "Back"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: xciteMobile.name
                font.pixelSize: parent.height/2
                color: "#f2f2f2"
            }
        }

        states: [
            State {
                name: "up"
                PropertyChanges { target: backButton; anchors.verticalCenterOffset: -(53*0.75)}
                PropertyChanges { target: backButton; anchors.horizontalCenterOffset: -(53*0.75)}
            },
            State {
                name: "down"
                PropertyChanges { target: backButton; anchors.verticalCenterOffset: 0}
                PropertyChanges { target: backButton; anchors.horizontalCenterOffset: 0}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: backButton; property: "anchors.verticalCenterOffset"; duration: 300; easing.type: Easing.InOutCubic}
                NumberAnimation { target: backButton; property: "anchors.horizontalCenterOffset"; duration: 300; easing.type: Easing.InOutCubic}
            }
        ]

        Rectangle {
            width: 30
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                enabled: controlTracker == 1
                hoverEnabled: true

                onEntered: {
                    controlTimer.restart()
                    backTimer.start()
                    showBack = 1
                }

                onExited: {
                    showBack = 0
                }

                onClicked: {
                    backButtonPressed()
                    detectInteraction()
                }
            }
        }
    }

    Rectangle {
        z: 3
        id: deviceButtons
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 75
        height: 75
        radius: 38
        color: darktheme == true? "#0B0B09" : "#F2F2F2"

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                if (controlTracker == 0) {
                   controlTracker = 1
                }
            }

            onClicked: {
                if (controlTracker == 1) {
                    controlTracker = 0
                }
                else {
                    controlTracker = 1
                }
            }
        }
    }

    Rectangle {
        id: centerDot
        z: 3
        height: 6
        width: 6
        radius: 3
        color: maincolor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: 15
    }

    Rectangle {
        z: 3
        height: 6
        width: 6
        radius: 3
        color: maincolor
        anchors.verticalCenter: centerDot.verticalCenter
        anchors.right: centerDot.left
        anchors.rightMargin: 6
    }

    Rectangle {
        z: 3
        height: 6
        width: 6
        radius: 3
        color: maincolor
        anchors.verticalCenter: centerDot.verticalCenter
        anchors.left: centerDot.right
        anchors.leftMargin: 6
    }

    Timer {
        id: backTimer
        interval: 1000
        repeat: false
        running: showBack == 1

        onTriggered: {
            showBack = 0
        }
    }

    Timer {
        id: dragTimer
        interval: 1000
        repeat: false
        running: showDrag == 1

        onTriggered: {
            showDrag = 0
        }
    }

    Timer {
        id: minimizeTimer
        interval: 1000
        repeat: false
        running: showMinimize == 1

        onTriggered: {
            showMinimize = 0
        }
    }

    Timer {
        id: controlTimer
        interval: 6000
        repeat: false
        running: controlTracker == 1

        onTriggered: {
            controlTracker = 0
        }
    }
}
