import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQrCode.Component 1.0

import "../../Controls" as Controls
import "../../Theme" 1.0

Controls.Diode {
    id: receiveCoinsDiode

    title: qsTr("RECEIVE COINS")
    menuLabelText: qsTr("XBY")

    Connections {
        target: accountCreateForm
        onConfirmed: {
            testnetGetAccountAddress(newItem.name)
            accountCreateForm.close()
        }

        onCancelled: {
            accountCreateForm.close()
        }
    }

    RowLayout {
        anchors.topMargin: diodeHeaderHeight + 15
        anchors.fill: parent

        // Form
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 264
            Layout.maximumWidth: 550
            Layout.leftMargin: 20
            Layout.topMargin: 20
            Layout.bottomMargin: 20
            Layout.rightMargin: 10
            Layout.alignment: Qt.AlignTop

            Controls.FormLabel {
                Layout.bottomMargin: 25
                text: qsTr("Main")
            }

            Controls.TextInput {
                Layout.fillWidth: true
                id: formAddress
                readOnly: true
            }

            RowLayout {
                Layout.topMargin: 6

                Label {
                    id: copyPasteButton

                    readonly property string defaultText: qsTr("Copy to clipboard")
                    readonly property string altText: qsTr("Address copied!")
                    readonly property string defaultIcon: "../../icons/copy-clipboard.svg"
                    readonly property string altIcon: "../../icons/circle-cross.svg"
                    property bool isActive: false

                    font.pixelSize: 12
                    font.weight: isActive ? Font.Bold : Font.Normal
                    text: isActive ? altText : defaultText
                    color: isActive ? "#ffffff" : "#E3E3E3"
                    leftPadding: 24

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            copyTextTimer.start()
                            clipboard.text = formAddress.text
                            parent.isActive = true
                        }
                    }

                    Image {
                        id: copyImage
                        fillMode: Image.PreserveAspectFit
                        source: parent.isActive ? parent.altIcon : parent.defaultIcon
                        width: 25
                        sourceSize.width: 15
                        sourceSize.height: 13
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: parent.Center
                        anchors.rightMargin: 5

                        Timer {
                            id: copyTextTimer
                            interval: 1500
                            running: false
                            repeat: false
                            onTriggered: copyPasteButton.isActive = false
                        }
                    }
                }

                Label {
                    Layout.fillWidth: true
                    font.weight: Font.Light
                    visible: xcite.width > 1100
                    color: "#E3E3E3"
                    horizontalAlignment: Text.AlignRight
                    rightPadding: 20
                    font.pixelSize: 12

                    text: qsTr("Or choose another address from your list")

                    Image {
                        fillMode: Image.PreserveAspectFit
                        source: "../../icons/right-arrow2.svg"
                        width: 19
                        height: 13
                        sourceSize.width: 19
                        sourceSize.height: 13
                        anchors.right: parent.right
                    }
                }
            }

            Controls.FormLabel {
                Layout.topMargin: 40
                Layout.bottomMargin: 25
                text: qsTr("QR Code")
            }

            Label {
                font.pixelSize: 12
                text: qsTr("Send money to this address by scanning QR code")
                color: "#E3E3E3"
            }

            QtQrCode {
                Layout.topMargin: 25
                Layout.bottomMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter
                data: formAddress.text
                background: "transparent"
                foreground: Theme.primaryHighlight
                width: 240
                height: 240
            }
        }

        Rectangle {
            visible: xcite.width > 1275
            Layout.fillHeight: true
            Layout.bottomMargin: 20
            Layout.leftMargin: 10
            Layout.rightMargin: 5
            width: 1
            color: "#535353"
        }

        // Address Book
        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 197
            clip: true
            Layout.topMargin: 20
            Layout.bottomMargin: 20
            Layout.rightMargin: 20
            Layout.leftMargin: 10
            Layout.alignment: Qt.AlignTop
            Layout.maximumHeight: 504

            Controls.FormLabel {
                text: qsTr("Address Book")
                Layout.bottomMargin: 25
            }

            Rectangle {
                id: addressBookContainer

                Layout.fillHeight: true
                Layout.fillWidth: true

                radius: 4
                color: "#2A2C31"

                Controls.AddressBook {
                    id: addressBook
                    model: wallet.accounts

                    Connections {
                        Component.onCompleted: {
                            addressBook.add(
                                        "",
                                        "BMy2BpwyJc5i7upNm5Vv8HMkwXqBR3kCxS")
                            addressBook.add(
                                        "Main",
                                        "Jc5i7upNmBMy2Bpwy5Vv8HMkwXqBR3kCxS")
                            addressBook.add(
                                        "Secondary",
                                        "upNm5Vv8HMkBMy2BpwyJc5i7wXqBR3kCxS")
                            addressBook.currentIndex = 0
                        }
                    }

                    Connections {
                        target: wallet.accounts
                        onSetCurrentIndex: {
                            addressBook.currentIndex = idx
                        }
                    }

                    Connections {
                        target: addressBook.model
                        onDataChanged: {
                            selectItem(addressBook.getSelectedItem())
                        }
                    }

                    onCurrentItemChanged: {
                        var item = addressBook.getSelectedItem()

                        if (item.address === '') {
                            testnetGetAccountAddress(item.name)
                            item = addressBook.getSelectedItem()
                        }

                        selectItem(item)
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.topMargin: 10
                Layout.maximumHeight: 29
                Layout.minimumHeight: 29
                Layout.alignment: Qt.AlignLeft

                Controls.AddressButton {
                    btnEditEnabled: false
                    type: "ADDRESS"
                    currentItem: addressBook.currentItem

                    Connections {
                        onAddressAdded: {

                        }

                        onAddressUpdated: {
                            addressBook.update(name, address)
                            selectItem(addressBook.getSelectedItem())
                        }

                        onAddressRemoved: {
                            addressBook.removeSelected()
                        }

                        onBtnAddClicked: {
                            if (!xcite.isNetworkActive) {
                                modalAlert({
                                               bodyText: "Connect to the testnet wallet to create new addresses",
                                               title: qsTr("TESTNET REQUIRED"),
                                               buttonText: qsTr("OK")
                                           })
                                return
                            }

                            accountCreateForm.open()
                        }
                    }
                }
            }
        }
    }

    function selectItem(item) {
        formAddress.text = item.address
    }
}
