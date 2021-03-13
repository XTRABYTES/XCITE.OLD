/**
* Filename: XChatList.qml
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
import SortFilterProxyModel 0.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.11
import QtQuick.Window 2.2

import "qrc:/Controls" as Controls

Rectangle {
    width: parent.width
    height: parent.height
    anchors.top: parent.top
    color: "transparent"
    clip :true

    property bool xChatFocus: true
    property alias xChatList: msgList
    property alias xChatOrderedList: arrangedMsg
    property string tagging: ""


    Component {
        id: msgLine

        Rectangle {
            id: msgRow
            width: parent.width
            height: author === "xChatRobot"? ((robotMsgBox.height + 4) > xChatRobotIcon.height? (robotMsgBox.height + 4): xChatRobotIcon.height) : (message === ""? 0 : (messageHeader.height + quoteArea.height + messageText.height + linkArea.height + imageArea.height))
            color: "transparent"
            visible: message != ""
            clip: true

            DropShadow {
                anchors.fill: msgBox
                source: msgBox
                samples: 9
                radius: 4
                color: darktheme == true? "#000000" : "#727272"
                horizontalOffset:0
                verticalOffset: 0
                spread: 0
                visible: author != "xChatRobot"
            }

            Rectangle {
                id: msgBox
                width: (0.85 * (appWidth - 56))
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                anchors.left: author==(myUsername)? undefined : parent.left
                anchors.leftMargin: author==(myUsername)? 0 : 2
                anchors.right: author==(myUsername)? parent.right : undefined
                anchors.rightMargin: author==(myUsername)? 2 : 0
                color: darktheme == true? "#2A2C31" : "#F2F2F2"
                visible: author != "xChatRobot"
            }

            Rectangle {
                id: messageHeader
                color: "transparent"
                width: msgBox.width
                height: senderID.height + 6
                anchors.left: msgBox.left
                anchors.right: msgBox.right
                anchors.top: msgRow.top
                visible: author != "xChatRobot"
            }

            Label {
                id: senderID
                text: author
                font.family: xciteMobile.name
                font.pixelSize: 12
                font.bold: true
                horizontalAlignment: Text.AlignLeft
                color: darktheme == false? "#14161B" : "#F2F2F2"
                anchors.left:msgBox.left
                anchors.leftMargin: 10
                anchors.top: msgBox.top
                anchors.topMargin: 5
                visible: author != "xChatRobot"

                Rectangle {
                    height: senderID.height
                    width: senderID.width
                    anchors.verticalCenter: senderID.verticalCenter
                    anchors.horizontalCenter: senderID.horizontalCenter
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent
                        //focus: false

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            if(getUserStatus(author) !== "dnd" && author !== myUsername) {
                                tagging = ""
                                tagging = "@" + senderID.text
                            }
                            else if (getUserStatus(author) === "dnd"){
                                dndNotification(author)
                            }
                        }
                    }
                }
            }

            Label {
                id: messageDate
                text: date
                anchors.right: msgBox.right
                anchors.rightMargin: 10
                anchors.bottom: senderID.bottom
                anchors.bottomMargin: 1
                font.family: xciteMobile.name
                font.pixelSize: 10
                horizontalAlignment: Text.AlignRight
                color: darktheme == false? "#14161B" : "#F2F2F2"
                visible: author != "xChatRobot"
            }

            Rectangle {
                id: online
                height: 5
                width: 5
                radius: 5
                anchors.left: senderID.right
                anchors.leftMargin: 5
                anchors.verticalCenter: senderID.verticalCenter
                color: getUserStatus(author) === "online"? "#4BBE2E" : (getUserStatus(author) === "idle"? "#F7931A" : "#E55541")
                visible: author != "xChatRobot" && getUserStatus(author) !== "dnd"
            }

            Rectangle {
                id: dndArea
                height: 10
                width: 10
                color: "transparent"
                anchors.left: senderID.right
                anchors.leftMargin: 5
                anchors.verticalCenter: senderID.verticalCenter
                visible: getUserStatus(author) === "dnd"
            }

            Image {
                source: 'qrc:/icons/mobile/dnd-icon_01.svg'
                width: 10
                height: 10
                fillMode: Image.PreserveAspectFit
                anchors.left: senderID.right
                anchors.leftMargin: 5
                anchors.verticalCenter: senderID.verticalCenter
                visible: dndArea.visible == true
            }

            Image {
                source: darktheme == true? (device == "mobile"? 'qrc:/icons/mobile/phone-icon_02_white.svg' : 'qrc:/icons/mobile/computer-icon_01_white.svg') : (device == "mobile"? 'qrc:/icons/mobile/phone-icon_02_black.svg' : 'qrc:/icons/mobile/computer-icon_01_black.svg')
                width: 14
                height: 14
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: senderID.verticalCenter
                anchors.left: online.right
                anchors.leftMargin: 5
                visible: author != "xChatRobot" && !dndArea.visible
            }

            Rectangle {
                id: msgBoxDivider
                height: 1
                anchors.left: msgBox.left
                anchors.leftMargin: 10
                anchors.right: msgBox.right
                anchors.rightMargin: 10
                anchors.top: senderID.bottom
                color: "#0ED8D2"
                visible: author != "xChatRobot"
            }

            Rectangle {
                id: quoteArea
                color: "transparent"
                width: msgBox.width
                height: quote != "" ? messageQuote.height + 5 : 0
                anchors.left: msgBox.left
                anchors.right: msgBox.right
                anchors.top: messageHeader.bottom
                visible: author != "xChatRobot" && quote != ""
            }

            DropShadow {
                anchors.fill: messageQuote
                source: messageQuote
                samples: 9
                radius: 4
                color: darktheme == true? "#000000" : "#727272"
                horizontalOffset:0
                verticalOffset: 0
                spread: 0
                visible: author != "xChatRobot" && (quote != "" || quote != undefined)
            }

            Rectangle {
                id: messageQuote
                width: msgBox.width - 20
                height: quote != ""? quoteText.height + 5 : 0
                color: "#816030"
                anchors.horizontalCenter: msgBox.horizontalCenter
                anchors.top: msgBoxDivider.bottom
                anchors.topMargin: 5
                visible: author != "xChatRobot" && quote != ""

                Text {
                    id: quoteText
                    text: quote != ""? "<<" + quote + ">>" : ""
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    font.italic: true
                    font.family: xciteMobile.name
                    color: "#F2F2F2"
                    wrapMode: Text.Wrap
                    font.pixelSize: 14
                    maximumLineCount: 3
                    elide: Text.ElideMiddle
                }
            }

            Text {
                id: messageText
                text: message + "<br>"
                anchors.left: msgBox.left
                anchors.leftMargin: 10
                anchors.right: msgBox.right
                anchors.rightMargin: 10
                anchors.top: quote != ""? quoteArea.bottom : messageHeader.bottom
                anchors.topMargin: 5
                horizontalAlignment: Text.AlignLeft
                font.family: xciteMobile.name
                wrapMode: Text.Wrap
                font.pixelSize: 16
                textFormat: Text.StyledText
                color: darktheme == false? "#14161B" : "#F2F2F2"
                visible: author != "xChatRobot"

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent

                        onPressAndHold: {
                            addQuote(author, message)
                            //xchatQuote = author + ": " + message
                            //quoteAdded = true
                        }
                    }
                }
            }

            Rectangle {
                id: linkArea
                color: "transparent"
                width: msgBox.width
                height: webLink != ""? messageLink.height + 5 : 0
                anchors.left: msgBox.left
                anchors.right: msgBox.right
                anchors.top: messageText.bottom
                visible: author != "xChatRobot" && webLink != ""
            }

            Text {
                id: messageLink
                text: webLink != ""? webLink : ""
                anchors.left: messageText.left
                anchors.right: messageText.right
                anchors.top: linkArea.top
                anchors.topMargin: -15
                horizontalAlignment: Text.AlignLeft
                font.family: xciteMobile.name
                wrapMode: Text.WrapAnywhere
                maximumLineCount: 2
                elide: Text.ElideRight
                font.pixelSize: 16
                font.underline: true
                color: "#1499E4"
                visible: author != "xChatRobot" && webLink != ""

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onPressAndHold: {
                            xChatClipBoard = 1
                            url2Copy = webLink
                        }

                        onClicked: {
                            Qt.openUrlExternally(webLink)
                        }
                    }
                }
            }

            Rectangle {
                id: imageArea
                color: "transparent"
                width: msgBox.width - 20
                height: image != ""? messageImage.paintedHeight + 5 : 0
                anchors.left: msgBox.left
                anchors.right: msgBox.right
                anchors.top: webLink != ""? linkArea.bottom : messageText.bottom
                anchors.topMargin: -15
                visible: author != "xChatRobot" && image != ""
            }

            Image {
                id: messageImage
                source: image != ""? image : ''
                height: image.implicitHeight < 120? image.implicitHeight : 120
                width: image.implicitWidth < msgBox.width - 20? image.implicitWidth : msgBox.width - 20
                fillMode: Image.PreserveAspectFit
                anchors.top: imageArea.top
                anchors.horizontalCenter: msgBox.horizontalCenter
                visible: author != "xChatRobot" && image != ""

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            xchatLargeImage = image
                            xChatLargeImageTracker = 1
                        }
                    }
                }
            }

            DropShadow {
                z: 12
                anchors.fill: clipBoardPopup
                source: clipBoardPopup
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color: "black"
                opacity: 0.4
                transparentBorder: true
                visible: xChatClipBoard == 1 && url2Copy == webLink
            }

            Item {
                id: clipBoardPopup
                z: 12
                width: copyToClipboard.width + closeClipboard.width
                height: 40
                anchors.horizontalCenter: messageLink.horizontalCenter
                anchors.verticalCenter: messageLink.verticalCenter
                visible: xChatClipBoard == 1 && url2Copy == webLink

                property int textCopied: 0

                MouseArea {
                    width: appWidth
                    height: appHeight
                    anchors.verticalCenter: xcite.verticalCenter
                    anchors.horizontalCenter: xcite.horizontalCenter

                    onClicked: xChatClipBoard = 0
                }

                Rectangle {
                    id: copyToClipboard
                    height: 40
                    width: toClipboardText.width + 40
                    color: "#34363D"
                    anchors.left: parent.left
                    anchors.verticalCenter: clipBoardPopup.verticalCenter

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            copyText2Clipboard(webLink)
                            xChatClipBoard = 0
                            urlCopy2Clipboard = 1
                        }
                    }
                }

                Label {
                    id: toClipboardText
                    text: "Copy URL"
                    font.family: "Brandon Grotesque"
                    font.pointSize: 14
                    font.bold: true
                    color: "#F2F2F2"
                    anchors.horizontalCenter: copyToClipboard.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle {
                    id: closeClipboard
                    height: 40
                    width: 40
                    color: "#34363D"
                    anchors.left: copyToClipboard.right
                    anchors.verticalCenter: parent.verticalCenter

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            xChatClipBoard = 0
                        }
                    }
                }

                Image {
                    id: closeClipboardImage
                    source:'qrc:/icons/mobile/delete-icon_01_light.svg'
                    height: 15
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: closeClipboard.horizontalCenter
                    anchors.verticalCenter: closeClipboard.verticalCenter
                }
            }

            DropShadow {
                z: 12
                anchors.fill: copiedPopup
                source: copiedPopup
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0
                color: "black"
                opacity: 0.4
                transparentBorder: true
                visible: urlCopy2Clipboard == 1 && url2Copy == webLink
            }

            Item {
                id: copiedPopup
                z: 12
                width: popupCopied.width
                height: 40
                anchors.horizontalCenter: messageLink.horizontalCenter
                anchors.verticalCenter: messageLink.verticalCenter
                visible: urlCopy2Clipboard == 1 && url2Copy == webLink

                Rectangle {
                    id: popupCopied
                    height: 40
                    width: popupCopiedText.width + 56
                    color: "#34363D"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                Label {
                    id: popupCopiedText
                    text: "Copied to clipboard!"
                    font.family: "Brandon Grotesque"
                    font.pointSize: 14
                    font.bold: true
                    color: "#F2F2F2"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }


            Image {
                id: xChatRobotIcon
                source: 'qrc:/icons/mobile/robot_bee_01.svg'
                width: 40
                height: 40
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                visible: author == "xChatRobot"
            }

            Rectangle {
                id: robotMsgBox
                height: robotText.height +10
                anchors.left: xChatRobotIcon.right
                anchors.leftMargin: 10
                anchors.right: parent.right
                 color: "transparent"
                visible: author == "xChatRobot"
            }

            Text {
                id: robotText
                text: message
                anchors.left: robotMsgBox.left
                anchors.leftMargin: 10
                anchors.right: robotMsgBox.right
                anchors.rightMargin: 10
                anchors.top: robotMsgBox.top
                anchors.topMargin: 5
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.Wrap
                font.pixelSize: 16
                color: "#E55541"
                visible: author == "xChatRobot"
            }
        }
    }

    SortFilterProxyModel {
        id: arrangedMsg
        sourceModel: xChatTread
        sorters: [
            StringSorter {
                roleName: "msgID";
                sortOrder: Qt.AscendingOrder;
            }
        ]
    }

    ListView {
        anchors.fill: parent
        id: msgList
        model: arrangedMsg
        delegate: msgLine
        spacing: 7
        onDraggingChanged: {
            xChatFocus = false
            xChatScrolling = true
            detectInteraction()
        }

        onDragEnded: {
            if (msgList.atYEnd) {
                xChatScrolling = false
                newMessages = false
            }
            else {
                xChatScrolling = true
            }
        }
    }

    Component.onCompleted: {
        msgList.positionViewAtEnd()
    }
}
