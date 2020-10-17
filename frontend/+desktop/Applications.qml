/**
* Filename: Applications.qml
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
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop

Rectangle {
    id: backgroundApps
    z: 1
    width: appWidth/6 * 5
    height: appHeight
    anchors.right: xcite.right
    anchors.top: xcite.top
    color: bgcolor

    Label {
        id: applicationsLabel
        text: "APPLICATIONS"
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Rectangle {
        id: appWindow
        width: parent.width - appHeight/9
        height: parent.height
        anchors.top: applicationsLabel.bottom
        anchors.topMargin: appHeight/18
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        clip: true

        Desktop.ApplicationList {
            id: myApplications
            anchors.top: parent.top
            anchors.topMargin: appWidth/24
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
