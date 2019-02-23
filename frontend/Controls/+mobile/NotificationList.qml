/**
* Filename: Notificationlist.qml
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

import "qrc:/Controls" as Controls

Rectangle {
    width: parent.width
    height: parent.height
    color: "transparent"

    Component {
        id: notificationLine

        Rectangle {
            id: notificationRow
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            height: 80
            color:"transparent"

            Controls.CardBody {

            }

            Image {
                id: deleteNotification
                width: 25
                fillMode: Image.PreserveAspectFit
                source: darktheme == true? "qrc:/icons/mobile/debug-icon_01_light.svg" : "qrc:/icons/mobile/debug-icon_01_dark.svg"
                anchors.top: parent.top
                anchors.topMargin: 14
                anchors.right: parent.right
                anchors.rightMargin: 28

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            ListView.currentIndex
                            notifificationList.remove(ListView.currentIndex)
                        }
                    }
                }
            }

            Label {
                id: notificationDate
                text: date
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.top: parent.top
                anchors.topMargin: 14
                font.family: xciteMobile.name
                font.pixelSize: 14
                font.capitalization: Font.SmallCaps
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
            }

            Label {
                id: notificationOrigin
                text: origin
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.right: deleteNotification.left
                anchors.rightMargin: 10
                anchors.top: notificationDate.bottom
                anchors.topMargin: 1
                font.family: xciteMobile.name
                font.pixelSize: 18
                font.bold: true
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                elide: Text.ElideRight
            }

            Label {
                id: notificationMessage
                text: message
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.top: notificationOrigin.bottom
                anchors.topMargin: 15
                anchors.right: parent.right
                anchors.rightMargin: 28
                font.family: xciteMobile.name
                font.pixelSize: 14
                font.capitalization: Font.SmallCaps
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                elide: Text.ElideRight
            }
        }
    }

    ListView {
        anchors.fill: parent
        id: picklist
        model: notificationList
        delegate: notificationLine
        onDraggingChanged: detectInteraction()
    }
}
