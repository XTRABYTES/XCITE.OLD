import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.1
import QtQuick.Controls.Material 2.1

import "Controls" as Controls

import 'X-Board' as XBoard
import 'X-Change' as XChange

import xtrabytes.xcite.xchat 1.0

// TODO: Currently this is a low-performance proof of concept demonstrating scalability.
// For production, this should be refactored to make proper use of Loaders, limit the use of JavaScript functions, etc.
// More information: http://doc.qt.io/qt-5/scalability.html

Item {
    id: dashboard

    readonly property int layoutGridSpacing: 15
    readonly property int sideMenuWidth: 90

    signal selectView(string path)

    Connections {
        Component.onCompleted: {
            // Set the current view to X-Board -> Home
            selectView("xBoard.home");
        }
    }

    RowLayout {
        id: rootLayout
        anchors.fill: parent
        anchors.rightMargin: layoutGridSpacing
        anchors.bottomMargin: layoutGridSpacing
        spacing: 15

        Controls.SideMenu {
        }

        ColumnLayout {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Layout.fillHeight: true

            Controls.ModuleMenu {
            }


            Loader {
                Layout.fillHeight: true
                Layout.fillWidth: true
                id: viewLoader
            }

            // More

            // Commented out until we decide if we need this.
            // If so, refactor it into its own separate view

            /*
            ColumnLayout {
                id: tools
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 15
                visible: false

                RowLayout {
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
                                    text: qsTr("XBY Transfer Amount (e.g. 1 or 1000):")
                                }
                                TextField {
                                    id: transferAmount
                                    text: "1"
                                }
                                Label {
                                    text: qsTr("XBY Transfer Cycles (e.g. 5000):")
                                }
                                TextField {
                                    id: transferCycles
                                    text: "5000"
                                }
                                Label {
                                    text: qsTr("Transactions Per Minute (Use a number between 1 and 1000 to prevent your system from freezing)")
                                }
                                TextField {
                                    id: transactionsPerMin
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

            */
        }
    }

    Controls.Popup {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: sideMenuWidth + layoutGridSpacing
    }

    XchatPopup {
        id: xChatPopup
        visible:true
    }
}
