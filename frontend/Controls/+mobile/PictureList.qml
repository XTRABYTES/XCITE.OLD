/**
 * Filename: PictureList.qml
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
import QtQuick.Window 2.2
import SortFilterProxyModel 0.2
import QtGraphicalEffects 1.0

Rectangle {
    id: allPictureCards
    width: Screen.width
    height: 250
    color: "transparent"
    anchors.bottom: parent.bottom
    anchors.left: Screen.left

    Component {
        id:pictureCard

        Rectangle {
            id: pictureSquare
            color: "transparent"
            width: 250
            height: 250
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            border.color: "#F2F2F2"
            border.width: 2

            Image {
                id: picture
                source: fileURL
            }


        }
    }

    Image {
        id: closeButton
        source: 'qrc:/icons/CloseIcon.svg'
        width: 15
        height: 15
        anchors.right: Screen.right
        anchors.rightMargin: 15
        anchors.bottom: Screen.bottom
        anchors.topMargin: 260

        ColorOverlay {
            anchors.fill: parent
            source: parent
            color: "#F2F2F2"
        }

        MouseArea {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 30
            height: 30

            onClicked: pictureTracker = 0
        }
    }

    ListView {
        id: allPictures
        model: pictureList
        delegate: pictureCard
        orientation: ListView.Horizontal
        spacing: 0
        anchors.fill: parent
        onDraggingChanged: detectInteraction()
    }
}


