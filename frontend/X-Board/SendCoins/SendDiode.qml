import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../../Controls" as Controls

Controls.Diode {
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

            ColumnLayout {
                anchors.top: parent.top
                spacing: 5

                Controls.FormLabel {
                    Layout.topMargin: 10
                    Layout.bottomMargin: 25
                    text: qsTr("Amount")
                }

                Controls.TextInput {
                    Layout.preferredWidth: 516
                    topPadding: 5
                    bottomPadding: 5
                    text: qsTr("745,34")

                    TextXBY {
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 12
                        anchors.bottomMargin: 5
                    }
                }

                Slider {
                }

                Controls.FormLabel {
                    Layout.topMargin: 10
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
                    font.pixelSize: 24
                    Layout.preferredWidth: 516
                    text: qsTr("BMy2BpwyJc5i7upNm5Vv8HMkwXqBR3kCxS")
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
                        text: qsTr("746,34")
                        font.family: "Roboto"
                        font.weight: Font.Light
                        font.pixelSize: 36
                    }
                }

                Label {
                    topPadding: 10
                    font.pixelSize: 12
                    font.family: "Roboto"
                    text: qsTr("Transaction fee: 1 XBY")
                }
            }

            Rectangle {
                Layout.fillHeight: true
                width: 1
                color: "#535353"
            }

            Item {
                anchors.top: parent.top

                Layout.preferredWidth: 360
                Layout.preferredHeight: 113.5
                Layout.fillHeight: true
                Layout.fillWidth: true

                Controls.LabelUnderlined {
                    text: qsTr("Address book")
                    pixelSize: 16
                }

                Controls.ListViewCoins {
                    color: "#2A2C31"
                    radius: 5
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.leftMargin: 22
            Layout.rightMargin: 22
            height: 1
            color: "#535353"
        }

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
                confirmationModal({
                                      title: qsTr("PAYMENT CONFIRMATION"),
                                      text: qsTr("Are you sure you want to send 745,34 XBY to Lachelle Hamblin (BMy2BpwyJc5i7upNm5Vv8HMkwXqBR3kCxS)?"),
                                      confirmText: qsTr("YES, SEND"),
                                      cancelText: qsTr("NO, CANCEL")
                                  })
            }
        }
    }
}
