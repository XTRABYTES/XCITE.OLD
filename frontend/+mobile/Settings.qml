/**
 * Filename: Settings.qml
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
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtMultimedia 5.8

import "../Controls" as Controls

/**
  * Main page
  */

Rectangle {
    id: backgroundSignUp
    z: 1
    width: Screen.width
    height: Screen.height
    color: "#1B2934"

    Image {
        id: largeLogo
        source: 'qrc:/icons/XBY_logo_large.svg'
        width: parent.width * 2
        height: (largeLogo.width / 75) * 65
        anchors.top: parent.top
        anchors.topMargin: 63
        anchors.right: parent.right
        opacity: 0.5
    }
    Label {
        id: welcomeText
        text: "WELCOME TO XCITE"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 25
        color: "#F2F2F2"
        font.pixelSize: 24
        font.family: xciteMobile.name
        font.bold: true
    }
    Image {
        id: back
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 25
        source: '../icons/left-arrow.svg'
        width: 15
        height: 15

        MouseArea {
            anchors.fill: back
            onClicked: {
                mainRoot.pop()
                mainRoot.push("../DashboardForm.qml")
                appsTracker = 0
                selectedPage = "home"
            }
        }
    }
}
