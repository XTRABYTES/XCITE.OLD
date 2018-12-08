/**
* Filename: AddressPicklist.qml
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
import QtQuick.Controls 2.3
import SortFilterProxyModel 0.2



Rectangle {
    width: parent.width
    height: parent.height
    color: "transparent"

    property int selectedWallet: 0
    property string searchFilter:  (selectedWallet == 0 ? "XBY" : "XFUEL")

    Component {
        id: contactLine

        Rectangle {
            id: contactsRow
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            height: 45
            color:"transparent"

            Rectangle {
                id: clickIndicator
                anchors.fill: parent
                color: "black"
                opacity: 0.25
                visible: false

                Connections {
                    target: picklist
                    onMovementEnded: {
                        clickIndicator.visible = false
                    }
                }
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    clickIndicator.visible = true
                }

                onReleased: {
                    clickIndicator.visible = false
                }

                onClicked: {
                    clickIndicator.visible = false
                    if (transferTracker == 1) {
                        addressbookTracker = 0;
                        selectedAddress = address
                    }
                }
            }

            Rectangle {
                height: 1
                width: parent.width - 10
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                color: "#727272"
            }

            Label {
                id: addressContactName
                text: {
                    if (name.length > 12) {
                        name.substring(0,12) + "..."}
                    else {
                        name
                    }
                }
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.verticalCenter: parent.verticalCenter
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pixelSize: 16
                font.bold: true
                color: "#F2F2F2"
            }

            Label {
                id: addressHash
                text: (address).substring(0,17) + "..."
                anchors.left: parent.left
                anchors.leftMargin: 163
                anchors.bottom: addressContactName.bottom
                font.family: xciteMobile.name //"Brandon Grotesque"
                font.pixelSize: 14
                font.weight: Font.Light
                color: "#F2F2F2"
            }
        }
    }
    SortFilterProxyModel {
        id: filteredAddresses
        sourceModel: addressList
        filters: [
            RegExpFilter {
                 roleName: "coin"
                 pattern: searchFilter
            },
            ValueFilter {
                 roleName: "active"
                 value: true
            }
        ]
    }


    ListView {
        anchors.fill: parent
        id: picklist
        model: filteredAddresses
        delegate: contactLine
    }
}
