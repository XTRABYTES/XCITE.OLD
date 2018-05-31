/**
 * Filename: StatusBox.qml
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
    Layout.preferredWidth: 259
    Layout.fillHeight: true

    Rectangle {
        height: parent.height
        width: parent.width
        //Layout.preferredWidth:
        id: status

        color: "transparent"
        ListView {
            id: channelList
            //interactive: false
            model: statusModel

            anchors.left: parent.left

            clip: true

            height: parent.height
            width: 200
            delegate: StatusGroup {
                anchors.left: parent.left
                groupText: model.groupName + " - " + model.channels.count
                items: model.channels
                groupHeight: 47
                groupWidth: parent.width
            }
        }
    }

    //Representation of all the channel groups and channels
    ListModel {
        id: statusModel

        ListElement {
            groupName: "ADMINISTRATORS"
            channels: [
                ListElement {
                    name: "Bojack"
                    status: "busy"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },

                ListElement {
                    name: "Stuge"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                }
            ]
        }
        ListElement {
            groupName: "MODERATORS"
            channels: [
                ListElement {
                    name: "Bojack"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "unavailable"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },

                ListElement {
                    name: "Stuge"
                    status: "busy"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                }
            ]
        }

        ListElement {
            groupName: "ONLINE"
            channels: [
                ListElement {
                    name: "Bojack"
                    status: "busy"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "unavailable"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Bojack"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "busy"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "busy"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Bojack"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Bojack"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Bojack"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Bojack"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Bojack"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Bojack"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Bojack"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                },
                ListElement {
                    name: "Stuge"
                    status: "available"
                    selected: false
                    avatar: "../../icons/avatar.svg"
                }
            ]
        }
    }
}
