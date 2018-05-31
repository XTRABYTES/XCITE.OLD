/**
 * Filename: HistoryTable.qml
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
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import SortFilterProxyModel 0.1

TableView {
    id: transactionTable

    model: SortFilterProxyModel {
        id: proxyModel
        source: wallet.transactions.rowCount() > 0 ? wallet.transactions : null
        sortOrder: transactionTable.sortIndicatorOrder
        sortCaseSensitivity: Qt.CaseInsensitive
        sortRole: wallet.transactions.rowCount(
                      ) > 0 ? transactionTable.getColumn(
                                  transactionTable.sortIndicatorColumn).role : ""
    }

    // TODO: This is just a placeholder to test out click-to-view a transaction
    onDoubleClicked: {
        popup.open()
    }

    anchors.fill: parent

    backgroundVisible: false
    alternatingRowColors: false
    frameVisible: false
    headerVisible: true

    verticalScrollBarPolicy: Qt.ScrollBarAsNeeded
    horizontalScrollBarPolicy: Qt.ScrollBarAsNeeded

    style: TableViewStyle {
        transientScrollBars: false

        Component {
            id: scrollbarHide

            Item {
                visible: false
            }
        }

        incrementControl: scrollbarHide
        decrementControl: scrollbarHide
        corner: scrollbarHide
        frame: scrollbarHide

        scrollBarBackground: Item {
            implicitWidth: 8
            implicitHeight: 8
        }

        handleOverlap: 0
        handle: Rectangle {
            radius: 6
            //color: Theme.primaryHighlight
            implicitHeight: 8
            implicitWidth: 8
            opacity: 0.4
            anchors.fill: parent
        }

        // Table row attributes
        rowDelegate: Item {
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
                        if (styleData.value === "IN")
                            Theme.primaryHighlight
                        if (styleData.value === "OUT")
                            "#F77E7E"
                        if (styleData.value >= 0)
                            Theme.primaryHighlight
                        if (styleData.value < 0)
                            "#F77E7E"
                        break
                    default:
                        "#ffffff"
                        break
                    }
                }
                text: {
                    switch (styleData.column) {
                    case 1:
                        styleData.value === "IN" ? qsTr(
                                                       "Receive") : qsTr("Send")
                        break
                    case 2:
                        Qt.formatDateTime(styleData.value, "dd MMMM yyyy")
                        break
                    case 3:
                        Qt.formatDateTime(styleData.value, "h:mm a")
                        break
                    case 6:
                        // Add the + prefix and XBY suffix to column 6 (value)
                        (styleData.value > 0 ? ("+" + styleData.value) : styleData.value) + " XBY"
                        break
                    default:
                        styleData.value
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
        role: "type"
        width: 125
        resizable: false
    }

    TableViewColumn {
        title: qsTr("Value")
        role: "amount"
        width: 125
        resizable: false
    }
}
