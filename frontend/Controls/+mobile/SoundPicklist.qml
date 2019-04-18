/**
* Filename: SoundPicklist.qml
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

Rectangle {
    id: completePicklist
    width: 120
    height: parent.height - 25
    color: "#2A2C31"

    Component {
        id: picklistEntry

        Rectangle {
            id: picklistRow
            width: 120
            height: 35
            color: "transparent"

            Rectangle {
                id: clickIndicator
                anchors.fill: parent
                color: "white"
                opacity: 0.25
                visible: false
            }

            AnimatedImage  {
                id: waitingDots
                source: 'qrc:/gifs/loading-gif_01.gif'
                width: 90
                height: 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                playing: saveSound == true
                visible: saveSound == true? (userSettings.sound === soundNR? true : false) : false
            }

            Label {
                id: soundName
                text: name
                color: userSettings.sound === soundNR? "#0ED8D2" : "#F2F2F2"
                font.pixelSize: 16
                font.family: xciteMobile.name
                anchors.verticalCenter: picklistRow.verticalCenter
                anchors.left: picklistRow.left
                anchors.leftMargin: 7
                visible: saveSound == true? (userSettings.sound === soundNR? false : true) : true
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    clickIndicator.visible = true
                    detectInteraction()
                }

                onCanceled: {
                    clickIndicator.visible = false
                }

                onReleased: {
                    clickIndicator.visible = false
                }

                onClicked: {
                    if (saveSound == false) {
                        clickIndicator.visible = false
                        oldSound = userSettings.sound
                        userSettings.sound = soundNR;
                        notification.play()
                        saveSound = true
                        saveAppSettings()
                    }
                }

                Connections {
                    target: UserSettings

                    onSaveSucceeded: {
                        if (soundTracker === 1) {
                            saveSound =false
                        }
                    }

                    onSaveFailed: {
                        if (soundTracker === 1) {
                            userSettings.sound = oldSound
                            soundChangeFailed = 1
                            saveSound = false
                        }
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                color: "#5F5F5F"
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                visible: index < (soundList.count - 1) ? true : false
            }
        }
    }

    ListView {
        anchors.fill: parent
        id: pickList
        model: soundList
        delegate: picklistEntry
        contentHeight: soundList.count * 35
        onDraggingChanged: detectInteraction()

        ScrollBar.vertical: ScrollBar {
            parent: pickList.parent
            anchors.top: pickList.top
            anchors.right: pickList.right
            anchors.bottom: pickList.bottom
            width: 5
            opacity: 1
            policy: ScrollBar.AlwaysOn
            visible: (soundList.count * 35) > 140
        }
    }
}
