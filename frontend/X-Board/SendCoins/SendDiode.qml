import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "../../Controls" as Controls

Controls.Diode {
    property int networkFee: 1
    property real balance: 175314
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

                Slider {
                    id: control
                    from: 0
                    stepSize: balance / 4
                    snapMode: Slider.SnapAlways
                    leftPadding: 0
                    rightPadding: 0
                    to: balance
                    Layout.preferredWidth: 516
                    Layout.bottomMargin: 10
                    Layout.topMargin: 10
                    bottomPadding: 15
                    clip: true

                    background: Rectangle {
                        x: control.leftPadding
                        y: control.topPadding + control.availableHeight / 2 - height / 2
                        implicitWidth: 200
                        implicitHeight: 4
                        width: control.availableWidth
                        height: implicitHeight
                        radius: 2
                        color: "#2A2C31"

                        Rectangle {
                            x: 0
                            y: -9
                            implicitWidth: 22
                            implicitHeight: 22
                            radius: 11
                            border.width: 0
                            color: "#2A2C31"

                            Text {
                                anchors.fill: parent
                                anchors.topMargin: 27
                                anchors.leftMargin: 3
                                color: "#E0E0E0"
                                font.family: "Roboto"
                                font.weight: Font.Light
                                font.pixelSize: 10
                                text: "0%"
                                width: 22
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        Rectangle {
                            x: (control.availableWidth - 22) / 4
                            y: -9
                            implicitWidth: 22
                            implicitHeight: 22
                            radius: 11
                            border.width: 0
                            color: "#2A2C31"

                            Text {
                                anchors.fill: parent
                                anchors.topMargin: 27
                                anchors.leftMargin: 3
                                color: "#E0E0E0"
                                font.family: "Roboto"
                                font.weight: Font.Light
                                font.pixelSize: 10
                                text: "25%"
                                width: 22
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        Rectangle {
                            x: (control.availableWidth - 22) / 4 * 2
                            y: -9
                            implicitWidth: 22
                            implicitHeight: 22
                            radius: 11
                            border.width: 0
                            color: "#2A2C31"

                            Text {
                                anchors.fill: parent
                                anchors.topMargin: 27
                                anchors.leftMargin: 3
                                color: "#E0E0E0"
                                font.family: "Roboto"
                                font.weight: Font.Light
                                font.pixelSize: 10
                                text: "50%"
                                width: 22
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        Rectangle {
                            x: (control.availableWidth - 22) / 4 * 3
                            y: -9
                            implicitWidth: 22
                            implicitHeight: 22
                            radius: 11
                            border.width: 0
                            color: "#2A2C31"

                            Text {
                                anchors.fill: parent
                                anchors.topMargin: 27
                                anchors.leftMargin: 3
                                color: "#E0E0E0"
                                font.family: "Roboto"
                                font.weight: Font.Light
                                font.pixelSize: 10
                                text: "75%"
                                width: 22
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        Rectangle {
                            x: control.availableWidth - 22
                            y: -9
                            implicitWidth: 22
                            implicitHeight: 22
                            radius: 11
                            border.width: 0
                            color: "#2A2C31"

                            Text {
                                anchors.fill: parent
                                anchors.topMargin: 27
                                anchors.leftMargin: 3
                                color: "#E0E0E0"
                                font.family: "Roboto"
                                font.weight: Font.Light
                                font.pixelSize: 10
                                text: "100%"
                                width: 22
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                    }

                    handle: Rectangle {
                        id: handle
                        property int rayLength: 50
                        property int blobWidth: 22

                        x: control.leftPadding + control.visualPosition
                           * (control.availableWidth - width)
                        y: control.topPadding + control.availableHeight / 2 - height / 2
                        implicitWidth: blobWidth
                        implicitHeight: blobWidth
                        radius: blobWidth / 2
                        color: control.pressed ? "#0ED8D2" : "#0ED8D2"
                        border.width: 0

                        Rectangle {
                            x: control.leftPadding - handle.rayLength + 5
                            y: (control.topPadding + control.availableHeight / 2 - height / 2) - 6
                            implicitWidth: handle.rayLength
                            implicitHeight: 4
                            width: implicitWidth
                            height: implicitHeight
                            color: "#0ED8D2"

                            LinearGradient {
                                anchors.fill: parent
                                start: Qt.point(handle.rayLength, 0)
                                end: Qt.point(0, 0)
                                gradient: Gradient {
                                    GradientStop {
                                        position: 0.0
                                        color: "#0ED8D2"
                                    }
                                    GradientStop {
                                        position: 1.0
                                        color: "#2A2C31"
                                    }
                                }
                            }
                        }

                        Rectangle {
                            x: control.leftPadding + handle.blobWidth - 5
                            y: (control.topPadding + control.availableHeight / 2 - height / 2) - 6
                            implicitWidth: handle.rayLength
                            implicitHeight: 4
                            width: implicitWidth
                            height: implicitHeight
                            color: "#0ED8D2"

                            LinearGradient {
                                anchors.fill: parent
                                start: Qt.point(0, 0)
                                end: Qt.point(handle.rayLength, 0)
                                gradient: Gradient {
                                    GradientStop {
                                        position: 0.0
                                        color: "#0ED8D2"
                                    }
                                    GradientStop {
                                        position: 1.0
                                        color: "#2A2C31"
                                    }
                                }
                            }
                        }
                    }

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
                        anchors.fill: parent
                        radius: 4
                        color: "#2A2C31"
                    }

                    Controls.AddressBook {
                        id: addressBook

                        onCurrentItemChanged: {
                            var item = model.get(currentIndex)
                            formAddress.text = item.address
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
                                      text: text,
                                      confirmText: qsTr("YES, SEND"),
                                      cancelText: qsTr("NO, CANCEL")
                                  })
            }
        }
    }
}
