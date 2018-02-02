import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import SortFilterProxyModel 0.1
import QtQuick.Dialogs 1.1

import "../../Controls" as Controls

Rectangle {
    color: cBoardBackground
    radius: 5
    Layout.minimumHeight: 465
    Layout.minimumWidth: 928.26
    Layout.fillHeight: true
    Layout.fillWidth: true

    Controls.BoardHeader {
        id: boardHeader
        text: qsTr("RECENT TRANSACTIONS")
        menuLabelText: qsTr("Complete View")
    }

    // TODO: This will be replaced by a bespoke dialog
    MessageDialog {
        id: popup
        title: "Test"
        text: "Item clicked"
    }

    TableView {
        id: transactionTable

        model: SortFilterProxyModel {
            id: proxyModel
            source: transactionModel.count > 0 ? transactionModel : null
            sortOrder: transactionTable.sortIndicatorOrder
            sortCaseSensitivity: Qt.CaseInsensitive
            sortRole: transactionModel.count > 0 ? transactionTable.getColumn(transactionTable.sortIndicatorColumn).role : ""
        }

        // TODO: This is just a placeholder to test out click-to-view a transaction
        onDoubleClicked: {
            popup.open();
        }

        backgroundVisible: false
        alternatingRowColors: false
        frameVisible: false

        anchors.top: boardHeader.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 15
        anchors.leftMargin: 22

        style: TableViewStyle {
            scrollBarBackground: Item {
                implicitWidth: 14
                implicitHeight: 16
            }

            // Scrollbar specific properties
            transientScrollBars: true   // We use this because the default scrollbars look awful
            handle: Item {
                implicitWidth: 14
                implicitHeight: 16

                Rectangle {
                    color: "#0ED8D2"
                    opacity: 0.6
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    radius: 4
                    anchors.rightMargin: 1
                }
            }

            // Table header attributes
            headerDelegate: Rectangle {
                height: 55
                color: "#3A3E46"    // This needs to be set (non to avoid the rows being visible under the header

                Text {
                    color: "#FFF7F7"
                    verticalAlignment: Text.AlignVCenter
                    height: parent.height
                    text: styleData.value
                    font.pixelSize: 16
                    font.family: "Roboto"
                    font.weight: Font.Light

                    Rectangle {
                        anchors.top: parent.verticalCenter
                        anchors.topMargin: 20
                        width: parent.width ? 60 : 0    // Avoid extraneous underline after last column
                        height: 1
                        color: "#24B9C3"
                    }
                }
            }

            // Table row attributes
            rowDelegate: Rectangle {
                color: "transparent"
                height: 60

                Rectangle {
                    height: 1
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.bottom
                    anchors.leftMargin: 10
                    color: "#535353"
                }
            }

            // Table item attributes
            itemDelegate: Item {
                Text {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 26

                    color: {
                        switch (styleData.column) {
                        case 1:
                        case 6:
                            // Colour columns 1 and 6 (Type and value) based on the hidden type column. Keeps things language agnostic
                            var row = transactionModel.get(styleData.row);
                            row && row.type === "IN" ? "#0ED8D2" : "#F77E7E"
                            break;
                        default:
                            "#ffffff"
                            break;
                        }
                    }

                    text: {
                        switch (styleData.column) {
                        case 6:
                            // Add the + prefix and XBY suffix to column 6 (value)
                            (styleData.value > 0 ? ("+" + styleData.value) : styleData.value) + " XBY";
                            break;
                        default:
                            styleData.value;
                        }
                    }

                    // Ensure ellipsis are applied
                    elide: styleData.elideMode
                    width: parent.width

                    font.pixelSize: 12
                    font.family: "Roboto"
                }
            }
        }

        // Hidden column used to determine which colors should be applied.
        // TODO: Do we want columns to be resizable?
        TableViewColumn {
            title: "type"
            role: "type"
            visible: false
        }

        TableViewColumn {
            title: qsTr("Type")
            role: "typeLabel"
            width: 125
            resizable: false
        }

        TableViewColumn {
            title: qsTr("Date")
            role: "date"
            width: 150
            resizable: false
        }

        TableViewColumn {
            title: qsTr("Time")
            role: "time"
            width: 100
            resizable: false
        }

        TableViewColumn {
            title: qsTr("Address")
            role: "address"
            width: 175
            resizable: false
        }

        TableViewColumn {
            title: qsTr("Transaction ID")
            role: "transactionID"
            width: 175
            resizable: false
        }

        TableViewColumn {
            title: qsTr("Value")
            role: "value"
            width: 125
            resizable: false
        }

        ListModel {
            id: transactionModel

            // Placeholder data
            ListElement {
                type: "IN"
                typeLabel: qsTr("Received")
                date: "Monday, 24th of January"
                time: "12:45PM"
                address: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                transactionID: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                value: 1000000
            }
            ListElement {
                type: "OUT"
                typeLabel: qsTr("Sent")
                date: "Tuesday, 24th of January"
                time: "12:45PM"
                address: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                transactionID: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                value: -5000
            }
            ListElement {
                type: "OUT"
                typeLabel: qsTr("Sent")
                date: "Wednesday, 24th of January"
                time: "12:45PM"
                address: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                transactionID: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                value: -6000
            }
            ListElement {
                type: "IN"
                typeLabel: qsTr("Received")
                date: "Thursday, 24th of January"
                time: "12:45PM"
                address: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                transactionID: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                value: 15000
            }
            ListElement {
                type: "OUT"
                typeLabel: qsTr("Sent")
                date: "Friday, 24th of January"
                time: "12:45PM"
                address: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                transactionID: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                value: -19000
            }
            ListElement {
                type: "IN"
                typeLabel: qsTr("Received")
                date: "Saturday, 24th of January"
                time: "12:45PM"
                address: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                transactionID: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                value: 8000
            }
            ListElement {
                type: "OUT"
                typeLabel: qsTr("Sent")
                date: "Sunday, 24th of January"
                time: "12:45PM"
                address: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                transactionID: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                value: -8005
            }
            ListElement {
                type: "OUT"
                typeLabel: qsTr("Sent")
                date: "Monday, 24th of January"
                time: "12:45PM"
                address: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                transactionID: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                value: -1234.45
            }
            ListElement {
                type: "IN"
                typeLabel: qsTr("Received")
                date: "Tuesday, 24th of January"
                time: "12:45PM"
                address: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                transactionID: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                value: 2345.34
            }
            ListElement {
                type: "OUT"
                typeLabel: qsTr("Sent")
                date: "Wednesday, 24th of January"
                time: "12:45PM"
                address: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                transactionID: "xghl32lk8dfss577g734j34xghl32lk8dfss577g734j34"
                value: -1234.45
            }
        }
    }
}
