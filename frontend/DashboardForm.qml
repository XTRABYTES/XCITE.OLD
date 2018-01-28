import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.1
import QtQuick.Controls.Material 2.1
import "Controls" as Controls
import "X-Board/Nodes" as NodeComponents

import xtrabytes.xcite.xchat 1.0


// TODO: Currently this is a low-performance proof of concept demonstrating scalability.
// For production, this should be refactored to make proper use of Loaders, limit the use of JavaScript functions, etc.
// More information: http://doc.qt.io/qt-5/scalability.html

Item {

    RowLayout {
        id: rootLayout
        anchors.fill: parent
        spacing: 15

        Rectangle {
            // Diode navigation
            id: navRectangle
            color: "#3A3E47"
            Layout.fillHeight: true
            Layout.minimumWidth: 90
            Layout.preferredWidth: 90
            Layout.maximumWidth: 90

            ColumnLayout {
                width: parent.width
                Layout.fillHeight: true
                anchors.left: parent.left
                anchors.top: parent.top
                spacing: 40

                Controls.ButtonDiode {
                    id: logobutton
                    imageSource: "logos/xby_logo.svg"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.topMargin: 15
                    changeColorOnClick: false
                    hoverEnabled: false
                    size: 70
                    height: 40
                }

                Controls.ButtonDiode {
                    id: xBoardHomeButtonDiode
                    imageSource: "icons/dollar-pointer.svg"
                    // This is a placeholder image
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    isSelected: true
                    hasLabel: true
                    labelText: qsTr("HOME")
                    onButtonClicked: {
                        xBoardHome.visible = true
                        tools.visible = false
                        xBoardNodes.visible = false
                        xBoardNodesButtonDiode.isSelected = false
                    }
                }

                Controls.ButtonDiode {
                    id: xBoardNodesButtonDiode
                    imageSource: "icons/share.svg"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    isSelected: false
                    hasLabel: true
                    labelText: qsTr("NODES")
                    onButtonClicked: {
                        xBoardHome.visible = false
                        tools.visible = false
                        xBoardNodes.visible = true
                        xBoardHomeButtonDiode.isSelected = false
                    }
                }
            }

            ColumnLayout {
                width: parent.width
                Layout.fillHeight: true
                Layout.minimumHeight: 200
                Layout.preferredHeight: 200
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                spacing: 40

                Controls.ButtonDiode {
                    id: settingsButton
                    imageSource: "icons/lock.svg"
                    // This is a placeholder image
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    isSelected: false
                    hasLabel: true
                    labelText: qsTr("SETTINGS")
                    onButtonClicked: {

                    }
                }

                Controls.ButtonDiode {
                    id: wifiButton
                    imageSource: "icons/wifi.svg"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    isSelected: false
                    hasLabel: true
                    labelText: qsTr("ONLINE")
                    onButtonClicked: {

                    }
                }

                Switch {
                    id: killSwitch
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    checked: true
                    padding: 0
                }
            }
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

            ColumnLayout {
                id: xBoardHome
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 15

                RowLayout {
                    // X-Board Home Row 1
                    id: xBoardHomeRow1
                    Layout.fillHeight: true
                    Layout.rightMargin:15
                    anchors.left: parent.left
                    //anchors.right: parent.right

                    spacing: 15

                    // TODO Add first row of wallet UI here after mockups are ready

                    NodeComponents.BalanceBoard{}

                    NodeComponents.TransactionsBoard{}
                }

                RowLayout {
                    // X-Board Home Row 2
                    id: xBoardHomeRow2
                    Layout.fillHeight: true
                    anchors.left: parent.left
                    Layout.rightMargin:15
                    spacing: 15

                    // TODO Add second row of wallet UI here after mockups are ready

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumHeight: 200
                        Layout.preferredHeight: 400
                        color: "#3A3E47"
                        radius: 5
                    }
                }
            }

            ColumnLayout {
                id: xBoardNodes
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 15
                visible: false

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

            Rectangle {
                // Filler
                width: 15
                color: "transparent"
            }

            RowLayout {
                // Footer
                height: 40
                anchors.left: parent.left
                anchors.bottom: parent.bottom

                Rectangle {
                    Layout.fillWidth: true
                    height: 40
                    color: "#0DD8D2"
                    radius: 2

                    RowLayout {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20

                        Text {
                            text: qsTr("Notice!")
                            font.family: "Roboto"
                            font.weight: Font.Bold
                            font.pixelSize: 18
                            color: "#335F5E"
                        }

                        Text {
                            text: qsTr("This is a pre-release version of XCITE for testing only.")
                            font.family: "Roboto"
                            font.pixelSize: 18
                            color: "#335F5E"
                        }

                        Controls.ButtonPlainText {
                            width: webLinkText.width
                            onButtonClicked: {
                                Qt.openUrlExternally("https://xtrabytes.global")
                            }

                            Text {
                                id: webLinkText
                                anchors.topMargin: 5
                                text: qsTr("xtrabytes.global")
                                font.family: "Roboto"
                                font.weight: Font.Bold
                                font.pixelSize: 18
                                color: "#335F5E"
                            }
                        }
                    }
                }

                XchatSummary {
                    anchors.right: parent.right
                }
            }
        }
    }

    XchatPopup {
        id: xchatpopup
        visible:true
    }
}


