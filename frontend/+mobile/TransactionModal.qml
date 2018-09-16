/**
 * Filename: TransactionModal.qml
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
  * Transfer Modal Popup
  */
Rectangle {
    id: modal
    // parent.height > 800 ? (parent.height - 400) :
    height: 425
    // parent.width - 50
    width: 325
    color: "#42454F"
    visible: transferTracker == 1 && addressBookTracker != 1
             && scanQRCodeTracker != 1 && transactionConfirmTracker != 1 && transactionSentTracker != 1
    radius: 4
    z: 1000

    Rectangle {
        id: modalTop
        height: 50
        width: modal.width
        anchors.top: modal.top
        anchors.left: modal.left
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
            anchors.bottom: modalTop.bottom
            anchors.bottomMargin: 15
            anchors.right: modalTop.right
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
        anchors.horizontalCenter: modal.horizontalCenter
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
        anchors.top: modal.top
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
        id: textFieldEmpty3
        source: '../icons/CloseIcon.svg'
        anchors.verticalCenter: sendAmount.verticalCenter
        anchors.right: sendAmount.right
        anchors.rightMargin: 10
        width: textFieldEmpty3.height
        height: 12
        visible: transferTracker == 1 && transferSwitch.on ===  true
        ColorOverlay {
            anchors.fill: textFieldEmpty3
            source: textFieldEmpty3
            color: "#727272"
        }
        Rectangle {
            id: textFieldEmpty3ButtonArea
            width: 20
            height: 20
            anchors.left: textFieldEmpty3.left
            anchors.bottom: textFieldEmpty3.bottom
            color: "transparent"
            MouseArea {
                anchors.fill: textFieldEmpty3ButtonArea
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
        id: textFieldEmpty1
        source: '../icons/CloseIcon.svg'
        anchors.verticalCenter: keyInput.verticalCenter
        anchors.right: keyInput.right
        anchors.rightMargin: 10
        width: textFieldEmpty1.height
        height: 12
        visible: transferTracker == 1 && transferSwitch.on ===  true
        ColorOverlay {
            anchors.fill: textFieldEmpty1
            source: textFieldEmpty1
            color: "#727272" // make image like it lays under grey glass
        }
        Rectangle {
            id: textFieldEmpty1ButtonArea
            width: 20
            height: 20
            anchors.left: textFieldEmpty1.left
            anchors.bottom: textFieldEmpty1.bottom
            color: "transparent"
            MouseArea {
                anchors.fill: textFieldEmpty1ButtonArea
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
        id: textFieldEmpty2
        source: '../icons/CloseIcon.svg'
        anchors.verticalCenter: referenceInput.verticalCenter
        anchors.right: referenceInput.right
        anchors.rightMargin: 10
        width: textFieldEmpty2.height
        height: 12
        visible: transferTracker == 1 && transferSwitch.on ===  true
        ColorOverlay {
            anchors.fill: textFieldEmpty2
            source: textFieldEmpty2
            color: "#727272"
        }
        Rectangle {
            id: textFieldEmpty2ButtonArea
            width: 20
            height: 20
            anchors.left: textFieldEmpty2.left
            anchors.bottom: textFieldEmpty2.bottom
            color: "transparent"
            MouseArea {
                anchors.fill: textFieldEmpty2ButtonArea
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
}
