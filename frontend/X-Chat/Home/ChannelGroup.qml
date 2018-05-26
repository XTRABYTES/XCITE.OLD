/**
 * Filename: ChannelGroup.qml
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
import QtQuick.Layouts 1.3
import "../../Controls" as Controls


//Creates and manages a group of channels
Item {
    id: group

    property string groupText: ""
    property string iconSource: "../../icons/circle-cross.svg"
    property int iconSize: 20
    property alias items: groupChannels.model
    property int groupWidth: 200
    property int groupHeight: 47
    property int itemHeight: 29

    height: groupHeight + groupChannels.model.count * itemHeight
    width: groupWidth

    signal channelSelected(int index)

    Rectangle {

        id: groupRect
        color: "#30333B"
        height: groupHeight
        width: groupWidth

        Text {
            text: groupText
            id: channelGroupText
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.verticalCenter: parent.verticalCenter
            color: "#BDBDBD"
            font.family: "Roboto Regular"
            font.pixelSize: 13
        }

        Controls.ButtonIcon {
            id: iconButton
            Layout.preferredWidth: 35

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 12
            imageSource: iconSource
            size: iconSize
            MouseArea {
                anchors.fill: parent
            }
        }
    }

    //The ListView contains a list of ListElement which we then use a repeater on to display because
    //we do not want it to inherit the scrollable properties of flicable in the list view.
    ColumnLayout {
        anchors.top: groupRect.bottom
        height: groupChannels.model.count * 29
        width: parent.width

        Column {
            width: parent.width
            Repeater {

                width: parent.width
                id: groupChannels
                model: 10

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
                            group.channelSelected(index)
                            channelBackground.color = "#666B78"
                        }
                    }
                }
            }
        }
    }
}
