import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.1

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
                spacing: 30

                DiodeButton {
                    id: logobutton
                    imageSource: "logos/xby_logo.svg"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.topMargin: 35
                    changeColorOnClick: false
                    hoverEnabled: false
                    size: 70
                }

                DiodeButton {
                    id: diode1button
                    imageSource: "icons/dollar-pointer.svg"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    isSelected: true
                    onButtonClicked: {

                    }
                }

                DiodeButton {
                    id: diode2button
                    imageSource: "icons/share.svg"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    isSelected: true
                    onButtonClicked: {

                    }
                }

                DiodeButton {
                    id: diode3button
                    imageSource: "icons/shuffle.svg"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    isSelected: true
                    onButtonClicked: {

                    }
                }

                DiodeButton {
                    id: diode4button
                    imageSource: "icons/chat.svg"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    isSelected: true
                    onButtonClicked: {

                    }
                }

                DiodeButton {
                    id: diode5button
                    imageSource: "icons/plus-button.svg"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    isSelected: false
                    onButtonClicked: {

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
                spacing: 15

                DiodeButton {
                    id: settingsButton
                    imageSource: "icons/plus-button.svg"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    isSelected: false
                    onButtonClicked: {

                    }
                }

                DiodeButton {
                    id: wifiButton
                    imageSource: "icons/wifi.svg"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    isSelected: false
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
            Layout.fillHeight: true

            Rectangle {
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

                RowLayout {
                    Layout.fillWidth: true
                    Layout.maximumWidth: 700
                    anchors.left: parent.left
                    height: parent.height

                    NavigationButton {
                        id: homeNavButton
                        height: 70
                        text: qsTr("HOME")
                        isSelected: true
                        onButtonClicked: {
                            homeNavButton.isSelected = true
                            xchangeNavButton.isSelected = false
                            xchatNavButton.isSelected = false
                            homeDiodeRow1.visible = true
                            homeDiodeRow2.visible = true
                            toolsDiodeRow1.visible = false
                        }
                    }

                    NavigationButton {
                        id: xchangeNavButton
                        height: 70
                        text: qsTr("X-CHANGE")
                        onButtonClicked: {
                            homeNavButton.isSelected = false
                            xchangeNavButton.isSelected = true
                            xchatNavButton.isSelected = false
                            toolsNavButton.isSelected = false
                            homeDiodeRow1.visible = true
                            homeDiodeRow2.visible = true
                            toolsDiodeRow1.visible = false
                        }
                    }

                    NavigationButton {
                        id: xchatNavButton
                        height: 70
                        text: qsTr("X-CHAT")
                        onButtonClicked: {
                            homeNavButton.isSelected = false
                            xchangeNavButton.isSelected = false
                            xchatNavButton.isSelected = true
                            toolsNavButton.isSelected = false
                            homeDiodeRow1.visible = true
                            homeDiodeRow2.visible = true
                            toolsDiodeRow1.visible = false
                        }
                    }
                    NavigationButton {
                        id: toolsNavButton
                        height: 70
                        text: qsTr("TOOLS")
                        onButtonClicked: {
                            homeNavButton.isSelected = false
                            xchangeNavButton.isSelected = false
                            xchatNavButton.isSelected = false
                            toolsNavButton.isSelected = true
                            homeDiodeRow1.visible = false
                            homeDiodeRow2.visible = false
                            toolsDiodeRow1.visible = true
                        }
                    }

                }
            }

            RowLayout {
                // Diode row 1
                id: homeDiodeRow1
                Layout.fillHeight: true
                anchors.left: parent.left
                spacing: 15

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumHeight: 100
                    color: "#3A3E47"
                    DockButton {
                        height: 13
                        anchors.top: parent.top
                        anchors.left: parent.left
                        width: parent.width
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumHeight: 100
                    color: "#3A3E47"
                    DockButton {
                        height: 13
                        anchors.top: parent.top
                        anchors.left: parent.left
                        width: parent.width
                    }
                }
            }

            RowLayout {
                id: toolsDiodeRow1
                Layout.fillHeight: true
                anchors.left: parent.left
                spacing: 15
                visible: false

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumHeight: 100
                    color: "#3A3E47"

                    ColumnLayout {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        width: parent.width

                        DockButton {
                            height: 13
                            anchors.top: parent.top
                            anchors.left: parent.left
                            width: parent.width
                        }

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

            Rectangle {
                // Filler
                width: 15
                color: "transparent"
            }

            RowLayout {
                // Diode row 2
                id: homeDiodeRow2
                Layout.fillHeight: true
                anchors.left: parent.left
                spacing: 15

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumHeight: 100
                    color: "#3A3E47"
                    DockButton {
                        height: 13
                        anchors.top: parent.top
                        anchors.left: parent.left
                        width: parent.width
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

                Rectangle {
                    Layout.fillWidth: true
                    height: 40
                    color: "#0DD8D2"

                    RowLayout {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20

                        Text {
                            text: qsTr("Notice!")
                            font.family: "Roboto"
                            font.weight: Font.Bold
                            font.pixelSize: 20
                            color: "#335F5E"
                        }

                        Text {
                            text: qsTr("This is a pre-release version of XCITE for testing only.")
                            font.family: "Roboto"
                            font.pixelSize: 20
                            color: "#335F5E"
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


