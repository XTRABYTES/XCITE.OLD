/**
 * Filename: Introduction.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */
import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import "../Controls" as Controls

Column {
    id: onboardingIntroduction
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    anchors.top: parent.top
    anchors.topMargin: 15
    height: 500
    spacing: 20

    Image {
        smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        height: 250
        source: "../backgrounds/launchscreen-logo.png"
    }

    Label {
        id: versionLabel
        font.pixelSize: 24
        anchors.horizontalCenter: parent.horizontalCenter
        color: "white"
        text: qsTr("XCITE - Version " + AppVersion)
    }

    Label {
        font.pixelSize: 20
        color: "white"
        width: 540
        wrapMode: Text.WordWrap
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        lineHeight: 1.25
        text: qsTr("This pre-release version of XCITE showcases development builds of our XCITE, X-CHAT and X-CHANGE modules.")
    }

    Controls.ButtonModal {
        Layout.fillWidth: false
        width: 220
        buttonHeight: 38
        labelText: "LET'S DO THIS"
        anchors.horizontalCenter: parent.horizontalCenter
        isPrimary: true
        visible: settings.onboardingCompleted === false
        onButtonClicked: {
            settings.onboardingCompleted = true
            mainRoot.push("../DashboardForm.qml")
        }
    }

    Timer {
        interval: 1000
        running: Component.Ready && settings.onboardingCompleted === true
        repeat: false
        onTriggered: {
            mainRoot.pushEnter = fadeInTransition
            mainRoot.pushExit = fadeOutTransition
            mainRoot.push("../DashboardForm.qml")
        }
    }

    Transition {
        id: fadeInTransition
        PropertyAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: 200
        }
    }

    Transition {
        id: fadeOutTransition
        PropertyAnimation {
            property: "opacity"
            from: 1
            to: 0
            duration: 200
        }
    }
}
