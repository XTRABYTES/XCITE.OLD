import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import AddressBookModel 0.1

import "../../Controls" as Controls

Controls.Diode {
    property int networkFee: 1
    property real balance: wallet.balance
    property real totalAmount: networkFee + (formAmount.text.length > 0 ? parseFloat(
                                                                              formAmount.text) : 0)

    title: qsTr("SEND XBY")
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

            // Form
            ColumnLayout {
                anchors.top: parent.top
                spacing: 5

                // Amount
                Controls.FormLabel {
                    Layout.topMargin: 10
                    Layout.bottomMargin: 25
                    text: qsTr("Amount")
                }

                Controls.TextInput {
                    id: formAmount
                    Layout.preferredWidth: 516
                    topPadding: 5
                    bottomPadding: 5
                    text: "0"

                    TextXBY {
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 12
                        anchors.bottomMargin: 5
                    }
                }

                Controls.SliderAmount {
                    Layout.preferredWidth: 516
                    Layout.bottomMargin: 10
                    Layout.topMargin: 10
                    totalAmount: balance

                    onMoved: {
                        formAmount.text = Number(value).toFixed(2)
                    }
                }

                // Pay To
                Controls.FormLabel {
                    Layout.topMargin: 20
                    Layout.bottomMargin: 25
                    text: qsTr("Pay to")
                }

                Label {
                    font.pixelSize: 12
                    font.family: "Roboto"
                    bottomPadding: 10
                    text: qsTr("Enter a XTRABYTES address in here.\nEx: BMy2BpwyJc5i7upNm5Vv8HMkwXqBR3kCxS ")
                }

                Controls.TextInput {
                    id: formAddress
                    font.pixelSize: 24
                    Layout.preferredWidth: 516
                    topPadding: 10
                    bottomPadding: 10
                }

                Label {
                    Layout.topMargin: 6
                    Layout.preferredWidth: 516
                    anchors.right: parent.right
                    horizontalAlignment: Text.AlignRight
                    rightPadding: 20
                    font.pixelSize: 12
                    font.family: "Roboto"
                    text: qsTr("Or add a recipient from your address book")

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

                // Total
                Controls.FormLabel {
                    Layout.topMargin: 40
                    Layout.bottomMargin: 25
                    text: qsTr("Total")
                }

                RowLayout {
                    TextXBY {
                        Layout.alignment: Qt.AlignBottom
                        Layout.bottomMargin: 5
                    }

                    Label {
                        text: Number(totalAmount).toFixed(2)
                        font.family: "Roboto"
                        font.weight: Font.Light
                        font.pixelSize: 36
                    }
                }

                Label {
                    topPadding: 10
                    font.pixelSize: 12
                    font.family: "Roboto"
                    text: qsTr("Transaction fee:") + " " + networkFee + " " + qsTr(
                              "XBY")
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
                    text: qsTr("Address book")
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

                            model: AddressBookModel {
                            }

                            Connections {
                                // TODO: Temporary placeholder content
                                Component.onCompleted: {
                                    addressBook.add(
                                                "@james87uk",
                                                "XLGSfK2RhjvEbkGMe4WVk2R8k9auLESAsv")
                                    addressBook.add(
                                                "@posey",
                                                "XJmqWTfBQwZk2QgU3eFnbtenUHXXPmsgPa")
                                    addressBook.add(
                                                "@nrocy",
                                                "XYjAvodSHYRBzWv1WGb1bCtmVfMvGDSYAJ")

                                    addressBook.currentIndex = 0
                                }
                            }

                            onCurrentItemChanged: {
                                var item = model.get(currentIndex)
                                formAddress.text = item.address
                            }
                        }
                    }

                    RowLayout {
                        anchors.top: addressBookContainer.bottom
                        anchors.topMargin: 10

                        Controls.AddressButton {
                            Layout.leftMargin: -17
                        }
                    }
                }
            }
        }

        // Bottom Divider
        Rectangle {
            Layout.fillWidth: true
            Layout.leftMargin: 22
            Layout.rightMargin: 22
            height: 1
            color: "#535353"
        }

        // Send Payment
        Controls.ButtonModal {
            Layout.fillWidth: true
            Layout.topMargin: 35
            Layout.bottomMargin: 35
            Layout.leftMargin: 172
            Layout.rightMargin: 172
            label.font.family: "Roboto"
            label.font.weight: Font.Medium
            label.font.letterSpacing: 3
            label.text: qsTr("SEND PAYMENT")
            isPrimary: true
            buttonHeight: 60

            onButtonClicked: {
                var item = addressBook.currentItem.item

                var text = qsTr("Are you sure you want to send") + " " + Number(
                            formAmount.text).toFixed(
                            2) + " " + "to" + " " + item.name + " (" + item.address + ")?"

                confirmationModal({
                                      title: qsTr("PAYMENT CONFIRMATION"),
                                      bodyText: text,
                                      confirmText: qsTr("YES, SEND"),
                                      cancelText: qsTr("NO, CANCEL")
                                  }, function () {
                                      testnetSendFrom('', item.address,
                                                      Number(formAmount.text))
                                  })
            }
        }
    }
}
