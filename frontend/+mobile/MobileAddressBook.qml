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
import QtMultimedia 5.8
import "../Controls" as Controls

/**
  * Address Book
  */
Item {
    property int appsTracker: 0
    property int clickedAddSquare: 0
    property int editAddressTracker: 0
    property int clickedEditTracker: 0
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
            text: qsTr("Posey")
        }
    }
    Rectangle {
        z: 100
        color: "#2A2C31"
        opacity: 0.8
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: parent.width
        height: 50
    }
    Rectangle {
        color: "black"
        opacity: .8
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height
        width: parent.width
        z: 5
        visible: appsTracker == 1 || editAddressTracker == 1
    }
    Rectangle {
        color: "#34363D"
        anchors.top: transfer.bottom
        anchors.topMargin: 8
        anchors.left: parent.left
        height: parent.height
        width: parent.width
        z: 0
        visible: true
    }
    RowLayout {
        id: headingRow
        anchors.top: heading.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: heading.horizontalCenter
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
        anchors.bottomMargin: 19
        font.bold: true
        Image {
            id: transfer2
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.right
            anchors.leftMargin: 8
            source: '../icons/transfer_icon.svg'
            width: 16
            height: 16
        }
    }

    Label {
        id: addAddress
        text: "ADD ADDRESS"
        font.pixelSize: 12
        font.family: "Brandon Grotesque"
        color: "#C7C7C7"
        anchors.right: address.right
        anchors.bottom: address.top
        anchors.bottomMargin: 19
        anchors.rightMargin: 24
        font.bold: true
        Image {
            id: plus
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.right
            anchors.leftMargin: 8
            source: '../icons/add_icon_03.svg'
            width: 16
            height: 16
        }
    }

    Controls.AddressBookSquares {
        id: address
        anchors.top: parent.top
        anchors.topMargin: 125
        anchors.left: parent.left
        anchors.leftMargin: 25
        name: "Posey"
        numberAddresses: 1
        height: clickedAddSquare == 0 ? 75 : 150
        Image {
            width: 25
            height: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }
        Rectangle {
            id: expandAddressArea
            width: 40
            height: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -5
            color: "transparent"
            MouseArea {
                anchors.fill: expandAddressArea
                onClicked: {
                    if(clickedAddSquare == 0){
                        clickedAddSquare = 1
                        return
                    }
                    if(clickedAddSquare == 1 ){
                        clickedAddSquare = 0
                        return
                    }
                }
            }
        }
        Image {
            id: icon
            width: 20
            height: 20
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 50
            source: '../icons/XBY_card_logo_colored_05.svg'
            visible: clickedAddSquare == 1
        }
        Label {
            anchors.left: icon.right
            anchors.leftMargin: 5
            anchors.verticalCenter: icon.verticalCenter
            text: "XBY"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: true
            visible: clickedAddSquare == 1
        }
        Label {
            id: addressLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: icon.verticalCenter
            text: "Main"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: true
            visible: clickedAddSquare == 1
        }
        Image {
            id: editAddress
            width: 20
            height: 20
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 50
            source: '../icons/edit.svg'
            visible: clickedAddSquare == 1
            ColorOverlay {
                anchors.fill: editAddress
                source: editAddress
                color: "#DADADA"
            }
            MouseArea {
                anchors.fill: editAddress
                onClicked: {
                    editAddressTracker = 1
                }
            }
        }
        Rectangle {
            id: dividerLine
            visible: clickedAddSquare == 1
            width: address.width - 20
            height: 1
            color: "#575757"
            anchors.top: icon.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle {
        id: modal
        height: 300
        width: parent.width - 50
        color: "#42454F"
        radius: 4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
        visible: editAddressTracker == 1
        z: 100
        Rectangle {
            id: modalTop
            height: 50
            width: modal.width
            anchors.bottom: modal.top
            anchors.left: modal.left
            color: "#34363D"
            radius: 4
        }
        Label{
            anchors.horizontalCenter: modalTop.horizontalCenter
            anchors.verticalCenter: modalTop.verticalCenter
            color: "White"
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            font.bold: true
            text: "EDIT ADDRESS"
        }
        Image {
            id: icon2
            width: 25
            height: 25
            anchors.left: keyInput1.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 25
            source: '../icons/XBY_card_logo_colored_05.svg'
            visible: clickedAddSquare == 1
        }
        Label {
            id: label1
            anchors.left: icon2.right
            anchors.leftMargin: 5
            anchors.verticalCenter: icon2.verticalCenter
            text: "XBY"
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: true
            visible: clickedAddSquare == 1
        }
        Image {
            source: '../icons/dropdown_icon.svg'
            width: 15
            height: 15
            anchors.left: label1.right
            anchors.leftMargin: 8
            anchors.verticalCenter: label1.verticalCenter
        }
        Controls.TextInput {
            id: keyInput1
            height: 34
            placeholder: "Edit Name"
            text: address.name
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: icon2.bottom
            anchors.topMargin: 20
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editAddressTracker == 1
        }
        Image {
            id: textFieldEmpty1
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput1.verticalCenter
            anchors.right: keyInput1.right
            anchors.rightMargin: 10
            width: textFieldEmpty1.height
            height: 12
            ColorOverlay {
                anchors.fill: textFieldEmpty1
                source: textFieldEmpty1
                color: "#727272"
            }
            Rectangle {
                id: keyInput1ButtonArea
                width: 20
                height: 20
                anchors.left: textFieldEmpty1.left
                anchors.bottom: textFieldEmpty1.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: keyInput1ButtonArea
                    onClicked: {
                        keyInput1.text = ""
                    }
                }
            }
        }
        Controls.TextInput {
            id: keyInput2
            height: 34
            placeholder: "Edit Label"
            text: addressLabel.text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: keyInput1.bottom
            anchors.topMargin: 20
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editAddressTracker == 1
        }
        Image {
            id: textFieldEmpty2
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput2.verticalCenter
            anchors.right: keyInput2.right
            anchors.rightMargin: 10
            width: textFieldEmpty2.height
            height: 12
            ColorOverlay {
                anchors.fill: textFieldEmpty2
                source: textFieldEmpty2
                color: "#727272"
            }
            Rectangle {
                id: keyInput2ButtonArea
                width: 20
                height: 20
                anchors.left: textFieldEmpty2.left
                anchors.bottom: textFieldEmpty2.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: keyInput2ButtonArea
                    onClicked: {
                        keyInput2.text = ""
                    }
                }
            }
        }
        Controls.TextInput {
            id: keyInput3
            height: 34
            placeholder: "Edit Address"
            text: receivingAddress
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: keyInput2.bottom
            anchors.topMargin: 20
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editAddressTracker == 1
        }
        Image {
            id: textFieldEmpty3
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput3.verticalCenter
            anchors.right: keyInput3.right
            anchors.rightMargin: 10
            width: textFieldEmpty3.height
            height: 12
            ColorOverlay {
                anchors.fill: textFieldEmpty3
                source: textFieldEmpty3
                color: "#727272"
            }
            Rectangle {
                id: keyInput3ButtonArea
                width: 20
                height: 20
                anchors.left: textFieldEmpty3.left
                anchors.bottom: textFieldEmpty3.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: keyInput3ButtonArea
                    onClicked: {
                        keyInput3.text = ""
                    }
                }
            }
        }
        Rectangle {
            id: editConfirm
            width: keyInput1.width
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: keyInput3.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editAddressTracker == 1
            MouseArea {
                anchors.fill: editConfirm

                onClicked: {
                    editAddressTracker = 0
                    addressName1 = keyInput1.text
                    addressLabel.text = keyInput2.text
                    receivingAddress = keyInput3.text
                }
            }
            Text {
                text: "DONE"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Controls.AddressBookSquares {
        id: address2
        anchors.top: address.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        name: "Nrocy"
        numberAddresses: 1
        Image {
            width: 25
            height: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }
    }
    Controls.AddressBookSquares {
        id: address3
        anchors.top: address2.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        name: "Enervey"
        numberAddresses: 1
        Image {
            width: 25
            height: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }
    }
    Controls.AddressBookSquares {
        id: address4
        anchors.top: address3.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        name: "Danny"
        numberAddresses: 1
        Image {
            width: 25
            height: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }
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
        source: '../icons/Apps_icon_03.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 30
        width: 20
        height: 20
        z: 100
        visible: appsTracker == 0
        MouseArea {
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
        MouseArea {
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
        Text {
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
        Text {
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
        Text {
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
