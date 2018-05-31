/**
 * Filename: RegistrationConfirmation.qml
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
    property string level1NodeText: " L1 Node!"
    property string level2NodeText: " L2 Node!"
    property string level3NodeText: " L3 Node!"
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
            text: qsTr("Confirmation")
            Layout.leftMargin: 25
            font.pixelSize: 19
        }
        Label {
            Layout.leftMargin: 25
            Layout.topMargin: 15
            font.pixelSize: 16
            color: "#d5d5d5"
            text: "Static registration string"
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
            Layout.leftMargin: 25
            Layout.topMargin: 20
            font.pixelSize: 16
            color: "#d5d5d5"
            text: "Deposit Transaction ID"
        }
        TextArea {
            id: depID
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
                        clipboard.text = depID.text
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
            Layout.leftMargin: 25
            Layout.topMargin: 20
            font.pixelSize: 16
            color: "#d5d5d5"
            text: "Fee Transaction ID"
        }
        TextArea {
            id: feeTrans
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
                        clipboard.text = feeTrans.text
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
            Layout.leftMargin: 25
            Layout.topMargin: 20
            font.pixelSize: 16
            color: "#d5d5d5"
            text: "Public Static Key"
        }
        TextArea {
            id: pubKey
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
                        clipboard.text = pubKey.text
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
            Layout.leftMargin: 25
            Layout.topMargin: 20
            font.pixelSize: 16
            color: "#d5d5d5"
            text: "Placeholder"
        }
        TextArea {
            id: holderKey
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
                        clipboard.text = holderKey.text
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
        Controls.Switch {
            id: confirmSwitch
            on: false
            Layout.topMargin: 15
            Layout.leftMargin: 25

            Label {
                anchors.left: parent.right
                anchors.leftMargin: 10
                color: "#d5d5d5"
                text: "I have copied and saved all strings above to multiple secure locations that only I have access to"
            }
        }
        Controls.ButtonModal {
            font.pixelSize: 18
            Layout.leftMargin: 25
            Layout.topMargin: 15
            labelText: "DONE"
            height: 42
            Layout.fillWidth: true
            Layout.minimumWidth: 70
            Layout.preferredWidth: 120
            Layout.maximumWidth: 150
            label.font.weight: Font.Medium
            isPrimary: true
            onButtonClicked: {
                if (confirmSwitch.on == true) {
                    tracker = 0
                    if (saveLevel == 0) {
                        modalAlert({
                                       bodyText: "Congratulations, you have registered your"
                                                 + level1NodeText,
                                       title: qsTr("Module Alert"),
                                       buttonText: qsTr("OK")
                                   })
                    }
                    if (saveLevel == 1) {
                        modalAlert({
                                       bodyText: "Congratulations, you have registered your"
                                                 + level2NodeText,
                                       title: qsTr("Module Alert"),
                                       buttonText: qsTr("OK")
                                   })
                    }
                    if (saveLevel == 2) {
                        modalAlert({
                                       bodyText: "Congratulations, you have registered your"
                                                 + level3NodeText,
                                       title: qsTr("Module Alert"),
                                       buttonText: qsTr("OK")
                                   })
                    }
                }
                if (confirmSwitch.on == false) {
                    modalAlert({
                                   bodyText: "Before finalizing your node acquisition, please first confirm you have copied and saved all strings above.",
                                   title: qsTr("Module Alert"),
                                   buttonText: qsTr("OK")
                               })
                }
            }
        }
    }
}
