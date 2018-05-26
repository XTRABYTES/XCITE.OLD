/**
 * Filename: RegistrationDetails.qml
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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0
import "../../Controls" as Controls
import "../../Theme" 1.0
import QtQuick.Extras 1.4


/**
  * Refactored, needs cleaning up on the Low, Medium High Texts, see line 136
  */
Controls.Diode {

    // primary rectangle properties
    property int pageTracker: 0
    property int level1
    id: regLevel
    width: parent.width - 100
    height: parent.height - 500
    Layout.minimumHeight: 100
    color: "#3A3E47"
    radius: 5
    anchors.fill: parent

    ColumnLayout {
        Text {
            id: text2
            Layout.topMargin: 10
            Layout.leftMargin: 13
            width: 143
            height: 23
            color: "#e2e2e2"
            text: qsTr("Node Registration")
            font.pixelSize: 18
        }
    }
    // Second layer text
    ColumnLayout {
        anchors.top: parent.top
        anchors.topMargin: 65
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10

        Controls.FormLabel {
            Layout.topMargin: 20
            text: qsTr("Registration Details")
            Layout.leftMargin: 25
            font.pixelSize: 19
        }
        Label {
            Layout.leftMargin: 25
            Layout.topMargin: 20
            font.pixelSize: 16
            color: "#d5d5d5"
            text: "Static registration string"
        }
        Label {
            Layout.leftMargin: 25
            Layout.topMargin: 6
            font.pixelSize: 12
            text: "Save this code in a safe location"
            font.weight: Font.Medium
            color: "#FFFFFF"
        }
        TextArea {
            id: regString
            color: "#d5d5d5"
            text: "aFEFR452ffaf778wyJc5i8upNm5Vv8HMkwXqBR3kaf3452CxS"
            width: 300
            readOnly: true
            Layout.leftMargin: 35
            Layout.topMargin: 5
            background: Rectangle {
                width: regString.width + 20
                color: "#2A2C31"
                radius: 4
                border.width: parent.activeFocus ? 2 : 0
                border.color: Theme.primaryHighlight
                anchors.left: parent.left
                anchors.leftMargin: -10
                anchors.top: parent.top
                anchors.topMargin: -3
            }
        }
        Label {

            Image {
                fillMode: Image.PreserveAspectFit
                source: "../../icons/copy-clipboard.svg"
                anchors.right: parent.left
                anchors.rightMargin: 5
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        clipboard.text = regString.text
                    }
                }
            }

            font.pixelSize: 12
            Layout.leftMargin: 45
            Layout.topMargin: 5
            text: "Copy string to clipboard"
            font.weight: Font.Medium
            color: "#FFFFFF"
        }
        Label {
            font.pixelSize: 16
            Layout.leftMargin: 25
            Layout.topMargin: 20
            color: "#d5d5d5"
            text: "XBY Deposit Address"
        }

        TextArea {
            id: addString
            color: "#d5d5d5"
            text: "BMy2BpwyJc5i8upNm5Vv8HMkwXqBR3kCxS"
            width: 220
            Layout.leftMargin: 35
            Layout.topMargin: 5
            background: Rectangle {
                width: 335
                color: "#2A2C31"
                radius: 4
                border.width: parent.activeFocus ? 2 : 0
                border.color: Theme.primaryHighlight
                anchors.left: parent.left
                anchors.leftMargin: -10
                anchors.top: parent.top
                anchors.topMargin: -3
            }
        }

        Label {
            font.pixelSize: 16
            Layout.leftMargin: 25
            Layout.topMargin: 10
            color: "#d5d5d5"
            text: "Accept transaction fee"
        }
        Label {
            font.pixelSize: 12
            Layout.leftMargin: 25
            Layout.topMargin: 3
            text: "Save this code in a safe location"
            color: "#FFFFFF"
            font.weight: Font.Medium
        }
        Controls.Switch {
            id: confirmationSwitch
            on: false
            Layout.topMargin: 15
            Layout.leftMargin: 50
            Label {
                anchors.right: parent.left
                anchors.rightMargin: 10
                color: "#d5d5d5"
                text: "No"
            }
            Label {
                anchors.left: parent.right
                anchors.leftMargin: 10
                color: "#d5d5d5"
                text: "Yes"
            }
        }

        Label {
            font.pixelSize: 16
            Layout.leftMargin: 25
            Layout.topMargin: 15
            color: "#d5d5d5"
            text: "Total Deposit"
        }
        Label {
            font.pixelSize: 14
            Layout.leftMargin: 25
            Layout.topMargin: 10
            color: "#d5d5d5"
            text: {
                if (saveLevel == 0 && paymentMethod == 0)
                    "125,000 XBY"
                if (saveLevel == 0 && paymentMethod == 1)
                    "85,000 XBY & 40,000 XFUEL"
                if (saveLevel == 1 && paymentMethod == 0)
                    "250,000 XBY"
                if (saveLevel == 1 && paymentMethod == 1)
                    "170,000 XBY & 80,000 XFUEL"
                if (saveLevel == 2 && paymentMethod == 0)
                    "500,000 XBY"
                if (saveLevel == 2 && paymentMethod == 1)
                    "330,000 XBY + 170,000 XFUEL"
            }
        }
        Controls.ButtonModal {
            font.pixelSize: 18
            Layout.leftMargin: 25
            Layout.topMargin: 35
            labelText: "CONFIRM"
            height: 42
            Layout.fillWidth: true
            Layout.minimumWidth: 180
            Layout.preferredWidth: 230
            Layout.maximumWidth: 300
            label.font.weight: Font.Medium
            isPrimary: true
            onButtonClicked: {
                if (confirmationSwitch.on == true) {
                    tracker = 3
                }
                if (confirmationSwitch.on == false) {
                    modalAlert({
                                   bodyText: "Before submitting your deposit, please first confirm you have saved all strings above.",
                                   title: qsTr("Module Alert"),
                                   buttonText: qsTr("OK")
                               })
                }
            }
        }
    }
}
