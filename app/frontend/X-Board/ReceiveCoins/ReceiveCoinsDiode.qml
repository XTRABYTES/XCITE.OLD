import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.4

import "../../Controls" as Controls
import QtQrCode.Component 1.0

Controls.Diode {
    id: receiveCoinsDiode

    title: qsTr("RECEIVE XBY")
    menuLabelText: qsTr("XBY")

    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 60
        spacing: 0

        RowLayout {
            spacing: 20
            Layout.fillWidth: true
            Layout.topMargin: 6
            Layout.leftMargin: 22
            Layout.rightMargin: 22
            Layout.bottomMargin: 20

            // Left Pane
            ColumnLayout {
                Layout.maximumWidth: 516
                anchors.top: parent.top
                spacing: 5

                // Main
                Controls.FormLabel {
                    Layout.topMargin: 10
                    Layout.bottomMargin: 25
                    text: qsTr("Main")
                }

                Controls.TextInput {
                    id: formAddress
                    font.pixelSize: 24
                    Layout.preferredWidth: 516
                    topPadding: 10
                    bottomPadding: 10
                }

                RowLayout {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    Layout.topMargin: 6

                    Label {
                        id: copyPasteButton

                        readonly property string defaultText: qsTr("Copy address to clipboard")
                        readonly property string altText: qsTr(
                                                              "Address copied!")
                        readonly property string defaultIcon: "../../icons/copy-clipboard.svg"
                        readonly property string altIcon: "../../icons/circle-cross.svg"
                        property bool isActive: false

                        font.pixelSize: 12
                        font.family: "Roboto"
                        font.weight: isActive ? Font.Bold : Font.Normal
                        text: isActive ? altText : defaultText
                        color: isActive ? "#ffffff" : "#E3E3E3"
                        anchors.top: parent.top
                        anchors.left: parent.left
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
                            width: 19
                            height: 13
                            sourceSize.width: 19
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
                        font.family: "Roboto"
                        font.weight: Font.Light
                        color: "#E3E3E3"
                        Layout.preferredWidth: 516
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignRight
                        rightPadding: 20
                        font.pixelSize: 12
                        text: qsTr(
                                  "Or change to another address from your list")

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

                // Main
                Controls.FormLabel {
                    Layout.topMargin: 40
                    Layout.bottomMargin: 25
                    text: qsTr("QR Code")
                }

                Label {
                    font.pixelSize: 12
                    font.family: "Roboto"
                    text: "Simply send money to this address by scanning this QR code"
                    color: "#E3E3E3"
                }

                QtQrCode {
                    Layout.topMargin: 25
                    Layout.bottomMargin: 25
                    anchors.horizontalCenter: parent.horizontalCenter
                    data: formAddress.text
                    background: "transparent"
                    foreground: "#0ED8D2"
                    width: 180
                    height: 180
                }
            }

            // Divider
            Rectangle {
                Layout.fillHeight: true
                width: 1
                color: "#535353"
            }

            // Address Book
            ColumnLayout {
                anchors.top: parent.top
                Layout.fillHeight: true
                Layout.fillWidth: true

                Controls.FormLabel {
                    Layout.topMargin: 10
                    text: qsTr("My Addresses")
                    Layout.bottomMargin: 25
                }

                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Rectangle {
                        id: addressBookContainer

                        anchors.fill: parent
                        anchors.bottomMargin: 60
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
                        anchors.top: addressBookContainer.bottom
                        anchors.topMargin: 10

                        Controls.AddressButton {
                            Layout.leftMargin: -17
                            currentItem: addressBook.currentItem

                            Connections {
                                onAddressAdded: {
                                    addressBook.add(name, address)
                                }

                                onAddressUpdated: {
                                    addressBook.update(name, address)
                                    selectItem(addressBook.getSelectedItem())
                                }

                                onAddressRemoved: {
                                    addressBook.removeSelected()
                                }
                            }
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
