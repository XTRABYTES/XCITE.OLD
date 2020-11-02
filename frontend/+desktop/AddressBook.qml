/**
* Filename: AddressBook.qml
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
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop

Rectangle {
    id: backgroundAddressbook
    z: 1
    width: appWidth/6 * 5
    height: appHeight
    anchors.right: xcite.right
    anchors.top: xcite.top
    color: bgcolor

    property bool myTheme: darktheme

    onMyThemeChanged: {
        transferButton.border.color = themecolor
        transferLabel.color = themecolor
        contactButton.border.color = themecolor
        contactLabel.color = themecolor
    }

    MouseArea {
        anchors.fill: parent
    }

    Controls.TextInput {
        id: searchAddressBook
        height: appHeight/24
        width: appWidth/6*1.5
        color: themecolor
        font.pixelSize: height/2
        leftPadding: height/2
        rightPadding: height/2
        horizontalAlignment: Text.AlignRight
        textBackground: "transparent"
        deleteBtn: 0
        mobile: 1
        placeholder: "Search contact"
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: addressbookLabel.bottom
        anchors.topMargin: appHeight/24
    }

    Rectangle {
        id: transferButton
        height: appHeight/24
        width: appWidth/6
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        anchors.top: searchAddressBook.bottom
        anchors.topMargin: appHeight/12
        color: "transparent"
        border.width: 1
        border.color: themecolor

        Label {
            id: transferLabel
            text: "TRANSFER"
            anchors.left: parent.left
            anchors.leftMargin: parent.height/2
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height/2
            font.family: xciteMobile.name
            color: themecolor
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                parent.border.color = maincolor
                transferLabel.color = maincolor
            }

            onExited: {
                parent.border.color = themecolor
                transferLabel.color = themecolor
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {

            }
        }
    }

    Rectangle {
        id: contactButton
        height: appHeight/24
        width: appWidth/6
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: searchAddressBook.bottom
        anchors.topMargin: appHeight/12
        color: "transparent"
        border.width: 1
        border.color: themecolor

        Label {
            id: contactLabel
            text: "ADD CONTACT"
            anchors.left: parent.left
            anchors.leftMargin: parent.height/2
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height/2
            font.family: xciteMobile.name
            color: themecolor
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                parent.border.color = maincolor
                contactLabel.color = maincolor
            }

            onExited: {
                parent.border.color = themecolor
                contactLabel.color = themecolor
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {

            }
        }
    }

    Rectangle {
        id: walletArea
        width: parent.width
        anchors.top: transferButton.bottom
        anchors.topMargin: appHeight/24
        anchors.bottom: parent.bottom
        anchors.bottomMargin: appWidth/24
        anchors.left: parent.left
        color: "transparent"
        clip: true

        Desktop.ContactList {
            id: myContactList
            anchors.top: parent.top
            searchFilter: searchAddressBook.text
        }
    }

    Desktop.ContactInfo {
        id: myContactInfo
        anchors.top: parent.top
    }

    Label {
        id: addressbookLabel
        text: "ADDRESSBOOK"
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Rectangle {
        height: appWidth/24
        width: parent.width
        anchors.bottom: parent.bottom
        color: darktheme == true? "#14161B" : "#FDFDFD"
    }
}
