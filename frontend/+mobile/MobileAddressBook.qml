/**
 * Filename: MobileAddressBook.qml
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
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "../Controls" as Controls
/**
  * Address Book
  */
Item {
    property int appsTracker: 0
    Item {
        id: heading
        anchors.left: parent.left
        anchors.right: parent.right
        height: 35

        Label {
            id: label
            font.pixelSize: 16
            anchors.fill: parent
            color: "white"
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            text: qsTr("POSEY")
        }
    }
    Rectangle{
        z: 100
        color: "#393B43"
        opacity: 0.8
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: parent.width
        height: 50
    }
    Rectangle{
        color: "black"
        opacity: .8
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height
        width: parent.width
        z: 5
        visible: appsTracker == 1
    }
    RowLayout {
        anchors.top: heading.bottom
        anchors.topMargin: 10
        anchors.left: heading.left
        anchors.leftMargin: 100
        spacing: 20
        Label {
            id: overview
            text: "OVERVIEW"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#757575"

            MouseArea {
                anchors.fill: overview
                onClicked: mainRoot.pop("MobileAddressBook.qml")
            }
        }

        Label {
            id: add5
            text: "ADDRESS BOOK"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#5E8BFE"
            Rectangle {
                id: titleLine
                width: add5.width
                height: 1
                color: "#5E8BFE"
                anchors.top: add5.bottom
                anchors.left: add5.left
                anchors.topMargin: 2
            }
        }
    }

    Label {
        id: transfer
        text: "TRANSFER"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        color: "#C7C7C7"
        anchors.left: address.left
        anchors.bottom: address.top
        anchors.bottomMargin: 8
        font.bold: true
        /**
        MouseArea {
            anchors.fill: add
            onClicked: mainRoot.push("MobileAddressBook.qml")
        }
        */
        Image {
            id: transfer2
            anchors.top: parent.top
            anchors.topMargin: -2
            anchors.left: parent.right
            anchors.leftMargin: 8
            source: '../icons/icon-transfer.svg'
            width: 16
            height: 16
            ColorOverlay {
                anchors.fill: transfer2
                source: transfer2
                color: "grey" // make image like it lays under grey glass
            }
        }
    }

    Label {
        id: addCoin
        text: "ADD ADDRESS"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        color: "#C7C7C7"
        anchors.right: address.right
        anchors.bottom: address.top
        anchors.bottomMargin: 8
        anchors.rightMargin: 24
        font.bold: true
        /**
        MouseArea {
            anchors.fill: add
            onClicked: mainRoot.push("MobileAddressBook.qml")
        }
        */
        Image {
            id: plus
            anchors.top: parent.top
            anchors.topMargin: -2
            anchors.left: parent.right
            anchors.leftMargin: 8
            source: '../icons/plus-button.svg'
            width: 16
            height: 16
            ColorOverlay {
                anchors.fill: plus
                source: plus
                color: "grey" // make image like it lays under grey glass
            }
        }
    }

    Controls.AddressBookSquares{
        id: address
        anchors.top: parent.top
        anchors.topMargin: 120
        anchors.left: parent.left
        anchors.leftMargin: 25
        name: "Posey"
    }
    Controls.AddressBookSquares{
        id: address2
        anchors.top: address.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        name: "Nrocy"
    }
    Controls.AddressBookSquares{
        id: address3
        anchors.top: address2.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        name: "Enervey"
    }
    Controls.AddressBookSquares{
        id: address4
        anchors.top: address3.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        name: "Danny"
    }
    Controls.AddressBookSquares{
        id: address5
        anchors.top: address4.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        name: "Goldeneye"
    }
    Controls.AddressBookSquares{
        id: address6
        anchors.top: address5.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        name: "Chef"
    }

    Image {
        id: settings
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 30
        source: '../icons/icon-settings.svg'
        width: 20
        height: 20
        z: 100

        ColorOverlay {
            anchors.fill: settings
            source: settings
            color: "#5E8BFF" // make image like it lays under grey glass
        }

        MouseArea {
            anchors.fill: settings
            //onClicked: pageLoader.source = "MobileAddressBook.qml"
            onClicked: mainRoot.push("Settings.qml")
        }
    }
    Image {
        id: apps
        source: '../icons/icon-apps.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 30
        width: 20
        height: 20
        z: 100
        visible: appsTracker == 0
        MouseArea{
            anchors.fill: apps
            onClicked: appsTracker = 1
        }
        ColorOverlay {
            anchors.fill: apps
            source: apps
            color: "#5E8BFF" // make image like it lays under grey glass
        }
        /**
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    clipboard.text = regString.text
                }
            }
            */
    }
    Image {
        id: closeApps
        source: '../icons/CloseIcon.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 30
        width: 20
        height: 20
        z: 100
        visible: appsTracker == 1
        MouseArea{
            anchors.fill: closeApps
            onClicked: appsTracker = 0
        }
        ColorOverlay {
            anchors.fill: closeApps
            source: closeApps
            color: "#5E8BFF" // make image like it lays under grey glass
        }
        /**
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    clipboard.text = regString.text
                }
            }
            */
    }
    Image {
        id: xchangeLink
        source: '../icons/XCHANGE_02.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 90
        anchors.right: parent.right
        anchors.rightMargin: 20
        width: 40
        height: 40
        z: 100
        visible: appsTracker == 1
        Text{
            text: "X-CHANGE"
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#5E8BFF"
            font.family: "Brandon Grotesque"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }
        ColorOverlay {
            anchors.fill: xchangeLink
            source: xchangeLink
            color: "#5E8BFF" // make image like it lays under grey glass
        }
        /**
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    clipboard.text = regString.text
                }
            }
            */
    }

    Image {
        id: xvaultLink
        source: '../icons/XVAULT_02.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 160
        anchors.right: parent.right
        anchors.rightMargin: 20
        width: 40
        height: 40
        z: 100
        visible: appsTracker == 1
        Text{
            text: "X-VAULT"
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#5E8BFF"
            font.family: "Brandon Grotesque"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }

        ColorOverlay {
            anchors.fill: xvaultLink
            source: xvaultLink
            color: "#5E8BFF" // make image like it lays under grey glass
        }
        /**
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    clipboard.text = regString.text
                }
            }
            */
    }

    Image {
        id: xchatLink
        source: '../icons/XCHAT_02.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 230
        anchors.right: parent.right
        anchors.rightMargin: 20
        width: 40
        height: 40
        z: 100
        visible: appsTracker == 1
        Text{
            text: "X-CHAT"
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#5E8BFF"
            font.family: "Brandon Grotesque"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }
        ColorOverlay {
            anchors.fill: xchatLink
            source: xchatLink
            color: "#5E8BFF" // make image like it lays under grey glass
        }
        /**
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    clipboard.text = regString.text
                }
            }
            */
    }
}
