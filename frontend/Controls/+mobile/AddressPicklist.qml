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
            visible: inView == true
            property bool inView: y >= (picklist.contentY - 5) && y <= picklist.span

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
                    if (currentAddress != address) {
                        clickIndicator.visible = true
                    }
                }

                onReleased: {
                    clickIndicator.visible = false
                }

                onClicked: {
                    clickIndicator.visible = false
                    if (transferTracker == 1 && currentAddress != address) {
                        addressbookTracker = 0;
                        selectedAddress = address
                    }
                }
            }

            Rectangle {
                height: 1
                width: parent.width - 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                color: darktheme == false? "#727272" : maincolor
                visible: index != 0
            }

            Label {
                id: addressContactName
                width: 130
                text: contact == 0? ("My address (" + label + ")") : ((contactList.get(contact).firstName).substring(0,1) + ". " + (contactList.get(contact).lastName) + " (" + label + ")")
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.verticalCenter: parent.verticalCenter
                font.family: xciteMobile.name
                font.pixelSize: 16
                font.bold: true
                color: "#F2F2F2"
                clip: contentWidth > width
                elide: Text.ElideRight
            }

            Label {
                id: addressHash
                text: address
                anchors.left: parent.left
                anchors.leftMargin: 170
                anchors.right: parent.right
                anchors.rightMargin: 30
                anchors.bottom: addressContactName.bottom
                font.family: xciteMobile.name
                font.pixelSize: 14
                color: "#F2F2F2"
                clip: contentWidth > width
                elide: Text.ElideRight
            }

            Rectangle {
                anchors.fill: parent
                color: "black"
                opacity: 0.6
                visible: currentAddress == address
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
        property real span : contentY + height
    }
}
