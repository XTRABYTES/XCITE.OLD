import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.1
import QtQuick.Controls.Material 2.1
import "Controls" as Controls
import "X-Board/Nodes" as NodeComponents
import "X-Board/Home" as HomeComponents

import xtrabytes.xcite.xchat 1.0

// TODO: Currently this is a low-performance proof of concept demonstrating scalability.
// For production, this should be refactored to make proper use of Loaders, limit the use of JavaScript functions, etc.
// More information: http://doc.qt.io/qt-5/scalability.html

Item {
    readonly property int layoutGridSpacing: 15
    readonly property int sideMenuWidth: 90

    RowLayout {
        id: rootLayout
        anchors.fill: parent
        spacing: 15

        Controls.SideMenu {
            id: sideMenu
        }

        ColumnLayout {
            id: rootColumnLayout
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Layout.fillHeight: true

            Rectangle {
                id: mainNav
                // Main navigation
                Layout.fillWidth: true
                Layout.maximumWidth: parent.width
                Layout.minimumHeight: 70
                Layout.preferredHeight: 70
                Layout.maximumHeight: 70
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottomMargin: -15
                color: "transparent"

                Rectangle {
                    height: 44
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    width: navRowLayout.width
                    radius: 5
                    color: "#3A3E47"

                    RowLayout {
                        id: navRowLayout
                        anchors.left: parent.left
                        anchors.top: parent.top
                        height: parent.height
                        spacing: 0

                        Controls.ButtonNavigation {
                            id: homeNavButton
                            height: 44
                            text: qsTr("X-BOARD")
                            isSelected: true
                            onButtonClicked: {
                                homeNavButton.isSelected = true
                                xchangeNavButton.isSelected = false
                                xchatNavButton.isSelected = false
                                xVaultNavButton.isSelected = false
                                moreNavButton.isSelected = false
                                xBoardHome.visible = true
                                tools.visible = false
                                xBoardNodes.visible = false
                            }
                        }

                        Controls.ButtonNavigation {
                            id: xchangeNavButton
                            height: 44
                            text: qsTr("X-CHANGE")
                            onButtonClicked: {
                                homeNavButton.isSelected = false
                                xchangeNavButton.isSelected = true
                                xchatNavButton.isSelected = false
                                xVaultNavButton.isSelected = false
                                moreNavButton.isSelected = false
                                xBoardHome.visible = false
                                tools.visible = false
                                xBoardNodes.visible = false
                            }
                        }

                        Controls.ButtonNavigation {
                            id: xchatNavButton
                            height: 44
                            text: qsTr("X-CHAT")
                            onButtonClicked: {
                                homeNavButton.isSelected = false
                                xchangeNavButton.isSelected = false
                                xchatNavButton.isSelected = true
                                xVaultNavButton.isSelected = false
                                moreNavButton.isSelected = false
                                xBoardHome.visible = false
                                tools.visible = false
                                xBoardNodes.visible = false
                            }
                        }
                        Controls.ButtonNavigation {
                            id: xVaultNavButton
                            height: 44
                            text: qsTr("X-VAULT")
                            onButtonClicked: {
                                homeNavButton.isSelected = false
                                xchangeNavButton.isSelected = false
                                xchatNavButton.isSelected = false
                                xVaultNavButton.isSelected = true
                                moreNavButton.isSelected = false
                                xBoardHome.visible = false
                                tools.visible = false
                                xBoardNodes.visible = false
                            }
                        }

                        Controls.ButtonNavigation {
                            id: moreNavButton
                            height: 44
                            text: qsTr("MORE")
                            onButtonClicked: {
                                homeNavButton.isSelected = false
                                xchangeNavButton.isSelected = false
                                xchatNavButton.isSelected = false
                                xVaultNavButton.isSelected = false
                                moreNavButton.isSelected = true
                                xBoardHome.visible = false
                                tools.visible = true
                                xBoardNodes.visible = false
                            }
                        }

                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.maximumWidth: 300
                    Layout.minimumWidth: 200
                    Layout.preferredWidth: 200
                    anchors.right: parent.right
                    height: parent.height
                    spacing: 30

                    Controls.SearchBox {
                        id: searchBox
                        placeholder: qsTr("Search for something...")
                        anchors.right: parent.right
                        anchors.rightMargin: 15
                    }
                }
            }

            // X-Board

            // Home

            HomeComponents.Layout {
                id: xBoardHome
                visible: sideMenu.selected === this
            }

            // Send Coins

            Item {
                id: xBoardSendCoins
                visible: sideMenu.selected === this
            }

            // Receive Coins

            Item {
                id: xBoardReceiveCoins
                visible: sideMenu.selected === this
            }

            // History

            Item {
                id: xBoardHistory
                visible: sideMenu.selected === this
            }

            // Nodes
            NodeComponents.Layout{
                id: xBoardNodes
                visible: sideMenu.selected === this
            }

           /* ColumnLayout {
                id: xBoardNodes
                anchors.left: parent.left
                anchors.right: parent.right

                spacing: 15
                visible: sideMenu.selected === this

                RowLayout {
                    id: xBoardNodesHeader
                    height: 50
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 15

                    Controls.ButtonSimple {
                        text: qsTr("Register Node")
                        onButtonClicked: {
                            xBoardNodesHeader.visible = false
                            nodeBalanceBoard.visible = false
                            nodeTransactionsBoard.visible = false
                            nodeRegistrationLevel.visible = true
                            xBoardNodesRow2.visible = false
                        }
                    }
                }

                RowLayout {
                    id: xBoardNodesRow1
                    Layout.fillHeight: true
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 15

                    NodeComponents.BalanceBoard {
                        id: nodeBalanceBoard
                    }

                    NodeComponents.TransactionsBoard {
                        id: nodeTransactionsBoard
                    }

                    NodeComponents.RegistrationLevel {
                        id: nodeRegistrationLevel
                        visible: false
                    }

                    NodeComponents.RegistrationDetails {
                        id: nodeRegistrationDetails
                        visible: false
                    }

                    NodeComponents.RegistrationConfirmation {
                        id: nodeRegistrationConfirmation
                        visible: false
                    }
                }

                RowLayout {
                    id: xBoardNodesRow2
                    Layout.fillHeight: true
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 15

                    NodeComponents.NetworkStatusBoard {
                        id: nodeNetworkStatus
                    }
                }
            }*/

            // Settings

            Item {
                id: moduleSettings
            }

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
