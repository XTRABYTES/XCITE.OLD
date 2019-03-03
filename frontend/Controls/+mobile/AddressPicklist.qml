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

import "qrc:/Controls" as Controls

Rectangle {
    width: parent.width
    height: parent.height
    color: "transparent"
    clip :true

    property string searchFilter: ""

    Component {
        id: contactLine

        Rectangle {
            id: contactsRow
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            height: 80
            color:"transparent"
            clip: true

            Controls.CardBody {
                id: myCardBody
            }

            Rectangle {
                id: clickIndicator
                anchors.fill: parent
                color: maincolor
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
                    detectInteraction()
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

            Label {
                id: addressContactName
                width: 130
                text: contactList.get(contact).firstName + " " + contactList.get(contact).lastName + " (" + label + ")"
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.right: parent.right
                anchors.rightMargin: 28
                anchors.top: parent.top
                anchors.topMargin: 10
                font.family: xciteMobile.name
                font.pixelSize: 20
                font.capitalization: Font.SmallCaps
                font.letterSpacing: 2
                font.bold: true
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                elide: Text.ElideRight
            }

            Label {
                id: addressHash
                text: address
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.right: parent.right
                anchors.rightMargin: 28
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                font.family: xciteMobile.name
                font.pixelSize: 14
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                elide: Text.ElideRight
            }
        }
    }
    SortFilterProxyModel {
        id: filteredAddresses
        sourceModel: addressList
        filters: [
            RegExpFilter {
                roleName: "coin"
                pattern: "^" + selectedCoin + "$"
            },
            ValueFilter {
                roleName: "remove"
                value: false
            },
            AnyOf {
                RegExpFilter {
                    roleName: "address"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
                RegExpFilter {
                    roleName: "label"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
                RegExpFilter {
                    roleName: "fullname"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
            }
        ]
        sorters: [
            StringSorter { roleName: "fullname" },
            StringSorter { roleName: "label" }
        ]
    }


    ListView {
        anchors.fill: parent
        id: picklist
        model: filteredAddresses
        delegate: contactLine
        contentHeight: (filteredAddresses.count * 80) + 50
        onDraggingChanged: detectInteraction()
    }
}
