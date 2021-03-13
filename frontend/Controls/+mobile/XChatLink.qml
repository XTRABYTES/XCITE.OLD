/**
* Filename: XChatLink.qml
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

import "qrc:/Controls/+mobile" as Mobile
import "qrc:/Controls" as Controls

Rectangle {
    id: xchatLinkModal
    width: appWidth
    height: appHeight
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    visible: xChatLinkTracker == 1

    property alias urlText: linkText.text

    MouseArea {
        anchors.fill: parent
    }

    Rectangle {
        width: parent.width
        height: parent.height
        color: "black"
        opacity: 0.5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
    }

    DropShadow {
        anchors.fill: linkBox
        source: linkBox
        samples: 9
        radius: 4
        color: darktheme == true? "#000000" : "#727272"
        horizontalOffset:0
        verticalOffset: 0
        spread: 0
    }

    Rectangle {
        id: linkBox
        width: parent.width - 56
        height: linkBoxLabel.height + linkText.height + deleteLink.height + 35
        color: darktheme == true? "#2A2C31" : "#F2F2F2"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50

        Label {
            id: linkBoxLabel
            text: "URL"
            anchors.left: linkBox.left
            anchors.leftMargin: 10
            anchors.top: linkBox.top
            anchors.topMargin: 5
            horizontalAlignment: Text.AlignLeft
            font.family: xciteMobile.name
            wrapMode: Text.Wrap
            font.pixelSize: 16
            font.bold: true
            color: darktheme == false? "#14161B" : "#F2F2F2"
        }

        Label{
            id: closeLink
            text: linkText.text == ""? "Close" : "Add link"
            font.family: xciteMobile.name
            font.pixelSize: 16
            font.capitalization: Font.SmallCaps
            color: darktheme == false? "#14161B" : "#F2F2F2"
            anchors.verticalCenter: linkBoxLabel.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
        }

        Rectangle {
            id: closeLinkButton
            width: 25
            height: 25
            anchors.horizontalCenter: closeLink.horizontalCenter
            anchors.verticalCenter: closeLink.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if ((linkText.text).trim() != "") {
                        xchatLink = linkText.text.trim()
                        linkAdded = true
                    }
                    else {
                        xchatLink = ""
                        linkAdded = false
                    }
                    xChatLinkTracker = 0
                }
            }
        }

        Controls.TextInput {
            id: linkText
            height: 34
            placeholder: "Type your URL."
            text: ""
            anchors.left: linkBox.left
            anchors.leftMargin: 10
            anchors.right: linkBox.right
            anchors.rightMargin: 10
            anchors.top: linkBoxLabel.bottom
            anchors.topMargin: 10
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            mobile: 1
            deleteBtn: 0
        }

        Image {
            id: deleteLink
            source: darktheme == true? 'qrc:/icons/mobile/trash-icon_01_light.svg' : 'qrc:/icons/mobile/trash-icon_01_dark.svg'
            height: 20
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: linkText.bottom
            anchors.topMargin: 10

            Rectangle {
                id: deleteButton
                height: 20
                width: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
            }

            MouseArea {
                anchors.fill: deleteButton

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    linkText.text = ""
                    xchatLink = ""
                    linkAdded = false
                }
            }
        }
    }
}
