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
        addContactButton.border.color = themecolor
    }

    MouseArea {
        anchors.fill: parent
    }

    Image {
        source: darktheme? "qrc:/icons/magnifying-glass-icon-light_01.png" : "qrc:/icons/magnifying-glass-icon-dark_01.png"
        height: searchAddressBook.height/2
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: searchAddressBook.verticalCenter
        anchors.right: searchAddressBook.left
        anchors.rightMargin: height/2
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

    Item {
        id: contactButton
        width: addContactButton.width + addContactLabel.width
        height: addContactButton.height
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: searchAddressBook.bottom
        anchors.topMargin: appHeight/12

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height + 6
            width: parent.width + 6
            radius: height/2
            color: bgcolor
            opacity: 0.9
        }

        Rectangle {
            id: addContactButton
            height: appWidth/48
            width: height
            radius: height/2
            color: "transparent"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            border.width: 2
            border.color: themecolor

            Rectangle {
               height: 2
               width: parent.width*0.6
               radius: height/2
               color: parent.border.color
               anchors.verticalCenter: parent.verticalCenter
               anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                width: 2
                height: parent.height*0.6
                radius: width/2
                color: parent.border.color
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Label {
            id: addContactLabel
            text: "ADD CONTACT"
            leftPadding: addContactButton.height/2
            font.pixelSize: addContactButton.height/2
            font.family: xciteMobile.name
            color: addContactButton.border.color
            anchors.left: addContactButton.right
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                addContactButton.border.color = maincolor
            }

            onExited: {
                addContactButton.border.color = themecolor
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                addContactTracker = 1
            }
        }
    }

    Rectangle {
        id: walletArea
        width: parent.width
        anchors.top: contactButton.bottom
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

    Desktop.AddContactModal {
        id: myAddContactModal
        anchors.top: parent.top
    }

    Desktop.AddressBookTransaction {
        id: myAddressBookTransaction
        anchors.top: parent.top
    }

    Rectangle {
        height: appWidth/24
        width: parent.width
        anchors.bottom: parent.bottom
        color: darktheme == true? "#14161B" : "#FDFDFD"
    }
}
