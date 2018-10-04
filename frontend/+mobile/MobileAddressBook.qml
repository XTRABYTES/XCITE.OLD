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
import QZXing 2.3
import "../Controls" as Controls

/**
  * Address Book
  */
Item {
    property int appsTracker: 0
    property int transferTracker: 0
    property int addressBookTracker: 0
    property int scanQRCodeTracker: 0
    property int transactionSentTracker: 0
    property int transactionConfirmTracker: 0
    property int clickedAddSquare: 0
    property int clickedAddSquare2: 0
    property int clickedAddSquare3: 0
    property int clickedAddSquare4: 0
    property int clickedAddSquare5: 0
    property int editAddressTracker: 0
    property int editAddressTracker2: 0
    property int editAddressTracker3: 0
    property int editAddressTracker4: 0
    property int editAddressTracker5: 0

    id: addressBookForm

    /**
      * pending design decision
    Rectangle {
        z: 100
        color: "#2A2C31"
        opacity: 0.8
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: parent.width
        height: 50
    }
    */
    Rectangle {
        color: "black"
        opacity: .8
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height
        width: parent.width
        z: 5
        visible: transferTracker == 1 || appsTracker == 1 || editAddressTracker == 1 || editAddressTracker2 == 1 || editAddressTracker3 == 1 || editAddressTracker4 == 1 || editAddressTracker5 == 1
    }
    Rectangle {
        id: mainrect
        color: "#34363D"
        anchors.top: transfer.bottom
        anchors.topMargin: 8
        anchors.left: parent.left
        height: parent.height
        width: parent.width
        z: 0
        visible: true
        MouseArea {
            anchors.fill: mainrect
            onClicked: {
                appsTracker = 0
            }
        }
    }

    Controls.TransferModal {
        z: 1000
        anchors.horizontalCenter: addressBookForm.horizontalCenter
        anchors.top: addressBookForm.top
        anchors.topMargin: 40
    }

    RowLayout {
        id: headingRow
        anchors.top: parent.top
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        Label {
            id: overview
            text: "OVERVIEW"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#757575"
            font.bold: true
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
            font.bold: true
            Rectangle {
                id: titleLine
                width: add5.width
                height: 2
                color: "#5E8BFE"
                anchors.top: add5.bottom
                anchors.left: add5.left
                anchors.topMargin: 2
            }
        }
    }

    Image {
        id: notif
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.verticalCenter: headingRow.verticalCenter
        source: '../icons/notification_icon_03.svg'
        width: 30
        height: 30
        ColorOverlay {
            anchors.fill: notif
            source: notif
            color: "#5E8BFF"
        }
        Image{
            id: notifAlert
            anchors.left: parent.right
            anchors.leftMargin: -16
            anchors.top: parent.top
            anchors.topMargin: 3
            source: '../icons/notification_red_circle_icon.svg'
            width: 8
            height: 8
        }
    }

    Image {
        id: apps
        source: '../icons/mobile-menu.svg'
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.verticalCenter: headingRow.verticalCenter
        width: 22
        height: 17
        z: 100
        visible: appsTracker == 0
        ColorOverlay {
            anchors.fill: apps
            source: apps
            color: "#5E8BFF"
        }
        MouseArea {
            anchors.fill: apps
            onClicked: appsTracker = 1
        }
    }

    Controls.Sidebar{
        anchors.left: parent.left
        anchors.top: parent.top
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
            source: '../icons/transfer_icon_02.svg'
            width: 16
            height: 16
            ColorOverlay {
                anchors.fill: transfer2
                source: transfer2
                color: "#5E8BFF"
            }
            MouseArea {
                anchors.fill: transfer2
                onClicked: {
                    transferTracker = 1
                }
            }
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
            source: '../icons/add_icon_04.svg'
            width: 16
            height: 16
            ColorOverlay {
                anchors.fill: plus
                source: plus
                color: "#5E8BFF"
            }
        }
    }

    Controls.TextInput {
        id: searchForAddress
        height: 34
        placeholder: "SEARCH ADDRESS BOOK"
        anchors.left: address.left
        anchors.top: headingRow.bottom
        anchors.topMargin: 40
        width: address.width
        color: "#727272"
        font.pixelSize: 11
        font.family: "Brandon Grotesque"
        font.bold: true
        mobile: 1
        addressBook: 1
    }
    Controls.AddressBookSquares {
        id: address
        anchors.top: searchForAddress.bottom
        anchors.topMargin: 50
        anchors.left: parent.left
        anchors.leftMargin: 25
        name: addressName1
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
        width: 325
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
            mobile: 1
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
            mobile: 1
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
            mobile: 1
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
                    addressType1 = keyInput2.text
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
        id: address_2
        anchors.top: address.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        name: addressName2
        numberAddresses: 1
        height: clickedAddSquare2 == 0 ? 75 : 150

        Image {
            width: 25
            height: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }
        Rectangle {
            id: expandAddressArea_2
            width: 40
            height: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -5
            color: "transparent"
            MouseArea {
                anchors.fill: expandAddressArea_2
                onClicked: {
                    if(clickedAddSquare2 == 0){
                        clickedAddSquare2 = 1
                        return
                    }
                    if(clickedAddSquare2 == 1 ){
                        clickedAddSquare2 = 0
                        return
                    }
                }
            }
        }
        Image {
            id: icon_2
            width: 20
            height: 20
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 50
            source: '../icons/XBY_card_logo_colored_05.svg'
            visible: clickedAddSquare2 == 1
        }
        Label {
            anchors.left: icon_2.right
            anchors.leftMargin: 5
            anchors.verticalCenter: icon_2.verticalCenter
            text: "XBY"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: true
            visible: clickedAddSquare2 == 1
        }
        Label {
            id: addressLabel_2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: icon_2.verticalCenter
            text: "Main"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: true
            visible: clickedAddSquare2 == 1
        }
        Image {
            id: editAddress_2
            width: 20
            height: 20
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 50
            source: '../icons/edit.svg'
            visible: clickedAddSquare2 == 1
            ColorOverlay {
                anchors.fill: editAddress_2
                source: editAddress_2
                color: "#DADADA"
            }
            MouseArea {
                anchors.fill: editAddress_2
                onClicked: {
                    editAddressTracker2 = 1
                }
            }
        }
        Rectangle {
            id: dividerLine_2
            visible: clickedAddSquare2 == 1
            width: address_2.width - 20
            height: 1
            color: "#575757"
            anchors.top: icon_2.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle {
        id: modal_2
        height: 300
        width: 325
        color: "#42454F"
        radius: 4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
        visible: editAddressTracker2 == 1
        z: 100
        Rectangle {
            id: modalTop_2
            height: 50
            width: modal_2.width
            anchors.bottom: modal_2.top
            anchors.left: modal_2.left
            color: "#34363D"
            radius: 4
        }
        Label{
            anchors.horizontalCenter: modalTop_2.horizontalCenter
            anchors.verticalCenter: modalTop_2.verticalCenter
            color: "White"
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            font.bold: true
            text: "EDIT ADDRESS"
        }
        Image {
            id: icon2_2
            width: 25
            height: 25
            anchors.left: keyInput1_2.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 25
            source: '../icons/XBY_card_logo_colored_05.svg'
            visible: clickedAddSquare2 == 1
        }
        Label {
            id: label1_2
            anchors.left: icon2_2.right
            anchors.leftMargin: 5
            anchors.verticalCenter: icon2_2.verticalCenter
            text: "XBY"
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: true
            visible: clickedAddSquare2 == 1
        }
        Image {
            source: '../icons/dropdown_icon.svg'
            width: 15
            height: 15
            anchors.left: label1_2.right
            anchors.leftMargin: 8
            anchors.verticalCenter: label1_2.verticalCenter
        }
        Controls.TextInput {
            id: keyInput1_2
            height: 34
            placeholder: "Edit Name"
            text: address_2.name
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: icon2_2.bottom
            anchors.topMargin: 20
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editAddressTracker2 == 1
        }
        Image {
            id: textFieldEmpty1_2
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput1_2.verticalCenter
            anchors.right: keyInput1_2.right
            anchors.rightMargin: 10
            width: textFieldEmpty1_2.height
            height: 12
            ColorOverlay {
                anchors.fill: textFieldEmpty1_2
                source: textFieldEmpty1_2
                color: "#727272"
            }
            Rectangle {
                id: keyInput1ButtonArea_2
                width: 20
                height: 20
                anchors.left: textFieldEmpty1_2.left
                anchors.bottom: textFieldEmpty1_2.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: keyInput1ButtonArea_2
                    onClicked: {
                        keyInput1_2.text = ""
                    }
                }
            }
        }
        Controls.TextInput {
            id: keyInput2_2
            height: 34
            placeholder: "Edit Label"
            text: addressLabel_2.text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: keyInput1_2.bottom
            anchors.topMargin: 20
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editAddressTracker2 == 1
        }
        Image {
            id: textFieldEmpty2_2
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput2_2.verticalCenter
            anchors.right: keyInput2_2.right
            anchors.rightMargin: 10
            width: textFieldEmpty2_2.height
            height: 12
            ColorOverlay {
                anchors.fill: textFieldEmpty2_2
                source: textFieldEmpty2_2
                color: "#727272"
            }
            Rectangle {
                id: keyInput2ButtonArea_2
                width: 20
                height: 20
                anchors.left: textFieldEmpty2_2.left
                anchors.bottom: textFieldEmpty2_2.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: keyInput2ButtonArea_2
                    onClicked: {
                        keyInput2_2.text = ""
                    }
                }
            }
        }
        Controls.TextInput {
            id: keyInput3_2
            height: 34
            placeholder: "Edit Address"
            text: receivingAddress2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: keyInput2_2.bottom
            anchors.topMargin: 20
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editAddressTracker2 == 1
        }
        Image {
            id: textFieldEmpty3_2
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput3_2.verticalCenter
            anchors.right: keyInput3_2.right
            anchors.rightMargin: 10
            width: textFieldEmpty3_2.height
            height: 12
            ColorOverlay {
                anchors.fill: textFieldEmpty3_2
                source: textFieldEmpty3_2
                color: "#727272"
            }
            Rectangle {
                id: keyInput3ButtonArea_2
                width: 20
                height: 20
                anchors.left: textFieldEmpty3_2.left
                anchors.bottom: textFieldEmpty3_2.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: keyInput3ButtonArea_2
                    onClicked: {
                        keyInput3_2.text = ""
                    }
                }
            }
        }
        Rectangle {
            id: editConfirm_2
            width: keyInput1_2.width
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: keyInput3_2.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editAddressTracker2 == 1
            MouseArea {
                anchors.fill: editConfirm_2

                onClicked: {
                    editAddressTracker2 = 0
                    addressName2 = keyInput1_2.text
                    addressType2 = keyInput2_2.text
                    addressLabel_2.text = keyInput2_2.text
                    receivingAddress2 = keyInput3_2.text
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

    /**
      * address 3
      */
    Controls.AddressBookSquares {
        id: address_3
        anchors.top: address_2.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        name: addressName3
        numberAddresses: 1
        height: clickedAddSquare3 == 0 ? 75 : 150

        Image {
            width: 25
            height: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }
        Rectangle {
            id: expandAddressArea_3
            width: 40
            height: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -5
            color: "transparent"
            MouseArea {
                anchors.fill: expandAddressArea_3
                onClicked: {
                    if(clickedAddSquare3 == 0){
                        clickedAddSquare3 = 1
                        return
                    }
                    if(clickedAddSquare3 == 1 ){
                        clickedAddSquare3 = 0
                        return
                    }
                }
            }
        }
        Image {
            id: icon_3
            width: 20
            height: 20
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 50
            source: '../icons/XBY_card_logo_colored_05.svg'
            visible: clickedAddSquare3 == 1
        }
        Label {
            anchors.left: icon_3.right
            anchors.leftMargin: 5
            anchors.verticalCenter: icon_3.verticalCenter
            text: "XBY"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: true
            visible: clickedAddSquare3 == 1
        }
        Label {
            id: addressLabel_3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: icon_3.verticalCenter
            text: "Main"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: true
            visible: clickedAddSquare3 == 1
        }
        Image {
            id: editAddress_3
            width: 20
            height: 20
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 50
            source: '../icons/edit.svg'
            visible: clickedAddSquare3 == 1
            ColorOverlay {
                anchors.fill: editAddress_3
                source: editAddress_3
                color: "#DADADA"
            }
            MouseArea {
                anchors.fill: editAddress_3
                onClicked: {
                    editAddressTracker3 = 1
                }
            }
        }
        Rectangle {
            id: dividerLine_3
            visible: clickedAddSquare3 == 1
            width: address_3.width - 20
            height: 1
            color: "#575757"
            anchors.top: icon_3.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle {
        id: modal_3
        height: 300
        width: 325
        color: "#42454F"
        radius: 4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
        visible: editAddressTracker3 == 1
        z: 100
        Rectangle {
            id: modalTop_3
            height: 50
            width: modal_3.width
            anchors.bottom: modal_3.top
            anchors.left: modal_3.left
            color: "#34363D"
            radius: 4
        }
        Label{
            anchors.horizontalCenter: modalTop_3.horizontalCenter
            anchors.verticalCenter: modalTop_3.verticalCenter
            color: "White"
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            font.bold: true
            text: "EDIT ADDRESS"
        }
        Image {
            id: icon2_3
            width: 25
            height: 25
            anchors.left: keyInput1_3.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 25
            source: '../icons/XBY_card_logo_colored_05.svg'
            visible: clickedAddSquare3 == 1
        }
        Label {
            id: label1_3
            anchors.left: icon2_3.right
            anchors.leftMargin: 5
            anchors.verticalCenter: icon2_3.verticalCenter
            text: "XBY"
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: true
            visible: clickedAddSquare3 == 1
        }
        Image {
            source: '../icons/dropdown_icon.svg'
            width: 15
            height: 15
            anchors.left: label1_3.right
            anchors.leftMargin: 8
            anchors.verticalCenter: label1_3.verticalCenter
        }
        Controls.TextInput {
            id: keyInput1_3
            height: 34
            placeholder: "Edit Name"
            text: address_3.name
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: icon2_3.bottom
            anchors.topMargin: 20
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editAddressTracker3 == 1
        }
        Image {
            id: textFieldEmpty1_3
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput1_3.verticalCenter
            anchors.right: keyInput1_3.right
            anchors.rightMargin: 10
            width: textFieldEmpty1_3.height
            height: 12
            ColorOverlay {
                anchors.fill: textFieldEmpty1_3
                source: textFieldEmpty1_3
                color: "#727272"
            }
            Rectangle {
                id: keyInput1ButtonArea_3
                width: 20
                height: 20
                anchors.left: textFieldEmpty1_3.left
                anchors.bottom: textFieldEmpty1_3.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: keyInput1ButtonArea_3
                    onClicked: {
                        keyInput1_3.text = ""
                    }
                }
            }
        }
        Controls.TextInput {
            id: keyInput2_3
            height: 34
            placeholder: "Edit Label"
            text: addressLabel_3.text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: keyInput1_3.bottom
            anchors.topMargin: 20
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editAddressTracker3 == 1
        }
        Image {
            id: textFieldEmpty2_3
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput2_3.verticalCenter
            anchors.right: keyInput2_3.right
            anchors.rightMargin: 10
            width: textFieldEmpty2_3.height
            height: 12
            ColorOverlay {
                anchors.fill: textFieldEmpty2_3
                source: textFieldEmpty2_3
                color: "#727272"
            }
            Rectangle {
                id: keyInput2ButtonArea_3
                width: 20
                height: 20
                anchors.left: textFieldEmpty2_3.left
                anchors.bottom: textFieldEmpty2_3.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: keyInput2ButtonArea_3
                    onClicked: {
                        keyInput2_3.text = ""
                    }
                }
            }
        }
        Controls.TextInput {
            id: keyInput3_3
            height: 34
            placeholder: "Edit Address"
            text: receivingAddress3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: keyInput2_3.bottom
            anchors.topMargin: 20
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editAddressTracker3 == 1
        }
        Image {
            id: textFieldEmpty3_3
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput3_3.verticalCenter
            anchors.right: keyInput3_3.right
            anchors.rightMargin: 10
            width: textFieldEmpty3_3.height
            height: 12
            ColorOverlay {
                anchors.fill: textFieldEmpty3_3
                source: textFieldEmpty3_3
                color: "#727272"
            }
            Rectangle {
                id: keyInput3ButtonArea_3
                width: 20
                height: 20
                anchors.left: textFieldEmpty3_3.left
                anchors.bottom: textFieldEmpty3_3.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: keyInput3ButtonArea_3
                    onClicked: {
                        keyInput3_3.text = ""
                    }
                }
            }
        }
        Rectangle {
            id: editConfirm_3
            width: keyInput1_3.width
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: keyInput3_3.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editAddressTracker3 == 1
            MouseArea {
                anchors.fill: editConfirm_3

                onClicked: {
                    editAddressTracker3 = 0
                    addressName3 = keyInput1_3.text
                    addressType3 = keyInput2_3.text
                    addressLabel_3.text = keyInput2_3.text
                    receivingAddress3 = keyInput3_3.text
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

    /**
      * address 4
      */
    Controls.AddressBookSquares {
        id: address_4
        anchors.top: address_3.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        name: addressName4
        numberAddresses: 1
        height: clickedAddSquare4 == 0 ? 75 : 150

        Image {
            width: 25
            height: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }
        Rectangle {
            id: expandAddressArea_4
            width: 40
            height: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -5
            color: "transparent"
            MouseArea {
                anchors.fill: expandAddressArea_4
                onClicked: {
                    if(clickedAddSquare4 == 0){
                        clickedAddSquare4 = 1
                        return
                    }
                    if(clickedAddSquare4 == 1 ){
                        clickedAddSquare4 = 0
                        return
                    }
                }
            }
        }
        Image {
            id: icon_4
            width: 20
            height: 20
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 50
            source: '../icons/XBY_card_logo_colored_05.svg'
            visible: clickedAddSquare4 == 1
        }
        Label {
            anchors.left: icon_4.right
            anchors.leftMargin: 5
            anchors.verticalCenter: icon_4.verticalCenter
            text: "XBY"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: true
            visible: clickedAddSquare4 == 1
        }
        Label {
            id: addressLabel_4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: icon_4.verticalCenter
            text: "Main"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: true
            visible: clickedAddSquare4 == 1
        }
        Image {
            id: editAddress_4
            width: 20
            height: 20
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 50
            source: '../icons/edit.svg'
            visible: clickedAddSquare4 == 1
            ColorOverlay {
                anchors.fill: editAddress_4
                source: editAddress_4
                color: "#DADADA"
            }
            MouseArea {
                anchors.fill: editAddress_4
                onClicked: {
                    editAddressTracker4 = 1
                }
            }
        }
        Rectangle {
            id: dividerLine_4
            visible: clickedAddSquare4 == 1
            width: address_4.width - 20
            height: 1
            color: "#575757"
            anchors.top: icon_4.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle {
        id: modal_4
        height: 300
        width: 325
        color: "#42454F"
        radius: 4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
        visible: editAddressTracker4 == 1
        z: 100
        Rectangle {
            id: modalTop_4
            height: 50
            width: modal_4.width
            anchors.bottom: modal_4.top
            anchors.left: modal_4.left
            color: "#34363D"
            radius: 4
        }
        Label{
            anchors.horizontalCenter: modalTop_4.horizontalCenter
            anchors.verticalCenter: modalTop_4.verticalCenter
            color: "White"
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            font.bold: true
            text: "EDIT ADDRESS"
        }
        Image {
            id: icon2_4
            width: 25
            height: 25
            anchors.left: keyInput1_4.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 25
            source: '../icons/XBY_card_logo_colored_05.svg'
            visible: clickedAddSquare4 == 1
        }
        Label {
            id: label1_4
            anchors.left: icon2_4.right
            anchors.leftMargin: 5
            anchors.verticalCenter: icon2_4.verticalCenter
            text: "XBY"
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: true
            visible: clickedAddSquare4 == 1
        }
        Image {
            source: '../icons/dropdown_icon.svg'
            width: 15
            height: 15
            anchors.left: label1_4.right
            anchors.leftMargin: 8
            anchors.verticalCenter: label1_4.verticalCenter
        }
        Controls.TextInput {
            id: keyInput1_4
            height: 34
            placeholder: "Edit Name"
            text: address_4.name
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: icon2_4.bottom
            anchors.topMargin: 20
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editAddressTracker4 == 1
        }
        Image {
            id: textFieldEmpty1_4
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput1_4.verticalCenter
            anchors.right: keyInput1_4.right
            anchors.rightMargin: 10
            width: textFieldEmpty1_4.height
            height: 12
            ColorOverlay {
                anchors.fill: textFieldEmpty1_4
                source: textFieldEmpty1_4
                color: "#727272"
            }
            Rectangle {
                id: keyInput1ButtonArea_4
                width: 20
                height: 20
                anchors.left: textFieldEmpty1_4.left
                anchors.bottom: textFieldEmpty1_4.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: keyInput1ButtonArea_4
                    onClicked: {
                        keyInput1_4.text = ""
                    }
                }
            }
        }
        Controls.TextInput {
            id: keyInput2_4
            height: 34
            placeholder: "Edit Label"
            text: addressLabel_4.text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: keyInput1_4.bottom
            anchors.topMargin: 20
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editAddressTracker4 == 1
        }
        Image {
            id: textFieldEmpty2_4
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput2_4.verticalCenter
            anchors.right: keyInput2_4.right
            anchors.rightMargin: 10
            width: textFieldEmpty2_4.height
            height: 12
            ColorOverlay {
                anchors.fill: textFieldEmpty2_4
                source: textFieldEmpty2_4
                color: "#727272"
            }
            Rectangle {
                id: keyInput2ButtonArea_4
                width: 20
                height: 20
                anchors.left: textFieldEmpty2_4.left
                anchors.bottom: textFieldEmpty2_4.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: keyInput2ButtonArea_4
                    onClicked: {
                        keyInput2_4.text = ""
                    }
                }
            }
        }
        Controls.TextInput {
            id: keyInput3_4
            height: 34
            placeholder: "Edit Address"
            text: receivingAddress4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: keyInput2_4.bottom
            anchors.topMargin: 20
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editAddressTracker4 == 1
        }
        Image {
            id: textFieldEmpty3_4
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput3_4.verticalCenter
            anchors.right: keyInput3_4.right
            anchors.rightMargin: 10
            width: textFieldEmpty3_4.height
            height: 12
            ColorOverlay {
                anchors.fill: textFieldEmpty3_4
                source: textFieldEmpty3_4
                color: "#727272"
            }
            Rectangle {
                id: keyInput3ButtonArea_4
                width: 20
                height: 20
                anchors.left: textFieldEmpty3_4.left
                anchors.bottom: textFieldEmpty3_4.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: keyInput3ButtonArea_4
                    onClicked: {
                        keyInput3_4.text = ""
                    }
                }
            }
        }
        Rectangle {
            id: editConfirm_4
            width: keyInput1_4.width
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: keyInput3_4.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editAddressTracker4 == 1
            MouseArea {
                anchors.fill: editConfirm_4

                onClicked: {
                    editAddressTracker4 = 0
                    addressName4 = keyInput1_4.text
                    addressType4 = keyInput2_4.text
                    addressLabel_4.text = keyInput2_4.text
                    receivingAddress4 = keyInput3_4.text
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

    /**
      * address 5
      */
    Controls.AddressBookSquares {
        id: address_5
        anchors.top: address_4.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        name: addressName5
        numberAddresses: 1
        height: clickedAddSquare5 == 0 ? 75 : 150

        Image {
            width: 25
            height: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }
        Rectangle {
            id: expandAddressArea_5
            width: 40
            height: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -5
            color: "transparent"
            MouseArea {
                anchors.fill: expandAddressArea_5
                onClicked: {
                    if(clickedAddSquare5 == 0){
                        clickedAddSquare5 = 1
                        return
                    }
                    if(clickedAddSquare5 == 1 ){
                        clickedAddSquare5 = 0
                        return
                    }
                }
            }
        }
        Image {
            id: icon_5
            width: 20
            height: 20
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 50
            source: '../icons/XBY_card_logo_colored_05.svg'
            visible: clickedAddSquare5 == 1
        }
        Label {
            anchors.left: icon_5.right
            anchors.leftMargin: 5
            anchors.verticalCenter: icon_5.verticalCenter
            text: "XBY"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: true
            visible: clickedAddSquare5 == 1
        }
        Label {
            id: addressLabel_5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: icon_5.verticalCenter
            text: "Main"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: true
            visible: clickedAddSquare5 == 1
        }
        Image {
            id: editAddress_5
            width: 20
            height: 20
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 50
            source: '../icons/edit.svg'
            visible: clickedAddSquare5 == 1
            ColorOverlay {
                anchors.fill: editAddress_5
                source: editAddress_5
                color: "#DADADA"
            }
            MouseArea {
                anchors.fill: editAddress_5
                onClicked: {
                    editAddressTracker5 = 1
                }
            }
        }
        Rectangle {
            id: dividerLine_5
            visible: clickedAddSquare5 == 1
            width: address_5.width - 20
            height: 1
            color: "#575757"
            anchors.top: icon_5.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle {
        id: modal_5
        height: 300
        width: 325
        color: "#42454F"
        radius: 4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
        visible: editAddressTracker5 == 1
        z: 100
        Rectangle {
            id: modalTop_5
            height: 50
            width: modal_5.width
            anchors.bottom: modal_5.top
            anchors.left: modal_5.left
            color: "#34363D"
            radius: 4
        }
        Label{
            anchors.horizontalCenter: modalTop_5.horizontalCenter
            anchors.verticalCenter: modalTop_5.verticalCenter
            color: "White"
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            font.bold: true
            text: "EDIT ADDRESS"
        }
        Image {
            id: icon2_5
            width: 25
            height: 25
            anchors.left: keyInput1_5.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 25
            source: '../icons/XBY_card_logo_colored_05.svg'
            visible: clickedAddSquare5 == 1
        }
        Label {
            id: label1_5
            anchors.left: icon2_5.right
            anchors.leftMargin: 5
            anchors.verticalCenter: icon2_5.verticalCenter
            text: "XBY"
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            color: "#E5E5E5"
            font.bold: true
            visible: clickedAddSquare5 == 1
        }
        Image {
            source: '../icons/dropdown_icon.svg'
            width: 15
            height: 15
            anchors.left: label1_5.right
            anchors.leftMargin: 8
            anchors.verticalCenter: label1_5.verticalCenter
        }
        Controls.TextInput {
            id: keyInput1_5
            height: 34
            placeholder: "Edit Name"
            text: address_5.name
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: icon2_5.bottom
            anchors.topMargin: 20
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editAddressTracker5 == 1
        }
        Image {
            id: textFieldEmpty1_5
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput1_5.verticalCenter
            anchors.right: keyInput1_5.right
            anchors.rightMargin: 10
            width: textFieldEmpty1_5.height
            height: 12
            ColorOverlay {
                anchors.fill: textFieldEmpty1_5
                source: textFieldEmpty1_5
                color: "#727272"
            }
            Rectangle {
                id: keyInput1ButtonArea_5
                width: 20
                height: 20
                anchors.left: textFieldEmpty1_5.left
                anchors.bottom: textFieldEmpty1_5.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: keyInput1ButtonArea_5
                    onClicked: {
                        keyInput1_5.text = ""
                    }
                }
            }
        }
        Controls.TextInput {
            id: keyInput2_5
            height: 34
            placeholder: "Edit Label"
            text: addressLabel_5.text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: keyInput1_5.bottom
            anchors.topMargin: 20
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editAddressTracker5 == 1
        }
        Image {
            id: textFieldEmpty2_5
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput2_5.verticalCenter
            anchors.right: keyInput2_5.right
            anchors.rightMargin: 10
            width: textFieldEmpty2_5.height
            height: 12
            ColorOverlay {
                anchors.fill: textFieldEmpty2_5
                source: textFieldEmpty2_5
                color: "#727272"
            }
            Rectangle {
                id: keyInput2ButtonArea_5
                width: 20
                height: 20
                anchors.left: textFieldEmpty2_5.left
                anchors.bottom: textFieldEmpty2_5.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: keyInput2ButtonArea_5
                    onClicked: {
                        keyInput2_5.text = ""
                    }
                }
            }
        }
        Controls.TextInput {
            id: keyInput3_5
            height: 34
            placeholder: "Edit Address"
            text: receivingAddress5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: keyInput2_5.bottom
            anchors.topMargin: 20
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: editAddressTracker5 == 1
        }
        Image {
            id: textFieldEmpty3_5
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput3_5.verticalCenter
            anchors.right: keyInput3_5.right
            anchors.rightMargin: 10
            width: textFieldEmpty3_5.height
            height: 12
            ColorOverlay {
                anchors.fill: textFieldEmpty3_5
                source: textFieldEmpty3_5
                color: "#727272"
            }
            Rectangle {
                id: keyInput3ButtonArea_5
                width: 20
                height: 20
                anchors.left: textFieldEmpty3_5.left
                anchors.bottom: textFieldEmpty3_5.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: keyInput3ButtonArea_5
                    onClicked: {
                        keyInput3_5.text = ""
                    }
                }
            }
        }
        Rectangle {
            id: editConfirm_5
            width: keyInput1_5.width
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: keyInput3_5.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editAddressTracker5 == 1
            MouseArea {
                anchors.fill: editConfirm_5

                onClicked: {
                    editAddressTracker5 = 0
                    addressName5 = keyInput1_5.text
                    addressType5 = keyInput2_5.text
                    addressLabel_5.text = keyInput2_5.text
                    receivingAddress5 = keyInput3_5.text
                }
            }
            // done
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
}
