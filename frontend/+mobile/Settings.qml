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

Item {
    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 100

        Item {
            id: heading
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
                text: qsTr("SETTINGS")
            }
        }
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
             onClicked: mainRoot.pop("Settings.qml")
        }
    }
}
