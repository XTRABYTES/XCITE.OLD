/**
 * Filename: RegistrationLevel.qml
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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import "../../Controls" as Controls


/**
  * Refactored, needs cleaning up on the Low, Medium High Texts, see line 136
  */
Controls.Diode {
    id: regLevel
    color: "#3A3E47"
    radius: 5
    anchors.fill: parent

    // Second layer text
    ColumnLayout {
        Text {
            id: text2
            Layout.topMargin: 10
            Layout.leftMargin: 13
            width: 143
            height: 23
            color: "#e2e2e2"
            text: qsTr("Node Registration")
            font.pixelSize: 18
        }

        Controls.FormLabel {
            Layout.topMargin: 55
            text: qsTr("Select a Node")
            Layout.leftMargin: 51
            font.pixelSize: 19
        }
    }

    // image in case of level 1 node
    Image {
        id: image0
        z: 1
        anchors {
            right: image1.left
            rightMargin: 96
            top: parent.top
            topMargin: 150
        }
        source: "../../icons/Level1.svg"

        width: parent.width > 1200 ? parent.width / 5.5 : 220
        height: parent.height / 3.3
    }

    // image in case of level 2 node
    Image {
        id: image1
        z: 1
        anchors {

            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 180
        }
        source: "../../icons/Level2.svg"
        width: parent.width > 1200 ? parent.width / 5.5 : 220
        height: (parent.height / 3 - 50)
    }

    // image in case of level 3 node
    Image {
        id: image2
        z: 1
        anchors {
            left: image1.right
            leftMargin: 96
            top: parent.top
            topMargin: 200
        }
        source: "../../icons/Level3.svg"
        width: parent.width > 1200 ? parent.width / 5.5 : 220
        height: parent.height / 3 - 80
    }

    RegistrationLevelBox {
        id: rectangle0
        title: qsTr("Level 1")
        anchors.top: image0.bottom
        anchors.topMargin: -20
        anchors.left: image0.left
        anchors.leftMargin: 0
        width: image1.width
        height: 285
        radius: 5
        color: "#2A2C31"
        earningsText: qsTr("Earnings:")
        transferText: qsTr("Transfer Rate:")
        networkText: qsTr("Network Stake:")
        earningsLevel: qsTr("High")
        transferLevel: qsTr("High")
        networkLevel: qsTr("High")
        paddingLevel: rectangle0.width - 60
        nodeLevel: 0
    }
    RegistrationLevelBox {
        id: rectangle1
        title: qsTr("Level 2")
        anchors.top: rectangle0.top
        anchors.left: image1.left
        anchors.leftMargin: 0
        width: image2.width
        height: 285
        radius: 5
        color: "#2A2C31"
        earningsText: qsTr("Earnings:")
        transferText: qsTr("Transfer Rate:")
        networkText: qsTr("Network Stake:")
        earningsLevel: qsTr("Medium")
        transferLevel: qsTr("Medium")
        networkLevel: qsTr("Medium")
        paddingLevel: rectangle1.width - 80
        nodeLevel: 1
    }

    RegistrationLevelBox {
        id: rectangle2
        title: qsTr("Level 3")
        anchors.top: rectangle0.top
        anchors.left: image2.left
        anchors.leftMargin: 0
        width: image2.width
        height: 285
        radius: 5
        color: "#2A2C31"
        earningsText: qsTr("Earnings:")
        transferText: qsTr("Transfer Rate:")
        networkText: qsTr("Network Stake:")
        earningsLevel: qsTr("Low")
        transferLevel: qsTr("Low")
        networkLevel: qsTr("Low")
        paddingLevel: rectangle2.width - 55
        nodeLevel: 2
    }
}
