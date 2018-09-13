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
import QZXing 2.3

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
        visible: transferTracker == 1 || appsTracker == 1 || editAddressTracker == 1 || editAddressTracker2 == 1 || editAddressTracker3 == 1 || editAddressTracker4 == 1 || editAddressTracker5 == 1
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
            source: '../icons/add_icon_03.svg'
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
      * Transfer Modal popup
      */
    Rectangle {
        id: transferModal
        // parent.height > 800 ? (parent.height - 400) :
        height: 425
        // parent.width - 50
        width: 325
        color: "#42454F"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
        visible: transferTracker == 1 && addressBookTracker != 1
                 && scanQRCodeTracker != 1 && transactionConfirmTracker != 1 && transactionSentTracker != 1
        radius: 4
        z: 100

        Rectangle {
            id: transferModalTop
            height: 50
            width: transferModal.width
            anchors.top: transferModal.top
            anchors.left: transferModal.left
            color: "#34363D"
            radius: 4
            Text {
                text: "TRANSFER"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#F2F2F2"
                font.family: "Brandon Grotesque"
                font.bold: true
                font.pixelSize: 15
            }
            Image {
                id: closeModal
                source: '../icons/CloseIcon.svg'
                anchors.bottom: transferModalTop.bottom
                anchors.bottomMargin: 15
                anchors.right: transferModalTop.right
                anchors.rightMargin: 30
                width: 20
                height: 20
                ColorOverlay {
                    anchors.fill: closeModal
                    source: closeModal
                    color: "white"
                }
                Rectangle {
                    id: closeModalButtonArea
                    width: 20
                    height: 20
                    anchors.left: closeModal.left
                    anchors.bottom: closeModal.bottom
                    color: "transparent"
                    MouseArea {
                        anchors.fill: closeModalButtonArea
                        onClicked:{
                            transferTracker = 0
                            sendAmount.text = ""
                            keyInput.text = ""
                            referenceInput.text = ""
                        }
                    }
                }
            }
        }
        Controls.Switch {
            id: transferSwitch
            anchors.horizontalCenter: transferModal.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 60

            Text {
                id: receiveText
                text: qsTr("RECEIVE")
                anchors.right: transferSwitch.left
                anchors.rightMargin: 7
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 13
                color: transferSwitch.on ? "#5F5F5F" : "#5E8BFE"
            }
            Text {
                id: sendText
                text: qsTr("SEND")
                anchors.left: transferSwitch.right
                anchors.leftMargin: 7
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 13
                color: transferSwitch.on ? "#5E8BFE" : "#5F5F5F"
            }
        }

        /**
          * Transfer Modal both send & receive
          */
        Image {
            id: currencyIcon
            source: '../icons/XBY_card_logo_colored_05.svg'
            width: 25
            height: 25
            anchors.left: sendAmount.left
            anchors.top: transferModal.top
            anchors.topMargin: 100
            visible: transferTracker == 1
            Label {
                id: currencyIconChild
                text: "XBY"
                anchors.left: currencyIcon.right
                anchors.leftMargin: 10
                color: "#E5E5E5"
                font.bold: true
                anchors.verticalCenter: currencyIcon.verticalCenter
            }
            Image {
                source: '../icons/dropdown_icon.svg'
                width: 15
                height: 15
                anchors.left: currencyIconChild.right
                anchors.leftMargin: 8
                anchors.verticalCenter: currencyIconChild.verticalCenter
                visible: transferTracker == 1
            }
        }
        Label {
            id: walletChoice
            text: "MAIN"
            anchors.right: walletDropdown.left
            anchors.rightMargin: 8
            anchors.verticalCenter: currencyIcon.verticalCenter
            color: "#E5E5E5"
            font.bold: true
            visible: transferTracker == 1
        }
        Image {
            id: walletDropdown
            source: '../icons/dropdown_icon.svg'
            width: 15
            height: 15
            anchors.right: sendAmount.right
            anchors.verticalCenter: walletChoice.verticalCenter
            visible: transferTracker == 1
        }
        /**
          * Transfer modal receive state
          */
        Item {
            id: qrPlaceholder
            width: 180
            height: 170
            anchors.horizontalCenter: qrBorder.horizontalCenter
            anchors.verticalCenter: qrBorder.verticalCenter
            z: 10
            visible: transferSwitch.on === false && transferTracker == 1
            Image {
                anchors.fill: parent
                source: "image://QZXing/encode/" + publicKey.text
                cache: false
            }
        }
        Rectangle {
            id: qrBorder
            radius: 8
            width: 210
            height: 200
            visible: transferSwitch.on === false && transferTracker == 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: currencyIcon.bottom
            anchors.topMargin: 20
            color: "white"
        }

        Text {
            id: pubKey
            text: "PUBLIC KEY"
            anchors.top: qrBorder.bottom
            anchors.topMargin: 21
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: true
            font.pixelSize: 13
            visible: transferSwitch.on ===  false && transferTracker == 1
        }
        Text {
            id: publicKey
            text: receivingAddress
            anchors.top: pubKey.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: pubKey.horizontalCenter
            color: "white"
            font.family: "Brandon Grotesque"
            font.pixelSize: 12
            visible: transferSwitch.on ===  false && transferTracker == 1
        }
        Image {
            id: pasteIcon
            source: '../icons/paste_icon.svg'
            width: 15
            height: 15
            anchors.left: publicKey.right
            anchors.leftMargin: 5
            anchors.verticalCenter: publicKey.verticalCenter
            visible: transferSwitch.on ===  false && transferTracker == 1
            ColorOverlay {
                anchors.fill: pasteIcon
                source: pasteIcon
                color: "white" // make image like it lays under grey glass
            }
        }

        /**
          * Transfer modal send state
          */
        Label {
            id: walletBalance
            text: wallet.balance.toLocaleString(
                      Qt.locale(), "f", 4) + " XBY"
            anchors.right: walletDropdown.right
            anchors.rightMargin: 0
            anchors.top: walletChoice.bottom
            anchors.topMargin: 1
            color: "#E5E5E5"
            font.bold: true
            font.pixelSize: 10
            visible: transferTracker == 1 && transferSwitch.on ===  true
        }
        Controls.TextInput {
            id: sendAmount
            height: 34
            placeholder: "AMOUNT (XBY)"
            validator: DoubleValidator {
                bottom: 0
            }
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: currencyIcon.bottom
            anchors.topMargin: 15
            visible: transferTracker == 1 && transferSwitch.on ===  true
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            mobile: 1
        }
        Image {
            id: transferTextFieldEmpty3
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: sendAmount.verticalCenter
            anchors.right: sendAmount.right
            anchors.rightMargin: 10
            width: transferTextFieldEmpty3.height
            height: 12
            visible: transferTracker == 1 && transferSwitch.on ===  true
            ColorOverlay {
                anchors.fill: transferTextFieldEmpty3
                source: transferTextFieldEmpty3
                color: "#727272"
            }
            Rectangle {
                id: transferTextFieldEmpty3ButtonArea
                width: 20
                height: 20
                anchors.left: transferTextFieldEmpty3.left
                anchors.bottom: transferTextFieldEmpty3.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: transferTextFieldEmpty3ButtonArea
                    onClicked: {
                        sendAmount.text = ""
                    }
                }
            }
        }
        Controls.TextInput {
            id: keyInput
            height: 34
            placeholder: "SEND TO (PUBLIC KEY)"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: sendAmount.bottom
            anchors.topMargin: 15
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: transferTracker == 1 && transferSwitch.on ===  true
            mobile: 1
        }
        Image {
            id: transferTextFieldEmpty1
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: keyInput.verticalCenter
            anchors.right: keyInput.right
            anchors.rightMargin: 10
            width: transferTextFieldEmpty1.height
            height: 12
            visible: transferTracker == 1 && transferSwitch.on ===  true
            ColorOverlay {
                anchors.fill: transferTextFieldEmpty1
                source: transferTextFieldEmpty1
                color: "#727272" // make image like it lays under grey glass
            }
            Rectangle {
                id: transferTextFieldEmpty1ButtonArea
                width: 20
                height: 20
                anchors.left: transferTextFieldEmpty1.left
                anchors.bottom: transferTextFieldEmpty1.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: transferTextFieldEmpty1ButtonArea
                    onClicked: {
                        keyInput.text = ""
                    }
                }
            }
        }
        Rectangle {
            id: scanQrButton
            visible: transferTracker == 1 && transferSwitch.on ===  true
            width: (keyInput.width / 2) - 3
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: keyInput.bottom
            anchors.topMargin: 15
            anchors.left: keyInput.left
            MouseArea {
                anchors.fill: scanQrButton
                onClicked: {
                    scanQRCodeTracker = 1
                }
            }
            Text {
                text: "SCAN QR"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#5E8BFF"
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: addressBookButton
            visible: transferTracker == 1 && transferSwitch.on ===  true
            width: (keyInput.width / 2) - 3
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: keyInput.bottom
            anchors.topMargin: 15
            anchors.right: keyInput.right
            MouseArea {
                anchors.fill: addressBookButton

                onClicked: {
                    addressBookTracker = 1
                }
            }
            Text {
                text: "ADDRESS BOOK"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Controls.TextInput {
            id: referenceInput
            height: 34
            placeholder: "REFERENCE"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: scanQrButton.bottom
            anchors.topMargin: 15
            color: "#727272"
            font.pixelSize: 11
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: transferTracker == 1 && transferSwitch.on ===  true
            mobile: 1
        }
        Image {
            id: transferTextFieldEmpty2
            source: '../icons/CloseIcon.svg'
            anchors.verticalCenter: referenceInput.verticalCenter
            anchors.right: referenceInput.right
            anchors.rightMargin: 10
            width: transferTextFieldEmpty2.height
            height: 12
            visible: transferTracker == 1 && transferSwitch.on ===  true
            ColorOverlay {
                anchors.fill: transferTextFieldEmpty2
                source: transferTextFieldEmpty2
                color: "#727272"
            }
            Rectangle {
                id: transferTextFieldEmpty2ButtonArea
                width: 20
                height: 20
                anchors.left: transferTextFieldEmpty2.left
                anchors.bottom: transferTextFieldEmpty2.bottom
                color: "transparent"
                MouseArea {
                    anchors.fill: transferTextFieldEmpty2ButtonArea
                    onClicked: {
                        referenceInput.text = ""
                    }
                }
            }
        }
        Rectangle {
            id: sendButton
            visible: transferTracker == 1 && transferSwitch.on ===  true
            width: keyInput.width
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: referenceInput.bottom
            anchors.topMargin: 35
            anchors.left: referenceInput.left
            MouseArea {
                anchors.fill: sendButton

                onClicked: {
                    transactionConfirmTracker = 1
                }
            }
            Text {
                text: "SEND"
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
      * Modal for confirming your transaction
    */
    Rectangle {
        id: transactionConfirmationModal
        // parent.height > 800 ? (parent.height - 400) :
        height: 300
        // parent.width - 50
        width: 325
        color: "#42454F"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
        visible: transactionConfirmTracker == 1
        radius: 4
        z: 300

        Rectangle {
            id: transactionConfirmationModalTop
            height: 50
            width: transactionConfirmationModal.width
            anchors.top: transactionConfirmationModal.top
            anchors.left: transactionConfirmationModal.left
            color: "#34363D"
            radius: 4

            Text {
                text: "TRANSFER"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#F2F2F2"
                font.family: "Brandon Grotesque"
                font.bold: true
                font.pixelSize: 15
            }
            Image {
                id: transactionConfirmationCloseModal
                source: '../icons/CloseIcon.svg'
                anchors.bottom: transactionConfirmationModalTop.bottom
                anchors.bottomMargin: 15
                anchors.right: transactionConfirmationModalTop.right
                anchors.rightMargin: 30
                width: 20
                height: 20
                ColorOverlay {
                    anchors.fill: transactionConfirmationCloseModal
                    source: transactionConfirmationCloseModal
                    color: "white"
                }
                Rectangle {
                    id: transactionConfirmationCloseModalButtonArea
                    width: 20
                    height: 20
                    anchors.left: transactionConfirmationCloseModal.left
                    anchors.bottom: transactionConfirmationCloseModal.bottom
                    color: "transparent"
                    MouseArea {
                        anchors.fill: transactionConfirmationCloseModalButtonArea
                        onClicked:{
                            transactionConfirmTracker = 0
                        }
                    }
                }
            }
        }
        Text {
            id: confirm
            text: "Confirm Payment"
            font.family: "Brandon Grotesque"
            font.pointSize: 15
            font.bold: false
            color: "#5E8BFF"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 65
        }
        Text {
            id: confirm2
            text: "You are about to send"
            font.family: "Brandon Grotesque"
            font.pointSize: 13
            font.bold: false
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: confirm.bottom
            anchors.topMargin: 30
        }
        Text {
            id: confirm3
            text: sendAmount.text + " XBY"
            font.family: "Brandon Grotesque"
            font.pointSize: 13
            font.bold: true
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: confirm2.bottom
            anchors.topMargin: 10
        }
        Text {
            id: confirm4
            text: "to"
            font.family: "Brandon Grotesque"
            font.pointSize: 13
            font.bold: false
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: confirm3.bottom
            anchors.topMargin: 20
        }
        Text {
            id: confirm5
            text: keyInput.text
            font.family: "Brandon Grotesque"
            font.pointSize: 13
            font.bold: true
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: confirm4.bottom
            anchors.topMargin: 20
        }
        Rectangle {
            id: confirmButton
            width: confirm5.width
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: confirm5.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: keyInput.text !== "" && keyInput.length === 34  && sendAmount.text !== "" && sendAmount.text !== "0" && sendAmount.text < wallet.balance
            MouseArea {
                anchors.fill: confirmButton

                onClicked: {
                    transactionSentTracker = 1
                    transactionConfirmTracker = 0
                }
            }
            Text {
                text: "CONFIRM"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: validationAlert
            width: 200
            height: 33
            radius: 8
            //red
            border.color: "#f45342"
            border.width: 2
            color: "transparent"
            anchors.top: confirm5.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: keyInput.text === "" || keyInput.length !== 34  || sendAmount.text === "" || sendAmount.text === "0" || sendAmount.text > wallet.balance
            MouseArea {
                anchors.fill: validationAlert

                onClicked: {
                    transactionSentTracker = 0
                    transactionConfirmTracker = 0
                }
            }
            Text {
                id: validationText
                text: "Invalid Amount or Key"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#f45342"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    /**
      * Modal for confirming transfer went through
      */
    Controls.TransactionSentModal{
        visible: transactionSentTracker == 1
        Rectangle {
            id: transactionSentClose
            width: (parent.height/4) + 40
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                anchors.fill: transactionSentClose

                onClicked: {
                    transactionSentTracker = 0
                    transferTracker = 1
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
      * AddressBookModal
      */
    Rectangle {
        id: addressBookModal
        height: 287
        // parent.width - 50
        width: 325
        color: "#42454F"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
        visible: addressBookTracker == 1
        radius: 4
        z: 155

        Rectangle {
            id: addressBookModalTop
            height: 50
            width: addressBookModal.width
            anchors.top: addressBookModal.top
            anchors.left: addressBookModal.left
            color: "#34363D"
            radius: 4
            Text {
                text: "ADDRESS BOOK"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#F2F2F2"
                font.family: "Brandon Grotesque"
                font.bold: true
                font.pixelSize: 15
            }
            Image {
                id: closeAddressBookModal
                source: '../icons/CloseIcon.svg'
                anchors.bottom: addressBookModalTop.bottom
                anchors.bottomMargin: 15
                anchors.right: addressBookModalTop.right
                anchors.rightMargin: 30
                width: 20
                height: 20
                ColorOverlay {
                    anchors.fill: closeAddressBookModal
                    source: closeAddressBookModal
                    color: "white" // make image like it lays under grey glass
                }
                Rectangle {
                    id: closeAddressBookModalButtonArea
                    width: 20
                    height: 20
                    anchors.left: closeAddressBookModal.left
                    anchors.bottom: closeAddressBookModal.bottom
                    color: "transparent"
                    MouseArea {
                        anchors.fill: closeAddressBookModalButtonArea
                        onClicked: addressBookTracker = 0
                    }
                }
            }
        }
        Image {
            id: addressIcon
            source: '../icons/XBY_card_logo_colored_05.svg'
            anchors.left: addressBookModal.left
            anchors.leftMargin: 30
            anchors.top: addressBookModal.top
            anchors.topMargin: 70
            width: 27
            height: 27
        }
        Text {
            id: addressIconName
            text: "XBY"
            anchors.verticalCenter: addressIcon.verticalCenter
            anchors.left: addressIcon.right
            anchors.leftMargin: 8
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: true
            font.pixelSize: 14
        }
        Image {
            source: '../icons/dropdown_icon.svg'
            width: 15
            height: 15
            anchors.left: addressIconName.right
            anchors.leftMargin: 8
            anchors.verticalCenter: addressIconName.verticalCenter
        }

        Rectangle {
            id: seperator1
            color: "#575757"
            height: 1
            width: parent.width - 50
            anchors.top: addressIcon.bottom
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: addressName1
            anchors.bottom: seperator1.top
            anchors.bottomMargin: 8
            anchors.left: seperator1.left
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Text {
            text: addressType1
            anchors.bottom: seperator1.top
            anchors.bottomMargin: 8
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Image {
            id: transferChoice1
            anchors.right: seperator1.right
            anchors.rightMargin: 10
            anchors.bottom: seperator1.top
            anchors.bottomMargin: 8
            source: '../icons/transfer_icon.svg'
            width: 14
            height: 14
            MouseArea {
                anchors.fill: transferChoice1
                onClicked: {
                    keyInput.text = receivingAddress
                    addressBookTracker = 0
                }
            }
        }
        Rectangle {
            id: seperator2
            color: "#575757"
            height: 1
            width: parent.width - 50
            anchors.top: seperator1.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: addressName2
            anchors.bottom: seperator2.top
            anchors.bottomMargin: 8
            anchors.left: seperator2.left
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Text {
            text: addressType2
            anchors.bottom: seperator2.top
            anchors.bottomMargin: 8
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Image {
            id: transferChoice2
            anchors.right: seperator2.right
            anchors.rightMargin: 10
            anchors.bottom: seperator2.top
            anchors.bottomMargin: 8
            source: '../icons/transfer_icon.svg'
            width: 14
            height: 14
            MouseArea {
                anchors.fill: transferChoice2
                onClicked: {
                    keyInput.text = receivingAddress2
                    addressBookTracker = 0
                }
            }
        }
        Rectangle {
            id: seperator3
            color: "#575757"
            height: 1
            width: parent.width - 50
            anchors.top: seperator2.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: addressName3
            anchors.bottom: seperator3.top
            anchors.bottomMargin: 8
            anchors.left: seperator3.left
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Text {
            text: addressType3
            anchors.bottom: seperator3.top
            anchors.bottomMargin: 8
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Image {
            id: transferChoice3
            anchors.right: seperator3.right
            anchors.rightMargin: 10
            anchors.bottom: seperator3.top
            anchors.bottomMargin: 8
            source: '../icons/transfer_icon.svg'
            width: 14
            height: 14
            MouseArea {
                anchors.fill: transferChoice3
                onClicked: {
                    keyInput.text = receivingAddress3
                    addressBookTracker = 0
                }
            }
        }
        Rectangle {
            id: seperator4
            color: "#575757"
            height: 1
            width: parent.width - 50
            anchors.top: seperator3.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: addressName4
            anchors.bottom: seperator4.top
            anchors.bottomMargin: 8
            anchors.left: seperator4.left
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Text {
            text: addressType4
            anchors.bottom: seperator4.top
            anchors.bottomMargin: 8
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Image {
            id: transferChoice4
            anchors.right: seperator4.right
            anchors.rightMargin: 10
            anchors.bottom: seperator4.top
            anchors.bottomMargin: 8
            source: '../icons/transfer_icon.svg'
            width: 14
            height: 14
            MouseArea {
                anchors.fill: transferChoice4
                onClicked: {
                    keyInput.text = receivingAddress4
                    addressBookTracker = 0
                }
            }
        }
        Rectangle {
            id: seperator5
            color: "#575757"
            height: 1
            width: parent.width - 50
            anchors.top: seperator4.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: addressName5
            anchors.bottom: seperator5.top
            anchors.bottomMargin: 8
            anchors.left: seperator5.left
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Text {
            text: addressType5
            anchors.bottom: seperator5.top
            anchors.bottomMargin: 8
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 10
        }
        Image {
            id: transferChoice5
            anchors.right: seperator5.right
            anchors.rightMargin: 10
            anchors.bottom: seperator5.top
            anchors.bottomMargin: 8
            source: '../icons/transfer_icon.svg'
            width: 14
            height: 14
            MouseArea {
                anchors.fill: transferChoice5
                onClicked: {
                    keyInput.text = receivingAddress5
                    addressBookTracker = 0
                }
            }
        }
    }
    /**
      * scanQRBookModal
      */
    Rectangle {
        id: scanQRModal
        // parent.height > 800 ? (parent.height - 400) :
        height: 425
        // parent.width - 50
        width: 325
        color: "#42454F"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
        visible: scanQRCodeTracker == 1
        radius: 4
        z: 155
        Item {
            visible: scanQRCodeTracker == 1
            z: 200
            /**
              * Commenting camera out for now, we'll cover full implementation of this in a seperate PR
            Camera {
                id: camera
                imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

                exposure {
                    exposureCompensation: -1.0
                    exposureMode: Camera.ExposurePortrait
                }

                flash.mode: Camera.FlashRedEyeReduction
                imageCapture {
                    onImageCaptured: {
                        imageToDecode.source = preview
                        decoder.decodeImageQML(imageToDecode)
                    }
                }
            }
            VideoOutput {
                source: camera
                z: 200
                width: 300
                height: 300
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                focus: visible // to receive focus and capture key events when visible
            }

            Image {
                id: imageToDecode
                visible: false
            }
            */
        }

        QZXing {
            id: decoder
            enabledDecoders: QZXing.DecoderFormat_QR_CODE
            onDecodingStarted: console.log("Decoding of image started...")
            onTagFound: {

                console.log("Barcode data: " + tag)
                keyInput.text = tag
            }
            onDecodingFinished: console.log(
                                    "Decoding finished "
                                    + (succeeded == true ? "successfully" : "unsuccessfully"))
        }

        Rectangle {
            id: scanQRModalTop
            height: 50
            width: scanQRModal.width
            anchors.top: scanQRModal.top
            anchors.left: scanQRModal.left
            color: "#34363D"
            radius: 4
            Text {
                text: "SCAN QR CODE"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#F2F2F2"
                font.family: "Brandon Grotesque"
                font.bold: true
                font.pixelSize: 15
            }
            Image {
                id: scanQRBookModalClose
                source: '../icons/CloseIcon.svg'
                anchors.bottom: scanQRModalTop.bottom
                anchors.bottomMargin: 15
                anchors.right: scanQRModalTop.right
                anchors.rightMargin: 30
                width: 20
                height: 20
                ColorOverlay {
                    anchors.fill: scanQRBookModalClose
                    source: scanQRBookModalClose
                    color: "white" // make image like it lays under grey glass
                }
                Rectangle {
                    id: scanQRModalButtonArea
                    width: 20
                    height: 20
                    anchors.left: scanQRBookModalClose.left
                    anchors.bottom: scanQRBookModalClose.bottom
                    color: "transparent"
                    MouseArea {
                        anchors.fill: scanQRModalButtonArea
                        onClicked: scanQRCodeTracker = 0
                    }
                }
            }
        }
    }

    /**
      * Bottom pieces
      */
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
