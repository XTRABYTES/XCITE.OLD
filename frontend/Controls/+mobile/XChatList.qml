/**
* Filename: XChatList.qml
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
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.11
import QtQuick.Window 2.2

import "qrc:/Controls" as Controls

Rectangle {
    width: parent.width
    height: parent.height
    anchors.top: parent.top
    color: "transparent"
    clip :true

    property bool xChatFocus: true
    property alias xChatList: msgList
    property string tagging: ""

    Component {
        id: msgLine

        Rectangle {
            id: msgRow
            width: parent.width
            height: author == "xChatRobot"? ((robotMsgBox.height + 4) > xChatRobotIcon.height?  (robotMsgBox.height + 4): xChatRobotIcon.height) :(message != ""? senderID.height + messageText.height + 1: 0)
            color: "transparent"
            visible: message != ""
            clip: true

            DropShadow {
                anchors.fill: msgBox
                source: msgBox
                samples: 9
                radius: 4
                color: darktheme == true? "#000000" : "#727272"
                horizontalOffset:0
                verticalOffset: 0
                spread: 0
                visible: author != "xChatRobot"
            }

            Rectangle {
                id: msgBox
                width: (0.85 * (Screen.width - 56))
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                anchors.left: author==(username)? undefined : parent.left
                anchors.leftMargin: author==(username)? 0 : 2
                anchors.right: author==(username)? parent.right : undefined
                anchors.rightMargin: author==(username)? 2 : 0
                color: darktheme == true? "#2A2C31" : "#F2F2F2"
                visible: author != "xChatRobot"
            }

            Label {
                id: senderID
                text: author
                font.family: xciteMobile.name
                font.pixelSize: 12
                font.bold: true
                horizontalAlignment: Text.AlignLeft
                color: darktheme == false? "#14161B" : "#F2F2F2"
                anchors.left:msgBox.left
                anchors.leftMargin: 10
                anchors.top: msgBox.top
                anchors.topMargin: 5
                visible: author != "xChatRobot"

                Rectangle {
                    height: senderID.height
                    width: senderID.width
                    anchors.verticalCenter: senderID.verticalCenter
                    anchors.horizontalCenter: senderID.horizontalCenter
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent
                        //focus: false

                        onClicked: {
                            console.log("author pushed")
                            tagging = "@" + senderID.text
                        }
                    }
                }
            }

            Label {
                id: messageDate
                text: date
                anchors.right: msgBox.right
                anchors.rightMargin: 10
                anchors.bottom: senderID.bottom
                anchors.bottomMargin: 1
                font.family: xciteMobile.name
                font.pixelSize: 10
                horizontalAlignment: Text.AlignRight
                color: darktheme == false? "#14161B" : "#F2F2F2"
                visible: author != "xChatRobot"
            }

            Rectangle {
                id: online
                height: 5
                width: 5
                radius: 5
                anchors.left: senderID.right
                anchors.leftMargin: 5
                anchors.verticalCenter: senderID.verticalCenter
                //color: getUserStatus(author) === "online"? "#4BBE2E" : (getUserStatus(author) === "idle"? "#F7931A" : "#E55541")
                color: darktheme == false? "#14161B" : "#F2F2F2"
                visible: author != "xChatRobot"
            }

            Image {
                source: darktheme == true? (device == "mobile"? 'qrc:/icons/mobile/phone-icon_02_white.svg' : 'qrc:/icons/mobile/computer-icon_01_white.svg') : (device == "mobile"? 'qrc:/icons/mobile/phone-icon_02_black.svg' : 'qrc:/icons/mobile/computer-icon_01_black.svg')
                width: 14
                height: 14
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: senderID.verticalCenter
                anchors.left: online.right
                anchors.leftMargin: 5
                visible: author != "xChatRobot"
            }

            Rectangle {
                id: msgBoxDivider
                height: 1
                anchors.left: msgBox.left
                anchors.leftMargin: 10
                anchors.right: msgBox.right
                anchors.rightMargin: 10
                anchors.top: senderID.bottom
                color: "#0ED8D2"
                visible: author != "xChatRobot"
            }

            Label {
                id: messageText
                text: message
                anchors.left: msgBox.left
                anchors.leftMargin: 10
                anchors.right: msgBox.right
                anchors.rightMargin: 10
                anchors.top: msgBoxDivider.bottom
                anchors.topMargin: 5
                horizontalAlignment: Text.AlignLeft
                font.family: xciteMobile.name
                wrapMode: Text.Wrap
                font.pixelSize: 16
                color: darktheme == false? "#14161B" : "#F2F2F2"
                visible: author != "xChatRobot"
            }

            Image {
                id: xChatRobotIcon
                source: darktheme == true? 'qrc:/icons/mobile/robot-icon_01_white.svg' : 'qrc:/icons/mobile/robot-icon_01_black.svg'
                width: 40
                height: 40
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                visible: author == "xChatRobot"
            }

            DropShadow {
                anchors.fill: robotMsgBox
                source: robotMsgBox
                samples: 9
                radius: 4
                color: darktheme == true? "#000000" : "#727272"
                horizontalOffset:0
                verticalOffset: 0
                spread: 0
                visible: author == "xChatRobot"
            }

            Rectangle {
                id: robotMsgBox
                height: robotText.height +10
                anchors.left: xChatRobotIcon.right
                anchors.leftMargin: 10
                anchors.right: parent.right
                color: darktheme == true? "#2A2C31" : "#F2F2F2"
                visible: author == "xChatRobot"
            }

            Text {
                id: robotText
                text: message
                anchors.left: robotMsgBox.left
                anchors.leftMargin: 10
                anchors.right: robotMsgBox.right
                anchors.rightMargin: 10
                anchors.top: robotMsgBox.top
                anchors.topMargin: 5
                horizontalAlignment: Text.AlignLeft
                font.family: xciteMobile.name
                wrapMode: Text.Wrap
                font.pixelSize: 16
                color: "#E55541"
                visible: author == "xChatRobot"
            }
        }
    }

    SortFilterProxyModel {
        id: arrangedMsg
        sourceModel: xChatTread
        sorters: [
            RoleSorter { roleName: "ID" ; sortOrder: Qt.DecendingOrder }
        ]
    }

    ListView {
        anchors.fill: parent
        id: msgList
        model: arrangedMsg
        delegate: msgLine
        spacing: 7
        onDraggingChanged: {
            xChatFocus = false
            detectInteraction()
        }        

    }

    Component.onCompleted: {
        msgList.positionViewAtEnd()
    }
}
