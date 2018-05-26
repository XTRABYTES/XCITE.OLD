/**
 * Filename: Layout.qml
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
import Qt.labs.calendar 1.0
import "../../Controls" as Controls
import "../../Theme" 1.0

ColumnLayout {
    readonly property color cBoardBackground: "#3a3e46"
    property int tracker: 0
    property int nodeType: 0
    property int saveLevel: 0
    property int paymentMethod: 0
    id: xCiteNodes
    anchors.left: parent.left
    anchors.right: parent.right
    visible: false
    height: parent.height - 5
    RowLayout {
        spacing: layoutGridSpacing
        ColumnLayout {
            spacing: layoutGridSpacing
            anchors.top: parent.top
            id: row1
            MyNodes {
                id: myNodes
                visible: tracker == 0
                anchors.top: parent.top
            }
            MyPayments {
                visible: tracker == 0

                Controls.ButtonModal {
                    Layout.fillHeight: true
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    anchors.topMargin: 10
                    isPrimary: true
                    width: parent.width
                    buttonHeight: 50
                    label.font.weight: Font.Medium
                    label.font.letterSpacing: 3
                    label.text: qsTr("Node Registration")

                    onButtonClicked: {
                        tracker = 1

                        modalAlert({
                                       bodyText: "This portion of XCITE is not yet functioning, expect it soon!",
                                       title: qsTr("Module Alert"),
                                       buttonText: qsTr("OK")
                                   })
                        return
                    }
                }
            }
        }
        ColumnLayout {
            spacing: layoutGridSpacing
            id: row2
            TransactionsBoard {
                visible: tracker == 0
            }
            Controls.ChartDiode {
                visible: tracker == 0
            }
        }
    }
    RegistrationLevel {

        visible: tracker == 1

        Label {
            id: back1

            readonly property string defaultText: qsTr("< Back")
            property bool isActive: false
            anchors.top: parent.top
            anchors.left: parent.left
            topPadding: 60
            leftPadding: 35
            font.pixelSize: 12
            font.weight: isActive ? Font.Bold : Font.Normal
            text: isActive ? altText : defaultText
            color: Theme.primaryHighlight

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    tracker = 0
                }
            }
        }
    }

    RegistrationDetails {
        visible: tracker == 2
        height: parent.height + 50

        Label {
            id: back2

            readonly property string defaultText: qsTr("< Back")

            property bool isActive: false
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            font.weight: isActive ? Font.Bold : Font.Normal
            text: isActive ? altText : defaultText
            color: Theme.primaryHighlight
            leftPadding: 35
            topPadding: 60

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    tracker = 1
                }
            }
        }
    }
    RegistrationConfirmation {
        visible: tracker == 3
        height: parent.height + 50
        Label {
            id: back3

            readonly property string defaultText: qsTr("< Back")

            property bool isActive: false
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            font.weight: isActive ? Font.Bold : Font.Normal
            text: isActive ? altText : defaultText
            color: Theme.primaryHighlight
            leftPadding: 35
            topPadding: 60

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    tracker = 2
                }
            }
        }
    }
}
