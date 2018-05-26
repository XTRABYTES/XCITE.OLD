/**
 * Filename: StatusGroup.qml
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

Item {
    id: statusGroup
    property string groupText: ""
    property alias items: groupChannels.model
    property int groupWidth: 300
    property int groupHeight: 40
    property int itemHeight: 29
    height: groupHeight + groupChannels.model.count * itemHeight
    width: parent.width

    Rectangle {

        id: groupRect
        height: 15
        width: parent.width
        anchors.top: parent.top
        anchors.topMargin: 20
        color: "transparent"

        Text {
            text: groupText
            id: channelGroupText
            anchors.left: parent.left
            anchors.leftMargin: 13.7
            anchors.verticalCenter: parent.verticalCenter
            color: "#A9AAAD"
            font.family: "Roboto Regular"
            font.pixelSize: 11
        }
    }

    //The ListView contains a list of ListElement which we then use a repeater on to display because
    //we do not want it to inherit the scrollable properties of flicable in the list view.
    ColumnLayout {
        anchors.top: groupRect.bottom
        anchors.topMargin: 15
        width: parent.width

        Column {
            width: parent.width
            Repeater {

                width: parent.width
                id: groupChannels
                model: 10

                Rectangle {
                    id: statusBackground
                    color: "transparent"
                    width: parent.width
                    height: itemHeight

                    RowLayout {
                        height: itemHeight

                        Rectangle {
                            id: statusAccountImage
                            height: 24.89
                            width: 24.89
                            color: "#4F535C"
                            radius: 100
                            anchors.left: parent.left
                            anchors.leftMargin: 13.52

                            Image {
                                anchors.fill: parent
                                // source: avatar
                            }

                            Rectangle {
                                id: statusIcon
                                height: 7
                                width: 7
                                color: "red"
                                state: status
                                radius: 100
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.leftMargin: 18
                                anchors.topMargin: 17

                                states: [
                                    State {
                                        name: "available"
                                        PropertyChanges {
                                            target: statusIcon
                                            color: "#0ED8D2"
                                        }
                                    },
                                    State {
                                        name: "busy"
                                        PropertyChanges {
                                            target: statusIcon
                                            color: "#F2C94C"
                                        }
                                    },
                                    State {
                                        name: "unavailable"
                                        PropertyChanges {
                                            target: statusIcon
                                            color: "#EB5757"
                                        }
                                    }
                                ]
                            }
                        }

                        Text {

                            text: name
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: statusAccountImage.right
                            anchors.leftMargin: 5
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            selected = true
                        }
                    }
                }
            }
        }
    }
}
