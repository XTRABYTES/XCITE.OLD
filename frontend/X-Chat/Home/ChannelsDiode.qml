/**
 * Filename: ChannelsDiode.qml
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

Controls.Diode {
    id: channelsDiode
    color: cDiodeBackground
    radius: 5
    Layout.preferredHeight: 843
    Layout.preferredWidth: 257
    Layout.fillHeight: true
    Controls.DiodeHeader {
        id: channelHeader
        text: "CHANNELS"
        iconSource: "../../icons/menu-settings.svg"
        iconOnly: true
        iconSize: 20
    }

    ColumnLayout {
        anchors.top: channelHeader.bottom
        anchors.left: parent.left
        width: 257

        ListView {
            id: channelList
            interactive: false
            model: groupModel

            anchors.left: parent.left

            clip: true

            height: 500
            width: parent.width
            delegate: ChannelGroup {
                anchors.left: parent.left
                groupText: model.groupName
                iconSource: "../../icons/circle-cross.svg"
                items: model.channels
                iconSize: 19
                groupHeight: 47
                groupWidth: parent.width
            }
        }

        //Representation of all the channel groups and channels
        ListModel {
            id: groupModel

            ListElement {
                groupName: "MAIN"
                channels: [
                    ListElement {
                        name: "announcements"
                        selected: false
                    },
                    ListElement {
                        name: "price-spam"
                        selected: false
                    },
                    ListElement {
                        name: "off-topic"
                        selected: false
                    },
                    ListElement {
                        name: "general"
                        selected: false
                    },
                    ListElement {
                        name: "community"
                        selected: false
                    }
                ]
            }
            ListElement {
                groupName: "TOPICS"
                channels: [
                    ListElement {
                        name: "announcements"
                        selected: false
                    },
                    ListElement {
                        name: "price-spam"
                        selected: false
                    },
                    ListElement {
                        name: "off-topic"
                        selected: false
                    },
                    ListElement {
                        name: "general"
                        selected: false
                    },
                    ListElement {
                        name: "community"
                        selected: false
                    }
                ]
            }
        }
    }
}
