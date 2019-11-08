/**
* Filename: XChatUsers.qml
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
    id: xchatUsersModal
    state: xchatUserTracker == 1? "up" : "down"
    height: Screen.height
    color: "transparent"
    anchors.right: parent.right
    anchors.top: parent.top
    onStateChanged: detectInteraction()

    property string usertag: ""

    states: [
        State {
            name: "up"
            PropertyChanges { target: xchatUsersModal; anchors.rightMargin: 0}
            PropertyChanges { target: xchatUsersModal; width: Screen.width}
        },
        State {
            name: "down"
            PropertyChanges { target: xchatUsersModal; anchors.rightMargin: -120}
            PropertyChanges { target: xchatUsersModal; width: 120}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: xchatUsersModal; property: "anchors.rightMargin"; duration: 300; easing.type: Easing.InOutCubic}
            NumberAnimation { target: xchatUsersModal; property: "width"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    Rectangle {
        height: parent.height
        anchors.left: parent.left
        anchors.right: userArea.left
        color: "black"
        opacity: 0.5
        visible: xchatUserTracker ==1

        MouseArea {
            anchors.fill: parent

            onClicked: {
                xchatUserTracker = 0
            }
        }
    }

    Rectangle {
        id: userArea
        height: parent.height
        width: 120
        anchors.top: parent.top
        anchors.right: parent.right
        color: darktheme == false ? "#34363D" : "#2A2C31"

        Text {
            id: xChatUsersLabel
            text: "Users"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            color:"#F2F2F2"
        }

        Rectangle {
            id: userNames
            width: parent.width
            anchors.top: xChatUsersLabel.bottom
            anchors.topMargin: 25
            anchors.bottom: parent.bottom
            color: "transparent"
        }

        Controls.XChatUsersList {
            id: myUsersList
            width: userNames.width
            anchors.top: userNames.top
            anchors.bottom: parent.bottom

            onTaggingChanged: {
                if (myUsersList.tagging !== "") {
                    usertag = ""
                    usertag = myUsersList.tagging
                    myUsersList.tagging = ""
                }
            }
        }
    }
}
