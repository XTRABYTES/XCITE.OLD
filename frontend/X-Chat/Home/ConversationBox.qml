/**
 * Filename: ConversationBox.qml
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
import QtGraphicalEffects 1.0

Item {

    id: conversationBox
    property int chatMessageBuffer: 30
    property alias conversationBoxWidth: conversationBox.width

    Layout.preferredWidth: 728
    height: parent.height

    ListView {

        id: conversations
        model: conversationModel
        anchors.fill: parent
        Layout.preferredWidth: 200 //parent.width
        Layout.maximumWidth: 200
        width: 100
        Layout.preferredHeight: parent.height
        clip: true

        delegate: Item {

            height: messageBlock.height
            Layout.preferredWidth: parent.width

            RowLayout {
                anchors.left: parent.left
                anchors.leftMargin: 12
                id: messageBlock
                height: chatName.height + chatTime.height
                        + chatbackground.height + chatMessageBuffer

                Rectangle {
                    id: messageBlockImageBackground
                    width: 60
                    height: 60
                    radius: 100
                    color: "#4F535C"

                    Image {
                        id: messageBlockChatImage
                        height: 50

                        //source: avatar
                        clip: true
                        fillMode: Image.PreserveAspectCrop
                        layer.enabled: true
                        layer.effect: OpacityMask {
                            maskSource: mask
                        }
                    }

                    Rectangle {
                        id: mask
                        width: parent.width
                        height: parent.height
                        radius: 250
                        visible: false
                    }
                }

                ColumnLayout {
                    anchors.left: messageBlockImageBackground.right
                    anchors.leftMargin: 10
                    Text {
                        id: chatName
                        text: userName
                        font.family: "Roboto"
                        color: "#A9AAAD"
                        font.pixelSize: 12
                    }

                    Rectangle {
                        id: chatbackground
                        color: isSelf ? '#0ED8D2' : '#4F535C'
                        width: chatText.width + 20
                        Layout.maximumWidth: conversationBoxWidth - layoutGridSpacing
                        height: chatText.height + 20
                        radius: 5
                        Text {
                            //HACK
                            id: chatTextHidden
                            visible: false
                            text: messageContent
                            color: isSelf ? '#333333' : '#FFFFFF'
                            font.family: "Roboto"
                            font.pixelSize: 11
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            wrapMode: Text.WordWrap
                        }
                        Text {
                            id: chatText
                            text: messageContent
                            color: isSelf ? '#333333' : '#FFFFFF'
                            font.family: "Roboto"

                            width: chatTextHidden.width
                            font.pixelSize: 11
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            wrapMode: Text.WordWrap
                        }
                    }

                    Text {
                        id: chatTime
                        text: time
                        font.family: "Roboto"
                        color: "#FFFFFF"
                        font.pixelSize: 7
                    }
                }
            }
        }
    }

    ListModel {
        id: conversationModel
        ListElement {
            userName: "Stuge"
            avatar: "../../icons/avatar.svg"
            messageContent: "some message going to the user"
            time: "10:25AM"
            isSelf: false
        }
        ListElement {
            userName: "Stuge"
            avatar: "../../icons/avatar.svg"
            messageContent: "He did the research apparently"
            time: "10:25AM"
            isSelf: false
        }
        ListElement {
            userName: "Stuge"
            avatar: "../../icons/avatar.svg"
            messageContent: "He did the research apparentlyasdasdasdasdasdadasd"
            time: "10:25AM"
            isSelf: false
        }

        ListElement {
            userName: "Stuge"
            avatar: "../../icons/avatar.svg"
            messageContent: "He did the research apparently"
            time: "10:25AM"
            isSelf: true
        }
        ListElement {
            userName: "Stuge"
            avatar: "../../icons/avatar.svg"
            messageContent: "He did the research apparentlyasdasdasdasdasdadasd"
            time: "10:25AM"
            isSelf: false
        }
        ListElement {
            userName: "Stuge"
            avatar: "../../icons/avatar.svg"
            messageContent: "He did the research apparentlyasdasdasdasdasdadasd"
            time: "10:25AM"
            isSelf: false
        }
        ListElement {
            userName: "Stuge"
            avatar: "../../icons/avatar.svg"
            messageContent: "He did the research apparentlyasdasdasdasdasdadasd"
            time: "10:25AM"
            isSelf: false
        }
        ListElement {
            userName: "Stuge"
            avatar: "../../icons/avatar.svg"
            messageContent: "He did the research apparentlyasdasdasdasdasdadasd"
            time: "10:25AM"
            isSelf: false
        }
        ListElement {
            userName: "Stuge"
            avatar: "../../icons/avatar.svg"
            messageContent: "He did the research apparentlyasdasdasdasdasdadasd"
            time: "10:25AM"
            isSelf: false
        }
        ListElement {
            userName: "Stuge"
            avatar: "../../icons/avatar.svg"
            messageContent: "He did the research apparentlyasdasdasdasdasdadasd"
            time: "10:25AM"
            isSelf: false
        }
        ListElement {
            userName: "Stuge"
            avatar: "../../icons/avatar.svg"
            messageContent: "He did the research apparentlyasdasdasdasdasdadasd"
            time: "10:25AM"
            isSelf: false
        }
        ListElement {
            userName: "Stuge"
            avatar: "../../icons/avatar.svg"
            messageContent: "He did the research apparentlyasdasdasdasdasdadasd"
            time: "10:25AM"
            isSelf: false
        }
        ListElement {
            userName: "Stuge"
            avatar: "../../icons/avatar.svg"
            messageContent: "He did the research apparentlyasdasdasdasdasdadasd"
            time: "10:25AM"
            isSelf: false
        }
        ListElement {
            userName: "Stuge"
            avatar: "../../icons/avatar.svg"
            messageContent: "He did the research apparentlyasdasdasdasdasdadasd"
            time: "10:25AM"
            isSelf: false
        }
    }
}
