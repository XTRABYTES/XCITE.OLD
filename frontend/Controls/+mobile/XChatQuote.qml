/**
* Filename: XChatQuote.qml
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

Rectangle {
    id: xchatQuoteModal
    width: Screen.width
    height: Screen.height
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    visible: xChatQuoteTracker == 1

    MouseArea {
        anchors.fill: parent
    }

    Rectangle {
        width: Screen.width
        height: Screen.height
        color: "black"
        opacity: 0.5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
    }

    DropShadow {
        anchors.fill: quoteBox
        source: quoteBox
        samples: 9
        radius: 4
        color: darktheme == true? "#000000" : "#727272"
        horizontalOffset:0
        verticalOffset: 0
        spread: 0
    }

    Rectangle {
        id: quoteBox
        width: parent.width - 56
        height: quoteBoxLabel.height + quoteBG.height + deleteQuote.height + 40
        color: darktheme == true? "#2A2C31" : "#F2F2F2"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50

        Label {
            id: quoteBoxLabel
            text: "QUOTE"
            anchors.left: quoteBox.left
            anchors.leftMargin: 10
            anchors.top: quoteBox.top
            anchors.topMargin: 5
            horizontalAlignment: Text.AlignLeft
            font.family: xciteMobile.name
            wrapMode: Text.Wrap
            font.pixelSize: 16
            font.bold: true
            color: darktheme == false? "#14161B" : "#F2F2F2"
        }

        Label{
            id: closeQuote
            text: xchatQuote == ""? "Close" : "Add quote"
            font.family: xciteMobile.name
            font.pixelSize: 16
            font.capitalization: Font.SmallCaps
            color: darktheme == false? "#14161B" : "#F2F2F2"
            anchors.verticalCenter: quoteBoxLabel.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
        }

        Rectangle {
            id: closeQuoteButton
            width: 25
            height: 25
            anchors.horizontalCenter: closeQuote.horizontalCenter
            anchors.verticalCenter: closeQuote.verticalCenter
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (quoteText.text == "no quote added") {
                        xchatQuote = ""
                        quoteAdded = false
                    }
                    xChatQuoteTracker = 0
                }
            }
        }

        Rectangle {
            id: quoteBG
            width: quoteBox.width - 20
            height: quoteText.height + 5
            color: "#816030"
            anchors.horizontalCenter: quoteBox.horizontalCenter
            anchors.top: quoteBoxLabel.bottom
            anchors.topMargin: 5

            Text {
                id: quoteText
                text: xchatQuote != ""? "<<" + xchatQuote + ">>" : "no quote added"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.italic: xchatQuote == ""? true : false
                font.family: xciteMobile.name
                color: xchatQuote == ""? "#C6C6C6" : "#F2F2F2"
                wrapMode: Text.Wrap
                font.pixelSize: 14
                maximumLineCount: 12
                elide: Text.ElideMiddle
            }
        }

        Image {
            id: deleteQuote
            source: darktheme == true? 'qrc:/icons/mobile/trash-icon_01_light.svg' : 'qrc:/icons/mobile/trash-icon_01_dark.svg'
            height: 20
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: quoteBG.bottom
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
                    xchatQuote = ""
                    quoteAdded = false
                }
            }
        }
    }
}
