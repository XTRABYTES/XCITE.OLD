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

            Column {
                anchors.top: parent.top
                Layout.fillWidth: true
                spacing: 5

                Controls.FormLabel {
                    text: qsTr("Amount")
                }

                Controls.TextInput {
                    text: qsTr("745,34")
                    width: parent.width
                }

                Slider {
                }

                Controls.FormLabel {
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
                    width: parent.width
                    text: qsTr("BMy2BpwyJc5i7upNm5Vv8HMkwXqBR3kCxS")
                }

                Label {
                    anchors.right: parent.right
                    font.pixelSize: 12
                    font.family: "Roboto"
                    text: qsTr("Or add a recipient from your address book")
                    topPadding: 10
                    bottomPadding: 50
                }

                Controls.FormLabel {
                    text: qsTr("Total")
                }

                Label {
                    text: qsTr("746,34")
                    font.family: "Roboto"
                    font.weight: Font.Light
                    font.pixelSize: 36
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

                Controls.LabelUnderlined {
                    text: qsTr("Address book")
                    pixelSize: 16
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
            Layout.bottomMargin: 25
            Layout.leftMargin: 172
            Layout.rightMargin: 172
            label.font.family: "Roboto"
            label.font.weight: Font.Medium
            label.font.letterSpacing: 3
            label.text: qsTr("SEND PAYMENT")
            isPrimary: true
            buttonHeight: 60
        }
    }
}
