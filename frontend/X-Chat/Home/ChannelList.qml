/**
 * Filename: ChannelList.qml
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

Column {
    property variant items
    width: parent.width
    Repeater {

        width: parent.width
        id: groupChannels
        model: items

        Rectangle {
            id: channelBackground
            color: "transparent"
            width: parent.width
            height: itemHeight

            Text {

                text: name
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 18
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    selected = true
                    //group.channelSelected(index)
                    channelBackground.color = "#666B78"
                }
            }
        }
    }
}
