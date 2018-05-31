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

ColumnLayout {
    id: tools

    property string selectedView
    property string selectedModule

    anchors.left: parent.left
    anchors.right: parent.right
    spacing: 15
    visible: selectedModule === 'tools'

    Connections {
        target: dashboard
        onSelectView: {
            var parts = path.split('.')

            selectedModule = parts[0]
            if (parts.length === 2) {
                selectedView = parts[1]
            } else {
                selectedView = defaultView
            }
        }
    }

    RowLayout {
        visible: false

        id: toolsRow1
        Layout.fillHeight: true
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 15

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 100
            color: "#3A3E47"
            radius: 5

            ColumnLayout {
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width

                ColumnLayout {
                    Layout.margins: 15
                    Label {
                        color: "#d5d5d5"
                        text: qsTr("XBY Transfer Amount (e.g. 1 or 1000):")
                    }
                    TextField {
                        id: transferAmount
                        color: "#d5d5d5"
                        text: "1"
                    }
                    Label {
                        color: "#d5d5d5"
                        text: qsTr("XBY Transfer Cycles (e.g. 5000):")
                    }
                    TextField {
                        id: transferCycles
                        color: "#d5d5d5"
                        text: "5000"
                    }
                    Label {
                        color: "#d5d5d5"
                        text: qsTr("Transactions Per Minute (Use a number between 1 and 1000 to prevent your system from freezing)")
                    }
                    TextField {
                        id: transactionsPerMin
                        color: "#d5d5d5"
                        text: "500"
                    }
                    Label {
                        text: qsTr("XBY Receiving Addresses (Enter one address per line)")
                    }
                    ScrollView {
                        Layout.fillWidth: true
                        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                        Layout.minimumHeight: 100
                        Layout.maximumHeight: 100
                        Layout.maximumWidth: 300

                        TextArea {
                            id: receivingAddresses
                            Layout.minimumHeight: 100
                            Layout.maximumHeight: 100
                            wrapMode: TextArea.Wrap
                        }
                    }
                    RowLayout {
                        Button {
                            id: sendButton
                            text: qsTr("Send")
                            onClicked: {

                            }
                        }
                        Button {
                            id: pauseButton
                            text: qsTr("Pause")
                            onClicked: {

                            }
                        }
                    }

                    Label {
                        text: qsTr("Completed Transactions:")
                    }
                    TextField {
                        id: completedTransactions
                        readOnly: true
                    }
                    Label {
                        text: qsTr("TX Log:")
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                        Layout.minimumHeight: 100
                        Layout.maximumHeight: 100
                        Layout.maximumWidth: 300

                        TextArea {
                            id: transactionLog
                            Layout.minimumHeight: 100
                            Layout.maximumHeight: 100
                            wrapMode: TextArea.Wrap
                            readOnly: true
                        }
                    }
                }
            }
        }
    }
}
