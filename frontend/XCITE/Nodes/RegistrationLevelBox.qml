/**
 * Filename: RegistrationLevelBox.qml
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
import "../../Controls" as Controls

Controls.Diode {
    id: diodeParent
    property string earningsText: ""
    property string networkText: ""
    property string transferText: ""
    // leftpadding
    property string earningsLevel: ""
    property string networkLevel: ""
    property string transferLevel: ""
    property int paddingLevel: 0
    property int nodeLevel: 0

    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 65
        anchors.leftMargin: 15
        anchors.rightMargin: 15

        Label {

            id: earningsLabel
            leftPadding: 30
            font.weight: Font.Light
            font.pixelSize: 16
            bottomPadding: 5
            color: "#d5d5d5"
            text: earningsText
            Label {
                id: earningsLabel1
                leftPadding: paddingLevel
                font.weight: Font.Light
                font.pixelSize: 16
                bottomPadding: 15
                color: "#d5d5d5"
                text: earningsLevel
            }
            Image {

                id: diamond
                visible: true
                anchors {
                    left: parent.left
                }
                source: "../../icons/icon-diamond.svg"
            }
        }

        Label {
            id: networkLabel
            leftPadding: 30
            font.weight: Font.Light
            font.pixelSize: 16
            bottomPadding: 5
            color: "#d5d5d5"
            text: networkText
            Label {
                id: networkLabel1
                leftPadding: paddingLevel
                font.weight: Font.Light
                font.pixelSize: 16
                bottomPadding: 15
                color: "#d5d5d5"
                text: networkLevel
            }
            Image {

                id: network
                visible: true
                anchors {
                    left: parent.left
                }
                source: "../../icons/icon-network.svg"
            }
        }

        Label {
            id: transferLabel
            leftPadding: 30
            font.weight: Font.Light
            font.pixelSize: 16
            bottomPadding: 0
            color: "#d5d5d5"
            text: transferText
            Label {
                id: transferLabel1
                leftPadding: paddingLevel
                font.weight: Font.Light
                font.pixelSize: 16
                bottomPadding: 15
                color: "#d5d5d5"
                text: transferLevel
            }
            Image {

                id: transfer
                visible: true
                anchors {
                    left: parent.left
                }
                source: "../../icons/icon-transfer.svg"
            }
        }

        Label {
            font.weight: Font.Light
            font.pixelSize: 16
            topPadding: 5
            color: "#d5d5d5"
            text: "Payment"
        }

        Controls.Switch {
            id: typeSwitch
            on: false
            Layout.topMargin: 12
            Layout.leftMargin: 35
            Label {
                anchors.right: parent.left
                anchors.rightMargin: 10
                color: "#24B9C3"
                font.pixelSize: 12
                text: "XBY"
                topPadding: 3
            }
            Label {
                anchors.left: parent.right
                anchors.leftMargin: 10
                color: "#24B9C3"
                font.pixelSize: 12
                text: "XBY+XFUEL"
                topPadding: 3
            }
        }
        Controls.ButtonModal {
            Layout.fillHeight: true
            isPrimary: true
            width: parent.width - 10
            buttonHeight: 40
            label.font.weight: Font.Medium
            label.font.letterSpacing: 3
            label.text: qsTr("Select")
            topPadding: 50

            onButtonClicked: {
                tracker = 2
                if (nodeLevel == 0)
                    saveLevel = 0
                if (nodeLevel == 1)
                    saveLevel = 1
                if (nodeLevel == 2)
                    saveLevel = 2
                if (typeSwitch.on == true)
                    paymentMethod = 1
                if (typeSwitch.on == false)
                    paymentMethod = 0
            }
        }
    }
}
