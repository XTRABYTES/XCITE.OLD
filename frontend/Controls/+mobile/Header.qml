/**
 * Filename: Header.qml
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

Item {
    property alias text: label.text
    property bool showBack: true

    anchors.left: parent.left
    anchors.right: parent.right
    height: 35

    Label {
        id: label
        font.pixelSize: 16
        anchors.fill: parent
        color: "white"
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
    }

    Image {
        visible: showBack
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        source: "/icons/mobile-back.svg"
        sourceSize.width: 19
        sourceSize.height: 13

        MouseArea {
            anchors.fill: parent
            onClicked: {
                mainRoot.pop()
            }
        }
    }
    Image {
        visible: showBack == false
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        source: "/icons/menu-settings.svg"
        sourceSize.width: 19
        sourceSize.height: 19

        MouseArea {
            anchors.fill: parent
            onClicked: {
                mainRoot.push("../Settings.qml")

                // settings link here
            }
        }
    }

    Image {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        source: "/icons/mobile-menu.svg"
        sourceSize.width: 15
        sourceSize.height: 11

        MouseArea {
            anchors.fill: parent
            onClicked: {

            }
        }
    }
}
